from sqlmodel import SQLModel, Field, Relationship
from typing import Optional

class Proceso(SQLModel, table=True):
    id_proceso: Optional[int] = Field(default=None, primary_key=True)
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = None
    distribucion: Optional[str] = None
    id_tipomaquina: Optional[int] = Field(default=None, foreign_key="tipos_maquinas.id_tipomaquina")

    # ✅ nuevo campo: ahora los procesos pertenecen a un diagrama
    id_diagrama: Optional[int] = Field(default=None, foreign_key="diagramas_de_flujo.id_diagrama")
    orden: Optional[int] = Field(default=None, ge=1)

    # relaciones (opcionales)
    # diagrama: Optional["DiagramaDeFlujo"] = Relationship(back_populates="procesos")