from fastapi import APIRouter, Body, Depends, HTTPException, Query
from sqlmodel import Session, select, SQLModel
from app.core.database import get_session
from app.crud import proceso_crud
from app.models.catalogo import Catalogo
from app.models.proceso_model import Proceso, ProcesoCreate, ProcesoRead, ProcesoTipoUpdate
from app.models.diagrama_de_flujo import DiagramaDeFlujo


router = APIRouter(prefix="/procesos", tags=["Procesos"])

# Clase para usar en response_model de /lookup
class ProcesoLookup(SQLModel):
    id_proceso: int
    nombre_proceso: str
    orden: int | None = None
    id_diagrama: int | None = None
    tipo: str | None = None
    diagrama_nombre: str | None = None
    catalogo_id: int | None = None
    catalogo_nombre: str | None = None  # <- seguirá opcional



@router.get("/lookup", response_model=list[ProcesoLookup])
def lookup_procesos(
    q: str | None = Query(None),
    diagrama_id: int | None = Query(None),
    catalogo_id: int | None = Query(None),
    exclude_id: int | None = Query(None),
    tipo: str | None = Query(None),
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
@router.post("/", response_model=ProcesoRead)
def create_proceso(payload: ProcesoCreate, session: Session = Depends(get_session)):
    # Convertimos DTO -> modelo de BD
    proc = Proceso.model_validate(payload)

    # Si viene id_diagrama, aplicamos la lógica de orden dentro del diagrama
    if proc.id_diagrama is not None:
        diagrama = session.get(DiagramaDeFlujo, proc.id_diagrama)
        if not diagrama:
            raise HTTPException(status_code=404, detail="El diagrama no existe")

        procesos_existentes = session.exec(
            select(Proceso)
            .where(Proceso.id_diagrama == proc.id_diagrama)
            .order_by(Proceso.orden)
        ).all()

        # Si no se especifica orden o es mayor, lo ponemos al final
        if not proc.orden or proc.orden > len(procesos_existentes):
            proc.orden = len(procesos_existentes) + 1
        else:
            # Desplazar procesos siguientes hacia abajo
            for p in procesos_existentes:
                if p.orden is not None and p.orden >= proc.orden:
                    p.orden = p.orden + 1
                    session.add(p)
    # Si NO hay id_diagrama, dejamos proc.orden como None (permitido)

    session.add(proc)
    session.commit()
    session.refresh(proc)
    return proc


# Listar procesos de un diagrama
@router.get("/{id_diagrama:int}")
def list_procesos(id_diagrama: int, session: Session = Depends(get_session)):
    procesos = session.exec(
        select(Proceso).where(Proceso.id_diagrama == id_diagrama).order_by(Proceso.orden)
    ).all()

    if not procesos:
        # aún si no hay procesos, devolvemos el contexto de diagrama+catálogo (si existe)
        diag = session.get(DiagramaDeFlujo, id_diagrama)
        if not diag:
            raise HTTPException(status_code=404, detail="No se encontraron procesos para este diagrama")
        cat = session.get(Catalogo, diag.id_catalogo) if diag.id_catalogo else None
        return {
            "id_diagrama": id_diagrama,
            "catalogo": ({"id_catalogo": cat.id_catalogo, "nombre": cat.nombre} if cat else None),
            "procesos": []
        }

    # si hay procesos, resolvemos el catálogo a partir del diagrama
    diag = session.get(DiagramaDeFlujo, id_diagrama)
    cat = session.get(Catalogo, diag.id_catalogo) if diag and diag.id_catalogo else None

    return {
        "id_diagrama": id_diagrama,
        "catalogo": ({"id_catalogo": cat.id_catalogo, "nombre": cat.nombre} if cat else None),
        "procesos": procesos
    }

@router.put("/{id_proceso:int}")
def update_proceso_endpoint(id_proceso: int, data: Proceso, session: Session = Depends(get_session)):
    proceso = proceso_crud.update_proceso(session, id_proceso, data)
    if not proceso:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return {"status": "ok", "proceso_actualizado": proceso.id_proceso}

@router.delete("/{id_proceso:int}")
def delete_proceso_endpoint(
    id_proceso: int,
    session: Session = Depends(get_session),
):
    deleted = proceso_crud.delete_proceso(session, id_proceso)
    if not deleted:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    # puedes devolver lo que quieras; el front no usa la respuesta
    return {"status": "ok", "id_eliminado": id_proceso}

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

@router.patch("/{proceso_id:int}/tipo", response_model=Proceso)
def cambiar_tipo_proceso(
    proceso_id: int,
    payload: ProcesoTipoUpdate,  # {"tipo": "NORMAL" | "ALMACENAMIENTO"}
    session: Session = Depends(get_session),
):
    try:
        updated = proceso_crud.set_tipo_en_proceso(session, proceso_id, payload.tipo)
    except ValueError as e:
        raise HTTPException(status_code=422, detail=str(e))
    if not updated:
        raise HTTPException(status_code=404, detail="Proceso no encontrado")
    return updated