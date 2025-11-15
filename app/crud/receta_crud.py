from typing import Any, List, Dict, Tuple
from sqlmodel import Session, delete, select
from app.models.materia_model import Materia
from app.models.proceso_model import Proceso
from app.models.receta import Receta


def get_receta_by_proceso(session: Session, id_proceso: int) -> Dict[str, list]:
    rows = session.exec(
        select(Receta, Materia)
        .join(Materia, Materia.id_materia == Receta.id_materia)
        .where(Receta.id_proceso == id_proceso)
    ).all()

    entradas, salidas = [], []
    for r, m in rows:
        item = {
            "id_receta": r.id_receta,
            "id_proceso": r.id_proceso,
            "id_materia": r.id_materia,
            "rol": r.rol,
            "cantidad": float(r.cantidad),
            "materia_nombre": m.nombre,
            "unidad": m.unidad,
        }
        (entradas if r.rol == "IN" else salidas).append(item)

    return {"entradas": entradas, "salidas": salidas}

def _validar_materias(session: Session, entradas: List[Dict], salidas: List[Dict]) -> None:
    ids = {e["id_materia"] for e in entradas} | {s["id_materia"] for s in salidas}
    if not ids:
        return
    existentes = set(session.exec(
        select(Materia.id_materia).where(Materia.id_materia.in_(ids))
    ).all())
    faltantes = ids - existentes
    if faltantes:
        raise ValueError(f"Materias inexistentes: {sorted(faltantes)}")

def replace_receta(
    session: Session,
    id_proceso: int,
    entradas: List[Dict[str, Any]],
    salidas: List[Dict[str, Any]],
) -> Dict[str, int]:
    _validar_materias(session, entradas, salidas)

    session.exec(delete(Receta).where(Receta.id_proceso == id_proceso))
    session.commit()

    rows: list[Receta] = []
    rows += [Receta(id_proceso=id_proceso, id_materia=x["id_materia"], rol="IN",  cantidad=x["cantidad"]) for x in entradas]
    rows += [Receta(id_proceso=id_proceso, id_materia=x["id_materia"], rol="OUT", cantidad=x["cantidad"]) for x in salidas]

    if rows:
        session.add_all(rows)
        session.commit()

    return {"inserted": len(rows)}

