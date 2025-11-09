from typing import List, Optional
from sqlmodel import Session, select
from app.models.proceso_model import Proceso
from app.models.tipo_maquina import TipoMaquina
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama


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

def list_procesos_lookup(
    session: Session,
    q: Optional[str] = None,
    diagrama_id: Optional[int] = None,
    catalogo_id: Optional[int] = None,
    exclude_id: Optional[int] = None,
    tipo: Optional[str] = None,  # "NORMAL" | "ALMACENAMIENTO"
    skip: int = 0,
    limit: int = 20,
) -> List[dict]:
    stmt = (
        select(
            Proceso.id_proceso,
            Proceso.nombre_proceso,
            Proceso.orden,
            Proceso.id_diagrama,
            Proceso.tipo,
            Diagrama.nombre.label("diagrama_nombre"),
            Diagrama.id_catalogo.label("catalogo_id"),
        )
        .join(Diagrama, Diagrama.id_diagrama == Proceso.id_diagrama)
    )

    if q:
        stmt = stmt.where(Proceso.nombre_proceso.ilike(f"%{q}%"))
    if diagrama_id:
        stmt = stmt.where(Proceso.id_diagrama == diagrama_id)
    if catalogo_id:
        stmt = stmt.where(Diagrama.id_catalogo == catalogo_id)
    if exclude_id:
        stmt = stmt.where(Proceso.id_proceso != exclude_id)
    if tipo:
        t = tipo.upper()
        if t in ("NORMAL", "ALMACENAMIENTO"):
            stmt = stmt.where(Proceso.tipo == t)

    stmt = stmt.order_by(Diagrama.nombre, Proceso.orden).offset(skip).limit(limit)
    rows = session.exec(stmt).all()
    return [dict(r._mapping) for r in rows]