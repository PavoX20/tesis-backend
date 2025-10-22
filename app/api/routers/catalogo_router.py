from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.catalogo import Catalogo
from app.crud.catalogo_crud import (
    get_all_catalogos, get_catalogo_by_id,
    create_catalogo, update_catalogo, delete_catalogo
)

router = APIRouter(prefix="/catalogo", tags=["Catalogo"])

@router.get("/", response_model=list[Catalogo])
def listar_catalogos(session: Session = Depends(get_session)):
    return get_all_catalogos(session)

@router.get("/{catalogo_id}", response_model=Catalogo)
def obtener_catalogo(catalogo_id: int, session: Session = Depends(get_session)):
    catalogo = get_catalogo_by_id(session, catalogo_id)
    if not catalogo:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return catalogo

@router.post("/", response_model=Catalogo)
def crear_catalogo(data: Catalogo, session: Session = Depends(get_session)):
    return create_catalogo(session, data)

@router.put("/{catalogo_id}", response_model=Catalogo)
def actualizar_catalogo(catalogo_id: int, data: Catalogo, session: Session = Depends(get_session)):
    updated = update_catalogo(session, catalogo_id, data)
    if not updated:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return updated

@router.delete("/{catalogo_id}", response_model=Catalogo)
def eliminar_catalogo(catalogo_id: int, session: Session = Depends(get_session)):
    deleted = delete_catalogo(session, catalogo_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return deleted