from typing import Optional
from sqlmodel import Session, select
from app.models.proceso import Proceso
from app.models.tipo_maquina import TipoMaquina


def get_proceso_by_id(session: Session, proceso_id: int):
    return session.get(Proceso, proceso_id)

def create_proceso(session: Session, data: Proceso):
    # Asignar orden automáticamente si no se envía
    if not data.orden and data.id_diagrama:
        max_orden = session.exec(
            select(Proceso.orden)
            .where(Proceso.id_diagrama == data.id_diagrama)
            .order_by(Proceso.orden.desc())
        ).first()
        data.orden = (max_orden or 0) + 1

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

    # Guardar id_diagrama antes de eliminar
    id_diagrama = proceso.id_diagrama
    session.delete(proceso)
    session.commit()

    # Reordenar los procesos del diagrama
    if id_diagrama:
        procesos = session.exec(
            select(Proceso)
            .where(Proceso.id_diagrama == id_diagrama)
            .order_by(Proceso.orden)
        ).all()

        for i, p in enumerate(procesos, start=1):
            p.orden = i
            session.add(p)
        session.commit()

    return proceso

def set_maquina_en_proceso(session: Session, proceso_id: int, id_tipomaquina: Optional[int]) -> Optional[Proceso]:
    proc = session.get(Proceso, proceso_id)
    if not proc:
        return None
    if id_tipomaquina is not None and session.get(TipoMaquina, id_tipomaquina) is None:
        raise ValueError("id_tipomaquina inválido")
    proc.id_tipomaquina = id_tipomaquina
    session.add(proc)
    session.commit()
    session.refresh(proc)
    return proc