import pandas as pd
import time
import ast
import heapq
import itertools
from . import funciones, parametros # Importamos para infiltrarnos

# --- 1. CLASE DEL MOTOR DE EVENTOS (El corazón del tiempo) ---
class MockRoot:
    def __init__(self):
        self.events = [] 
        self.current_sim_time = 0.0
        self.counter = itertools.count()

    def set_time(self, t):
        self.current_sim_time = t

    def after(self, ms, func=None, *args):
        # Convertir ms a segundos y agendar
        trigger_time = self.current_sim_time + (ms / 1000.0)
        count = next(self.counter)
        heapq.heappush(self.events, (trigger_time, count, func, args))

    def process_pending_events(self):
        # Ejecutar eventos pasados
        while self.events and self.events[0][0] <= self.current_sim_time:
            evt_time, _, func, args = heapq.heappop(self.events)
            if func:
                try: func(*args)
                except Exception: pass

# --- 2. EL ÁRBITRO INFILTRADO (Contador de Producción) ---
def spy_meta_avanzar(app, id_proceso, parada=0):
    """
    Esta función reemplaza a la original. Cuenta cada producción
    y actualiza el texto para que el Frontend lo vea.
    """
    # Buscamos el proceso en la memoria de la app virtual
    info = app.tree_procesos["data"].get(id_proceso)
    if not info: return False
    
    # 1. Incrementar contador interno
    actual = info.get("_contador_produccion", 0) + 1
    info["_contador_produccion"] = actual
    
    # 2. Actualizar el texto que ve el usuario (Ej: "5/100")
    meta_total = info.get("_meta_total", 100)
    info["META"] = f"{int(actual)}/{int(meta_total)}" # <--- ESTO ARREGLA EL 0
    
    # 3. Guardar buffer actual (cantidad en stock local del proceso)
    # En esta simulación simplificada, asumimos que el buffer es lo producido
    info["CANTIDAD"] = actual 
    
    return actual >= meta_total

class VirtualApp:
    def __init__(self, df_datos, df_areas, df_maquinaria, df_bodega):
        # Inicializamos columnas extra para el tracking
        cols = df_datos.columns.tolist() + ["T.ACTIVO", "T.PAUSADO", "META", "_contador_produccion"]
        self.tree_procesos = {"data": {}, "columns": cols}
        self.tree_bodega = {"data": {}, "columns": ["AREA", "MATERIA", "CANTIDAD"]}
        self.tree_maquinaria = {"data": {}, "columns": ["AREA", "MAQUINARIA", "CANTIDAD"]}
        self.tree_areas = {"data": {}, "columns": ["AREA", "PERSONAL"]}
        
        self.root = MockRoot()
        
        self.datos = df_datos
        self.df_areas = df_areas
        self.df_maquinaria = df_maquinaria
        self.df_bodega = df_bodega
        
        self.SPEED_FACTOR = 300.0 
        
        # Carga de Procesos
        for _, row in df_datos.iterrows():
            pid = row["ID_PROCESO"]
            row_dict = row.to_dict()
            row_dict["AREA"] = 0 
            
            # Guardamos la meta original para usarla en el contador
            meta_orig = row.get("META", 100)
            row_dict["_meta_total"] = meta_orig
            row_dict["_contador_produccion"] = 0
            row_dict["META"] = f"0/{meta_orig}" # Inicializar visualización
            
            # --- FIX LISTAS ---
            # Consumo
            m_str = str(row.get("MATERIA", ""))
            if m_str and m_str.lower() != "nan":
                row_dict["MATERIA"] = [x.strip().upper() for x in m_str.split(",") if x.strip()]
                row_dict["CANTIDAD_CONSUMO"] = [1.0] * len(row_dict["MATERIA"])
            else:
                row_dict["MATERIA"] = []
                row_dict["CANTIDAD_CONSUMO"] = []

            # Producción
            p_str = str(row.get("PRODUCE", ""))
            if p_str and p_str.lower() != "nan":
                row_dict["PRODUCE"] = [x.strip().upper() for x in p_str.split(",") if x.strip()]
                row_dict["CANTIDAD_PRODUCE"] = [1.0] * len(row_dict["PRODUCE"])
            else:
                row_dict["PRODUCE"] = []
                row_dict["CANTIDAD_PRODUCE"] = []

            # Params & Speed Hack
            try:
                raw_p = ast.literal_eval(str(row.get("PARAMETROS", "[10, 1]")))
                row_dict["PARAMETROS"] = [float(x)/self.SPEED_FACTOR for x in raw_p]
            except:
                row_dict["PARAMETROS"] = [10.0/self.SPEED_FACTOR, 1.0]
            
            row_dict["PARADA"] = 1.0
            
            row_dict.update({
                "ESTADO": "ESPERANDO", 
                "ACTIVO": True, 
                "T.ACTIVO": "00:00:00", "_sec_activo": 0.0,
                "T.PAUSADO": "00:00:00", "_sec_pausado": 0.0
            })
            self.tree_procesos["data"][pid] = row_dict

        # Carga Bodega (Area 0)
        if not df_bodega.empty:
            for _, row in df_bodega.iterrows():
                key = f"0_{str(row['MATERIA']).strip()}"
                self.tree_bodega["data"][key] = row.to_dict()
        
        # Carga Maquinaria (Area 0)
        if not df_maquinaria.empty:
            for _, row in df_maquinaria.iterrows():
                key = f"0_{str(row['MAQUINARIA']).strip()}"
                self.tree_maquinaria["data"][key] = row.to_dict()
                
        self.tree_areas["data"][0] = {"AREA": 0, "PERSONAL": 9999}

def _fmt_time(s): 
    m, s = divmod(s, 60)
    h, m = divmod(m, 60)
    return f"{int(h):02d}:{int(m):02d}:{int(s):02d}"

def ejecutar_simulacion_angelo(df_datos: pd.DataFrame, cantidad_meta: int, umbral_pausa: float = 0.20):
    # --- 💉 INYECCIÓN DE CÓDIGO (MONKEY PATCH) ---
    # Guardamos la función original por si acaso (buena práctica)
    original_meta = funciones.meta_avanzar
    # Reemplazamos la función del motor con nuestro Árbitro
    funciones.meta_avanzar = spy_meta_avanzar
    
    try:
        df_datos["META"] = cantidad_meta
        df_datos["AREA"] = 0 

        # 1. MAQUINARIA
        maquinas_rows = []
        if "ID_MAQUINA" in df_datos.columns:
            for _, row in df_datos.drop_duplicates("ID_MAQUINA").iterrows():
                qty = row["MAQUINAS"] if row.get("MAQUINAS", 0) > 0 else 999
                maquinas_rows.append({"AREA": 0, "MAQUINARIA": row["ID_MAQUINA"], "CANTIDAD": qty})
        df_maquinaria = pd.DataFrame(maquinas_rows)

        # 2. BODEGA
        todos = set()
        producidos = set()
        for _, row in df_datos.iterrows():
            for m in str(row.get("MATERIA", "")).split(","):
                if m.strip(): todos.add(m.strip().upper())
            for p in str(row.get("PRODUCE", "")).split(","):
                if p.strip(): 
                    todos.add(p.strip().upper())
                    producidos.add(p.strip().upper())

        bodega_rows = []
        for m in todos:
            # Stock inicial 0 para WIP, infinito para MP
            cant = 0 if m in producidos else 999999
            bodega_rows.append({"AREA": 0, "MATERIA": m, "CANTIDAD": cant})
        df_bodega = pd.DataFrame(bodega_rows)
        
        # 3. AREA
        df_areas = pd.DataFrame([{"AREA": 0, "PERSONAL": 9999}])

        # --- SIMULACIÓN ---
        TIMEOUT_REAL = 15.0       
        MAX_INTENTOS = 6
        DISPLAY_MULTIPLIER = 300.0
        SNAPSHOT_INTERVAL = 5.0 
        
        mejor_resultado = None
        intento = 1
        
        while intento <= MAX_INTENTOS:
            print(f"--- Iteración {intento} (Con Contador Infiltrado) ---")
            app = VirtualApp(df_datos.copy(), df_areas, df_maquinaria, df_bodega)
            
            # Arrancar procesos
            ids_procesos = list(app.tree_procesos["data"].keys())
            for pid in ids_procesos:
                try: funciones.simular_proceso(app, pid, "simulacion", app.df_bodega, app.df_areas, app.df_maquinaria, app.datos, pd.DataFrame())
                except: pass

            start_real = time.time()
            sim_time = 0.0
            last_real_tick = start_real
            last_snapshot = -SNAPSHOT_INTERVAL
            historial = []
            
            while (time.time() - start_real) < TIMEOUT_REAL:
                now_real = time.time()
                dt_real = now_real - last_real_tick
                last_real_tick = now_real
                dt_sim = dt_real * DISPLAY_MULTIPLIER
                sim_time += dt_sim
                
                # MOTOR DE EVENTOS
                app.root.set_time(sim_time)
                app.root.process_pending_events()
                
                # Actualizar Visuales
                all_inactive = True
                for pid in ids_procesos:
                    info = app.tree_procesos["data"][pid]
                    est = info.get("ESTADO", "ESPERANDO")
                    
                    if str(est).startswith("ACTIVO") or "TRABAJANDO" in str(est):
                        info["_sec_activo"] += dt_sim
                    else:
                        info["_sec_pausado"] += dt_sim
                    
                    info["T.ACTIVO"] = _fmt_time(info["_sec_activo"])
                    info["T.PAUSADO"] = _fmt_time(info["_sec_pausado"])
                    
                    if est not in ["Finalizado", "FINALIZADO", "INACTIVO", "BLOQUEADO"]:
                        all_inactive = False

                # Snapshot
                if (sim_time - last_snapshot) >= SNAPSHOT_INTERVAL:
                    snap = {"timestamp": sim_time, "procesos": {}}
                    for pid in ids_procesos:
                        inf = app.tree_procesos["data"][pid]
                        # AQUÍ ENVIAMOS EL DATO CORRECTO AL FRONT
                        snap["procesos"][str(pid)] = {
                            "estado": inf.get("ESTADO"),
                            "buffer_actual": inf.get("CANTIDAD", 0),
                            "producido": inf.get("META", "0/0"), # <--- ESTE ES EL CAMPO CLAVE
                            "nombre": inf.get("NOMBRE")
                        }
                    historial.append(snap)
                    last_snapshot = sim_time
                
                if all_inactive and not app.root.events:
                    break

            # Análisis
            a_optimizar = []
            detalles = {}
            for pid, info in app.tree_procesos["data"].items():
                tot = info["_sec_activo"] + info["_sec_pausado"]
                ratio = (info["_sec_pausado"]/tot) if tot > 0 else 0
                est = info.get("ESTADO", "")
                
                if ("S/M" in est or ratio > umbral_pausa) and est != "FINALIZADO":
                    a_optimizar.append(pid)
                    
                detalles[str(pid)] = {
                    "buffer_recomendado": info.get("CANTIDAD", 0),
                    "estado_final": est,
                    "t_activo": info["T.ACTIVO"],
                    "nombre": info["NOMBRE"]
                }
                
            mejor_resultado = {
                "iteracion": intento,
                "tiempo_computo": time.time() - start_real,
                "detalles_procesos": detalles,
                "historial": historial,
                "status": "Optimizado"
            }
            
            if not a_optimizar: break
            
            cambios = False
            for pid in a_optimizar:
                idx = df_datos.index[df_datos["ID_PROCESO"] == pid].tolist()
                if idx:
                    curr = df_datos.at[idx[0], "CANTIDAD"]
                    if curr < 1000:
                        df_datos.at[idx[0], "CANTIDAD"] = int(curr * 2)
                        cambios = True
            
            if not cambios: break
            intento += 1

    finally:
        # IMPORTANTE: Restaurar la función original al terminar
        # para no romper nada si se usa el módulo desde otro lado
        funciones.meta_avanzar = original_meta

    return mejor_resultado