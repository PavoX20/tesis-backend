from typing import Optional
from sqlmodel import SQLModel, Field

class Area(SQLModel, table=True):
    __tablename__ = "areas"

    id_area: Optional[int] = Field(default=None, primary_key=True)
    nombre: str
    tipo: Optional[str] = Field(default=None)
    personal: Optional[int] = Field(default=None, ge=0)
    restriccion: Optional[str] = Field(default=None)