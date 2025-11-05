# app/models/proceso.py
from typing import Optional
from pydantic import BaseModel
from sqlmodel import SQLModel, Field

class Proceso(SQLModel, table=True):
    __tablename__ = "procesos"

    id_proceso: Optional[int] = Field(default=None, primary_key=True)
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = None
    distribucion: Optional[str] = None  # 'norm', 'weibull_min', ...
    id_tipomaquina: Optional[int] = Field(default=None, foreign_key="tipos_maquinas.id_tipomaquina")
    id_diagrama: int = Field(foreign_key="diagramas_de_flujo.id_diagrama")
    orden: int




class ProcesoUpdate(BaseModel):
    nombre_proceso: Optional[str]
    distribucion: Optional[str]
    parametros: Optional[str]