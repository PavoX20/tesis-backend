from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama

router = APIRouter(prefix="/diagramas", tags=["Diagramas"])



@router.post("/")
def create_diagrama(diagrama: Diagrama, session: Session = Depends(get_session)):

    if diagrama.es_principal:
        existing = session.exec(
            select(Diagrama).where(
                (Diagrama.id_catalogo == diagrama.id_catalogo)
                & (Diagrama.es_principal == True)
            )
        ).first()
        if existing:
            raise HTTPException(
                status_code=400,
                detail="Ya existe un diagrama principal para este catálogo."
            )

    session.add(diagrama)
    session.commit()
    session.refresh(diagrama)
    return {"message": "Diagrama creado correctamente", "data": diagrama}



@router.get("/{id_catalogo}")
def list_diagramas(id_catalogo: int, session: Session = Depends(get_session)):
    diagramas = session.exec(
        select(Diagrama).where(Diagrama.id_catalogo == id_catalogo)
    ).all()

    if not diagramas:
        raise HTTPException(status_code=404, detail="No se encontraron diagramas para este catálogo")

    return {"catalogo_id": id_catalogo, "diagramas": diagramas}