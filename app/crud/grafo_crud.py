from typing import Dict, List
from sqlmodel import Session, select
from app.models.proceso_model import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta
from app.models.materia_model import Materia   
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama

def _receta_por_procesos(session: Session, proceso_ids: List[int]) -> Dict[int, dict]:
    if not proceso_ids:
        return {}
    rows = session.exec(
        select(Receta, Materia)
        .join(Materia, Materia.id_materia == Receta.id_materia)
        .where(Receta.id_proceso.in_(proceso_ids))
        .order_by(Receta.id_proceso, Receta.id_receta)
    ).all()
    by_proc: Dict[int, dict] = {}
    for r, m in rows:
        item = {
            "id_receta": r.id_receta,
            "id_materia": m.id_materia,
            "nombre": m.nombre,
            "unidad": m.unidad,
            "cantidad": r.cantidad,
        }
        slot = "entradas" if r.rol == "IN" else "salidas"
        by_proc.setdefault(r.id_proceso, {"entradas": [], "salidas": []})[slot].append(item)
    return by_proc

def get_grafo_by_diagrama(session: Session, id_diagrama: int):
    diagrama = session.get(Diagrama, id_diagrama)
    if not diagrama:
        return None

    procesos = session.exec(
        select(Proceso).where(Proceso.id_diagrama == id_diagrama).order_by(Proceso.orden)
    ).all()
    proceso_ids = [p.id_proceso for p in procesos]

    dependencias = session.exec(
        select(ProcesoDependencia).where(
            (ProcesoDependencia.id_origen.in_(proceso_ids)) |
            (ProcesoDependencia.id_destino.in_(proceso_ids))
        )
    ).all()

    receta_map = _receta_por_procesos(session, proceso_ids)

    return {
        "diagrama": {"id": diagrama.id_diagrama, "nombre": diagrama.nombre},
        "procesos": [
            {
                "id_proceso": p.id_proceso,
                "nombre_proceso": p.nombre_proceso,
                "orden": p.orden,
                "distribucion": p.distribucion,
                "id_tipomaquina": p.id_tipomaquina,
            }
            for p in procesos
        ],
        "dependencias": [{"id_origen": d.id_origen, "id_destino": d.id_destino} for d in dependencias],
        "recetas": [
            {"id_proceso": pid, **receta_map.get(pid, {"entradas": [], "salidas": []})}
            for pid in proceso_ids
        ],
    }

def get_grafo_by_catalogo(session: Session, id_catalogo: int):
    diagramas = session.exec(select(Diagrama).where(Diagrama.id_catalogo == id_catalogo)).all()
    if not diagramas:
        return None

    out = {"id_catalogo": id_catalogo, "diagramas": []}
    for d in diagramas:
        procesos = session.exec(
            select(Proceso).where(Proceso.id_diagrama == d.id_diagrama).order_by(Proceso.orden)
        ).all()
        proceso_ids = [p.id_proceso for p in procesos]

        dependencias = session.exec(
            select(ProcesoDependencia).where(
                (ProcesoDependencia.id_origen.in_(proceso_ids)) |
                (ProcesoDependencia.id_destino.in_(proceso_ids))
            )
        ).all()

        receta_map = _receta_por_procesos(session, proceso_ids)

        out["diagramas"].append({
            "id_diagrama": d.id_diagrama,
            "nombre": d.nombre,
            "es_principal": d.es_principal,
            "procesos": [
                {
                    "id_proceso": p.id_proceso,
                    "nombre_proceso": p.nombre_proceso,
                    "orden": p.orden,
                    "distribucion": p.distribucion,
                    "id_tipomaquina": p.id_tipomaquina,
                } for p in procesos
            ],
            "dependencias": [{"id_origen": dep.id_origen, "id_destino": dep.id_destino} for dep in dependencias],
            "recetas": [
                {"id_proceso": pid, **receta_map.get(pid, {"entradas": [], "salidas": []})}
                for pid in proceso_ids
            ],
        })
    return out