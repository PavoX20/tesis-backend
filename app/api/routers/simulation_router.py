from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.core.database import get_session 

from app.api.schemas.simulation import (
    SimulationRequest, 
    VisualSimulationResponse   
)

# IMPORTANTE: Importamos el nuevo servicio de Angelo
from app.services.simulation import angelo_simulation 

router = APIRouter(
    prefix="/simulacion",
    tags=["Simulación"]
)

@router.post("/visual-run", response_model=VisualSimulationResponse)
def ejecutar_simulacion_visual(
    payload: SimulationRequest, # Usamos el request completo (lista de productos)
    db: Session = Depends(get_session)
):
    """
    Endpoint principal para la Simulación de Angelo.
    1. Calcula Buffers Óptimos (Optimización).
    2. Genera Historial de Animación (Película).
    3. Genera Gráfica de Tiempos (Base64).
    """
    try:
        # Llamamos al nuevo servicio "Jefe de Orquesta"
        resultado = angelo_simulation.run_simulation(db, payload)
        
        # Validamos si hubo error controlado en el servicio
        if "error" in resultado:
             raise HTTPException(status_code=400, detail=resultado["error"])

        return resultado

    except HTTPException as e:
        raise e
    except Exception as e:
        import traceback
        traceback.print_exc()
        print(f"Error Critical en Angelo Engine: {e}")
        raise HTTPException(status_code=500, detail=f"Error interno: {str(e)}")