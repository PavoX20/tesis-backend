from sqlmodel import Session, select
from app.models.tipo_maquina import TipoMaquina

def get_all_tipos(session: Session):
    return session.exec(select(TipoMaquina)).all()

def get_tipo_by_id(session: Session, tipo_id: int):
    return session.get(TipoMaquina, tipo_id)

def create_tipo(session: Session, data: TipoMaquina):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_tipo(session: Session, tipo_id: int, data: TipoMaquina):
    tipo = session.get(TipoMaquina, tipo_id)
    if not tipo:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(tipo, key, value)
    session.add(tipo)
    session.commit()
    session.refresh(tipo)
    return tipo

def delete_tipo(session: Session, tipo_id: int):
    tipo = session.get(TipoMaquina, tipo_id)
    if not tipo:
        return None
    session.delete(tipo)
    session.commit()
    return tipo