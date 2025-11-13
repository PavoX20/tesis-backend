# app/api/routers/datos_proceso_router.py
from __future__ import annotations
from typing import List, Optional
from datetime import date
from fastapi import APIRouter, Depends, HTTPException, Query, Body
from sqlmodel import Session, select
from app.core.database import get_session
from app.models.catalogo import Catalogo
from app.models.dato_proceso_model import (
    DatoProceso,
    DatoProcesoRead,
    DatoProcesoCreate,
    DatoProcesoUpdate,
)
from app.crud import dato_proceso_crud
from app.crud import proceso_crud
from app.models.proceso_model import Proceso  # para validar existencia de proceso
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama

router = APIRouter(prefix="/datos-proceso", tags=["Datos de proceso"])

@router.get("/")
def list_datos_proceso(
    proceso_id: Optional[int] = Query(None),
    fecha_desde: Optional[str] = Query(None),
    fecha_hasta: Optional[str] = Query(None),
    operario: Optional[str] = Query(None),
    order: str = Query("desc", pattern="^(asc|desc)$"),
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=1000),
    session: Session = Depends(get_session),
):
    stmt = (
        select(
            DatoProceso.id_medicion,
            DatoProceso.id_proceso,
            DatoProceso.cantidad,
            DatoProceso.fecha,
            DatoProceso.tiempo_total_min,
            DatoProceso.tiempo_total_seg,
            DatoProceso.operario,
            DatoProceso.notas,
            Proceso.nombre_proceso.label("proceso_nombre"),      # <-- nuevo
            Catalogo.id_catalogo.label("catalogo_id"),           # <-- nuevo
            Catalogo.nombre.label("catalogo_nombre"),            # <-- nuevo
        )
        .join(Proceso, Proceso.id_proceso == DatoProceso.id_proceso)
        .join(Diagrama, Diagrama.id_diagrama == Proceso.id_diagrama, isouter=True)
        .join(Catalogo, Catalogo.id_catalogo == Diagrama.id_catalogo, isouter=True)
    )

    if proceso_id:
        stmt = stmt.where(DatoProceso.id_proceso == proceso_id)
    if fecha_desde:
        stmt = stmt.where(DatoProceso.fecha >= fecha_desde)
    if fecha_hasta:
        stmt = stmt.where(DatoProceso.fecha <= fecha_hasta)
    if operario:
        stmt = stmt.where(DatoProceso.operario.ilike(f"%{operario}%"))

    stmt = stmt.order_by(DatoProceso.fecha.asc() if order == "asc" else DatoProceso.fecha.desc())
    stmt = stmt.offset(skip).limit(limit)

    rows = session.exec(stmt).all()
    return [dict(r._mapping) for r in rows]


@router.get("/{id_medicion:int}")
def get_dato_proceso(
    id_medicion: int,
    session: Session = Depends(get_session),
):
    stmt = (
        select(
            DatoProceso.id_medicion,
            DatoProceso.id_proceso,
            DatoProceso.cantidad,
            DatoProceso.fecha,
            DatoProceso.tiempo_total_min,
            DatoProceso.tiempo_total_seg,
            DatoProceso.operario,
            DatoProceso.notas,
            Proceso.nombre_proceso.label("proceso_nombre"),
            Catalogo.id_catalogo.label("catalogo_id"),
            Catalogo.nombre.label("catalogo_nombre"),
        )
        .join(Proceso, Proceso.id_proceso == DatoProceso.id_proceso)
        .join(Diagrama, Diagrama.id_diagrama == Proceso.id_diagrama, isouter=True)
        .join(Catalogo, Catalogo.id_catalogo == Diagrama.id_catalogo, isouter=True)
        .where(DatoProceso.id_medicion == id_medicion)
    )
    row = session.exec(stmt).first()
    if not row:
        raise HTTPException(status_code=404, detail="Medición no encontrada")
    return dict(row._mapping)

@router.post("/", response_model=DatoProcesoRead)
def create_dato(payload: DatoProcesoCreate, session: Session = Depends(get_session)):
    # valida que exista el proceso
    if not proceso_crud.get_proceso_by_id(session, payload.id_proceso):
        raise HTTPException(404, "Proceso no existe")
    obj = DatoProceso.model_validate(payload)
    return dato_proceso_crud.create(session, obj)

@router.post("/bulk", response_model=List[DatoProcesoRead])
def bulk_create_datos(payload: List[DatoProcesoCreate], session: Session = Depends(get_session)):
    if not payload:
        return []
    # valida procesos (opcional: podrías omitir para rendimiento)
    for p in payload:
        if not proceso_crud.get_proceso_by_id(session, p.id_proceso):
            raise HTTPException(404, f"Proceso {p.id_proceso} no existe")
    objs = [DatoProceso.model_validate(p) for p in payload]
    return dato_proceso_crud.bulk_create(session, objs)

@router.put("/{id_medicion:int}", response_model=DatoProcesoRead)
def update_dato(
    id_medicion: int,
    patch: DatoProcesoUpdate,
    session: Session = Depends(get_session),
):
    # si envían cambio de proceso, valida que exista
    if patch.id_proceso is not None and not proceso_crud.get_proceso_by_id(session, patch.id_proceso):
        raise HTTPException(404, "Proceso no existe")
    dp = dato_proceso_crud.update(session, id_medicion, patch.dict(exclude_unset=True))
    if not dp:
        raise HTTPException(404, "Medición no encontrada")
    return dp

@router.delete("/{id_medicion:int}")
def delete_dato(id_medicion: int, session: Session = Depends(get_session)):
    ok = dato_proceso_crud.delete(session, id_medicion)
    if not ok:
        raise HTTPException(404, "Medición no encontrada")
    return {"status": "ok", "deleted_id": id_medicion}