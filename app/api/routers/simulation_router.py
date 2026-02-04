from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

# 1. Importamos la dependencia de BD que creamos en app/core/database.py
from app.core.database import get_db 

# 2. Importamos los esquemas correctos (Input y Output)
from app.api.schemas.simulation import SimulationRequest, VisualSimulationResponse

# 3. Importamos el servicio "Jefe de Orquesta" que ya probamos
from app.services.simulation.run_simulation import run_simulation_service

# Definimos el router. 
# NOTA: El prefijo "/api/simulation" ya se define en main.py, así que aquí lo dejamos limpio.
router = APIRouter()

@router.post("/run", response_model=VisualSimulationResponse, summary="Ejecutar Simulación")
def run_simulation_endpoint(
    payload: SimulationRequest, 
    db: Session = Depends(get_db)
):
    """
    Endpoint principal para la Simulación.
    Recibe: shoe_id y goal.
    Devuelve: Metadata, Historial completo y Gráfica en Base64.
    """
    try:
        # Llamamos al servicio real
        resultado = run_simulation_service(db, payload.shoe_id, payload.goal)
        
        # Si el servicio devuelve un error (ej. no encuentra el zapato), lanzamos 500 o 400
        if "error" in resultado:
             print(f"❌ Error en servicio: {resultado['error']}")
             raise HTTPException(status_code=400, detail=resultado["error"])

        # Retornamos el diccionario directo. Pydantic (VisualSimulationResponse) lo validará.
        return resultado

    except HTTPException as e:
        raise e
    except Exception as e:
        import traceback
        traceback.print_exc()
        print(f"🔥 Error Crítico en Endpoint Simulación: {e}")
        raise HTTPException(status_code=500, detail=f"Error interno del servidor: {str(e)}")