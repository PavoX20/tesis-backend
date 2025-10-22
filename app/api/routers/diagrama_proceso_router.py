from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.diagrama_proceso import DiagramaProceso
from app.crud.diagrama_proceso_crud import (
    get_all_diagrama_proceso, get_relacion,
    create_relacion, delete_relacion
)

router = APIRouter(prefix="/diagrama-proceso", tags=["Diagrama Proceso"])

@router.get("/", response_model=list[DiagramaProceso])
def listar_relaciones(session: Session = Depends(get_session)):
    return get_all_diagrama_proceso(session)

@router.get("/{id_diagrama}/{id_proceso}", response_model=DiagramaProceso)
def obtener_relacion(id_diagrama: int, id_proceso: int, session: Session = Depends(get_session)):
    relacion = get_relacion(session, id_diagrama, id_proceso)
    if not relacion:
        raise HTTPException(status_code=404, detail="Relación no encontrada")
    return relacion

@router.post("/", response_model=DiagramaProceso)
def crear_relacion(data: DiagramaProceso, session: Session = Depends(get_session)):
    return create_relacion(session, data)

@router.delete("/{id_diagrama}/{id_proceso}", response_model=DiagramaProceso)
def eliminar_relacion(id_diagrama: int, id_proceso: int, session: Session = Depends(get_session)):
    deleted = delete_relacion(session, id_diagrama, id_proceso)
    if not deleted:
        raise HTTPException(status_code=404, detail="Relación no encontrada")
    return deleted