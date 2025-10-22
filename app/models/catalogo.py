from typing import Optional
from sqlmodel import SQLModel, Field

class Catalogo(SQLModel, table=True):
    __tablename__ = "catalogo"

    id_catalogo: Optional[int] = Field(default=None, primary_key=True)
    nombre: str
    descripcion: Optional[str] = None
    genero: Optional[str] = Field(default=None)
    restriccion: Optional[str] = Field(default=None)
    precio: Optional[float] = Field(default=None, ge=0)