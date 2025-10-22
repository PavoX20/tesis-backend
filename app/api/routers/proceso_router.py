from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.proceso import Proceso
from app.crud.proceso_crud import (
    get_all_procesos, get_proceso_by_id,
    create_proceso, update_proceso, delete_proceso
)

router = APIRouter(prefix="/procesos", tags=["Procesos"])

@router.get("/", response_model=list[Proceso])
def listar_procesos(session: Session = Depends(get_session)):
    return get_all_procesos(session)

@router.get("/{proceso_id}", response_model=Proceso)
def obtener_proceso(proceso_id: int, session: Session = Depends(get_session)):
    proceso = get_proceso_by_id(session, proceso_id)
    if not proceso:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return proceso

@router.post("/", response_model=Proceso)
def crear_proceso(data: Proceso, session: Session = Depends(get_session)):
    return create_proceso(session, data)

@router.put("/{proceso_id}", response_model=Proceso)
def actualizar_proceso(proceso_id: int, data: Proceso, session: Session = Depends(get_session)):
    updated = update_proceso(session, proceso_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return updated

@router.delete("/{proceso_id}", response_model=Proceso)
def eliminar_proceso(proceso_id: int, session: Session = Depends(get_session)):
    deleted = delete_proceso(session, proceso_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return deleted