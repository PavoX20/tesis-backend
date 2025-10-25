from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session
from app.core.database import get_session
from app.models.receta import Receta, RecetaDetalle
from app.crud.receta_crud import (
    create_receta,
    get_recetas_by_diagrama,
    get_receta_by_id,
    delete_receta,
    create_receta_detalle,
    get_detalles_by_receta
)

router = APIRouter(prefix="/recetas", tags=["Recetas"])


@router.post("/")
def crear_receta(receta: Receta, session: Session = Depends(get_session)):
    try:
        nueva_receta = create_receta(session, receta)
        return {
            "message": "Receta creada correctamente",
            "data": nueva_receta
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{id_diagrama}")
def listar_recetas(id_diagrama: int, session: Session = Depends(get_session)):
    recetas = get_recetas_by_diagrama(session, id_diagrama)
    if not recetas:
        raise HTTPException(status_code=404, detail="No hay recetas para este diagrama")
    return {
        "id_diagrama": id_diagrama,
        "recetas": recetas
    }

# ---------- Crear receta ----------
@router.post("/", response_model=dict)
def crear_receta(receta: Receta, session: Session = Depends(get_session)):
    new_receta = create_receta(session, receta)
    return {"message": "Receta creada correctamente", "data": new_receta}


# ---------- Listar recetas por diagrama ----------
@router.get("/{id_diagrama}", response_model=dict)
def listar_recetas(id_diagrama: int, session: Session = Depends(get_session)):
    recetas = get_recetas_by_diagrama(session, id_diagrama)
    if not recetas:
        raise HTTPException(status_code=404, detail="No hay recetas para este diagrama")
    return {"id_diagrama": id_diagrama, "recetas": recetas}


# ---------- Obtener una receta por ID ----------
@router.get("/detalle/{id_receta}", response_model=dict)
def obtener_receta(id_receta: int, session: Session = Depends(get_session)):
    receta = get_receta_by_id(session, id_receta)
    if not receta:
        raise HTTPException(status_code=404, detail="Receta no encontrada")
    detalles = get_detalles_by_receta(session, id_receta)
    return {"receta": receta, "detalles": detalles}


# ---------- Eliminar una receta ----------
@router.delete("/{id_receta}", response_model=dict)
def eliminar_receta(id_receta: int, session: Session = Depends(get_session)):
    ok = delete_receta(session, id_receta)
    if not ok:
        raise HTTPException(status_code=404, detail="Receta no encontrada")
    return {"message": "Receta eliminada correctamente"}


# ---------- Crear detalle de receta ----------
@router.post("/detalle", response_model=dict)
def crear_detalle(detalle: RecetaDetalle, session: Session = Depends(get_session)):
    new_detalle = create_receta_detalle(session, detalle)
    return {"message": "Detalle agregado correctamente", "data": new_detalle}