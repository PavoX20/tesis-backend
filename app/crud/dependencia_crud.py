from typing import Iterable, List, Tuple
from sqlmodel import Session, select, delete
from app.models.diagrama_de_flujo import DiagramaDeFlujo
from app.models.procesos_dependencias import ProcesoDependencia
from app.models.proceso_model import Proceso  # tu modelo existente

def _get_proceso(session: Session, pid: int) -> Proceso | None:
    return session.get(Proceso, pid)

def crear(session: Session, id_origen: int, id_destino: int, exigir_mismo_diagrama: bool = True) -> ProcesoDependencia:
    if id_origen == id_destino:
        raise ValueError("Un proceso no puede depender de sí mismo")

    po = _get_proceso(session, id_origen)
    pd = _get_proceso(session, id_destino)
    if not po or not pd:
        raise ValueError("Proceso origen o destino no existe")

    if exigir_mismo_diagrama and po.id_diagrama != pd.id_diagrama:
        raise ValueError("La dependencia debe estar en el mismo diagrama")

    existente = session.get(ProcesoDependencia, (id_origen, id_destino))
    if existente:
        return existente

    dep = ProcesoDependencia(id_origen=id_origen, id_destino=id_destino)
    session.add(dep)
    session.commit()
    session.refresh(dep)
    return dep

def eliminar(session: Session, id_origen: int, id_destino: int) -> bool:
    dep = session.get(ProcesoDependencia, (id_origen, id_destino))
    if not dep:
        return False
    session.delete(dep)
    session.commit()
    return True

def listar_por_proceso(session: Session, id_proceso: int) -> Tuple[List[Proceso], List[Proceso]]:
    # predecesores: quienes apuntan a id_proceso
    q_in = (
        select(Proceso)
        .join(ProcesoDependencia, ProcesoDependencia.id_origen == Proceso.id_proceso)
        .where(ProcesoDependencia.id_destino == id_proceso)
        .order_by(Proceso.orden)
    )
    predecesores = session.exec(q_in).all()

    # sucesores: a quienes apunta id_proceso
    q_out = (
        select(Proceso)
        .join(ProcesoDependencia, ProcesoDependencia.id_destino == Proceso.id_proceso)
        .where(ProcesoDependencia.id_origen == id_proceso)
        .order_by(Proceso.orden)
    )
    sucesores = session.exec(q_out).all()
    return predecesores, sucesores

def reemplazar_sucesores(session: Session, id_proceso: int, nuevos_sucesores: Iterable[int], exigir_mismo_diagrama: bool = True) -> None:
    po = _get_proceso(session, id_proceso)
    if not po:
        raise ValueError("Proceso no encontrado")

    nuevos = set(int(x) for x in nuevos_sucesores if int(x) != id_proceso)

    # validar existencia y política de mismo diagrama
    if nuevos:
        rs = session.exec(select(Proceso).where(Proceso.id_proceso.in_(nuevos))).all()
        existentes = {r.id_proceso for r in rs}
        faltantes = nuevos - existentes
        if faltantes:
            raise ValueError(f"Procesos destino inexistentes: {sorted(faltantes)}")
        if exigir_mismo_diagrama and any(r.id_diagrama != po.id_diagrama for r in rs):
            raise ValueError("Todos los sucesores deben estar en el mismo diagrama")

    # borrar los que ya no están
    session.exec(
        delete(ProcesoDependencia).where(
            ProcesoDependencia.id_origen == id_proceso,
            ProcesoDependencia.id_destino.not_in(nuevos or { -1 })
        )
    )

    # insertar los faltantes
    for dest in nuevos:
        if not session.get(ProcesoDependencia, (id_proceso, dest)):
            session.add(ProcesoDependencia(id_origen=id_proceso, id_destino=dest))

    session.commit()
    
def reemplazar_predecesores(
    session: Session,
    id_proceso: int,
    nuevos_predecesores: Iterable[int],
    exigir_mismo_diagrama: bool = True,
) -> None:
    destino = session.get(Proceso, id_proceso)
    if not destino:
        raise ValueError("Proceso no encontrado")

    # normaliza y quita self-loop
    nuevos = [int(x) for x in nuevos_predecesores if int(x) != id_proceso]
    nuevos_set = set(nuevos)

    # valida existencia
    if nuevos_set:
        rs = session.exec(select(Proceso).where(Proceso.id_proceso.in_(nuevos_set))).all()
        existentes = {r.id_proceso for r in rs}
        faltantes = nuevos_set - existentes
        if faltantes:
            raise ValueError(f"Predecesores inexistentes: {sorted(faltantes)}")

        if exigir_mismo_diagrama:
            if any(r.id_diagrama != destino.id_diagrama for r in rs):
                raise ValueError("Todos los predecesores deben estar en el mismo diagrama")
        else:
            # misma familia de artículo: compara id_catalogo de sus diagramas
            dest_cat = session.exec(
                select(DiagramaDeFlujo.id_catalogo).where(DiagramaDeFlujo.id_diagrama == destino.id_diagrama)
            ).one()
            pred_diagramas = [r.id_diagrama for r in rs]
            pred_cats = session.exec(
                select(DiagramaDeFlujo.id_catalogo).where(DiagramaDeFlujo.id_diagrama.in_(pred_diagramas))
            ).all()
            if any(c != dest_cat for c in pred_cats):
                raise ValueError("Todos los predecesores deben pertenecer al mismo artículo")

    # borra TODAS las aristas entrantes al proceso destino
    session.exec(delete(ProcesoDependencia).where(ProcesoDependencia.id_destino == id_proceso))

    # inserta nuevas (origen = predecesor, destino = actual)
    for pid in nuevos_set:
        session.add(ProcesoDependencia(id_origen=pid, id_destino=id_proceso))

    session.commit()