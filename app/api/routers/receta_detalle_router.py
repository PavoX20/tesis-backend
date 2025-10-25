from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.receta import RecetaDetalle
from app.crud.receta_detalle_crud import create_receta_detalle, get_detalles_by_receta

router = APIRouter(prefix="/receta-detalle", tags=["Receta Detalle"])

@router.post("/")
def crear_receta_detalle(detalle: RecetaDetalle, session: Session = Depends(get_session)):
    try:
        nuevo_detalle = create_receta_detalle(session, detalle)
        return {
            "message": "Detalle de receta creado correctamente",
            "data": nuevo_detalle
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{id_receta}")
def listar_detalles(id_receta: int, session: Session = Depends(get_session)):
    detalles = get_detalles_by_receta(session, id_receta)
    if not detalles:
        raise HTTPException(status_code=404, detail="No hay detalles para esta receta")
    return {
        "id_receta": id_receta,
        "detalles": detalles
    }