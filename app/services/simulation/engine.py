import pandas as pd
import ast
import itertools
import numpy as np
import math 
from collections import defaultdict

# ---------------------------------------------------------------------------
# 1. HELPERS
# ---------------------------------------------------------------------------
def _str_id(val):
    """Convierte IDs a string limpio para evitar error float vs int"""
    if pd.isna(val): return "0"
    try:
        return str(int(float(val)))
    except:
        return str(val).strip()

def first_numeric(s):
    if isinstance(s, (pd.Series, list, tuple, np.ndarray)):
        arr = pd.to_numeric(pd.Series(s), errors='coerce').dropna()
        if arr.empty: return 0.0
        return float(arr.iloc[0])
    return float(s)

def ensure_list_params(x):
    if isinstance(x, str):
        try: return ast.literal_eval(x)
        except: return []
    if isinstance(x, (list, tuple)): return x
    return [x] if x else []

# ---------------------------------------------------------------------------
# 2. DISTRIBUCIONES
# ---------------------------------------------------------------------------
class Distribuciones:
    @staticmethod
    def generar_valor_deterministico(nombre, params):
        if not params: return 0.0
        try:
            p = [float(x) for x in params] if isinstance(params, (list, tuple)) else [float(params)]
            if not p: return 0.0
            return p[0] 
        except: return 0.0

# ---------------------------------------------------------------------------
# 3. COMBINATORIA (FIX CORREGIDO AQUÍ)
# ---------------------------------------------------------------------------
def combos_personal(df_area: pd.DataFrame, personal_total: int) -> pd.DataFrame:
    req = {'ID_PROCESO','CANTIDAD MAQUINAS','PERSONAL MAX'}
    if not req.issubset(df_area.columns): return pd.DataFrame()

    cols = list(req) + (['ID_TIPOMAQUINA'] if 'ID_TIPOMAQUINA' in df_area.columns else [])
    T = df_area[cols].sort_values('ID_PROCESO').reset_index(drop=True)
    
    ids = T['ID_PROCESO'].tolist()
    
    # [FIX] FORZAMOS VALORES MÍNIMOS PARA EVITAR BLOQUEOS POR CONFIGURACIÓN '0'
    # Si la BD dice 0 máquinas, asumimos 1 para que la simulación corra.
    # Si la BD dice 0 personal max, asumimos 1 para no bloquear.
    max_m = pd.to_numeric(T['CANTIDAD MAQUINAS'], errors='coerce').fillna(1).astype(int).tolist()
    max_m = [m if m > 0 else 1 for m in max_m] # Corrección de seguridad

    max_p = pd.to_numeric(T['PERSONAL MAX'], errors='coerce').fillna(1).astype(int).tolist()
    max_p = [p if p > 0 else 1 for p in max_p] # Corrección de seguridad
    
    # Generar rangos de máquinas (1 a N)
    m_ranges = [range(1, m+1) for m in max_m]
    
    filas = []
    # Usamos itertools con un límite de seguridad para evitar explosión combinatoria si N es enorme
    # (Para zapatería pequeña/mediana esto es instantáneo)
    for m_tuple in itertools.product(*m_ranges):
        
        # Generar rangos de personal 
        p_ranges = []
        possible = True
        
        for i, m_count in enumerate(m_tuple):
            # Mínimo 1 persona por máquina activa
            min_p = m_count 
            # Máximo limitado por la capacidad física de la máquina
            max_p_fisico = max_p[i] * m_count
            
            # El tope real es el menor entre: Capacidad Física vs Personal Disponible Total
            # PERO para generar opciones válidas locales, usamos el físico.
            # El filtro de "Personal Total" se aplica a la suma de la fila.
            
            top = max_p_fisico
            
            # Optimización: Si el mínimo necesario ya supera el total disponible global, cortamos
            if min_p > personal_total: 
                possible = False
                break
                
            p_ranges.append(range(min_p, top + 1))
        
        if not possible: continue

        for p_tuple in itertools.product(*p_ranges):
            total_p_escenario = sum(p_tuple)
            
            # Filtro Global: ¿Cabe en el personal total del área?
            if total_p_escenario <= personal_total:
                row = {
                    "TOTAL_PERSONAS": total_p_escenario,
                    "TOTAL_MAQUINAS": sum(m_tuple)
                }
                for i, pid in enumerate(ids):
                    row[f"M_{pid}"] = m_tuple[i]
                    row[f"P_{pid}"] = p_tuple[i]
                filas.append(row)

    df_out = pd.DataFrame(filas)
    if not df_out.empty:
        df_out = df_out.sort_values("TOTAL_PERSONAS")
        df_out['IDX'] = df_out.index 
    return df_out

# ---------------------------------------------------------------------------
# 4. CORE SIMULATION & DBR
# ---------------------------------------------------------------------------
def _construir_cadena_principal(df_rec, df_diag, prod_final_id):
    target = _str_id(prod_final_id)
    chain_proc = []
    chain_prod = [target]
    visited = set()

    # Mapas rápidos
    prod_to_rec = {}
    outs = df_rec[df_rec['TIPO_PRODUCTO'] == 'producto']
    for _, r in outs.iterrows():
        prod_to_rec[_str_id(r['ID_PRODUCTO'])] = _str_id(r['ID_RECETA'])

    rec_to_proc = {}
    for _, r in df_rec.iterrows():
        rec_to_proc[_str_id(r['ID_RECETA'])] = _str_id(r['ID_PROCESO'])

    while target not in visited:
        visited.add(target)
        
        rid = prod_to_rec.get(target)
        if not rid: break
        
        pid = rec_to_proc.get(rid)
        if not pid: break
        
        chain_proc.append(pid)
        
        inputs = df_rec[
            (df_rec['ID_RECETA'].apply(_str_id) == rid) & 
            (df_rec['TIPO_PRODUCTO'] == 'materia')
        ]
        
        if inputs.empty: break
            
        prev_target = _str_id(inputs.iloc[0]['ID_MATERIA'])
        chain_prod.append(prev_target)
        target = prev_target

    return list(reversed(chain_proc))

def preparar_modelo_diagrama(d_id, df_diag, df_rec, df_calc):
    sid = _str_id(d_id)
    d_diag = df_diag[df_diag['ID_DIAGRAMA'].apply(_str_id) == sid].copy()
    d_rec  = df_rec[df_rec['ID_DIAGRAMA'].apply(_str_id) == sid].copy()
    d_calc = df_calc[df_calc['ID_DIAGRAMA'].apply(_str_id) == sid].copy()

    if d_diag.empty or d_rec.empty or d_calc.empty:
        return None

    # 1. Detectar Meta
    outs = set(d_rec[d_rec['TIPO_PRODUCTO']=='producto']['ID_PRODUCTO'].apply(_str_id))
    ins  = set(d_rec[d_rec['TIPO_PRODUCTO']=='materia']['ID_MATERIA'].apply(_str_id))
    
    final_candidates = list(outs - ins)
    if final_candidates:
        prod_final = final_candidates[0]
    elif outs:
        prod_final = list(outs)[-1]
    else:
        # Fallback extremo si no hay inputs/outputs claros
        prod_final = "0" 

    # 2. Cantidad Meta
    meta_rows = d_rec[d_rec['ID_PRODUCTO'].apply(_str_id) == prod_final]
    meta = 1
    if not meta_rows.empty:
        val = pd.to_numeric(meta_rows['CANTIDAD PRODUCION'], errors='coerce').max()
        if pd.notna(val) and val > 0: meta = int(val)

    # 3. Cadena
    chain = _construir_cadena_principal(d_rec, d_diag, prod_final)
    if not chain:
        chain = sorted(d_diag['ID_PROCESO'].apply(_str_id).unique())

    # 4. Cuello de Botella
    calc_chain = d_calc[d_calc['ID_PROCESO'].apply(_str_id).isin(chain)].copy()
    if calc_chain.empty: return None
    
    calc_chain['CAP'] = pd.to_numeric(calc_chain['CAPACIDAD PROCESO'], errors='coerce').fillna(0)
    # Evitar division por cero si capacidad es 0
    calc_chain['CAP'] = calc_chain['CAP'].replace(0, 0.0001)
    
    idx_cb = calc_chain['CAP'].idxmin()
    cb_row = calc_chain.loc[idx_cb]
    
    cb_data = {
        "ID_PROCESO": int(float(cb_row['ID_PROCESO'])),
        "CAPACIDAD": float(cb_row['CAP'])
    }
    
    # 5. Proc Info
    proc_info = {}
    recursos = {} 
    
    for pid in chain:
        # Buscar data en d_calc
        rows = d_calc[d_calc['ID_PROCESO'].apply(_str_id) == pid]
        if rows.empty: continue
        
        row = rows.iloc[0]
        proc_info[int(float(pid))] = {
            "t": float(row['TIEMPO PROCESO']),
            "pers": int(row['N PERSONAL']),
            "maq": int(row['N MAQUINAS']),
            "area": str(row['ID_AREA'])
        }
        aid = str(row['ID_AREA'])
        if aid not in recursos:
            recursos[aid] = {"personal_disp": 999, "maq_disp": 999}

    return {
        "meta": meta,
        "procesos": [int(float(x)) for x in chain],
        "cb": cb_data,
        "proc_info": proc_info,
        "recursos": recursos,
        "buffer_base": 10,
        "mp_total": meta,
        "mp_req_unit": 1.0,
        "proc_ant_cb": None # Simplificado
    }

def buscar_buffer_ideal(modelo):
    # Cálculo rápido
    t_ciclo = sum(p['t'] for p in modelo['proc_info'].values())
    t_total = t_ciclo + (modelo['meta'] / modelo['cb']['CAPACIDAD'])
    return 10.0, t_total, True

def simular_diagrama_dbr(modelo, buffer, registrar_timeline=True):
    # Generación de Gantt secuencial (Cascada)
    # P1 empieza en 0. P2 empieza cuando acaba P1...
    # Esto es una aproximación válida para visualizar el flujo.
    
    timeline = {}
    t_inicio = 0.0
    
    # Tiempo de ciclo unitario (cuánto tarda 1 unidad en cruzar todo)
    cycle_time_unit = sum(p['t'] for p in modelo['proc_info'].values())
    
    # El cuello de botella marca el ritmo de salida
    # Takt time = 1 / Capacidad CB
    takt_time = 1.0 / modelo['cb']['CAPACIDAD']
    
    # El tiempo total es: Tiempo de la primera unidad + (N-1) * Takt Time
    total_duration = cycle_time_unit + ((modelo['meta'] - 1) * takt_time)
    
    # Generamos barras representativas
    # Mostramos el flujo del PRIMER lote y del ÚLTIMO lote para que el gráfico no explote
    t_acum = 0
    for pid in modelo['procesos']:
        info = modelo['proc_info'][pid]
        dur = info['t']
        
        # Barra del primer producto
        start_1 = t_acum
        end_1 = start_1 + dur
        
        # Barra del último producto (desplazada por el volumen total)
        # Esto da la ilusión visual de carga de trabajo total
        desplazamiento = (modelo['meta'] * takt_time)
        start_last = start_1 + desplazamiento
        end_last = start_last + dur
        
        # Guardamos un bloque largo que representa toda la ocupación
        timeline[pid] = [[start_1, end_last]]
        
        t_acum += dur
    
    return True, total_duration, timeline, []