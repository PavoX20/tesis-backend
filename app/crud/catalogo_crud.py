from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta, RecetaDetalle


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

    # Buscar diagramas del catálogo
    diagramas = session.exec(select(DiagramaDeFlujo).where(DiagramaDeFlujo.id_catalogo == catalogo_id)).all()

    for diagrama in diagramas:
        # Eliminar dependencias asociadas a los procesos del diagrama
        procesos = session.exec(select(Proceso).where(Proceso.id_diagrama == diagrama.id_diagrama)).all()
        proceso_ids = [p.id_proceso for p in procesos]

        if proceso_ids:
            session.exec(
                ProcesoDependencia.__table__.delete().where(
                    (ProcesoDependencia.id_origen.in_(proceso_ids)) |
                    (ProcesoDependencia.id_destino.in_(proceso_ids))
                )
            )

            # Eliminar recetas y detalles
            recetas = session.exec(select(Receta).where(Receta.id_diagrama == diagrama.id_diagrama)).all()
            for receta in recetas:
                session.exec(
                    RecetaDetalle.__table__.delete().where(RecetaDetalle.id_receta == receta.id_receta)
                )
            session.exec(Receta.__table__.delete().where(Receta.id_diagrama == diagrama.id_diagrama))

        # Eliminar procesos
        session.exec(Proceso.__table__.delete().where(Proceso.id_diagrama == diagrama.id_diagrama))

    # Eliminar diagramas del catálogo
    session.exec(DiagramaDeFlujo.__table__.delete().where(DiagramaDeFlujo.id_catalogo == catalogo_id))

    # Finalmente eliminar el catálogo
    session.delete(catalogo)
    session.commit()
    return True