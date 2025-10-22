from typing import Optional
from sqlmodel import SQLModel, Field, Relationship

class TipoMaquina(SQLModel, table=True):
    __tablename__ = "tipos_maquinas"

    id_tipomaquina: Optional[int] = Field(default=None, primary_key=True)
    nombre_maquina: str
    cantidad_maquinas: Optional[int] = Field(default=None, ge=0)
    personal_max: Optional[int] = Field(default=None, ge=0)
    id_area: Optional[int] = Field(default=None, foreign_key="areas.id_area")