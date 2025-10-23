from sqlmodel import Session, select
from app.models.proceso import Proceso

def get_all_procesos(session: Session):
    return session.exec(select(Proceso)).all()

def get_proceso_by_id(session: Session, proceso_id: int):
    return session.get(Proceso, proceso_id)

def create_proceso(session: Session, data: Proceso):
    # Si no se proporciona orden, lo colocamos al final del diagrama
    if data.id_diagrama:
        count = session.exec(
            select(Proceso).where(Proceso.id_diagrama == data.id_diagrama)
        ).count()
        data.orden = count + 1

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

    id_diagrama = proceso.id_diagrama
    orden_eliminado = proceso.orden

    session.delete(proceso)
    session.commit()

    # Reordenar los procesos restantes
    procesos_restantes = session.exec(
        select(Proceso)
        .where(Proceso.id_diagrama == id_diagrama)
        .order_by(Proceso.orden)
    ).all()

    for i, p in enumerate(procesos_restantes, start=1):
        p.orden = i
        session.add(p)

    session.commit()
    return {"deleted": proceso_id, "reordered": len(procesos_restantes)}