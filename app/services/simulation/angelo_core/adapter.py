import pandas as pd
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.models import Proceso, TipoMaquina, Area, DiagramaDeFlujo

def clean_name(name):
    """Limpia espacios, saltos de línea y estandariza mayúsculas."""
    if not name: return ""
    return str(name).strip().upper().replace("\n", "").replace("\r", "")

def db_to_angelo_format(db: Session, id_catalogo: int):
    # 1. Buscar Diagrama
    diagrama_principal = db.query(DiagramaDeFlujo).filter_by(id_catalogo=id_catalogo, es_principal=True).first()
    if not diagrama_principal:
        diagrama_principal = db.query(DiagramaDeFlujo).filter_by(id_catalogo=id_catalogo).first()
    
    if not diagrama_principal:
        return pd.DataFrame()

    # 2. Identificar Diagramas
    ids_diagramas = [diagrama_principal.id_diagrama]
    try:
        sql_subs = text('SELECT id_diagrama FROM diagramas_de_flujo WHERE id_diagrama_padre = :padre')
        subs = db.connection().execute(sql_subs, {"padre": diagrama_principal.id_diagrama}).fetchall()
        for sub in subs:
            ids_diagramas.append(sub[0])
    except Exception: pass

    # 3. Consultar Procesos
    query = db.query(Proceso, TipoMaquina, Area)\
        .outerjoin(TipoMaquina, Proceso.id_tipomaquina == TipoMaquina.id_tipomaquina)\
        .outerjoin(Area, TipoMaquina.id_area == Area.id_area)\
        .filter(Proceso.id_diagrama.in_(ids_diagramas))\
        .all()

    if not query: return pd.DataFrame()

    # --- LÓGICA DE CONEXIONES ROBUSTA ---
    ids_procesos_tuple = tuple([p[0].id_proceso for p in query])
    diccionario_entradas = {}
    diccionario_salidas = {}
    todos_los_productos_internos = set()

    if ids_procesos_tuple:
        try:
            conn = db.connection()
            
            # A. Obtener SALIDAS (Limpio)
            sql_salidas = text("""
                SELECT r.id_proceso, m.nombre 
                FROM receta r
                JOIN materias m ON r.id_materia = m.id_materia
                WHERE r.id_proceso IN :ids AND r.rol = 'OUT'
            """)
            result_out = conn.execute(sql_salidas, {"ids": ids_procesos_tuple}).fetchall()
            for pid, nombre_mat in result_out:
                nombre_limpio = clean_name(nombre_mat) # <--- LIMPIEZA AQUÍ
                if pid not in diccionario_salidas: diccionario_salidas[pid] = []
                diccionario_salidas[pid].append(nombre_limpio)
                todos_los_productos_internos.add(nombre_limpio)

            # B. Obtener ENTRADAS (Limpio)
            sql_entradas = text("""
                SELECT r.id_proceso, m.nombre 
                FROM receta r
                JOIN materias m ON r.id_materia = m.id_materia
                WHERE r.id_proceso IN :ids AND r.rol = 'IN'
            """)
            result_in = conn.execute(sql_entradas, {"ids": ids_procesos_tuple}).fetchall()
            for pid, nombre_mat in result_in:
                nombre_limpio = clean_name(nombre_mat) # <--- LIMPIEZA AQUÍ
                if pid not in diccionario_entradas: diccionario_entradas[pid] = []
                diccionario_entradas[pid].append(nombre_limpio)
                
        except Exception as e:
            print(f"⚠️ Error SQL: {e}")

    # 5. Construir DataFrame
    procesos_ordenados = sorted(query, key=lambda x: (x[0].id_diagrama, x[0].orden if x[0].orden else 0))
    rows = []
    
    for i, (proc, maq, area) in enumerate(procesos_ordenados):
        pid = proc.id_proceso
        
        inputs = diccionario_entradas.get(pid, [])
        outputs = diccionario_salidas.get(pid, [])
        
        mat_in = ",".join(inputs)
        prod_out = ",".join(outputs)
        if not prod_out: prod_out = f"OUTPUT_{pid}"

        nombre_real = proc.nombre_proceso if proc.nombre_proceso else f"Proceso {pid}"

        # Detectar Iniciales: ¿Consume algo que alguien produzca internamente?
        consume_interno = False
        for materia in inputs:
            if materia in todos_los_productos_internos:
                consume_interno = True
                break
        
        es_inicial = not consume_interno

        rows.append({
            "DIAGRAMA": proc.id_diagrama,
            "AREA": area.id_area if area else 1,
            "ID_PROCESO": pid,
            "NOMBRE": nombre_real,
            "TIPO": "NORMAL", 
            "ID_MAQUINA": maq.id_tipomaquina if maq else f"GEN-{i}",
            "MAQUINAS": maq.cantidad_maquinas if maq else 1,
            "MAX_P": maq.personal_max if maq else 1,
            "PERSONAL": 1, 
            "INCIALES": es_inicial,
            "META": 100, 
            "PARADA": 10, 
            "PRODUCE": prod_out,
            "CANTIDAD": 1, 
            "MATERIA": mat_in, 
            "DISTRIBUCION": proc.distribucion or "norm",
            "PARAMETROS": proc.parametros or "[10, 1]",
            "TIEMPO": 0, "CAPACIDAD": 0, "CUELLO_DE_BOTELLA": False, "FINALES": False 
        })
    
    return pd.DataFrame(rows)