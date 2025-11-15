# app/crud/dato_proceso_crud.py
from __future__ import annotations
from typing import List, Optional
from datetime import date
from sqlmodel import Session, select
from app.models.dato_proceso_model import DatoProceso

def get_by_id(session: Session, id_medicion: int) -> Optional[DatoProceso]:
    return session.get(DatoProceso, id_medicion)

def list_datos(
    session: Session,
    *,
    proceso_id: Optional[int] = None,
    fecha_desde: Optional[date] = None,
    fecha_hasta: Optional[date] = None,
    skip: int = 0,
    limit: int = 100,
) -> List[DatoProceso]:
    stmt = select(DatoProceso)
    if proceso_id:
        stmt = stmt.where(DatoProceso.id_proceso == proceso_id)
    if fecha_desde:
        stmt = stmt.where(DatoProceso.fecha >= fecha_desde)
    if fecha_hasta:
        stmt = stmt.where(DatoProceso.fecha <= fecha_hasta)
    stmt = stmt.order_by(DatoProceso.fecha.desc(), DatoProceso.id_medicion.desc()).offset(skip).limit(limit)
    return session.exec(stmt).all()

def create(session: Session, obj: DatoProceso) -> DatoProceso:
    session.add(obj)
    session.commit()
    session.refresh(obj)
    return obj

def bulk_create(session: Session, objs: List[DatoProceso]) -> List[DatoProceso]:
    session.add_all(objs)
    session.commit()
    for o in objs:
        session.refresh(o)
    return objs

def update(session: Session, id_medicion: int, patch: dict) -> Optional[DatoProceso]:
    db = session.get(DatoProceso, id_medicion)
    if not db:
        return None
    for k, v in patch.items():
        setattr(db, k, v)
    session.add(db)
    session.commit()
    session.refresh(db)
    return db

def delete(session: Session, id_medicion: int) -> bool:
    db = session.get(DatoProceso, id_medicion)
    if not db:
        return False
    session.delete(db)
    session.commit()
    return True


def get_tiempos_proceso(session: Session, proceso_id: int) -> List[float]:
    """
    Devuelve una lista de tiempos en segundos (float) para el proceso dado.
    Lee la columna tiempo_total_seg (TEXT) y la castea a float.
    """
    stmt = (
        select(DatoProceso.tiempo_total_seg)
        .where(DatoProceso.id_proceso == proceso_id)
        .order_by(DatoProceso.fecha, DatoProceso.id_medicion)
    )
    rows = session.exec(stmt).all()

    tiempos: List[float] = []
    for val in rows:
        if val is None:
            continue
        # val viene como str con un número, por ejemplo "21.933368"
        try:
            tiempos.append(float(val))
        except (TypeError, ValueError):
            # si hubiera algún valor raro lo ignoramos
            continue

    return tiempos