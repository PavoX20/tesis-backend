from sqlmodel import Session, select
from app.models.proceso import Proceso

def get_all_procesos(session: Session):
    return session.exec(select(Proceso)).all()

def get_proceso_by_id(session: Session, proceso_id: int):
    return session.get(Proceso, proceso_id)

def create_proceso(session: Session, data: Proceso):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_proceso(session: Session, proceso_id: int, data: Proceso):
    proceso = session.get(Proceso, proceso_id)
    if not proceso:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(proceso, key, value)
    session.add(proceso)
    session.commit()
    session.refresh(proceso)
    return proceso

def delete_proceso(session: Session, proceso_id: int):
    proceso = session.get(Proceso, proceso_id)
    if not proceso:
        return None
    session.delete(proceso)
    session.commit()
    return proceso