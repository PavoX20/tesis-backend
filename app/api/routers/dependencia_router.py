from typing import List
from fastapi import APIRouter, Depends, HTTPException, Query, Response
from pydantic import BaseModel
from sqlmodel import Session
from app.core.database import get_session
from app.crud import dependencia_crud
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.proceso_model import Proceso
from sqlmodel import SQLModel

router = APIRouter(prefix="/dependencias", tags=["Dependencias"])

class DependenciaCreate(SQLModel):
    id_origen: int
    id_destino: int

class ProcesoMini(SQLModel):
    id_proceso: int
    nombre_proceso: str
    orden: int | None = None
    id_diagrama: int

class DependenciasDeProcesoRead(SQLModel):
    predecesores: List[ProcesoMini]
    sucesores: List[ProcesoMini]

class DependenciasDeProcesoUpdate(SQLModel):
    sucesores: List[int] = []

@router.post("/", response_model=ProcesoDependencia, status_code=201)
def crear_dependencia(payload: DependenciaCreate,
                      exigir_mismo_diagrama: bool = Query(True, description="Bloquear cruces entre diagramas"),
                      session: Session = Depends(get_session)):
    try:
        return dependencia_crud.crear(session, payload.id_origen, payload.id_destino, exigir_mismo_diagrama)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.delete("/", status_code=204)
def eliminar_dependencia(id_origen: int, id_destino: int, session: Session = Depends(get_session)):
    ok = dependencia_crud.eliminar(session, id_origen, id_destino)
    if not ok:
        raise HTTPException(404, "Dependencia no encontrada")
    return

@router.get("/procesos/{id_proceso}", response_model=DependenciasDeProcesoRead)
def obtener_dependencias_de_proceso(id_proceso: int, session: Session = Depends(get_session)):
    pred, succ = dependencia_crud.listar_por_proceso(session, id_proceso)
    if pred is None and succ is None:
        raise HTTPException(404, "Proceso no encontrado")

    def mini(p: Proceso) -> ProcesoMini:
        return ProcesoMini(
            id_proceso=p.id_proceso,
            nombre_proceso=p.nombre_proceso,
            orden=p.orden,
            id_diagrama=p.id_diagrama,
        )

    return DependenciasDeProcesoRead(
        predecesores=[mini(p) for p in pred],
        sucesores=[mini(p) for p in succ],
    )

class PredecesoresBody(BaseModel):
    predecesores: list[int] = []

@router.get("/procesos/{id_proceso}")
def get_dependencias(id_proceso: int, session: Session = Depends(get_session)):
    try:
        pre, suc = dependencia_crud.listar_por_proceso(session, id_proceso)
    except Exception as e:
        raise HTTPException(400, str(e))

    def proj(p: Proceso):
        return {
            "id_proceso": p.id_proceso,
            "nombre_proceso": p.nombre_proceso,
            "orden": p.orden,
            "id_diagrama": p.id_diagrama,
        }

    return {"predecesores": [proj(p) for p in pre], "sucesores": [proj(s) for s in suc]}

@router.put("/procesos/{id_proceso}", status_code=204)
def put_predecesores(
    id_proceso: int,
    body: PredecesoresBody,
    exigir_mismo_diagrama: bool = Query(True),
    session: Session = Depends(get_session),
):
    try:
        dependencia_crud.reemplazar_predecesores(
            session, id_proceso, body.predecesores, exigir_mismo_diagrama=exigir_mismo_diagrama
        )
    except ValueError as e:
        raise HTTPException(400, str(e))
    return Response(status_code=204)