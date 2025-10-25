from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso import Proceso

def get_diagrama_detalle(session: Session, id_catalogo: int):
    diagrama = session.exec(
        select(DiagramaDeFlujo).where(DiagramaDeFlujo.id_catalogo == id_catalogo)
    ).first()

    if not diagrama:
        return None

    procesos = session.exec(
        select(Proceso)
        .where(Proceso.id_diagrama == diagrama.id_diagrama)
        .order_by(Proceso.id_proceso)
    ).all()

    return {
        "id_diagrama": diagrama.id_diagrama,
        "nombre": diagrama.nombre,
        "descripcion": diagrama.descripcion,
        "procesos": procesos
    }