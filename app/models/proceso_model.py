# app/models/proceso_model.py
from typing import Optional
from sqlmodel import SQLModel, Field
from pydantic import field_validator

# listas válidas
DISTRIBS = {"norm", "weibull_min", "expon", "lognorm", "gamma"}
TIPOS = {"NORMAL", "ALMACENAMIENTO"}


class Proceso(SQLModel, table=True):
    __tablename__ = "procesos"

    id_proceso: Optional[int] = Field(default=None, primary_key=True)
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = Field(default=None, ge=0)
    distribucion: Optional[str] = None  # 'norm', 'weibull_min', ...
    tipo: str = Field(default="NORMAL", description="NORMAL o ALMACENAMIENTO")
    id_tipomaquina: Optional[int] = Field(
        default=None, foreign_key="tipos_maquinas.id_tipomaquina"
    )
    # AHORA OPCIONAL
    id_diagrama: Optional[int] = Field(
        default=None, foreign_key="diagramas_de_flujo.id_diagrama"
    )
    # NUEVO: catálogo asignado directamente al proceso (opcional)
    id_catalogo: Optional[int] = Field(
        default=None, foreign_key="catalogo.id_catalogo"
    )
    # AHORA OPCIONAL (para procesos “sueltos” sin diagrama)
    orden: Optional[int] = Field(default=None, ge=1)

    # Validaciones Pydantic v2
    @field_validator("tipo", mode="before")
    @classmethod
    def _normalize_tipo(cls, v):
        if v is None:
            return "NORMAL"
        v = str(v).upper()
        if v not in TIPOS:
            raise ValueError(f"tipo inválido. Use {sorted(TIPOS)}")
        return v

    @field_validator("distribucion")
    @classmethod
    def _validate_distrib(cls, v):
        if v is None:
            return v
        if v not in DISTRIBS:
            raise ValueError(f"distribucion inválida. Use {sorted(DISTRIBS)}")
        return v


# DTOs
class ProcesoCreate(SQLModel):
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = Field(default=None, ge=0)
    distribucion: Optional[str] = None
    tipo: str = "NORMAL"
    id_tipomaquina: Optional[int] = None
    # opcionales al crear desde tu dialog
    id_diagrama: Optional[int] = None
    id_catalogo: Optional[int] = None
    orden: Optional[int] = None


class ProcesoRead(SQLModel):
    id_proceso: int
    nombre_proceso: str
    parametros: Optional[str]
    duracion: Optional[float]
    distribucion: Optional[str]
    tipo: str
    id_tipomaquina: Optional[int]
    id_diagrama: Optional[int]
    id_catalogo: Optional[int]
    orden: Optional[int]


class ProcesoUpdate(SQLModel):
    nombre_proceso: Optional[str] = None
    parametros: Optional[str] = None
    duracion: Optional[float] = Field(default=None, ge=0)
    distribucion: Optional[str] = None
    tipo: Optional[str] = None
    id_tipomaquina: Optional[int] = None
    id_diagrama: Optional[int] = None
    id_catalogo: Optional[int] = None
    orden: Optional[int] = None


class ProcesoLookup(SQLModel):
    id_proceso: int
    nombre_proceso: str
    orden: int | None = None
    id_diagrama: int | None = None
    tipo: str | None = None
    diagrama_nombre: str | None = None
    catalogo_id: int | None = None


class ProcesoTipoUpdate(SQLModel):
    tipo: str

    @field_validator("tipo", mode="before")
    @classmethod
    def _valida_tipo(cls, v):
        if v is None:
            raise ValueError("tipo es requerido")
        v = str(v).upper()
        if v not in TIPOS:
            raise ValueError(f"tipo inválido. Use {sorted(TIPOS)}")
        return v