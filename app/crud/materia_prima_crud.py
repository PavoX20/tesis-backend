from sqlmodel import Session, select
from app.models.materia_prima import MateriaPrima

def get_all_materias(session: Session):
    return session.exec(select(MateriaPrima)).all()

def get_materia_by_id(session: Session, materia_id: int):
    return session.get(MateriaPrima, materia_id)

def create_materia(session: Session, data: MateriaPrima):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_materia(session: Session, materia_id: int, data: MateriaPrima):
    materia = session.get(MateriaPrima, materia_id)
    if not materia:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(materia, key, value)
    session.add(materia)
    session.commit()
    session.refresh(materia)
    return materia

def delete_materia(session: Session, materia_id: int):
    materia = session.get(MateriaPrima, materia_id)
    if not materia:
        return None
    session.delete(materia)
    session.commit()
    return materia