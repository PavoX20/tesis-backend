# api/routers/analysis_router.py
from fastapi import APIRouter, HTTPException
from base64 import b64encode
from typing import List
from app.crud import dato_proceso_crud as crud_procesos

from app.services.stats.distribuciones import Distribuciones
from app.services.stats.selector import seleccionar_y_graficar, parametros_requeridos
from app.services.stats.plots import ax_to_png_bytes

from app.api.schemas import AutoResponse, ManualRequest, ManualResponse, RankedItem

# TODO: implementa este módulo en tu capa CRUD


router = APIRouter(prefix="/analysis", tags=["analysis"])

def _get_tiempos_segundos(proceso_id: int) -> List[float]:
    # TODO: implementa en tu capa CRUD:
    # - traer los registros del proceso/artículo
    # - convertir a segundos si vienen como timedelta/hh:mm:ss
    tiempos = crud_procesos.get_tiempos_proceso(proceso_id)  # -> list[float] en segundos
    return [float(x) for x in tiempos if x is not None]

@router.get("/processes/{proceso_id}/distribution", response_model=AutoResponse)
def distribution_auto(proceso_id: int, umbral: int = 20):
    x = _get_tiempos_segundos(proceso_id)
    if len(x) == 0:
        raise HTTPException(404, "Proceso sin datos")

    out = seleccionar_y_graficar(x, umbral=umbral)
    ax = out["ax"]
    img_b64 = b64encode(ax_to_png_bytes(ax)).decode("ascii")

    ranking = out.get("ranking") or []
    ranking_models = [
        RankedItem(
            titulo=r[0], ks=r[1], p=r[2], r2=r[3], distrib=r[4], parametros=r[5]
        ) for r in ranking
    ]

    return AutoResponse(
        seleccion=out["seleccion"],
        parametros=out["parametros"],
        mensaje=out["mensaje"],
        ranking=ranking_models,
        image_base64=img_b64,
    )

@router.post("/processes/{proceso_id}/distribution/manual", response_model=ManualResponse)
def distribution_manual(proceso_id: int, req: ManualRequest):
    x = _get_tiempos_segundos(proceso_id)
    if len(x) == 0:
        raise HTTPException(404, "Proceso sin datos")

    out = seleccionar_y_graficar(x, nombre=req.nombre, parametros=req.parametros, umbral=req.umbral)
    ax = out["ax"]
    img_b64 = b64encode(ax_to_png_bytes(ax)).decode("ascii")

    return ManualResponse(
        seleccion=out["seleccion"],
        parametros=out["parametros"],
        mensaje=out["mensaje"],
        image_base64=img_b64,
    )