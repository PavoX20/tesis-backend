from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import Session, select
from app.core.database import get_session
from app.crud.grafo_crud import get_grafo_by_catalogo, get_grafo_by_diagrama
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama
from app.models.catalogo import Catalogo

router = APIRouter(prefix="/grafo", tags=["Grafo"])

# ---------------------------------------------------------
# 1️⃣ Listar solo los diagramas principales (productos finales)
# ---------------------------------------------------------
@router.get("/productos-finales")
def get_productos_finales(session: Session = Depends(get_session)):
    diagramas = session.exec(
        select(Diagrama).where(Diagrama.es_principal == True)
    ).all()

    if not diagramas:
        raise HTTPException(status_code=404, detail="No se encontraron diagramas principales")

    data = []
    for d in diagramas:
        nombre_catalogo = session.exec(
            select(Catalogo.nombre).where(Catalogo.id_catalogo == d.id_catalogo)
        ).first()

        data.append({
            "id_diagrama": d.id_diagrama,
            "nombre_diagrama": d.nombre,
            "nombre_catalogo": nombre_catalogo
        })

    return {"productos_finales": data}


# ---------------------------------------------------------
# 2️⃣ Obtener el grafo completo de un diagrama por ID
# ---------------------------------------------------------
@router.get("/{id_diagrama}")
def get_grafo(id_diagrama: int, session: Session = Depends(get_session)):
    result = get_grafo_by_diagrama(session, id_diagrama)
    if not result:
        raise HTTPException(status_code=404, detail="Diagrama no encontrado")
    return result

@router.get("/catalogo/{id_catalogo}")
def get_grafo_catalogo(id_catalogo: int, session: Session = Depends(get_session)):
    result = get_grafo_by_catalogo(session, id_catalogo)
    if not result:
        raise HTTPException(status_code=404, detail="Catálogo no encontrado o sin diagramas")
    return result