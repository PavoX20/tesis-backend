from __future__ import annotations

from typing import Optional
from datetime import date

from sqlmodel import SQLModel, Field
from sqlalchemy import Column, Text
from sqlalchemy import Date as SADate  

class DatoProceso(SQLModel, table=True):
    __tablename__ = "datos_proceso"

    id_medicion: Optional[int] = Field(default=None, primary_key=True)

    id_proceso: int = Field(foreign_key="procesos.id_proceso")
    id_catalogo: int = Field(foreign_key="catalogo.id_catalogo")

    cantidad: Optional[float] = Field(default=None)
    fecha: date = Field(sa_column=Column(SADate, nullable=False))
    tiempo_total_min: Optional[str] = Field(default=None, sa_column=Column(Text, nullable=True))
    tiempo_total_seg: Optional[str] = Field(default=None, sa_column=Column(Text, nullable=True))
    operario: Optional[str] = Field(default=None)
    notas: Optional[str] = Field(default=None)

class DatoProcesoCreate(SQLModel):
    id_proceso: int
    id_catalogo: int
    cantidad: Optional[float] = None
    fecha: date

    tiempo_total_min: Optional[str] = None
    tiempo_total_seg: Optional[str] = None
    operario: Optional[str] = None
    notas: Optional[str] = None

class DatoProcesoRead(SQLModel):
    id_medicion: int
    id_proceso: int
    id_catalogo: int
    cantidad: Optional[float] = None
    fecha: date
    tiempo_total_min: Optional[str] = None
    tiempo_total_seg: Optional[str] = None
    operario: Optional[str] = None
    notas: Optional[str] = None

class DatoProcesoUpdate(SQLModel):
    id_proceso: Optional[int] = None
    id_catalogo: Optional[int] = None
    cantidad: Optional[float] = None
    fecha: Optional[date] = None
    tiempo_total_min: Optional[str] = None
    tiempo_total_seg: Optional[str] = None
    operario: Optional[str] = None
    notas: Optional[str] = None