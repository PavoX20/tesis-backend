from sqlmodel import Session, select
from app.models.receta import Receta

def get_all_recetas(session: Session):
    return session.exec(select(Receta)).all()

def get_receta_by_id(session: Session, receta_id: int):
    return session.get(Receta, receta_id)

def create_receta(session: Session, data: Receta):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_receta(session: Session, receta_id: int, data: Receta):
    receta = session.get(Receta, receta_id)
    if not receta:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(receta, key, value)
    session.add(receta)
    session.commit()
    session.refresh(receta)
    return receta

def delete_receta(session: Session, receta_id: int):
    receta = session.get(Receta, receta_id)
    if not receta:
        return None
    session.delete(receta)
    session.commit()
    return receta