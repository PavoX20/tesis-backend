from fastapi import APIRouter, Body, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.crud import proceso_crud
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

    # Obtener procesos existentes ordenados
    procesos_existentes = session.exec(
        select(Proceso).where(Proceso.id_diagrama == proceso.id_diagrama).order_by(Proceso.orden)
    ).all()

    # Si no se especifica orden, agregar al final
    if not proceso.orden or proceso.orden > len(procesos_existentes):
        proceso.orden = len(procesos_existentes) + 1
    else:
        # Desplazar procesos siguientes hacia abajo
        for p in procesos_existentes:
            if p.orden >= proceso.orden:
                p.orden += 1
                session.add(p)

    # Crear nuevo proceso
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

@router.put("/{id_proceso}")
def update_proceso_endpoint(id_proceso: int, data: Proceso, session: Session = Depends(get_session)):
    proceso = proceso_crud.update_proceso(session, id_proceso, data)
    if not proceso:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return {"status": "ok", "proceso_actualizado": proceso.id_proceso}

@router.patch("/{proceso_id}/maquina", response_model=Proceso)
def asignar_maquina(
    proceso_id: int,
    payload: dict = Body(..., example={"id_tipomaquina": 9}),  # null para desasignar
    session: Session = Depends(get_session),
):
    id_tm = payload.get("id_tipomaquina", None)
    try:
        updated = proceso_crud.set_maquina_en_proceso(session, proceso_id, id_tm)
    except ValueError as e:
        raise HTTPException(400, detail=str(e))
    if not updated:
        raise HTTPException(404, "Proceso no encontrado")
    return updated