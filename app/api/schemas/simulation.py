from pydantic import BaseModel
from typing import List, Dict, Any, Optional, Union

# --- INPUT SCHEMAS (Lo que recibes) ---
class ProductoSolicitud(BaseModel):
    id_catalogo: int
    cantidad: int

class SimulationRequest(BaseModel):
    productos: List[ProductoSolicitud]
    asignacion_manual: Optional[Dict[str, int]] = None
    solo_info: bool = False

# --- OUTPUT SCHEMAS (Lo que respondes) ---

# 1. Estructura para Materiales
class MaterialDetalle(BaseModel):
    id_materia: int
    nombre: Optional[str] = "Desconocido"
    cantidad_total: float

# 2. Estructura para Escenarios (Ranking)
class DetalleAsignacion(BaseModel):
    personal: int
    maquinas: int
    tiempo_base: float

class EscenarioItem(BaseModel):
    ranking: int
    ranking_score: float
    total_personal_usado: int
    total_maquinas_usadas: int
    # Usamos Dict[str, Any] para flexibilidad en las claves de procesos (IDs dinámicos)
    detalle_asignacion: Dict[str, Any] 

class ReporteArea(BaseModel):
    id_area: int
    nombre_area: str
    escenarios: List[EscenarioItem]

# 3. Estructura Principal de Respuesta
class SimulationResponse(BaseModel):
    diagrama_id: int
    tiempo_total: float
    buffer_ideal: float
    es_factible: bool
    cuello_botella: int
    
    # Nuevos campos obligatorios
    lista_materiales_total: List[MaterialDetalle]
    materiales_por_proceso: Dict[str, List[MaterialDetalle]]
    analisis_escenarios: List[ReporteArea]
    
    # Datos visuales
    gantt_data: Dict[str, List[List[float]]]
    detalles_procesos: Dict[str, Any]

class Config:
        # Esto permite que si el backend devuelve un campo extra no explote, 
        # o si falta alguno opcional lo maneje.
        from_attributes = True
    
class ProductoRequest(BaseModel):
    id_catalogo: int
    cantidad: int