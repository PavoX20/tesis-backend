import pandas as pd
import numpy as np
import ast
from sqlalchemy.orm import Session
from sqlalchemy import text
from fastapi import HTTPException
import logging
import traceback
from collections import defaultdict

from app.services.simulation import data_loader, engine, funcion 
from app.api.schemas.simulation import SimulationRequest

logger = logging.getLogger("uvicorn.error")

def safe_int(val):
    try: return int(float(val))
    except: return 0

def run_simulation(db: Session, request: SimulationRequest):
    mode_desc = "PREVIEW (SOLO INFO)" if request.solo_info else "SIMULACIÓN COMPLETA"
    print(f"--- INICIANDO {mode_desc} ---")
    
    # 1. CARGA DE DATOS
    try:
        data = data_loader.load_simulation_data(db)
    except Exception as e:
        logger.error(f"Error cargando datos: {e}")
        raise HTTPException(status_code=500, detail="Error cargando datos.")
    
    catalogo = data["catalogo"]
    areas = data["areas"]
    tipos_de_maquinas = data["tipos_de_maquinas"]
    procesos = data["procesos"]
    receta_global = data["receta"] 
    diagramas_de_flujo = data["diagramas_de_flujo"]
    materias_info = data.get("materias", pd.DataFrame()) 
    
    # Enriquece receta
    if not receta_global.empty and 'ID_DIAGRAMA' not in receta_global.columns:
        if not procesos.empty and 'ID_PROCESO' in procesos.columns and 'ID_DIAGRAMA' in procesos.columns:
            receta_global = receta_global.merge(
                procesos[['ID_PROCESO', 'ID_DIAGRAMA']], 
                on='ID_PROCESO', how='left'
            )

    # 2. INPUT
    prod_data = []
    for p in request.productos:
        prod_data.append({"ID_PRODUCTO": p.id_catalogo, "Cantidad": p.cantidad})
    
    produccion = pd.DataFrame(prod_data)
    if catalogo.empty: raise HTTPException(status_code=404, detail="Catalogo vacío.")
    produccion = produccion.merge(catalogo[['ID_PRODUCTO', 'ID_DIAGRAMA']], on='ID_PRODUCTO', how='left')
    
    resultados_simulacion = []

    # 3. BUCLE PRINCIPAL
    for idx, row in produccion.iterrows():
        try:
            id_producto = safe_int(row['ID_PRODUCTO'])
            id_diagrama_principal = safe_int(row['ID_DIAGRAMA']) 
            cantidad_pedido = row['Cantidad']

            # --- RASTREO ---
            ids_diagramas_relacionados = set()
            if id_diagrama_principal > 0: ids_diagramas_relacionados.add(id_diagrama_principal)
            
            try:
                mapa_produccion = defaultdict(list)
                if not receta_global.empty and 'ID_DIAGRAMA' in receta_global.columns:
                    salidas = receta_global[receta_global['ROL'] == 'OUT']
                    for _, r_out in salidas.iterrows():
                        prod_id = safe_int(r_out['ID_MATERIA'])
                        diag_id = safe_int(r_out['ID_DIAGRAMA'])
                        if prod_id > 0 and diag_id > 0:
                            if diag_id not in mapa_produccion[prod_id]:
                                mapa_produccion[prod_id].append(diag_id)
                
                if mapa_produccion:
                    cola_diagramas = [id_diagrama_principal]
                    procesados = set()
                    while cola_diagramas:
                        curr_diag_id = cola_diagramas.pop(0)
                        if curr_diag_id in procesados: continue
                        procesados.add(curr_diag_id)
                        procs_diag = diagramas_de_flujo[
                            diagramas_de_flujo['ID_DIAGRAMA'].apply(safe_int) == curr_diag_id
                        ]['ID_PROCESO'].unique()
                        if len(procs_diag) > 0:
                            insumos = receta_global[
                                (receta_global['ID_PROCESO'].isin(procs_diag)) & 
                                (receta_global['ROL'] != 'OUT')
                            ]['ID_MATERIA'].unique()
                            for insumo_id in insumos:
                                id_insumo = safe_int(insumo_id)
                                proveedores = mapa_produccion.get(id_insumo, [])
                                for diag_origen in proveedores:
                                    if diag_origen not in ids_diagramas_relacionados:
                                        ids_diagramas_relacionados.add(diag_origen)
                                        cola_diagramas.append(diag_origen)
            except Exception as e:
                print(f"WARN: Rastreo falló ({e})")

            lista_ids_str = [str(x) for x in ids_diagramas_relacionados if x > 0]
            if not lista_ids_str: continue

            # --- CARGA Y ENRIQUECIMIENTO ---
            df_diag_d = diagramas_de_flujo[
                diagramas_de_flujo['ID_DIAGRAMA'].apply(safe_int).astype(str).isin(lista_ids_str)
            ].copy()
            if df_diag_d.empty: continue

            df_diag_d = df_diag_d.merge(procesos, on='ID_PROCESO', how='left', suffixes=('', '_proc'))
            
            col_nombre_proceso = 'NOMBRE PROCESO' 
            if 'NOMBRE_PROCESO' in df_diag_d.columns: col_nombre_proceso = 'NOMBRE_PROCESO'
            nombres_procesos_map = {}
            if col_nombre_proceso in df_diag_d.columns:
                temp_map = df_diag_d[['ID_PROCESO', col_nombre_proceso]].drop_duplicates()
                for _, rmap in temp_map.iterrows():
                    val = str(rmap[col_nombre_proceso])
                    if val and val.lower() != 'nan':
                        nombres_procesos_map[safe_int(rmap['ID_PROCESO'])] = val

            df_diag_d['ID_TIPOMAQUINA'] = df_diag_d['ID_TIPOMAQUINA'].apply(safe_int)
            tipos_de_maquinas['ID_TIPOMAQUINA'] = tipos_de_maquinas['ID_TIPOMAQUINA'].apply(safe_int)
            df_diag_d = df_diag_d.merge(tipos_de_maquinas, on='ID_TIPOMAQUINA', how='left', suffixes=('', '_tm'))
            
            df_diag_d['ID_AREA'] = df_diag_d['ID_AREA'].apply(safe_int)
            areas['ID_AREA'] = areas['ID_AREA'].apply(safe_int)
            df_diag_d = df_diag_d.merge(areas[['ID_AREA', 'PERSONAL']], on='ID_AREA', how='left')
            df_diag_d.rename(columns={'PERSONAL': 'PERSONAL AREA'}, inplace=True)
            
            df_diag_d['PERSONAL AREA'] = df_diag_d['PERSONAL AREA'].fillna(1).astype(int)
            df_diag_d['CANTIDAD MAQUINAS'] = df_diag_d['CANTIDAD MAQUINAS'].fillna(1).astype(int)
            df_diag_d['PERSONAL MAX'] = df_diag_d['PERSONAL MAX'].fillna(100).astype(int)

            if request.solo_info:
                detalles_preview = {}
                unique_procs = df_diag_d.drop_duplicates(subset=['ID_PROCESO'])
                for _, row_p in unique_procs.iterrows():
                    pid = safe_int(row_p['ID_PROCESO'])
                    nombre = nombres_procesos_map.get(pid, f"Proceso {pid}")
                    area_id = safe_int(row_p['ID_AREA'])
                    p_max = int(row_p['PERSONAL MAX'])
                    detalles_preview[str(pid)] = {
                        "t": 0, "pers": 0, "maq": 0,
                        "area": f"Area {area_id}", "nombre_proceso": nombre, "max_pers": p_max
                    }
                resultados_simulacion.append({
                    "diagrama_id": int(id_diagrama_principal),
                    "tiempo_total": 0, "buffer_ideal": 0, "es_factible": True,
                    "cuello_botella": 0, "materiales_por_proceso": {}, 
                    "lista_materiales_total": [], "analisis_escenarios": [],
                    "gantt_data": {}, "detalles_procesos": detalles_preview 
                })
                continue 

            ids_procesos = df_diag_d['ID_PROCESO'].unique()

            # --- D. RECETAS ---
            df_rec_d = receta_global[receta_global['ID_PROCESO'].isin(ids_procesos)].copy()
            procesos_con_receta = df_rec_d['ID_PROCESO'].unique() if not df_rec_d.empty else []
            procesos_sin_receta = [pid for pid in ids_procesos if pid not in procesos_con_receta]
            if procesos_sin_receta:
                dummy_rows = []
                for pid in procesos_sin_receta:
                    dummy_rows.append({
                        'ID_RECETA': 0, 'ID_PROCESO': pid, 'ID_MATERIA': 99999,
                        'ROL': 'OUT', 'CANTIDAD': 1.0, 'CANTIDAD UNITARIA': 1.0,
                        'ID_DIAGRAMA': str(id_diagrama_principal) 
                    })
                df_rec_d = pd.concat([df_rec_d, pd.DataFrame(dummy_rows)], ignore_index=True)

            df_rec_d['ID_PRODUCTO'] = df_rec_d['ID_MATERIA'] 
            df_rec_d['TIPO_PRODUCTO'] = np.where(df_rec_d['ROL'] == 'OUT', 'producto', 'materia')
            df_rec_d['ID_DIAGRAMA'] = str(id_diagrama_principal)

            
            # 1. Calculamos cantidad base (esto daba 10,000)
            df_rec_d['CANTIDAD PRODUCION'] = df_rec_d['CANTIDAD UNITARIA'] * cantidad_pedido
            
            # 2. Corregimos: Forzamos que la salida sea EXACTAMENTE lo que pediste (100)
            # Y para asegurarnos, lo aplicamos tanto a lo que dice 'OUT' como al producto principal por ID
            mask_producto = (df_rec_d['ROL'] == 'OUT') | (df_rec_d['ID_MATERIA'] == id_producto)
            df_rec_d.loc[mask_producto, 'CANTIDAD PRODUCION'] = cantidad_pedido

            # --- E. CÁLCULO ---
            calc_rows_final = [] 
            reporte_escenarios = [] 
            todos_los_detalles_visuales = {} 

            unique_areas = df_diag_d['ID_AREA'].unique()

            for area_id in unique_areas:
                if area_id == 0: continue 

                diag_area = df_diag_d[df_diag_d['ID_AREA'] == area_id].copy()
                personal_disponible = int(diag_area.iloc[0]['PERSONAL AREA'])
                if personal_disponible <= 0: personal_disponible = 1
                
                diag_area_uniq = diag_area.drop_duplicates(subset=['ID_PROCESO']).copy()
                diag_area_uniq['PERSONAL FIJO'] = 0
                diag_area_uniq['TIPO'] = 'NORMAL' 

                max_map = dict(zip(diag_area_uniq['ID_PROCESO'], diag_area_uniq['PERSONAL MAX']))

                if request.asignacion_manual:
                    for pid_str, cant in request.asignacion_manual.items():
                        pid = safe_int(pid_str)
                        mask = diag_area_uniq['ID_PROCESO'] == pid
                        if mask.any():
                            diag_area_uniq.loc[mask, 'PERSONAL FIJO'] = int(cant)

                tiempos_ref = []
                for _, row_p in diag_area_uniq.iterrows():
                    # --- LECTURA DE TIEMPOS (Correcta gracias al Data Loader) ---
                    t_val = float(row_p.get('DURACION') or 0.0)

                    if t_val <= 0:
                        try:
                            raw_params = row_p.get('PARAMETROS')
                            if raw_params:
                                params_list = ast.literal_eval(str(raw_params))
                                if isinstance(params_list, list) and len(params_list) > 0:
                                    t_val = float(params_list[0]) 
                        except Exception as e:
                            print(f"Error leyendo params: {e}")

                    if t_val <= 0.1: t_val = 5.0 

                    tiempos_ref.append({
                        'ID_PROCESO': safe_int(row_p['ID_PROCESO']),
                        'T': t_val
                    })
                df_tiempos = pd.DataFrame(tiempos_ref)
                
                try:
                    combinaciones = funcion.combos_personal(diag_area_uniq, personal_disponible)
                except Exception as e:
                    print(f"ERROR Motor: {e}")
                    combinaciones = pd.DataFrame()

                lista_evaluada = []
                if not combinaciones.empty:
                    for _, row_comb in combinaciones.iterrows():
                        t_ciclo_area = 0.0
                        detalles_combo = {}
                        valid_combo = True
                        total_pers_row = 0
                        total_maqs_row = 0
                        
                        for _, t_row in df_tiempos.iterrows():
                            pid = safe_int(t_row['ID_PROCESO'])
                            col_p = f"P_{pid}"
                            col_m = f"M_{pid}"
                            n_pers = row_comb.get(col_p, 0)
                            
                            if col_m in row_comb: n_maqs = row_comb[col_m]
                            else: n_maqs = 1 
                            
                            total_pers_row += n_pers
                            total_maqs_row += n_maqs

                            if n_pers <= 0: t_ciclo_area = float('inf'); valid_combo = False
                            else: t_ciclo_area += t_row['T'] / n_pers
                            
                            detalles_combo[str(pid)] = {
                                "personal": int(n_pers), "maquinas": int(n_maqs), "tiempo_base": t_row['T']
                            }

                        if valid_combo:
                            lista_evaluada.append({
                                "ranking_score": t_ciclo_area,
                                "total_personal_usado": int(total_pers_row),
                                "total_maquinas_usadas": int(total_maqs_row),
                                "detalle_asignacion": detalles_combo
                            })

                lista_evaluada.sort(key=lambda x: x['ranking_score'])
                for i, item in enumerate(lista_evaluada): item['ranking'] = i + 1

                reporte_escenarios.append({
                    "id_area": int(area_id),
                    "nombre_area": f"Area {area_id}",
                    "total_combinaciones": len(lista_evaluada),
                    "escenarios": lista_evaluada
                })

                if lista_evaluada:
                    mejor_opcion = lista_evaluada[0]
                else:
                    detalles_dummy = {}
                    for _, t_row in df_tiempos.iterrows():
                        pid_key = str(safe_int(t_row['ID_PROCESO']))
                        detalles_dummy[pid_key] = { "personal": 1, "maquinas": 1, "tiempo_base": t_row['T'] }
                    mejor_opcion = { "ranking": 0, "detalle_asignacion": detalles_dummy }

                for pid_str, info in mejor_opcion['detalle_asignacion'].items():
                    pid_int = safe_int(pid_str)
                    calc_rows_final.append({
                        'ID_DIAGRAMA': str(id_diagrama_principal),
                        'ID_PROCESO': pid_int,
                        'ID_AREA': int(area_id),
                        'TIEMPO PROCESO': info['tiempo_base'],
                        'N MAQUINAS': info['maquinas'],
                        'N PERSONAL': info['personal'],
                        'CAPACIDAD PROCESO': (1.0 / info['tiempo_base']) * info['personal'] if info['tiempo_base'] > 0 else 0.1
                    })
                    nombre_real = nombres_procesos_map.get(pid_int, f"Proceso {pid_int}")
                    max_p_val = max_map.get(pid_int, 99)
                    
                    todos_los_detalles_visuales[str(pid_int)] = {
                        "t": info['tiempo_base'],
                        "pers": info['personal'],
                        "maq": info['maquinas'],
                        "area": f"Area {area_id}",
                        "nombre_proceso": nombre_real,
                        "max_pers": int(max_p_val)
                    }

            if not calc_rows_final: continue
            df_calc_loop = pd.DataFrame(calc_rows_final)

            modelo = engine.preparar_modelo_diagrama(str(id_diagrama_principal), df_diag_d, df_rec_d, df_calc_loop)
            
            if modelo:
                buf_ideal, t_total, ok = engine.buscar_buffer_ideal(modelo)
                _, _, timeline, _ = engine.simular_diagrama_dbr(modelo, buf_ideal, registrar_timeline=True)
                
                mat_req = df_rec_d[df_rec_d['TIPO_PRODUCTO'] == 'materia'].copy()
                if not mat_req.empty and not materias_info.empty:
                    mat_req = mat_req.merge(materias_info, on='ID_MATERIA', how='left')
                    if 'NOMBRE_MATERIA' not in mat_req.columns:
                        mat_req['NOMBRE_MATERIA'] = "Materia " + mat_req['ID_MATERIA'].astype(str)
                else:
                    mat_req['NOMBRE_MATERIA'] = "Materia " + mat_req['ID_MATERIA'].astype(str)

                l_mat_global = []
                if not mat_req.empty:
                    res = mat_req.groupby(['ID_MATERIA', 'NOMBRE_MATERIA'])['CANTIDAD PRODUCION'].sum().reset_index()
                    for _, r in res.iterrows():
                        if int(r['ID_MATERIA']) != 99999:
                            l_mat_global.append({
                                "id_materia": int(r['ID_MATERIA']),
                                "nombre": str(r['NOMBRE_MATERIA']),
                                "cantidad_total": float(r['CANTIDAD PRODUCION'])
                            })

                detalles_mat_proceso = {}
                for pid in ids_procesos:
                    insumos_proc = mat_req[mat_req['ID_PROCESO'] == pid]
                    lista_insumos = []
                    for _, r in insumos_proc.iterrows():
                        if int(r['ID_MATERIA']) != 99999:
                            nombre_mat = r['NOMBRE_MATERIA'] if 'NOMBRE_MATERIA' in r else f"Mat {r['ID_MATERIA']}"
                            lista_insumos.append({
                                "id_materia": int(r['ID_MATERIA']),
                                "nombre": str(nombre_mat),
                                "cantidad_total": float(r['CANTIDAD PRODUCION']) 
                            })
                    detalles_mat_proceso[str(safe_int(pid))] = lista_insumos

                timeline_str = {str(k): v for k, v in timeline.items()}
                
                resultados_simulacion.append({
                    "diagrama_id": int(id_diagrama_principal),
                    "tiempo_total": float(t_total),
                    "buffer_ideal": float(buf_ideal),
                    "es_factible": bool(ok),
                    "cuello_botella": int(modelo["cb"]["ID_PROCESO"]),
                    "lista_materiales_total": l_mat_global,       
                    "materiales_por_proceso": detalles_mat_proceso, 
                    "analisis_escenarios": reporte_escenarios,    
                    "gantt_data": timeline_str,
                    "detalles_procesos": todos_los_detalles_visuales
                })

        except Exception as e:
            print(f"CRASH PROD {row.get('ID_PRODUCTO')}: {e}")
            traceback.print_exc()
            continue

    return resultados_simulacion