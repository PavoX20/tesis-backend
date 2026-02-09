from fastapi import APIRouter, HTTPException, Depends
from sqlmodel import Session
from app.core.database import get_session
from app.models.catalogo import Catalogo
from app.crud.catalogo_crud import (
    get_all_catalogos,
    get_catalogo_by_id,
    create_catalogo,
    update_catalogo,
    delete_catalogo,
)

router = APIRouter(prefix="/catalogo", tags=["Catálogo"])

@router.get("/")
def listar_catalogos(session: Session = Depends(get_session)):
    catalogos = get_all_catalogos(session)
    return {"catalogos": catalogos}

@router.get("/{catalogo_id}")
def obtener_catalogo(catalogo_id: int, session: Session = Depends(get_session)):
    catalogo = get_catalogo_by_id(session, catalogo_id)
    if not catalogo:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return {"catalogo": catalogo}

@router.post("/")
def crear_catalogo(catalogo: Catalogo, session: Session = Depends(get_session)):
    nuevo_catalogo = create_catalogo(session, catalogo)
    return {
        "message": "Artículo creado correctamente",
        "data": nuevo_catalogo,
    }

@router.put("/{catalogo_id}")
def actualizar_catalogo(catalogo_id: int, data: Catalogo, session: Session = Depends(get_session)):
    actualizado = update_catalogo(session, catalogo_id, data)
    if not actualizado:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return {
        "message": "Catálogo actualizado correctamente",
        "data": actualizado,
    }

@router.delete("/{catalogo_id}")
def eliminar_catalogo(catalogo_id: int, session: Session = Depends(get_session)):
    eliminado = delete_catalogo(session, catalogo_id)
    if not eliminado:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado")
    return {
        "message": f"Catálogo {catalogo_id} eliminado correctamente (en cascada)",
    }