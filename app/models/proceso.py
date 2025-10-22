from typing import Optional
from sqlmodel import SQLModel, Field

class Proceso(SQLModel, table=True):
    __tablename__ = "procesos"

    id_proceso: Optional[int] = Field(default=None, primary_key=True)
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = Field(default=None, ge=0)
    distribucion: Optional[str] = Field(default=None)
    id_tipomaquina: Optional[int] = Field(default=None, foreign_key="tipos_maquinas.id_tipomaquina")