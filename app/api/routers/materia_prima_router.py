from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.materia_prima import MateriaPrima
from app.crud.materia_prima_crud import (
    get_all_materias, get_materia_by_id,
    create_materia, update_materia, delete_materia
)

router = APIRouter(prefix="/materias-primas", tags=["Materias Primas"])

@router.get("/", response_model=list[MateriaPrima])
def listar_materias(session: Session = Depends(get_session)):
    return get_all_materias(session)

@router.get("/{materia_id}", response_model=MateriaPrima)
def obtener_materia(materia_id: int, session: Session = Depends(get_session)):
    materia = get_materia_by_id(session, materia_id)
    if not materia:
        raise HTTPException(status_code=404, detail="Materia prima no encontrada")
    return materia

@router.post("/", response_model=MateriaPrima)
def crear_materia(data: MateriaPrima, session: Session = Depends(get_session)):
    return create_materia(session, data)

@router.put("/{materia_id}", response_model=MateriaPrima)
def actualizar_materia(materia_id: int, data: MateriaPrima, session: Session = Depends(get_session)):
    updated = update_materia(session, materia_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Materia prima no encontrada")
    return updated

@router.delete("/{materia_id}", response_model=MateriaPrima)
def eliminar_materia(materia_id: int, session: Session = Depends(get_session)):
    deleted = delete_materia(session, materia_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Materia prima no encontrada")
    return deleted