from pydantic import BaseModel
from typing import List, Dict, Any, Optional

# --- INPUTS (Solicitudes) ---

class ProductoSolicitud(BaseModel):
    id_catalogo: int
    cantidad: int

class SimulationRequest(BaseModel):
    """
    Estructura unificada para pedir simulaciones.
    Soporta lista de productos por si en el futuro simulas varios a la vez.
    """
    productos: List[ProductoSolicitud]
    asignacion_manual: Optional[Dict[str, int]] = None
    solo_info: bool = False
    umbral_pausa: Optional[float] = 0.20

# --- OUTPUTS (Respuestas) ---

class VisualSimulationResponse(BaseModel):
    """
    Respuesta optimizada para el Frontend de Angelo.
    Contiene la metadata, los resultados de buffers, la película y la gráfica.
    """
    modelo: str
    meta_cantidad: int
    
    # Resumen rápido (Tiempo de cálculo, status)
    resumen: Dict[str, Any]
    
    # Aquí vienen los Buffers Optimizados y tiempos por proceso
    detalles_procesos: Dict[str, Any]
    
    # LA PELÍCULA: Lista de frames paso a paso para la animación
    historial_animacion: List[Dict[str, Any]]
    
    # La imagen generada por matplotlib en Base64
    grafica_base64: Optional[str] = None