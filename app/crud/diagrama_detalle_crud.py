from sqlmodel import select, Session
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso_model import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta
from app.models.materia_model import Materia  

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
        select(Proceso).where(Proceso.id_diagrama == diagrama_principal.id_diagrama).order_by(Proceso.orden)
    ).all()

    # Subdiagramas
    subdiagramas = session.exec(
        select(DiagramaDeFlujo).where(
            DiagramaDeFlujo.id_catalogo == id_catalogo,
            DiagramaDeFlujo.es_principal == False
        )
    ).all()

    subdiagramas_data = []
    for sub in subdiagramas:
        procesos_sub = session.exec(
            select(Proceso).where(Proceso.id_diagrama == sub.id_diagrama).order_by(Proceso.orden)
        ).all()
        subdiagramas_data.append({
            "id_diagrama": sub.id_diagrama,
            "nombre": sub.nombre,
            "descripcion": sub.descripcion,
            "procesos": procesos_sub,
        })

    # Dependencias
    dependencias = session.exec(select(ProcesoDependencia)).all()

    # Recetas por proceso del principal (N IN / N OUT)
    recetas = []
    for proc in procesos_principal:
        filas = session.exec(
            select(Receta, Materia)
            .join(Materia, Materia.id_materia == Receta.id_materia)
            .where(Receta.id_proceso == proc.id_proceso)
            .order_by(Receta.id_receta)
        ).all()

        entradas = [
            {"id_receta": r.id_receta, "id_materia": m.id_materia, "nombre": m.nombre, "unidad": m.unidad, "cantidad": r.cantidad}
            for (r, m) in filas if r.rol == "IN"
        ]
        salidas = [
            {"id_receta": r.id_receta, "id_materia": m.id_materia, "nombre": m.nombre, "unidad": m.unidad, "cantidad": r.cantidad}
            for (r, m) in filas if r.rol == "OUT"
        ]

        recetas.append({
            "id_proceso": proc.id_proceso,
            "entradas": entradas,
            "salidas": salidas,
        })

    return {
        "diagrama_principal": {
            "id_diagrama": diagrama_principal.id_diagrama,
            "nombre": diagrama_principal.nombre,
            "descripcion": diagrama_principal.descripcion,
            "procesos": procesos_principal,
        },
        "subdiagramas": subdiagramas_data,
        "dependencias": [{"id_origen": d.id_origen, "id_destino": d.id_destino} for d in dependencias],
        "recetas": recetas,
    }