from typing import Optional
from sqlmodel import SQLModel, Field

class Receta(SQLModel, table=True):
    __tablename__ = "receta"

    id_receta: Optional[int] = Field(default=None, primary_key=True)
    id_proceso: Optional[int] = Field(default=None, foreign_key="procesos.id_proceso")
    id_materia_entrada: Optional[int] = Field(default=None, foreign_key="materias_primas.id_materia")
    cantidad_entrada: Optional[float] = Field(default=None, ge=0)
    id_materia_salida: Optional[int] = Field(default=None, foreign_key="materias_primas.id_materia")
    cantidad_salida: Optional[float] = Field(default=None, ge=0)