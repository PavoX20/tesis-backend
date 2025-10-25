from sqlmodel import Session, select
from app.models.receta import Receta, RecetaDetalle

def create_receta(session: Session, receta: Receta):
    session.add(receta)
    session.commit()
    session.refresh(receta)
    return receta

def get_recetas_by_diagrama(session: Session, id_diagrama: int):
    recetas = session.exec(select(Receta).where(Receta.id_diagrama == id_diagrama)).all()
    return recetas

# ---------- Crear receta ----------
def create_receta(session: Session, receta: Receta):
    session.add(receta)
    session.commit()
    session.refresh(receta)
    return receta


# ---------- Obtener recetas por diagrama ----------
def get_recetas_by_diagrama(session: Session, id_diagrama: int):
    recetas = session.exec(
        select(Receta).where(Receta.id_diagrama == id_diagrama)
    ).all()
    return recetas


# ---------- Obtener receta por ID ----------
def get_receta_by_id(session: Session, id_receta: int):
    receta = session.get(Receta, id_receta)
    return receta


# ---------- Eliminar receta ----------
def delete_receta(session: Session, id_receta: int):
    receta = session.get(Receta, id_receta)
    if receta:
        session.delete(receta)
        session.commit()
        return True
    return False


# ---------- Crear detalle ----------
def create_receta_detalle(session: Session, detalle: RecetaDetalle):
    session.add(detalle)
    session.commit()
    session.refresh(detalle)
    return detalle


# ---------- Obtener detalles por receta ----------
def get_detalles_by_receta(session: Session, id_receta: int):
    detalles = session.exec(
        select(RecetaDetalle).where(RecetaDetalle.id_receta == id_receta)
    ).all()
    return detalles