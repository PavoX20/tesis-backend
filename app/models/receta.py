# app/models/receta.py
from __future__ import annotations
from typing import Optional
from decimal import Decimal
from sqlmodel import SQLModel, Field, Column
from sqlalchemy import UniqueConstraint, Numeric

class Receta(SQLModel, table=True):
    __tablename__ = "receta"
    __table_args__ = (
        UniqueConstraint("id_proceso", "id_materia", "rol",
                         name="uq_receta_proceso_materia_rol"),
    )

    id_receta: Optional[int] = Field(default=None, primary_key=True)
    id_proceso: int = Field(foreign_key="procesos.id_proceso", index=True)
    id_materia: int = Field(foreign_key="materias.id_materia", index=True)
    # "IN" = entrada, "OUT" = salida
    rol: str = Field(min_length=2, max_length=3)
    cantidad: Decimal = Field(sa_column=Column(Numeric(12, 4), nullable=False))