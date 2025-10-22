from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.tipo_maquina import TipoMaquina
from app.crud.tipo_maquina_crud import (
    get_all_tipos, get_tipo_by_id,
    create_tipo, update_tipo, delete_tipo
)

router = APIRouter(prefix="/tipos-maquinas", tags=["Tipos de Maquinas"])

@router.get("/", response_model=list[TipoMaquina])
def listar_tipos(session: Session = Depends(get_session)):
    return get_all_tipos(session)

@router.get("/{tipo_id}", response_model=TipoMaquina)
def obtener_tipo(tipo_id: int, session: Session = Depends(get_session)):
    tipo = get_tipo_by_id(session, tipo_id)
    if not tipo:
        raise HTTPException(status_code=404, detail="Tipo de máquina no encontrado")
    return tipo

@router.post("/", response_model=TipoMaquina)
def crear_tipo(data: TipoMaquina, session: Session = Depends(get_session)):
    return create_tipo(session, data)

@router.put("/{tipo_id}", response_model=TipoMaquina)
def actualizar_tipo(tipo_id: int, data: TipoMaquina, session: Session = Depends(get_session)):
    updated = update_tipo(session, tipo_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Tipo de máquina no encontrado")
    return updated

@router.delete("/{tipo_id}", response_model=TipoMaquina)
def eliminar_tipo(tipo_id: int, session: Session = Depends(get_session)):
    deleted = delete_tipo(session, tipo_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Tipo de máquina no encontrado")
    return deleted