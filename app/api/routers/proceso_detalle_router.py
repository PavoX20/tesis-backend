from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.crud.proceso_detalle_crud import get_proceso_detalle

router = APIRouter(prefix="/procesos-detalle", tags=["Procesos Detalle"])

@router.get("/{id_proceso}")
def obtener_proceso_detalle(id_proceso: int, session: Session = Depends(get_session)):
    detalle = get_proceso_detalle(session, id_proceso)
    if not detalle:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return detalle