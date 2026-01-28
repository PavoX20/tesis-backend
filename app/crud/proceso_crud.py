from typing import List, Optional
from sqlmodel import Session, func, select
from app.models.catalogo import Catalogo
from app.models.dato_proceso_model import DatoProceso
from app.models.proceso_model import Proceso, TIPOS
from app.models.tipo_maquina import TipoMaquina
from app.models.diagrama_de_flujo import DiagramaDeFlujo as Diagrama
from sqlalchemy.orm import aliased


def get_proceso_by_id(session: Session, proceso_id: int):
    return session.get(Proceso, proceso_id)

def create_proceso(session: Session, data: Proceso):
    # 1. Asignar orden automáticamente si no se envía (Lógica Original)
    if not data.orden and data.id_diagrama:
        max_orden = session.exec(
            select(Proceso.orden)
            .where(Proceso.id_diagrama == data.id_diagrama)
            .order_by(Proceso.orden.desc())
        ).first()
        data.orden = (max_orden or 0) + 1

    # 2. Guardar el proceso (Lógica Original)
    session.add(data)
    session.commit()
    session.refresh(data)

    # 3. Auto-conexión Segura (Opción B mejorada)
    # Usamos un try-except para que NUNCA afecte a la creación del proceso si algo falla aquí.
    try:
        # Importación local para evitar errores de "Circular Import" si tus modelos se llaman entre sí
        from app.models.procesos_dependencias import ProcesoDependencia

        if data.id_diagrama and (data.orden or 0) > 1:
            prev_proceso = session.exec(
                select(Proceso)
                .where(Proceso.id_diagrama == data.id_diagrama)
                .where(Proceso.orden == (data.orden - 1))
            ).first()

            if prev_proceso:
                # Verificamos que no exista ya la conexión para evitar errores de duplicados
                existe = session.get(ProcesoDependencia, (prev_proceso.id_proceso, data.id_proceso))
                if not existe:
                    dep = ProcesoDependencia(
                        id_origen=prev_proceso.id_proceso,
                        id_destino=data.id_proceso
                    )
                    session.add(dep)
                    session.commit()
    except Exception as e:
        # Si falla la auto-conexión, solo lo imprimimos en consola, pero el proceso YA SE CREÓ.
        print(f"ADVERTENCIA: El proceso se creó, pero falló la auto-conexión: {e}")

    return data

def update_proceso(session: Session, proceso_id: int, data: Proceso):
    proceso = session.get(Proceso, proceso_id)
    if not proceso:
        return None
    for key, value in data.dict(exclude_unset=True).items():
        setattr(proceso, key, value)
    session.add(proceso)
    session.commit()
    session.refresh(proceso)
    return proceso

def delete_proceso(session: Session, proceso_id: int):
    proceso = session.get(Proceso, proceso_id)
    if not proceso:
        return None

    # Guardar id_diagrama antes de eliminar
    id_diagrama = proceso.id_diagrama
    session.delete(proceso)
    session.commit()

    # Reordenar los procesos del diagrama
    if id_diagrama:
        procesos = session.exec(
            select(Proceso)
            .where(Proceso.id_diagrama == id_diagrama)
            .order_by(Proceso.orden)
        ).all()

        for i, p in enumerate(procesos, start=1):
            p.orden = i
            session.add(p)
        session.commit()

    return proceso

def set_maquina_en_proceso(session: Session, proceso_id: int, id_tipomaquina: Optional[int]) -> Optional[Proceso]:
    proc = session.get(Proceso, proceso_id)
    if not proc:
        return None
    if id_tipomaquina is not None and session.get(TipoMaquina, id_tipomaquina) is None:
        raise ValueError("id_tipomaquina inválido")
    proc.id_tipomaquina = id_tipomaquina
    session.add(proc)
    session.commit()
    session.refresh(proc)
    return proc

def list_procesos_lookup(
    session: Session,
    q: Optional[str] = None,
    diagrama_id: Optional[int] = None,
    catalogo_id: Optional[int] = None,
    exclude_id: Optional[int] = None,
    tipo: Optional[str] = None,
    skip: int = 0,
    limit: int = 20,
) -> List[dict]:
    # subconsulta: último catalogo en datos_proceso
    dp_catalogo_id_sq = (
        select(DatoProceso.id_catalogo)
        .where(DatoProceso.id_proceso == Proceso.id_proceso)
        .order_by(DatoProceso.fecha.desc(), DatoProceso.id_medicion.desc())
        .limit(1)
        .scalar_subquery()
    )

    # alias de catálogo para cada fuente
    CatDiag = aliased(Catalogo)   # catálogo del diagrama
    CatDP = aliased(Catalogo)     # catálogo desde datos_proceso
    CatProc = aliased(Catalogo)   # catálogo directo en proceso

    stmt = (
        select(
            Proceso.id_proceso,
            Proceso.nombre_proceso,
            Proceso.orden,
            Proceso.id_diagrama,
            Proceso.tipo,
            Diagrama.nombre.label("diagrama_nombre"),

            # IDs de catálogo por cada origen
            Diagrama.id_catalogo.label("catalogo_id_diagrama"),
            dp_catalogo_id_sq.label("catalogo_id_dp"),
            Proceso.id_catalogo.label("catalogo_id_proc"),

            # Nombres de catálogo por cada origen
            CatDiag.nombre.label("catalogo_nombre_diagrama"),
            CatDP.nombre.label("catalogo_nombre_dp"),
            CatProc.nombre.label("catalogo_nombre_proc"),

            # Exposición final (prioridad: proceso -> diagrama -> datos_proceso)
            func.coalesce(
                Proceso.id_catalogo,
                Diagrama.id_catalogo,
                dp_catalogo_id_sq,
            ).label("catalogo_id"),
            func.coalesce(
                CatProc.nombre,
                CatDiag.nombre,
                CatDP.nombre,
            ).label("catalogo_nombre"),
        )
        .join(Diagrama, Diagrama.id_diagrama == Proceso.id_diagrama, isouter=True)
        .join(CatDiag, CatDiag.id_catalogo == Diagrama.id_catalogo, isouter=True)
        .join(CatDP, CatDP.id_catalogo == dp_catalogo_id_sq, isouter=True)
        .join(CatProc, CatProc.id_catalogo == Proceso.id_catalogo, isouter=True)
    )

    if q:
        stmt = stmt.where(Proceso.nombre_proceso.ilike(f"%{q}%"))
    if diagrama_id:
        stmt = stmt.where(Proceso.id_diagrama == diagrama_id)
    if catalogo_id:
        stmt = stmt.where(
            func.coalesce(
                Proceso.id_catalogo,
                Diagrama.id_catalogo,
                dp_catalogo_id_sq,
            )
            == catalogo_id
        )
    if exclude_id:
        stmt = stmt.where(Proceso.id_proceso != exclude_id)
    if tipo:
        t = tipo.upper()
        if t in ("NORMAL", "ALMACENAMIENTO"):
            stmt = stmt.where(Proceso.tipo == t)

    stmt = (
        stmt.order_by(Diagrama.nombre, Proceso.orden, Proceso.id_proceso)
        .offset(skip)
        .limit(limit)
    )

    rows = session.exec(stmt).all()
    return [dict(r._mapping) for r in rows]


def set_tipo_en_proceso(session: Session, proceso_id: int, nuevo_tipo: str) -> Optional[Proceso]:
    proc = session.get(Proceso, proceso_id)
    if not proc:
        return None

    t = str(nuevo_tipo).upper()
    if t not in TIPOS:
        raise ValueError(f"tipo inválido. Use {sorted(TIPOS)}")

    proc.tipo = t
    session.add(proc)
    session.commit()
    session.refresh(proc)
    return proc