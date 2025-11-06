from typing import List, Optional
from sqlmodel import Session, select
from app.models.materia_model import Materia# si tu modelo se llama Materia en materias.py, ajusta import

def create_materia(db: Session, nombre: str, unidad: str, tipo: str, costo: float = 0.0) -> Materia:
    m = Materia(nombre=nombre, unidad=unidad, tipo=tipo, costo=costo)
    db.add(m); db.commit(); db.refresh(m)
    return m

def list_materias(db: Session, q: Optional[str], limit: int, skip: int) -> List[Materia]:
    stmt = select(Materia)
    if q:
        stmt = stmt.where(Materia.nombre.ilike(f"%{q}%"))
    return db.exec(stmt.limit(limit).offset(skip)).all()