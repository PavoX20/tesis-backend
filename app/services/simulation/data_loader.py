import pandas as pd
from sqlalchemy.orm import Session
from app.models import (
    Catalogo, Materia, Area, TipoMaquina, Proceso, 
    DiagramaDeFlujo, Receta
)

def load_simulation_data(db: Session):
    """
    Carga datos crudos y los estandariza para el servicio de simulación.
    Nombres de columnas estandarizados a MAYÚSCULAS para evitar KeyErrors.
    """
    
    # 1. CATALOGO
    # Usamos read_sql con statement para ser más robustos que [vars(x)...]
    cat = pd.read_sql(db.query(Catalogo).statement, db.bind)
    cat = cat.rename(columns={
        "id_catalogo": "ID_PRODUCTO",
        "nombre": "NOMBRE",
        "genero": "GENERO",
        "restriccion": "RESTRICCION"
    })

    # 2. DIAGRAMAS
    diag = pd.read_sql(db.query(DiagramaDeFlujo).statement, db.bind)
    diag = diag.rename(columns={
        "id_diagrama": "ID_DIAGRAMA",
        "id_catalogo": "ID_PRODUCTO_FK", # Temporal para merge
        "nombre": "NOMBRE_DIAGRAMA"
    })

    # Merge Catalogo <-> Diagrama (Prioridad: Principal)
    if not diag.empty and not cat.empty:
        if 'es_principal' in diag.columns:
            diag = diag.sort_values('es_principal', ascending=False)
        
        cat = cat.merge(diag[['ID_PRODUCTO_FK', 'ID_DIAGRAMA']], 
                        left_on='ID_PRODUCTO', right_on='ID_PRODUCTO_FK', 
                        how='left')
        cat = cat.drop(columns=['ID_PRODUCTO_FK'])
    else:
        cat['ID_DIAGRAMA'] = None

    # 3. AREAS
    areas = pd.read_sql(db.query(Area).statement, db.bind)
    areas = areas.rename(columns={
        "id_area": "ID_AREA",
        "personal": "PERSONAL",
        "nombre": "NOMBRE_AREA"
    })

    # 4. TIPOS MAQUINAS
    tm = pd.read_sql(db.query(TipoMaquina).statement, db.bind)
    tm = tm.rename(columns={
        "id_tipomaquina": "ID_TIPOMAQUINA",
        "id_area": "ID_AREA",
        "cantidad_maquinas": "CANTIDAD MAQUINAS",
        "personal_max": "PERSONAL MAX"
    })

    # 5. PROCESOS
    proc = pd.read_sql(db.query(Proceso).statement, db.bind)
    proc = proc.rename(columns={
        "id_proceso": "ID_PROCESO",
        "id_diagrama": "ID_DIAGRAMA",
        "id_tipomaquina": "ID_TIPOMAQUINA",
        "nombre_proceso": "NOMBRE PROCESO",
        "parametros": "PARAMETROS",
        "distribucion": "DISTRIBUCION"
    })
    # Ordenar si existe columna orden
    if 'orden' in proc.columns:
        proc = proc.sort_values('orden')

    # 6. RECETAS (CRÍTICO: Traer ROL y ID_MATERIA y Normalizar)
    rec = pd.read_sql(db.query(Receta).statement, db.bind)
    rec = rec.rename(columns={
        "id_receta": "ID_RECETA",
        "id_proceso": "ID_PROCESO",
        "id_materia": "ID_MATERIA", 
        "rol": "ROL",               
        "cantidad": "CANTIDAD"
    })
    
    # Asegurar mayúsculas en el contenido de ROL
    if not rec.empty and 'ROL' in rec.columns:
        rec['ROL'] = rec['ROL'].str.upper()
    
    # Crear columna CANTIDAD UNITARIA estándar
    if 'CANTIDAD' in rec.columns:
        rec['CANTIDAD UNITARIA'] = rec['CANTIDAD']
    else:
        rec['CANTIDAD UNITARIA'] = 1.0

    # 7. MATERIAS (Para nombres/tipos extra si se requieren)
    mat = pd.read_sql(db.query(Materia).statement, db.bind)
    mat = mat.rename(columns={"id_materia": "ID_MATERIA", "nombre": "NOMBRE_MATERIA"})

    # Diagramas Estructural (Auxiliar para el engine si lo necesita directo)
    # Crea una tabla simple ID_DIAGRAMA | ID_PROCESO
    diagramas_flujo_simple = proc[['ID_DIAGRAMA', 'ID_PROCESO']].copy()
    # Intentamos pegar ID_RECETA si existe
    if not rec.empty:
        # Pegamos la primera receta que encontremos por proceso, solo como referencia
        rec_first = rec.drop_duplicates(subset=['ID_PROCESO'])
        diagramas_flujo_simple = diagramas_flujo_simple.merge(
            rec_first[['ID_PROCESO', 'ID_RECETA']], on='ID_PROCESO', how='left'
        )
        # Llenar nulos con 0
        diagramas_flujo_simple['ID_RECETA'] = diagramas_flujo_simple['ID_RECETA'].fillna(0).astype(int)
    else:
        diagramas_flujo_simple['ID_RECETA'] = 0

    return {
        "catalogo": cat,
        "areas": areas,
        "tipos_de_maquinas": tm,
        "procesos": proc,
        "receta": rec,
        "diagramas_de_flujo": diagramas_flujo_simple,
        "materias": mat
    }