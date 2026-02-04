from pydantic import BaseModel
from typing import List, Dict, Any, Optional

# ==========================================
# 1. MODELOS AUXILIARES (Restaurados para Simulación General)
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

# A. Respuesta Legacy (Para el endpoint /run - Tablas y Costos)
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

# B. Respuesta Visual (Para el endpoint /visual-run - Animación)
# Mantenemos la estructura "Actual" que funciona con tu Results.tsx
class VisualSimulationResponse(BaseModel):
    status: str
    simulation_metadata: Dict[str, Any]
    results: Dict[str, Any] 
    # Dentro de 'results' viajará 'chart_base64' y 'history_main'

# ==========================================
# 3. MODELO DE SOLICITUD UNIFICADO
# ==========================================

class SimulationRequest(BaseModel):
    """
    Modelo híbrido que acepta tanto la estructura antigua como la nueva.
    Los campos son opcionales para permitir ambos tipos de payload.
    """
    # --- Campos Legacy (Simulación General) ---
    productos: Optional[List[ProductoSolicitud]] = None
    asignacion_manual: Optional[Dict[str, int]] = None
    solo_info: bool = False

    # --- Campos Visual (Angelo Engine) ---
    shoe_id: Optional[int] = None
    goal: Optional[int] = None