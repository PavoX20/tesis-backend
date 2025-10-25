from sqlmodel import Session, select
from app.models.proceso import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta
from app.models.receta import RecetaDetalle
from app.models.materia_prima import MateriaPrima
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama

def get_grafo_by_diagrama(session: Session, id_diagrama: int):
    diagrama = session.get(Diagrama, id_diagrama)
    if not diagrama:
        return None

    # Procesos del diagrama actual
    procesos = session.exec(select(Proceso).where(Proceso.id_diagrama == id_diagrama)).all()
    procesos_ids = [p.id_proceso for p in procesos]

    # Dependencias internas + cruzadas (que conecten cualquier proceso relacionado)
    dependencias = session.exec(
        select(ProcesoDependencia)
        .where(
            (ProcesoDependencia.id_origen.in_(procesos_ids)) |
            (ProcesoDependencia.id_destino.in_(procesos_ids))
        )
    ).all()

    # Recetas del diagrama
    recetas = session.exec(select(Receta).where(Receta.id_diagrama == id_diagrama)).all()

    recetas_detalle = []
    for r in recetas:
        detalles = session.exec(select(RecetaDetalle).where(RecetaDetalle.id_receta == r.id_receta)).all()
        materiales = []
        for det in detalles:
            materia = session.get(MateriaPrima, det.id_materia)
            materiales.append({
                "nombre": materia.nombre if materia else "Desconocido",
                "cantidad": det.cantidad_requerida
            })
        recetas_detalle.append({
            "id_receta": r.id_receta,
            "producto": session.get(MateriaPrima, r.id_producto).nombre,
            "cantidad_producida": r.cantidad_producida,
            "materiales": materiales
        })

    return {
        "diagrama": {"id": diagrama.id_diagrama, "nombre": diagrama.nombre},
        "procesos": [
            {
                "id_proceso": p.id_proceso,
                "nombre_proceso": p.nombre_proceso,
                "orden": p.orden,
                "distribucion": p.distribucion,
                "id_tipomaquina": p.id_tipomaquina,
                "id_receta": p.id_receta,
            }
            for p in procesos
        ],
        "dependencias": [
            {"id_origen": d.id_origen, "id_destino": d.id_destino}
            for d in dependencias
        ],
        "recetas": recetas_detalle
    }
    

def get_grafo_by_catalogo(session: Session, id_catalogo: int):
    # Obtener todos los diagramas del catálogo
    diagramas = session.exec(
        select(Diagrama).where(Diagrama.id_catalogo == id_catalogo)
    ).all()
    if not diagramas:
        return None

    resultado = {"id_catalogo": id_catalogo, "diagramas": []}

    for d in diagramas:
        # Procesos
        procesos = session.exec(
            select(Proceso).where(Proceso.id_diagrama == d.id_diagrama)
        ).all()
        procesos_data = [
            {
                "id_proceso": p.id_proceso,
                "nombre_proceso": p.nombre_proceso,
                "orden": p.orden,
                "distribucion": p.distribucion,
                "id_tipomaquina": p.id_tipomaquina,
                "id_receta": p.id_receta,
            }
            for p in procesos
        ]

        # Dependencias internas del diagrama
        dependencias = session.exec(select(ProcesoDependencia)).all()
        dependencias_data = [
            {"id_origen": dep.id_origen, "id_destino": dep.id_destino}
            for dep in dependencias
            if dep.id_origen and dep.id_destino
        ]

        # Recetas por proceso
        recetas = session.exec(
            select(Receta).where(Receta.id_diagrama == d.id_diagrama)
        ).all()

        recetas_data = []
        for r in recetas:
            detalles = session.exec(
                select(RecetaDetalle, MateriaPrima)
                .join(MateriaPrima, MateriaPrima.id_materia == RecetaDetalle.id_materia)
                .where(RecetaDetalle.id_receta == r.id_receta)
            ).all()

            recetas_data.append({
                "id_receta": r.id_receta,
                "producto": session.exec(
                    select(MateriaPrima.nombre).where(MateriaPrima.id_materia == r.id_producto)
                ).first(),
                "cantidad_producida": r.cantidad_producida,
                "materiales": [
                    {"nombre": m.MateriaPrima.nombre, "cantidad": m.RecetaDetalle.cantidad_requerida}
                    for m in detalles
                ]
            })

        resultado["diagramas"].append({
            "id_diagrama": d.id_diagrama,
            "nombre": d.nombre,
            "es_principal": d.es_principal,
            "procesos": procesos_data,
            "dependencias": dependencias_data,
            "recetas": recetas_data,
        })

    return resultado