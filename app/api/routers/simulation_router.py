from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.core.database import get_session 

# Importamos los schemas existentes y los NUEVOS
from app.api.schemas.simulation import (
    SimulationRequest, 
    SimulationResponse,
    VisualSimulationRequest,   # <--- Nuevo
    VisualSimulationResponse   # <--- Nuevo
)

# Importamos ambos servicios: el analítico (service) y el visual (visual_service)
from app.services.simulation import service as simulation_service
from app.services.simulation import visual_service # <--- Asegúrate de tener este archivo creado

router = APIRouter(
    prefix="/simulacion",
    tags=["Simulación"]
)

# --- ENDPOINT 1: Simulación Analítica (DBR, Costos, Eficiencia) ---
@router.post("/run", response_model=List[SimulationResponse])
def ejecutar_simulacion(
    payload: SimulationRequest, 
    db: Session = Depends(get_session) 
):
    try:
        resultados = simulation_service.run_simulation(db, payload)
        return resultados
    except HTTPException as e:
        raise e 
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        import traceback
        traceback.print_exc()
        raise HTTPException(status_code=500, detail="Error interno del servidor.")

# --- ENDPOINT 2: Simulación Visual (Timeline, Animación) ---
@router.post("/visual-run", response_model=VisualSimulationResponse)
def ejecutar_simulacion_visual(
    payload: VisualSimulationRequest,
    db: Session = Depends(get_session)
):
    """
    Genera la línea de tiempo (timeline) para la animación en el frontend.
    No guarda histórico en BD, calcula en memoria RAM.
    """
    try:
        # Llamamos al nuevo motor visual
        resultado = visual_service.ejecutar_simulacion_visual(
            db, 
            id_producto=payload.id_catalogo, 
            cantidad=payload.cantidad
        )
        return resultado

    except ValueError as e:
        # Errores de negocio (ej. Producto no existe)
        raise HTTPException(status_code=404, detail=str(e))
    except Exception as e:
        import traceback
        traceback.print_exc()
        print(f"Error Visual Engine: {e}")
        raise HTTPException(status_code=500, detail="Error generando la simulación visual.")