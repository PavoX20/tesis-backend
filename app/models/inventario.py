from typing import Optional
from sqlmodel import SQLModel, Field, Relationship

from app.models.area import Area
from app.models.materia_model import Materia 

class InventarioBase(SQLModel):
    id_area: int = Field(foreign_key="areas.id_area")
    id_materia: int = Field(foreign_key="materias.id_materia")
    cantidad: float = Field(default=0) 

class Inventario(InventarioBase, table=True):
    __tablename__ = "inventario"
    __table_args__ = {"extend_existing": True} 

    id_inventario: Optional[int] = Field(default=None, primary_key=True)

class InventarioCreate(InventarioBase):
    pass

class InventarioUpdate(SQLModel):
    cantidad: float