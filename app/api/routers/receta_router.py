from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.receta import Receta
from app.crud.receta_crud import (
    get_all_recetas, get_receta_by_id,
    create_receta, update_receta, delete_receta
)

router = APIRouter(prefix="/recetas", tags=["Recetas"])

@router.get("/", response_model=list[Receta])
def listar_recetas(session: Session = Depends(get_session)):
    return get_all_recetas(session)

@router.get("/{receta_id}", response_model=Receta)
def obtener_receta(receta_id: int, session: Session = Depends(get_session)):
    receta = get_receta_by_id(session, receta_id)
    if not receta:
        raise HTTPException(status_code=404, detail="Receta no encontrada")
    return receta

@router.post("/", response_model=Receta)
def crear_receta(data: Receta, session: Session = Depends(get_session)):
    return create_receta(session, data)

@router.put("/{receta_id}", response_model=Receta)
def actualizar_receta(receta_id: int, data: Receta, session: Session = Depends(get_session)):
    updated = update_receta(session, receta_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Receta no encontrada")
    return updated

@router.delete("/{receta_id}", response_model=Receta)
def eliminar_receta(receta_id: int, session: Session = Depends(get_session)):
    deleted = delete_receta(session, receta_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Receta no encontrada")
    return deleted