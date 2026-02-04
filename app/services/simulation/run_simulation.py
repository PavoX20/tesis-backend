import pandas as pd
import os
import sys
from sqlalchemy import text
from sqlalchemy.orm import Session

# --- CONFIGURACIÓN DE RUTAS SIMPLE ---
# Obtenemos la ruta de la carpeta 'angelo_core'
current_dir = os.path.dirname(os.path.abspath(__file__))
core_dir = os.path.join(current_dir, "angelo_core")

# Agregamos 'angelo_core' al sistema para que Python encuentre 'runner' y 'funciones'
if core_dir not in sys.path:
    sys.path.append(core_dir)

try:
    # Importamos DIRECTAMENTE los archivos por su nombre real
    import runner  # Busca runner.py en angelo_core
    import funciones # Busca funciones.py en angelo_core
except ImportError as e:
    print(f"❌ Error importando el núcleo desde {core_dir}: {e}")
    print("Asegúrate de que 'runner.py' y 'funciones.py' existan en esa carpeta.")
    raise e

# --- FIN DE IMPORTS ---

def fetch_and_transform_data(db: Session, catalogo_id: int, user_goal: int):
    print(f"📥 [Servicio] Consultando producto {catalogo_id}, Meta: {user_goal}")

    # 1. Obtener Procesos
    query_procesos = text("""
        SELECT 
            p.id_proceso, p.nombre_proceso, p.parametros, p.distribucion, p.tipo,
            p.id_tipomaquina, tm.nombre_maquina, tm.cantidad_maquinas, tm.personal_max, tm.id_area,
            p.id_diagrama
        FROM public.procesos p
        JOIN public.diagramas_de_flujo df ON p.id_diagrama = df.id_diagrama
        LEFT JOIN public.tipos_maquinas tm ON p.id_tipomaquina = tm.id_tipomaquina
        WHERE df.id_catalogo = :cat_id
        ORDER BY df.es_principal DESC, p.orden;
    """)
    df_raw_procesos = pd.read_sql(query_procesos, db.connection(), params={"cat_id": catalogo_id})

    if df_raw_procesos.empty:
        raise ValueError(f"No se encontraron procesos para el zapato ID {catalogo_id}")

    ids_procesos = tuple(df_raw_procesos['id_proceso'].tolist())

    # 2. Dependencias
    if len(ids_procesos) == 1:
        query_deps = text(f"SELECT id_destino, id_origen FROM public.procesos_dependencias WHERE id_destino = {ids_procesos[0]}")
    else:
        query_deps = text(f"SELECT id_destino, id_origen FROM public.procesos_dependencias WHERE id_destino IN {ids_procesos}")
    df_deps = pd.read_sql(query_deps, db.connection())

    # 3. Recetas
    if len(ids_procesos) == 1:
        query_recetas = text(f"SELECT r.id_proceso, r.rol, r.cantidad, m.nombre as nombre_materia FROM public.receta r JOIN public.materias m ON r.id_materia = m.id_materia WHERE r.id_proceso = {ids_procesos[0]}")
    else:
        query_recetas = text(f"SELECT r.id_proceso, r.rol, r.cantidad, m.nombre as nombre_materia FROM public.receta r JOIN public.materias m ON r.id_materia = m.id_materia WHERE r.id_proceso IN {ids_procesos}")
    df_recetas = pd.read_sql(query_recetas, db.connection())

    # 4. Recursos
    query_materia_prima = text("SELECT nombre as \"MATERIA\" FROM public.materias WHERE tipo = 'materia_prima'")
    df_bodega = pd.read_sql(query_materia_prima, db.connection())
    df_bodega['AREA'] = 0
    df_bodega['CANTIDAD'] = 999999.0

    df_maq = pd.read_sql("SELECT id_area as \"AREA\", nombre_maquina as \"MAQUINARIA\", cantidad_maquinas as \"CANTIDAD\" FROM public.tipos_maquinas", db.connection())
    df_areas = pd.read_sql("SELECT id_area as \"AREA\", personal as \"PERSONAL\" FROM public.areas", db.connection())

    # --- TRANSFORMACIÓN ---
    filas_simulacion = []
    for _, proc in df_raw_procesos.iterrows():
        pid = proc['id_proceso']
        
        mis_deps = df_deps[df_deps['id_destino'] == pid]['id_origen'].tolist()
        
        ins = df_recetas[(df_recetas['id_proceso'] == pid) & (df_recetas['rol'] == 'IN')]
        str_mat_in = ",".join(ins['nombre_materia'].astype(str))
        str_cant_in = ",".join(ins['cantidad'].astype(str))
        
        outs = df_recetas[(df_recetas['id_proceso'] == pid) & (df_recetas['rol'] == 'OUT')]
        str_mat_out = ",".join(outs['nombre_materia'].astype(str))

        total_maq = int(proc['cantidad_maquinas']) if pd.notnull(proc['cantidad_maquinas']) else 0
        total_pers = int(proc['personal_max']) if pd.notnull(proc['personal_max']) else 0

        fila = {
            "DIAGRAMA": proc['id_diagrama'],
            "AREA": int(proc['id_area']) if pd.notnull(proc['id_area']) else 0,
            "ID_PROCESO": pid,
            "TIPO": proc['tipo'],
            "ID_MAQUINA": proc['nombre_maquina'] if pd.notnull(proc['nombre_maquina']) else "",
            "MAQUINAS": total_maq, 
            "MAX_P": total_pers,
            "PERSONAL": total_pers, 
            "INCIALES": len(mis_deps) == 0,
            "META": user_goal,
            "PARADA": 1.0,
            "PRODUCE": str_mat_out,
            "CANTIDAD": str_cant_in,
            "MATERIA": str_mat_in,
            "DISTRIBUCION": proc['distribucion'],
            "PARAMETROS": proc['parametros']
        }
        filas_simulacion.append(fila)

    df_datos = pd.DataFrame(filas_simulacion)
    df_maq['AREA'] = df_maq['AREA'].fillna(0).astype(int)
    df_areas['AREA'] = df_areas['AREA'].fillna(0).astype(int)

    return df_datos, df_bodega, df_maq, df_areas

def run_simulation_service(db: Session, shoe_id: int, goal: int):
    try:
        df_datos, df_bodega, df_maq, df_areas = fetch_and_transform_data(db, shoe_id, goal)
        
        print("💾 Guardando 'debug_dataframe_simulacion.xlsx'...")
        df_datos.to_excel("debug_dataframe_simulacion.xlsx", index=False)
        
        # AQUÍ es donde necesitamos funciones.py
        df_procesado = funciones.preparar_procesos(df_datos)
        
        print("🚀 [Servicio] Ejecutando Simulación...")
        # Usamos la clase HeadlessApp importada de runner.py
        app = runner.HeadlessApp(df_procesado, df_bodega, df_maq, df_areas)
        app.run()

        chart_b64 = ""
        if os.path.exists("grafica_base64.txt"):
            with open("grafica_base64.txt", "r") as f:
                chart_b64 = f.read()
        
        return {
            "status": "success",
            "simulation_metadata": {
                "shoe_id": shoe_id,
                "goal": goal,
                "bottleneck_process_id": app.cb_info["ID"],
                "total_time_seconds": app.virtual_time
            },
            "results": {
                "chart_base64": chart_b64, 
                "history_main": app.historial["datos"]
            }
        }
        
    except Exception as e:
        import traceback
        traceback.print_exc()
        return {"error": str(e)}