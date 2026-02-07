from pydantic import BaseModel
from typing import List, Dict, Any, Optional

# ==========================================
# 1. MODELOS AUXILIARES (Legacy)
# ==========================================

class ProductoSolicitud(BaseModel):
    id_catalogo: int
    cantidad: int

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

# ==========================================
# 2. MODELOS DE RESPUESTA
# ==========================================

# A. Respuesta Legacy
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

# B. Respuesta Visual
class VisualSimulationResponse(BaseModel):
    status: str
    simulation_metadata: Dict[str, Any]
    results: Dict[str, Any] 

# ==========================================
# 3. MODELOS PARA OPTIMIZACIÓN (NUEVO)
# ==========================================

# 1. El modelo más pequeño (Hijo)
class DetalleConfigProceso(BaseModel):
    id_proceso: int
    nombre_proceso: str
    maquinas_asignadas: int
    personal_asignado: int

# 2. El modelo intermedio (Contenedor de hijos)
class EscenarioCombinatorio(BaseModel):
    ranking: int
    tiempo_total: float
    total_personal: int
    total_maquinas: int
    buffer: float
    bottleneck_id: Optional[int] = None
    bottleneck_nombre: Optional[str] = None
    distribucion: List[DetalleConfigProceso] # Usa el modelo definido arriba

# 3. El modelo Padre (Respuesta final)
class OptimizationResponse(BaseModel):
    status: str
    total_combinaciones_generadas: int
    escenarios: List[EscenarioCombinatorio] # Usa el modelo definido arriba

# ==========================================
# 4. MODELO DE SOLICITUD UNIFICADO
# ==========================================

class SimulationRequest(BaseModel):
    productos: Optional[List[ProductoSolicitud]] = None
    asignacion_manual: Optional[Dict[str, int]] = None
    solo_info: bool = False
    shoe_id: Optional[int] = None
    goal: Optional[int] = None