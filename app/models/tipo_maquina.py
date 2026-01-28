from typing import Optional, TYPE_CHECKING
from sqlmodel import SQLModel, Field, Relationship

if TYPE_CHECKING:
    from .area import Area

class TipoMaquina(SQLModel, table=True): 

    __tablename__ = "tipos_maquinas"

    id_tipomaquina: Optional[int] = Field(default=None, primary_key=True)
    nombre_maquina: str
    cantidad_maquinas: Optional[int] = Field(default=None, ge=0)
    personal_max: Optional[int] = Field(default=None, ge=0)
    id_area: Optional[int] = Field(default=None, foreign_key="areas.id_area")

    area: Optional["Area"] = Relationship(back_populates="maquinas")