from sqlmodel import select, Session
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta, RecetaDetalle


def get_diagrama_detalle(session: Session, id_catalogo: int):
    # Diagrama principal
    diagrama_principal = session.exec(
        select(DiagramaDeFlujo).where(
            DiagramaDeFlujo.id_catalogo == id_catalogo,
            DiagramaDeFlujo.es_principal == True
        )
    ).first()
    if not diagrama_principal:
        return {"message": "No se encontró diagrama principal"}

    procesos_principal = session.exec(
        select(Proceso).where(Proceso.id_diagrama == diagrama_principal.id_diagrama)
    ).all()

    # Subdiagramas asociados
    subdiagramas = session.exec(
        select(DiagramaDeFlujo).where(
            DiagramaDeFlujo.id_catalogo == id_catalogo,
            DiagramaDeFlujo.es_principal == False
        )
    ).all()

    subdiagramas_data = []
    for sub in subdiagramas:
        procesos_sub = session.exec(
            select(Proceso).where(Proceso.id_diagrama == sub.id_diagrama)
        ).all()
        subdiagramas_data.append({
            "id_diagrama": sub.id_diagrama,
            "nombre": sub.nombre,
            "descripcion": sub.descripcion,
            "procesos": procesos_sub,
        })

    # Dependencias globales
    dependencias = session.exec(select(ProcesoDependencia)).all()

    # Recetas opcionales
    recetas = []
    for proc in procesos_principal:
        rec = session.exec(
            select(Receta).where(Receta.id_proceso == proc.id_proceso)
        ).first()
        if rec:
            detalles = session.exec(
                select(RecetaDetalle).where(RecetaDetalle.id_receta == rec.id_receta)
            ).all()
            recetas.append({
                "id_receta": rec.id_receta,
                "id_proceso": rec.id_proceso,
                "id_diagrama": rec.id_diagrama,
                "cantidad_producida": rec.cantidad_producida,
                "detalles": [
                    {
                        "id_materia": d.id_materia,
                        "cantidad_requerida": d.cantidad_requerida
                    }
                    for d in detalles
                ],
            })

    return {
        "diagrama_principal": {
            "id_diagrama": diagrama_principal.id_diagrama,
            "nombre": diagrama_principal.nombre,
            "descripcion": diagrama_principal.descripcion,
            "procesos": procesos_principal,
        },
        "subdiagramas": subdiagramas_data,
        "dependencias": [
            {"id_origen": d.id_origen, "id_destino": d.id_destino}
            for d in dependencias
        ],
        "recetas": recetas,
    }