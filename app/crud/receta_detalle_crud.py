from sqlmodel import Session, select
from app.models.receta import RecetaDetalle

def create_receta_detalle(session: Session, detalle: RecetaDetalle):
    session.add(detalle)
    session.commit()
    session.refresh(detalle)
    return detalle

def get_detalles_by_receta(session: Session, id_receta: int):
    detalles = session.exec(select(RecetaDetalle).where(RecetaDetalle.id_receta == id_receta)).all()
    return detalles