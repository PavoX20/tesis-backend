from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.diagrama import DiagramaDeFlujo
from app.crud.diagrama_crud import (
    get_all_diagramas, get_diagrama_by_id,
    create_diagrama, update_diagrama, delete_diagrama
)

router = APIRouter(prefix="/diagramas", tags=["Diagramas de Flujo"])

@router.get("/", response_model=list[DiagramaDeFlujo])
def listar_diagramas(session: Session = Depends(get_session)):
    return get_all_diagramas(session)

@router.get("/{diagrama_id}", response_model=DiagramaDeFlujo)
def obtener_diagrama(diagrama_id: int, session: Session = Depends(get_session)):
    diagrama = get_diagrama_by_id(session, diagrama_id)
    if not diagrama:
        raise HTTPException(status_code=404, detail="Diagrama no encontrado")
    return diagrama

@router.post("/", response_model=DiagramaDeFlujo)
def crear_diagrama(data: DiagramaDeFlujo, session: Session = Depends(get_session)):
    return create_diagrama(session, data)

@router.put("/{diagrama_id}", response_model=DiagramaDeFlujo)
def actualizar_diagrama(diagrama_id: int, data: DiagramaDeFlujo, session: Session = Depends(get_session)):
    updated = update_diagrama(session, diagrama_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Diagrama no encontrado")
    return updated

@router.delete("/{diagrama_id}", response_model=DiagramaDeFlujo)
def eliminar_diagrama(diagrama_id: int, session: Session = Depends(get_session)):
    deleted = delete_diagrama(session, diagrama_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Diagrama no encontrado")
    return deleted