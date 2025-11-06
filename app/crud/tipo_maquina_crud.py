from typing import Optional
from sqlmodel import Session, select
from app.models.tipo_maquina import TipoMaquina
from app.models.area import Area

def get_all_tipos_maquinas(session: Session, area_id: Optional[int] = None):
    stmt = select(TipoMaquina)
    if area_id is not None:
        stmt = stmt.where(TipoMaquina.id_area == area_id)
    return session.exec(stmt).all()

def get_tipo_maquina_by_id(session: Session, tm_id: int) -> Optional[TipoMaquina]:
    return session.get(TipoMaquina, tm_id)

def create_tipo_maquina(session: Session, data: TipoMaquina) -> TipoMaquina:
    if data.id_area is not None and session.get(Area, data.id_area) is None:
        raise ValueError("id_area inválido")
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

def update_tipo_maquina(session: Session, tm_id: int, data: TipoMaquina) -> Optional[TipoMaquina]:
    obj = session.get(TipoMaquina, tm_id)
    if not obj:
        return None
    payload = data.model_dump(exclude={"id_tipomaquina"}, exclude_unset=True)
    if "id_area" in payload and payload["id_area"] is not None and session.get(Area, payload["id_area"]) is None:
        raise ValueError("id_area inválido")
    for k, v in payload.items():
        setattr(obj, k, v)
    session.add(obj)
    session.commit()
    session.refresh(obj)
    return obj

def delete_tipo_maquina(session: Session, tm_id: int) -> Optional[TipoMaquina]:
    obj = session.get(TipoMaquina, tm_id)
    if not obj:
        return None
    session.delete(obj)
    session.commit()
    return obj