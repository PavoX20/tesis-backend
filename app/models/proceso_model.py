from typing import Optional
from sqlmodel import SQLModel, Field
from pydantic import field_validator

# Constantes
DISTRIBS = {"norm", "weibull_min", "expon", "lognorm", "gamma"}
TIPOS = {"NORMAL", "ALMACENAMIENTO"}

# --- MODELO PRINCIPAL (TABLA) ---
class Proceso(SQLModel, table=True):
    __tablename__ = "procesos"

    id_proceso: Optional[int] = Field(default=None, primary_key=True)
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = Field(default=None, ge=0)
    distribucion: Optional[str] = None  
    tipo: str = Field(default="NORMAL", description="NORMAL o ALMACENAMIENTO")
    
    # Claves foráneas (Strings para evitar ciclos)
    id_tipomaquina: Optional[int] = Field(default=None, foreign_key="tipos_maquinas.id_tipomaquina")
    id_diagrama: Optional[int] = Field(default=None, foreign_key="diagramas_de_flujo.id_diagrama")
    id_catalogo: Optional[int] = Field(default=None, foreign_key="catalogo.id_catalogo")
    orden: Optional[int] = Field(default=None, ge=1)

    @field_validator("tipo", mode="before")
    @classmethod
    def _normalize_tipo(cls, v):
        return "NORMAL" if v is None else str(v).upper()

    @field_validator("distribucion")
    @classmethod
    def _validate_distrib(cls, v):
        return v

# --- SCHEMAS AUXILIARES (Pydantic) ---

class ProcesoCreate(SQLModel):
    nombre_proceso: str
    parametros: Optional[str] = None
    duracion: Optional[float] = None
    distribucion: Optional[str] = None
    tipo: str = "NORMAL"
    id_tipomaquina: Optional[int] = None
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

# Esta es la clase que faltaba y causaba el error:
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