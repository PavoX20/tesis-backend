from typing import List, Optional
from fastapi import APIRouter, Depends, Query
from pydantic import BaseModel, Field
from sqlmodel import Session
from app.core.database import get_session
from app.crud.materia_crud import create_materia, list_materias
from app.models.materia_model import Materia

router = APIRouter(prefix="/materias", tags=["materias"])

class MateriaCreate(BaseModel):
    nombre: str
    unidad: str
    tipo: str
    costo: float = Field(ge=0, default=0.0)

@router.post("", response_model=Materia)
def post_materia(body: MateriaCreate, db: Session = Depends(get_session)):
    return create_materia(db, **body.dict())

@router.get("", response_model=List[Materia])
def get_materias(q: Optional[str] = Query(None), limit: int = 20, skip: int = 0,
                 db: Session = Depends(get_session)):
    return list_materias(db, q, limit, skip)