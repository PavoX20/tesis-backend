from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.models.catalogo import Catalogo

router = APIRouter(prefix="/catalogo", tags=["Catálogo"])


# Crear nuevo artículo
@router.post("/")
def create_catalogo(catalogo: Catalogo, session: Session = Depends(get_session)):
    session.add(catalogo)
    session.commit()
    session.refresh(catalogo)
    return {"message": "Artículo creado correctamente", "data": catalogo}


# Listar todos los artículos
@router.get("/")
def list_catalogos(session: Session = Depends(get_session)):
    result = session.exec(select(Catalogo)).all()
    return {"catalogos": result}