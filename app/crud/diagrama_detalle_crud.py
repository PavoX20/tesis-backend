from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.diagrama import DiagramaDeFlujo
from app.models.diagrama_proceso import DiagramaProceso
from app.models.proceso import Proceso

def get_diagrama_detalle_por_catalogo_id(session: Session, catalogo_id: int):
    # Buscar el catálogo
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None

    # Buscar el diagrama asociado
    diagrama = session.exec(
        select(DiagramaDeFlujo).where(DiagramaDeFlujo.id_catalogo == catalogo.id_catalogo)
    ).first()
    if not diagrama:
        return {"catalogo": catalogo, "diagrama": None, "procesos": []}

    # Obtener relaciones diagrama → proceso
    relaciones = session.exec(
        select(DiagramaProceso).where(DiagramaProceso.id_diagrama == diagrama.id_diagrama)
    ).all()

    # Obtener los procesos en orden
    procesos = []
    for rel in sorted(relaciones, key=lambda r: r.orden or 0):
        proceso = session.get(Proceso, rel.id_proceso)
        if proceso:
            procesos.append({
                "orden": rel.orden,
                "id_proceso": proceso.id_proceso,
                "nombre_proceso": proceso.nombre_proceso,
                "distribucion": proceso.distribucion,
                "parametros": proceso.parametros,
                "duracion": proceso.duracion,
            })

    return {
        "catalogo": catalogo,
        "diagrama": diagrama,
        "procesos": procesos
    }