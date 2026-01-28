from typing import Optional
from sqlmodel import SQLModel, Field

class Materia(SQLModel, table=True):
    __tablename__ = "materias"
    id_materia: Optional[int] = Field(default=None, primary_key=True)
    nombre: str
    unidad: str
    costo: float = 0.0
    tipo: str  

