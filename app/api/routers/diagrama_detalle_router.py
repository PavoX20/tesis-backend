from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.crud.diagrama_detalle_crud import get_diagrama_detalle_por_catalogo_id

router = APIRouter(prefix="/diagramas-detalle", tags=["Diagramas Detalle"])

@router.get("/{catalogo_id}")
def obtener_diagrama_por_catalogo(catalogo_id: int, session: Session = Depends(get_session)):
    detalle = get_diagrama_detalle_por_catalogo_id(session, catalogo_id)
    if not detalle:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado o sin diagrama asociado")
    return detalle