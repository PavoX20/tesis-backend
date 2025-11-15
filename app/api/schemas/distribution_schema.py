from pydantic import BaseModel, Field
from typing import List, Optional

class RankedItem(BaseModel):
    titulo: str
    ks: Optional[float]
    p: Optional[float]
    r2: Optional[float]
    distrib: str
    parametros: List[float]

class AutoResponse(BaseModel):
    modo: str = "auto"
    seleccion: Optional[str] = None          # ← antes str
    parametros: List[float] = Field(default_factory=list)
    mensaje: str
    ranking: List[RankedItem] = Field(default_factory=list)
    image_base64: Optional[str] = None

class ManualRequest(BaseModel):
    nombre: str
    parametros: List[float]
    umbral: int = 20

class ManualResponse(BaseModel):
    modo: str = "manual"
    seleccion: str
    parametros: List[float]
    mensaje: str
    image_base64: Optional[str] = None