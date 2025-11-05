from typing import List
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlmodel import Session
from app.core.database import get_session
from app.crud.receta_crud import get_receta_by_proceso, replace_receta

router = APIRouter(prefix="/receta", tags=["Receta"])

class RecetaLineaIn(BaseModel):
    id_materia: int
    cantidad: float

class RecetaProcesoIn(BaseModel):
    entradas: List[RecetaLineaIn] = []
    salidas: List[RecetaLineaIn] = []

@router.get("/proceso/{id_proceso}")
def api_get_receta(id_proceso: int, session: Session = Depends(get_session)):
    return get_receta_by_proceso(session, id_proceso)

@router.put("/proceso/{id_proceso}")
def api_put_receta(id_proceso: int, body: RecetaProcesoIn, session: Session = Depends(get_session)):
    try:
        # convertimos Pydantic -> dicts para evitar el error “object is not subscriptable”
        entradas = [x.model_dump() for x in body.entradas]
        salidas  = [x.model_dump() for x in body.salidas]
        return replace_receta(session, id_proceso, entradas, salidas)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))