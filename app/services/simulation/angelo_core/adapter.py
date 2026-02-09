import pandas as pd
from sqlalchemy.orm import Session
from sqlalchemy import text
from app.models.simulacion_model import Proceso, TipoMaquina, Area, DiagramaDeFlujo

def clean_param(val):
    if not val or str(val).lower() == "nan" or str(val).strip() == "": 
        return "[10, 1]"
    return str(val)

def db_to_angelo_format(db: Session, id_catalogo: int, cantidad_meta: int):
    query = db.query(Proceso, TipoMaquina, Area)\
        .join(DiagramaDeFlujo, Proceso.id_diagrama == DiagramaDeFlujo.id_diagrama)\
        .outerjoin(TipoMaquina, Proceso.id_tipomaquina == TipoMaquina.id_tipomaquina)\
        .outerjoin(Area, TipoMaquina.id_area == Area.id_area)\
        .filter(DiagramaDeFlujo.id_catalogo == id_catalogo)\
        .order_by(Proceso.orden)\
        .all()

    if not query:
        print(f"⚠️ ADAPTER: No se encontraron procesos para el producto {id_catalogo}")
        return pd.DataFrame(), pd.DataFrame(), pd.DataFrame(), pd.DataFrame()

    ids_procesos = tuple([p.id_proceso for p, _, _ in query])
    

    recetas_in = {}
    recetas_out = {}
    cantidades_parada = {}

    if ids_procesos:
        conn = db.connection()
        try:
            # IN
            sql_in = text("""
                SELECT r.id_proceso, m.nombre 
                FROM receta r JOIN materias m ON r.id_materia = m.id_materia 
                WHERE r.id_proceso IN :ids AND r.rol = 'IN'
            """)
            for pid, mat in conn.execute(sql_in, {"ids": ids_procesos}).fetchall():
                if pid not in recetas_in: recetas_in[pid] = []
                recetas_in[pid].append(str(mat).strip().upper())

            # OUT (y Cantidad para PARADA/LOTE)
            sql_out = text("""
                SELECT r.id_proceso, m.nombre, r.cantidad 
                FROM receta r JOIN materias m ON r.id_materia = m.id_materia 
                WHERE r.id_proceso IN :ids AND r.rol = 'OUT'
            """)
            for pid, mat, cant in conn.execute(sql_out, {"ids": ids_procesos}).fetchall():
                if pid not in recetas_out: recetas_out[pid] = []
                recetas_out[pid].append(str(mat).strip().upper())
                cantidades_parada[pid] = float(cant) if cant else 1.0

        except Exception as e:
            print(f"⚠️ Error Recetas: {e}")

    # 3. Detectar Producción Interna (Para calcular INICIALES)
    todos_producidos = set()
    for lista in recetas_out.values():
        todos_producidos.update(lista)

    rows = []
    bodega_rows = []
    maquinaria_rows = []
    areas_rows = {}

    for proc, maq, area in query:
        pid = proc.id_proceso
        
        inputs = recetas_in.get(pid, [])
        outputs = recetas_out.get(pid, [])
        
        # INICIALES: Si NO consume nada producido internamente
        es_inicial = True
        for inp in inputs:
            if inp in todos_producidos:
                es_inicial = False
                break
        
        # Lote de salida
        parada_val = cantidades_parada.get(pid, 1.0)

        row = {
            "DIAGRAMA": proc.id_diagrama,
            "AREA": area.id_area if area else 1,
            "ID_PROCESO": pid,
            "TIPO": str(proc.tipo).upper() if proc.tipo else "NORMAL",
            "ID_MAQUINA": maq.id_tipomaquina if maq else 0,
            "MAQUINAS": maq.cantidad_maquinas if maq else 1,
            "MAX_P": maq.personal_max if maq else 1,
            "PERSONAL": maq.personal_max if maq else 1, 
            "INCIALES": es_inicial,
            "META": cantidad_meta,
            "PARADA": parada_val, 
            "PRODUCE": ",".join(outputs),
            "CANTIDAD": 1.0, # Buffer inicial
            "MATERIA": ",".join(inputs),
            "DISTRIBUCION": proc.distribucion or "norm",
            "PARAMETROS": clean_param(proc.parametros),
            "NOMBRE": proc.nombre_proceso # (Extra visual)
        }
        rows.append(row)

        # Tablas Auxiliares
        for m in inputs:
            if m not in todos_producidos:
                bodega_rows.append({"AREA": 0, "MATERIA": m, "CANTIDAD": 999999})
        
        if maq:
            maquinaria_rows.append({
                "AREA": area.id_area if area else 1,
                "MAQUINARIA": maq.id_tipomaquina,
                "CANTIDAD": maq.cantidad_maquinas
            })
        
        aid = area.id_area if area else 1
        if aid not in areas_rows:
            areas_rows[aid] = {"AREA": aid, "PERSONAL": 999}

    df = pd.DataFrame(rows)
    df_bodega = pd.DataFrame(bodega_rows).drop_duplicates()
    df_maquinaria = pd.DataFrame(maquinaria_rows).drop_duplicates()
    df_areas = pd.DataFrame(list(areas_rows.values()))

    # ========================================================
    # 🔍 SECCIÓN DE DEBUG (Imprime como el Excel de Angelo)
    # ========================================================
    if not df.empty:
        # Configurar Pandas para mostrar TODO sin cortar
        pd.set_option('display.max_columns', None)
        pd.set_option('display.max_rows', None)
        pd.set_option('display.width', 1000)
        pd.set_option('display.expand_frame_repr', False)

        print("\n" + "="*80)
        print(f"📊 DATAFRAME GENERADO (Simulando DATOS.xlsx) - {len(df)} Procesos")
        print("="*80)
        
        # Ocultamos la columna NOMBRE extra para que sea idéntico al Excel de Angelo
        cols_angelo = [
            "DIAGRAMA", "AREA", "ID_PROCESO", "TIPO", "ID_MAQUINA", 
            "MAQUINAS", "MAX_P", "PERSONAL", "INCIALES", "META", 
            "PARADA", "PRODUCE", "CANTIDAD", "MATERIA", 
            "DISTRIBUCION", "PARAMETROS"
        ]
        
        # Filtramos solo las columnas que existen (por seguridad)
        cols_presentes = [c for c in cols_angelo if c in df.columns]
        print(df[cols_presentes].to_string(index=False))
        print("="*80 + "\n")
    # ========================================================

    return df, df_bodega, df_maquinaria, df_areas