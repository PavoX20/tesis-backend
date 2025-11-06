from fastapi import APIRouter, Depends, HTTPException, Body
from sqlmodel import Session
from typing import Optional
from app.core.database import get_session
from app.models.area import Area
from app.models.tipo_maquina import TipoMaquina
from app.crud.tipo_maquina_crud import (
    get_all_tipos_maquinas, get_tipo_maquina_by_id,
    create_tipo_maquina, update_tipo_maquina, delete_tipo_maquina
)

router = APIRouter(prefix="/tipos-maquinas", tags=["Tipos de máquinas"])

@router.get("/", response_model=list[TipoMaquina])
def listar_tipos_maquinas(area_id: Optional[int] = None, session: Session = Depends(get_session)):
    return get_all_tipos_maquinas(session, area_id)

@router.get("/{tm_id}", response_model=TipoMaquina)
def obtener_tipo_maquina(tm_id: int, session: Session = Depends(get_session)):
    obj = get_tipo_maquina_by_id(session, tm_id)
    if not obj:
        raise HTTPException(404, "Tipo de máquina no encontrado")
    return obj

@router.post("/", response_model=TipoMaquina, status_code=201)
def crear_tipo_maquina(data: TipoMaquina, session: Session = Depends(get_session)):
    try:
        return create_tipo_maquina(session, data)
    except ValueError as e:
        raise HTTPException(400, detail=str(e))

@router.put("/{tm_id}", response_model=TipoMaquina)
def actualizar_tipo_maquina(tm_id: int, payload: dict = Body(...), session: Session = Depends(get_session)):
    obj = session.get(TipoMaquina, tm_id) or HTTPException(404, "No encontrado")
    # solo actualiza claves presentes
    for k in ("nombre_maquina","cantidad_maquinas","personal_max","id_area"):
        if k in payload:
            if k == "id_area" and payload[k] is not None and session.get(Area, payload[k]) is None:
                raise HTTPException(400, "id_area inválido")
            setattr(obj, k, payload[k])
    session.commit(); session.refresh(obj); return obj

@router.delete("/{tm_id}", status_code=204)
def eliminar_tipo_maquina(tm_id: int, session: Session = Depends(get_session)):
    obj = session.get(TipoMaquina, tm_id)
    if not obj:
        raise HTTPException(404, "Tipo de máquina no encontrado")
    session.delete(obj)
    session.commit()
    return  # 204 No Content