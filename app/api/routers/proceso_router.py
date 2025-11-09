from fastapi import APIRouter, Body, Depends, HTTPException, Query
from sqlmodel import Session, select, SQLModel
from app.core.database import get_session
from app.crud import proceso_crud
from app.models.proceso_model import Proceso
from app.models.diagrama_de_flujo import DiagramaDeFlujo


router = APIRouter(prefix="/procesos", tags=["Procesos"])

# Clase para usar en response_model de /lookup
class ProcesoLookup(SQLModel):
    id_proceso: int
    nombre_proceso: str
    orden: int | None = None
    id_diagrama: int
    tipo: str | None = None
    diagrama_nombre: str | None = None
    catalogo_id: int | None = None



@router.get("/lookup", response_model=list[ProcesoLookup])
def lookup_procesos(
    q: str | None = Query(None, description="Búsqueda por nombre"),
    diagrama_id: int | None = Query(None, description="Filtra por diagrama"),
    catalogo_id: int | None = Query(None, description="Filtra por catálogo (artículo)"),
    exclude_id: int | None = Query(None, description="Excluye un proceso"),
    tipo: str | None = Query(None, description="NORMAL | ALMACENAMIENTO"),
    skip: int = Query(0, ge=0),
    limit: int = Query(20, ge=1, le=100),
    session: Session = Depends(get_session),
):
    return proceso_crud.list_procesos_lookup(
        session=session,
        q=q,
        diagrama_id=diagrama_id,
        catalogo_id=catalogo_id,
        exclude_id=exclude_id,
        tipo=tipo,
        skip=skip,
        limit=limit,
    )




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
@router.get("/{id_diagrama:int}")
def list_procesos(id_diagrama: int, session: Session = Depends(get_session)):
    procesos = session.exec(
        select(Proceso).where(Proceso.id_diagrama == id_diagrama).order_by(Proceso.orden)
    ).all()

    if not procesos:
        raise HTTPException(status_code=404, detail="No se encontraron procesos para este diagrama")

    return {"id_diagrama": id_diagrama, "procesos": procesos}

@router.put("/{id_proceso:int}")
def update_proceso_endpoint(id_proceso: int, data: Proceso, session: Session = Depends(get_session)):
    proceso = proceso_crud.update_proceso(session, id_proceso, data)
    if not proceso:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return {"status": "ok", "proceso_actualizado": proceso.id_proceso}

@router.patch("/{proceso_id:int}/maquina", response_model=Proceso)
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