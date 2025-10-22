from sqlmodel import Session, select
from app.models.catalogo import Catalogo

def get_all_catalogos(session: Session):
    return session.exec(select(Catalogo)).all()

def get_catalogo_by_id(session: Session, catalogo_id: int):
    return session.get(Catalogo, catalogo_id)

def create_catalogo(session: Session, data: Catalogo):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_catalogo(session: Session, catalogo_id: int, data: Catalogo):
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(catalogo, key, value)
    session.add(catalogo)
    session.commit()
    session.refresh(catalogo)
    return catalogo

def delete_catalogo(session: Session, catalogo_id: int):
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None
    session.delete(catalogo)
    session.commit()
    return catalogo