from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso_model import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta


# ==============================
# 🔹 OBTENER TODOS LOS CATÁLOGOS
# ==============================
def get_all_catalogos(session: Session):
    return session.exec(select(Catalogo)).all()


# ==============================
# 🔹 OBTENER CATÁLOGO POR ID
# ==============================
def get_catalogo_by_id(session: Session, catalogo_id: int):
    return session.get(Catalogo, catalogo_id)


# ==============================
# 🔹 CREAR CATÁLOGO
# ==============================
def create_catalogo(session: Session, data: Catalogo):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data


# ==============================
# 🔹 ACTUALIZAR CATÁLOGO
# ==============================
def update_catalogo(session: Session, catalogo_id: int, data: Catalogo):
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None

    for key, value in data.dict(exclude_unset=True).items():
        setattr(catalogo, key, value)

    session.add(catalogo)
    session.commit()
    session.refresh(catalogo)
    return catalogo


# ==============================
# 🔹 ELIMINAR CATÁLOGO EN CASCADA
# ==============================
def delete_catalogo(session: Session, catalogo_id: int):
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None

    # procesos de todos los diagramas del catálogo
    proc_ids = session.exec(
        select(Proceso.id_proceso)
        .join(DiagramaDeFlujo, DiagramaDeFlujo.id_diagrama == Proceso.id_diagrama)
        .where(DiagramaDeFlujo.id_catalogo == catalogo_id)
    ).all()

    if proc_ids:
        # borra filas de receta del conjunto de procesos
        session.exec(Receta.__table__.delete().where(Receta.id_proceso.in_(proc_ids)))
        # cascada se encarga de procesos_dependencias al borrar procesos

    # borra procesos (por si no confías en la cascada posterior)
    session.exec(
        Proceso.__table__.delete().where(
            Proceso.id_diagrama.in_(
                select(DiagramaDeFlujo.id_diagrama).where(DiagramaDeFlujo.id_catalogo == catalogo_id)
            )
        )
    )
    # borra diagramas
    session.exec(DiagramaDeFlujo.__table__.delete().where(DiagramaDeFlujo.id_catalogo == catalogo_id))
    # borra catálogo
    session.delete(catalogo)
    session.commit()
    return True