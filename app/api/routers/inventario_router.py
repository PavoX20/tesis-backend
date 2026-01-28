from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session, select
from typing import List

from app.core.database import get_session
from app.models.inventario import Inventario, InventarioCreate
from app.models.materia_model import Materia
from app.models.area import Area

from pydantic import BaseModel
class InventarioResponse(BaseModel):
    id_inventario: int
    area_nombre: str
    materia_nombre: str
    cantidad: float

router = APIRouter(
    prefix="/inventario",
    tags=["Inventario"]
)

@router.get("/", response_model=List[InventarioResponse])
def leer_inventario(
    area_id: int = Query(None, description="Filtrar por Área"),
    db: Session = Depends(get_session)
):

    query = select(Inventario, Area.nombre, Materia.nombre).join(Area).join(Materia)

    if area_id:
        query = query.where(Inventario.id_area == area_id)

    resultados = db.exec(query).all()

    respuesta = []
    for inv, area_nom, mat_nom in resultados:
        respuesta.append({
            "id_inventario": inv.id_inventario,
            "area_nombre": area_nom,
            "materia_nombre": mat_nom,
            "cantidad": float(inv.cantidad)
        })
    return respuesta

@router.post("/upsert", response_model=Inventario)
def actualizar_stock(
    payload: InventarioCreate,
    db: Session = Depends(get_session)
):

    statement = select(Inventario).where(
        Inventario.id_area == payload.id_area,
        Inventario.id_materia == payload.id_materia
    )
    existente = db.exec(statement).first()

    if existente:

        existente.cantidad = payload.cantidad
        db.add(existente)
        db.commit()
        db.refresh(existente)
        return existente
    else:

        nuevo = Inventario.from_orm(payload)
        db.add(nuevo)
        db.commit()
        db.refresh(nuevo)
        return nuevo

@router.post("/movimiento")
def movimiento_stock(
    id_area: int,
    id_materia: int,
    delta: float, 

    db: Session = Depends(get_session)
):
    statement = select(Inventario).where(
        Inventario.id_area == id_area,
        Inventario.id_materia == id_materia
    )
    item = db.exec(statement).first()

    if not item:

        if delta < 0:
             raise HTTPException(status_code=400, detail="No existe inventario para descontar")

        item = Inventario(id_area=id_area, id_materia=id_materia, cantidad=delta)
        db.add(item)
    else:
        nuevo_total = item.cantidad + delta
        if nuevo_total < 0:
             raise HTTPException(status_code=400, detail="Stock insuficiente en bodega")
        item.cantidad = nuevo_total
        db.add(item)

    db.commit()
    return {"mensaje": "Stock actualizado", "nuevo_total": item.cantidad}