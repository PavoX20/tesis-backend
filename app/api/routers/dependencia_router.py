from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.proceso import Proceso

router = APIRouter(prefix="/dependencias", tags=["Dependencias"])


# Crear una dependencia entre procesos
@router.post("/")
def create_dependencia(dep: ProcesoDependencia, session: Session = Depends(get_session)):
    # Validar que ambos procesos existen
    origen = session.get(Proceso, dep.id_origen)
    destino = session.get(Proceso, dep.id_destino)

    if not origen or not destino:
        raise HTTPException(status_code=404, detail="Alguno de los procesos no existe")

    # Evitar duplicados
    existing = session.exec(
        select(ProcesoDependencia)
        .where(ProcesoDependencia.id_origen == dep.id_origen)
        .where(ProcesoDependencia.id_destino == dep.id_destino)
    ).first()

    if existing:
        raise HTTPException(status_code=400, detail="La dependencia ya existe")

    session.add(dep)
    session.commit()
    session.refresh(dep)
    return {"message": "Dependencia creada correctamente", "data": dep}


@router.get("/{id_diagrama}")
def get_dependencias_by_diagrama(id_diagrama: int, session: Session = Depends(get_session)):
    # Procesos del diagrama actual
    procesos_ids = session.exec(
        select(Proceso.id_proceso).where(Proceso.id_diagrama == id_diagrama)
    ).all()

    if not procesos_ids:
        raise HTTPException(status_code=404, detail="No se encontraron procesos para este diagrama")

    # Dependencias internas
    internas = session.exec(
        select(ProcesoDependencia)
        .where(ProcesoDependencia.id_origen.in_(procesos_ids))
        .where(ProcesoDependencia.id_destino.in_(procesos_ids))
    ).all()

    # Dependencias cruzadas (origen fuera pero destino dentro, o viceversa)
    cruzadas = session.exec(
        select(ProcesoDependencia)
        .where(
            (ProcesoDependencia.id_origen.in_(procesos_ids)) |
            (ProcesoDependencia.id_destino.in_(procesos_ids))
        )
    ).all()

    # Unificar sin duplicar
    dependencias = { (d.id_origen, d.id_destino): d for d in internas + cruzadas }.values()

    return {
        "id_diagrama": id_diagrama,
        "dependencias": [
            {"id_origen": d.id_origen, "id_destino": d.id_destino}
            for d in dependencias
        ]
    }
