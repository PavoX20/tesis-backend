from sqlmodel import Session, select
from app.models.diagrama_proceso import DiagramaProceso

def get_all_diagrama_proceso(session: Session):
    return session.exec(select(DiagramaProceso)).all()

def get_relacion(session: Session, id_diagrama: int, id_proceso: int):
    return session.get(DiagramaProceso, (id_diagrama, id_proceso))

def create_relacion(session: Session, data: DiagramaProceso):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def delete_relacion(session: Session, id_diagrama: int, id_proceso: int):
    relacion = session.get(DiagramaProceso, (id_diagrama, id_proceso))
    if not relacion:
        return None
    session.delete(relacion)
    session.commit()
    return relacion