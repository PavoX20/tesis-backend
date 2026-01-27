from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import Session, select
from typing import List

from app.core.database import get_session
from app.models.inventario import Inventario, InventarioCreate
from app.models.materia_model import Materia
from app.models.area import Area

# Schema simple para la respuesta visual (JSON)
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

# 1. VER STOCK (GET)
@router.get("/", response_model=List[InventarioResponse])
def leer_inventario(
    area_id: int = Query(None, description="Filtrar por Área"),
    db: Session = Depends(get_session)
):
    # Join para traer los nombres bonitos de Área y Materia
    query = select(Inventario, Area.nombre, Materia.nombre).join(Area).join(Materia)
    
    if area_id:
        query = query.where(Inventario.id_area == area_id)
        
    resultados = db.exec(query).all()
    
    # Formateamos la respuesta
    respuesta = []
    for inv, area_nom, mat_nom in resultados:
        respuesta.append({
            "id_inventario": inv.id_inventario,
            "area_nombre": area_nom,
            "materia_nombre": mat_nom,
            "cantidad": float(inv.cantidad)
        })
    return respuesta

# 2. CARGAR STOCK (Upsert - Crea o Actualiza)
@router.post("/upsert", response_model=Inventario)
def actualizar_stock(
    payload: InventarioCreate,
    db: Session = Depends(get_session)
):
    # Buscamos si ya existe
    statement = select(Inventario).where(
        Inventario.id_area == payload.id_area,
        Inventario.id_materia == payload.id_materia
    )
    existente = db.exec(statement).first()
    
    if existente:
        # Si existe, actualizamos la cantidad (reemplazo directo)
        existente.cantidad = payload.cantidad
        db.add(existente)
        db.commit()
        db.refresh(existente)
        return existente
    else:
        # Si no existe, creamos
        nuevo = Inventario.from_orm(payload)
        db.add(nuevo)
        db.commit()
        db.refresh(nuevo)
        return nuevo

# 3. MOVER STOCK (Para la simulación: Descontar material)
@router.post("/movimiento")
def movimiento_stock(
    id_area: int,
    id_materia: int,
    delta: float, # Positivo=Entrada, Negativo=Salida
    db: Session = Depends(get_session)
):
    statement = select(Inventario).where(
        Inventario.id_area == id_area,
        Inventario.id_materia == id_materia
    )
    item = db.exec(statement).first()
    
    if not item:
        # Si intenta restar de algo que no existe
        if delta < 0:
             raise HTTPException(status_code=400, detail="No existe inventario para descontar")
        # Si es suma, creamos
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