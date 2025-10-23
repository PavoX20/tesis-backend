from sqlmodel import Session, select
from app.models.proceso import Proceso
from app.models.diagrama import DiagramaDeFlujo

def get_diagrama_detalle(session: Session, id_catalogo: int):
    """Obtiene los procesos asociados a un diagrama específico."""
    diagrama = session.exec(
        select(DiagramaDeFlujo).where(DiagramaDeFlujo.id_catalogo == id_catalogo)
    ).first()
    if not diagrama:
        return None

    procesos = session.exec(
        select(Proceso)
        .where(Proceso.id_diagrama == diagrama.id_diagrama)
        .order_by(Proceso.orden)
    ).all()

    return {
        "id_diagrama": diagrama.id_diagrama,
        "nombre": diagrama.nombre,
        "descripcion": diagrama.descripcion,
        "procesos": procesos
    }