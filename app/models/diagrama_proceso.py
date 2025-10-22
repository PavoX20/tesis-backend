from sqlmodel import SQLModel, Field

class DiagramaProceso(SQLModel, table=True):
    __tablename__ = "diagrama_proceso"

    id_diagrama: int = Field(foreign_key="diagramas_de_flujo.id_diagrama", primary_key=True)
    id_proceso: int = Field(foreign_key="procesos.id_proceso", primary_key=True)
    orden: int = Field(ge=1)