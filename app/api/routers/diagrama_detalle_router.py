from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.crud.diagrama_detalle_crud import get_diagrama_detalle

router = APIRouter(prefix="/diagramas-detalle", tags=["Diagramas Detalle"])

@router.get("/{id_catalogo}")
def get_diagrama_detalle_endpoint(id_catalogo: int, session: Session = Depends(get_session)):
    result = get_diagrama_detalle(session, id_catalogo)
    if not result:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado o sin diagrama asociado")


    #PRUEBA
    return result