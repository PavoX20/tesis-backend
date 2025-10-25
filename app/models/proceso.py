from sqlmodel import SQLModel, Field, Column, String, Integer, Numeric, ForeignKey

class Proceso(SQLModel, table=True):
    __tablename__ = "procesos"

    id_proceso: int | None = Field(default=None, primary_key=True)
    nombre_proceso: str = Field(sa_column=Column(String(255), nullable=False))
    parametros: str | None = None
    duracion: float | None = Field(default=None, sa_column=Column(Numeric(10,2)))
    distribucion: str | None = None
    id_tipomaquina: int | None = Field(default=None, foreign_key="tipos_maquinas.id_tipomaquina")
    id_diagrama: int | None = Field(default=None, foreign_key="diagramas_de_flujo.id_diagrama")
    id_receta: int | None = Field(default=None, foreign_key="recetas.id_receta")
    orden: int | None = Field(default=None)