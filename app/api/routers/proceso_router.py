from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.models.proceso import Proceso
from app.models.diagrama_de_flujo import DiagramaDeFlujo

router = APIRouter(prefix="/procesos", tags=["Procesos"])


# Crear un proceso dentro de un diagrama
@router.post("/")
def create_proceso(proceso: Proceso, session: Session = Depends(get_session)):
    # Verificar que el diagrama existe
    diagrama = session.exec(
        select(DiagramaDeFlujo).where(DiagramaDeFlujo.id_diagrama == proceso.id_diagrama)
    ).first()
    if not diagrama:
        raise HTTPException(status_code=404, detail="El diagrama no existe")

    # Calcular orden automáticamente si no se envía
    if proceso.orden is None:
        last = session.exec(
            select(Proceso).where(Proceso.id_diagrama == proceso.id_diagrama)
        ).all()
        proceso.orden = len(last) + 1

    session.add(proceso)
    session.commit()
    session.refresh(proceso)
    return {"message": "Proceso creado correctamente", "data": proceso}


# Listar procesos de un diagrama
@router.get("/{id_diagrama}")
def list_procesos(id_diagrama: int, session: Session = Depends(get_session)):
    procesos = session.exec(
        select(Proceso).where(Proceso.id_diagrama == id_diagrama).order_by(Proceso.orden)
    ).all()

    if not procesos:
        raise HTTPException(status_code=404, detail="No se encontraron procesos para este diagrama")

    return {"id_diagrama": id_diagrama, "procesos": procesos}