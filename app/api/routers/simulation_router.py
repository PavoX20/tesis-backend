from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

# Ajusta el import de get_session según tu proyecto
from app.core.database import get_session 

from app.api.schemas.simulation import SimulationRequest, SimulationResponse
from app.services.simulation import service as simulation_service

# --- AQUÍ SÍ VA EL ROUTER ---
router = APIRouter(
    prefix="/simulacion",
    tags=["Simulación"]
)

@router.post("/run", response_model=List[SimulationResponse])
def ejecutar_simulacion(
    payload: SimulationRequest, 
    db: Session = Depends(get_session) 
):
    try:
        # Llamada al servicio
        resultados = simulation_service.run_simulation(db, payload)
        return resultados
    
    except HTTPException as e:
        raise e 
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        import traceback
        traceback.print_exc()
        print(f"Error NO CONTROLADO: {e}")
        raise HTTPException(status_code=500, detail="Error interno del servidor.")