from sqlmodel import Session, select
from app.models.catalogo import Catalogo
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.proceso_model import Proceso
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.receta import Receta

def get_all_catalogos(session: Session):
    return session.exec(select(Catalogo)).all()

def get_catalogo_by_id(session: Session, catalogo_id: int):
    return session.get(Catalogo, catalogo_id)

def create_catalogo(session: Session, data: Catalogo):
    session.add(data)
    session.commit()
    session.refresh(data)
    return data

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

def delete_catalogo(session: Session, catalogo_id: int):
    catalogo = session.get(Catalogo, catalogo_id)
    if not catalogo:
        return None

    proc_ids = session.exec(
        select(Proceso.id_proceso)
        .join(DiagramaDeFlujo, DiagramaDeFlujo.id_diagrama == Proceso.id_diagrama)
        .where(DiagramaDeFlujo.id_catalogo == catalogo_id)
    ).all()

    if proc_ids:

        session.exec(Receta.__table__.delete().where(Receta.id_proceso.in_(proc_ids)))

    session.exec(
        Proceso.__table__.delete().where(
            Proceso.id_diagrama.in_(
                select(DiagramaDeFlujo.id_diagrama).where(DiagramaDeFlujo.id_catalogo == catalogo_id)
            )
        )
    )

    session.exec(DiagramaDeFlujo.__table__.delete().where(DiagramaDeFlujo.id_catalogo == catalogo_id))

    session.delete(catalogo)
    session.commit()
    return True