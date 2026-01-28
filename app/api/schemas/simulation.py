from pydantic import BaseModel
from typing import List, Dict, Any, Optional, Union

class ProductoSolicitud(BaseModel):
    id_catalogo: int
    cantidad: int

class SimulationRequest(BaseModel):
    productos: List[ProductoSolicitud]
    asignacion_manual: Optional[Dict[str, int]] = None
    solo_info: bool = False

class MaterialDetalle(BaseModel):
    id_materia: int
    nombre: Optional[str] = "Desconocido"
    cantidad_total: float

class DetalleAsignacion(BaseModel):
    personal: int
    maquinas: int
    tiempo_base: float

class EscenarioItem(BaseModel):
    ranking: int
    ranking_score: float
    total_personal_usado: int
    total_maquinas_usadas: int

    detalle_asignacion: Dict[str, Any] 

class ReporteArea(BaseModel):
    id_area: int
    nombre_area: str
    escenarios: List[EscenarioItem]

class SimulationResponse(BaseModel):
    diagrama_id: int
    tiempo_total: float
    buffer_ideal: float
    es_factible: bool
    cuello_botella: int

    lista_materiales_total: List[MaterialDetalle]
    materiales_por_proceso: Dict[str, List[MaterialDetalle]]
    analisis_escenarios: List[ReporteArea]

    gantt_data: Dict[str, List[List[float]]]
    detalles_procesos: Dict[str, Any]

    class Config:

        from_attributes = True

class ProductoRequest(BaseModel):
    id_catalogo: int
    cantidad: int

class VisualSimulationRequest(BaseModel):
    id_catalogo: int
    cantidad: int

class VisualSimulationResponse(BaseModel):
    modelo: str
    meta_cantidad: int
    resumen: Dict[str, Any]      

    timeline: List[Dict[str, Any]] 

    grafica_base64: Optional[str] = None