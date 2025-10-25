# app/models/receta_model.py
from sqlmodel import SQLModel, Field, ForeignKey, Column, Integer, Numeric

class Receta(SQLModel, table=True):
    __tablename__ = "recetas"
    id_receta: int | None = Field(default=None, primary_key=True)
    id_diagrama: int = Field(foreign_key="diagramas_de_flujo.id_diagrama")
    id_proceso: int | None = Field(default=None, foreign_key="procesos.id_proceso")
    id_producto: int | None = Field(default=None, foreign_key="materias_primas.id_materia")
    cantidad_producida: float = Field(sa_column=Column(Numeric(10,2), nullable=False))

class RecetaDetalle(SQLModel, table=True):
    __tablename__ = "receta_detalle"
    id_detalle: int | None = Field(default=None, primary_key=True)
    id_receta: int = Field(foreign_key="recetas.id_receta")
    id_materia: int = Field(foreign_key="materias_primas.id_materia")
    cantidad_requerida: float = Field(sa_column=Column(Numeric(10,2), nullable=False))
    cantidad_unitaria: float = Field(sa_column=Column(Numeric(10,2), nullable=False))