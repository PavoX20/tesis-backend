from fastapi import APIRouter, HTTPException, Depends
from base64 import b64encode
from typing import List
from sqlmodel import Session

from app.core.database import get_session
from app.crud import dato_proceso_crud as crud_procesos

from app.services.stats.selector import seleccionar_y_graficar, parametros_requeridos
from app.services.stats.plots import ax_to_png_bytes

from app.api.schemas import AutoResponse, ManualRequest, ManualResponse, RankedItem

router = APIRouter(prefix="/analysis", tags=["analysis"])


def _get_tiempos_segundos(session: Session, proceso_id: int) -> List[float]:
    """
    Lee los tiempos de BD (columna tiempo_total_seg) y los convierte a float.
    """
    tiempos = crud_procesos.get_tiempos_proceso(session, proceso_id)
    return [float(x) for x in tiempos if x is not None]


@router.get("/processes/{proceso_id}/distribution", response_model=AutoResponse)
def distribution_auto(
    proceso_id: int,
    umbral: int = 20,
    session: Session = Depends(get_session),
):
    """
    - Si N >= umbral → modo 'auto': devuelve ranking, selección recomendada e imagen.
    - Si N <  umbral → modo 'manual': indica que el usuario debe elegir distribución/params.
    """
    x = _get_tiempos_segundos(session, proceso_id)
    n = len(x)
    if n == 0:
        raise HTTPException(404, "Proceso sin datos")

    # Caso N < umbral → no intentamos ajustar, solo avisamos al front.
    if n < umbral:
        return AutoResponse(
            modo="manual",
            seleccion=None,
            parametros=[],
            mensaje=f"Proceso con solo {n} mediciones (<{umbral}). Selecciona distribución y parámetros manualmente.",
            ranking=[],
            image_base64=None,
        )

    # Caso N >= umbral → usamos selección automática
    out = seleccionar_y_graficar(x, umbral=umbral)
    ax = out["ax"]
    img_b64 = b64encode(ax_to_png_bytes(ax)).decode("ascii")

    ranking = out.get("ranking") or []
    ranking_models = [
        RankedItem(
            titulo=r[0],
            ks=r[1],
            p=r[2],
            r2=r[3],
            distrib=r[4],
            parametros=r[5],
        )
        for r in ranking
    ]

    return AutoResponse(
        modo=out.get("modo", "auto"),
        seleccion=out["seleccion"],
        parametros=out["parametros"],
        mensaje=out["mensaje"],
        ranking=ranking_models,
        image_base64=img_b64,
    )


@router.post("/processes/{proceso_id}/distribution/manual", response_model=ManualResponse)
def distribution_manual(
    proceso_id: int,
    req: ManualRequest,
    session: Session = Depends(get_session),
):
    """
    Usa los parámetros enviados por el usuario para graficar la distribución elegida.
    Se usa tanto cuando N < umbral como cuando el usuario sobrescribe la recomendada.
    """
    x = _get_tiempos_segundos(session, proceso_id)
    if len(x) == 0:
        raise HTTPException(404, "Proceso sin datos")

    try:
        out = seleccionar_y_graficar(
            x,
            nombre=req.nombre,
            parametros=req.parametros,
            umbral=req.umbral,
        )
    except ValueError as e:
        # errores de parámetros no válidos, distribución no soportada, etc.
        raise HTTPException(status_code=400, detail=str(e))

    ax = out["ax"]
    img_b64 = b64encode(ax_to_png_bytes(ax)).decode("ascii")

    return ManualResponse(
        seleccion=out["seleccion"],
        parametros=out["parametros"],
        mensaje=out["mensaje"],
        image_base64=img_b64,
    )


@router.get("/distributions/{nombre}/params", response_model=List[str])
def distribution_param_names(nombre: str):
    """
    Devuelve la lista de nombres de parámetros requeridos para una distribución
    (por ejemplo: ['media', 'desviacion'] para 'norm').
    Útil para construir los formularios en el front cuando N < umbral.
    """
    try:
        return parametros_requeridos(nombre)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))