from sqlmodel import Session, select
from app.models.diagrama import DiagramaDeFlujo

def get_all_diagramas(session: Session):
    return session.exec(select(DiagramaDeFlujo)).all()

def get_diagrama_by_id(session: Session, diagrama_id: int):
    return session.get(DiagramaDeFlujo, diagrama_id)

def create_diagrama(session: Session, data: DiagramaDeFlujo):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_diagrama(session: Session, diagrama_id: int, data: DiagramaDeFlujo):
    diagrama = session.get(DiagramaDeFlujo, diagrama_id)
    if not diagrama:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(diagrama, key, value)
    session.add(diagrama)
    session.commit()
    session.refresh(diagrama)
    return diagrama

def delete_diagrama(session: Session, diagrama_id: int):
    diagrama = session.get(DiagramaDeFlujo, diagrama_id)
    if not diagrama:
        return None
    session.delete(diagrama)
    session.commit()
    return diagrama