# app/crud/proceso_detalle_crud.py
from typing import List
from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.proceso_model import Proceso
from app.models.tipo_maquina import TipoMaquina
from app.models.area import Area
from app.models.receta import Receta
from app.models.materia_model import Materia
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama

def get_proceso_detalle(session: Session, id_proceso: int):
    # Proceso
    proceso = session.get(Proceso, id_proceso)
    if not proceso:
        return None

    # Diagrama y catálogo del proceso
    diagrama = session.get(Diagrama, proceso.id_diagrama) if proceso.id_diagrama else None
    catalogo = session.get(Catalogo, diagrama.id_catalogo) if diagrama and diagrama.id_catalogo else None

    # Tipo de máquina y área
    tipo_maquina = session.get(TipoMaquina, proceso.id_tipomaquina) if proceso.id_tipomaquina else None
    area = session.get(Area, tipo_maquina.id_area) if (tipo_maquina and tipo_maquina.id_area) else None

    # Receta: N entradas y N salidas
    filas = session.exec(
        select(Receta, Materia)
        .join(Materia, Materia.id_materia == Receta.id_materia)
        .where(Receta.id_proceso == id_proceso)
        .order_by(Receta.id_receta)
    ).all()

    entradas = [
        {
            "id_receta": r.id_receta,
            "id_materia": m.id_materia,
            "nombre": m.nombre,
            "unidad": m.unidad,
            "cantidad": r.cantidad,
        }
        for (r, m) in filas if r.rol == "IN"
    ]
    salidas = [
        {
            "id_receta": r.id_receta,
            "id_materia": m.id_materia,
            "nombre": m.nombre,
            "unidad": m.unidad,
            "cantidad": r.cantidad,
        }
        for (r, m) in filas if r.rol == "OUT"
    ]

    return {
        "proceso": {
            "id_proceso": proceso.id_proceso,
            "nombre_proceso": proceso.nombre_proceso,
            "distribucion": proceso.distribucion,
            "parametros": proceso.parametros,
            "duracion": proceso.duracion,
            "orden": proceso.orden,
            "tipo": proceso.tipo,                       # <-- ya lo tenías
            "id_diagrama": proceso.id_diagrama,         # <-- nuevo
        },
        "catalogo": (                                   # <-- nuevo bloque
            {
                "id_catalogo": catalogo.id_catalogo,
                "nombre": catalogo.nombre,
            } if catalogo else None
        ),
        "tipo_maquina": (
            {
                "id_tipomaquina": tipo_maquina.id_tipomaquina,
                "nombre_maquina": tipo_maquina.nombre_maquina,
                "cantidad_maquinas": tipo_maquina.cantidad_maquinas,
                "personal_max": tipo_maquina.personal_max,
            } if tipo_maquina else None
        ),
        "area": (
            {
                "id_area": area.id_area,
                "nombre": area.nombre,
                "tipo": area.tipo,
                "personal": area.personal,
                "restriccion": area.restriccion,
            } if area else None
        ),
        "receta": {"entradas": entradas, "salidas": salidas},
    }


def get_receta_by_proceso(session: Session, id_proceso: int) -> List[Receta]:
    return session.exec(select(Receta).where(Receta.id_proceso == id_proceso)).all()

def add_receta_row(session: Session, id_proceso: int, id_materia: int, rol: str, cantidad: float) -> Receta:
    r = Receta(id_proceso=id_proceso, id_materia=id_materia, rol=rol, cantidad=cantidad)
    session.add(r)
    session.commit()
    session.refresh(r)
    return r