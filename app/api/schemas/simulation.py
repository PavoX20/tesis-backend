from pydantic import BaseModel
from typing import Dict, Any

class SimulationRequest(BaseModel):
    shoe_id: int   # ID del catálogo (ej. 110)
    goal: int      # Meta de producción

# IMPORTANTE: El nombre de la clase debe ser VisualSimulationResponse
# porque así es como la estás importando en tu router.
class VisualSimulationResponse(BaseModel):
    status: str
    simulation_metadata: Dict[str, Any]
    results: Dict[str, Any] 
    # Dentro de 'results' viajará el campo 'chart_base64' y 'history_main'