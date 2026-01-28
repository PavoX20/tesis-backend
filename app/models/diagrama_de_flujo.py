from sqlmodel import SQLModel, Field, Column, String, Text, Boolean
from typing import Optional # <--- Importar Optional

class DiagramaDeFlujo(SQLModel, table=True):
    __tablename__ = "diagramas_de_flujo"

    id_diagrama: int | None = Field(default=None, primary_key=True)
    nombre: str = Field(sa_column=Column(String(255), nullable=False))
    descripcion: str | None = Field(default=None, sa_column=Column(Text))
    id_catalogo: int | None = Field(default=None, foreign_key="catalogo.id_catalogo")
    es_principal: bool = Field(default=False)
    
    # --- AGREGAR ESTO ---
    id_diagrama_padre: Optional[int] = Field(default=None, foreign_key="diagramas_de_flujo.id_diagrama")