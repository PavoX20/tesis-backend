from typing import Optional
from sqlmodel import SQLModel, Field

class MateriaPrima(SQLModel, table=True):
    __tablename__ = "materias_primas"

    id_materia: Optional[int] = Field(default=None, primary_key=True)
    nombre: str
    unidad: Optional[str] = Field(default=None)
    costo: Optional[float] = Field(default=None, ge=0)
    tipo: Optional[str] = Field(default=None)