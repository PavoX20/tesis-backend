from typing import Optional
from sqlmodel import SQLModel, Field

class DiagramaDeFlujo(SQLModel, table=True):
    __tablename__ = "diagramas_de_flujo"

    id_diagrama: Optional[int] = Field(default=None, primary_key=True)
    nombre: str
    descripcion: Optional[str] = None
    id_catalogo: Optional[int] = Field(default=None, foreign_key="catalogo.id_catalogo")