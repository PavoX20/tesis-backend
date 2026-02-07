from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

# 1. Importamos la dependencia de BD
# Usamos get_db que es la actual, si get_session es lo mismo, esto funcionará.
from app.core.database import get_db 

# 2. IMPORTACIÓN DE SERVICIOS
# Servicio Legacy (Simulación General/Tablas)
from app.services.simulation import service as simulation_service
# Servicio Nuevo (Simulación Visual/Angelo Engine)
from app.services.simulation.run_simulation import run_simulation_service, run_optimization_analysis

# 3. IMPORTACIÓN DE ESQUEMAS
# Necesitamos importar ambos tipos de Request. 
# Asegúrate de que en 'app/api/schemas/simulation.py' existan estas clases o ajusta los nombres aquí.
from app.api.schemas.simulation import (
    SimulationRequest,           # Input para la Simulación General (Lista de productos)
    SimulationResponse,          # Output para la Simulación General
    VisualSimulationResponse,
    OptimizationResponse,
)

# Definimos el router.
# IMPORTANTE: El prefix suele definirse en main.py (ej: app.include_router(..., prefix="/simulacion"))
# Pero si el código anterior tenía prefix="/simulacion" aquí, lo mantenemos limpio para que main.py decida,
# o lo ajustamos según tu main.py. Por ahora lo dejo limpio como el "Actual".
router = APIRouter()

# ==========================================
# ENDPOINT 1: SIMULACIÓN GENERAL (LEGACY)
# Ruta: POST /simulacion/run
# ==========================================
@router.post("/run", response_model=List[SimulationResponse], summary="Simulación General (Tablas)")
def ejecutar_simulacion_general(
    payload: SimulationRequest, 
    db: Session = Depends(get_db) 
):
    """
    Ejecuta la lógica original de simulación (cálculo de costos, tiempos, tablas).
    """
    try:
        # Llamada al servicio antiguo
        resultados = simulation_service.run_simulation(db, payload)
        return resultados
        
    except HTTPException as e:
        raise e 
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        import traceback
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=f"Error en Simulación General: {str(e)}")


# ==========================================
# ENDPOINT 2: SIMULACIÓN VISUAL (NUEVO)
# Ruta: POST /simulacion/visual-run
# ==========================================
# IMPORTANTE: He cambiado la ruta a "/visual-run" para no chocar con la anterior.
# Tendrás que actualizar tu frontend (simulacionApi.ts) para apuntar aquí.
@router.post("/visual-run", response_model=VisualSimulationResponse, summary="Simulación Visual (Animación)")
def ejecutar_simulacion_visual(
    # NOTA: Aquí asumo que SimulationRequest sirve para ambos o que 
    # definirás un esquema específico si los datos son distintos.
    # Si el payload es { shoe_id: 1, goal: 100 }, usa ese esquema.
    payload: SimulationRequest, 
    db: Session = Depends(get_db)
):
    """
    Ejecuta la lógica nueva (Angelo Engine) para la animación.
    Recibe: shoe_id y goal (dentro del payload).
    Devuelve: Metadata y Historial para animación.
    """
    try:
        # Extraemos shoe_id y goal. 
        # Si SimulationRequest es una lista (para el legacy), aquí fallará.
        # ADAPTACIÓN: Verificamos qué tipo de payload llega.
        
        shoe_id = 0
        goal = 0
        
        # Lógica de compatibilidad si usas el mismo esquema para ambos
        if hasattr(payload, 'shoe_id'):
            shoe_id = payload.shoe_id
            goal = payload.goal
        elif hasattr(payload, 'productos') and len(payload.productos) > 0:
            # Si llega la lista del legacy, tomamos el primero para la visual
            shoe_id = payload.productos[0].id_catalogo
            goal = payload.productos[0].cantidad
        else:
            # Fallback para pruebas rápidas o estructura plana
             # Ajusta esto según tu esquema real de entrada para la visual
             pass

        # Llamada al servicio nuevo
        resultado = run_simulation_service(db, shoe_id, goal)
        
        if "error" in resultado:
             print(f"❌ Error en servicio visual: {resultado['error']}")
             raise HTTPException(status_code=400, detail=resultado["error"])

        return resultado

    except HTTPException as e:
        raise e
    except Exception as e:
        import traceback
        traceback.print_exc()
        print(f"🔥 Error en Simulación Visual: {e}")
        raise HTTPException(status_code=500, detail=f"Error interno: {str(e)}")


# ==========================================
# ENDPOINT 3: ANÁLISIS DE OPTIMIZACIÓN (COMBINATORIA)
# Ruta: POST /simulacion/optimize
# ==========================================
@router.post("/optimize", response_model=OptimizationResponse, summary="Optimizar Recursos")
def analizar_optimizacion(
    payload: SimulationRequest, 
    db: Session = Depends(get_db)
):
    """
    Identifica el cuello de botella y simula combinaciones de Máquinas/Personal
    para encontrar tiempos más eficientes.
    """
    try:
        # Extracción segura de ID y Goal (Igual que en visual-run)
        shoe_id = 0
        goal = 0
        if hasattr(payload, 'shoe_id') and payload.shoe_id:
            shoe_id = payload.shoe_id
            goal = payload.goal
        elif hasattr(payload, 'productos') and payload.productos:
            shoe_id = payload.productos[0].id_catalogo
            goal = payload.productos[0].cantidad

        # Llamada al nuevo servicio
        resultado = run_optimization_analysis(db, shoe_id, goal)
        
        if "error" in resultado:
             raise HTTPException(status_code=400, detail=resultado["error"])

        return resultado

    except HTTPException as e:
        raise e
    except Exception as e:
        print(f"🔥 Error en Optimización: {e}")
        raise HTTPException(status_code=500, detail=f"Error interno: {str(e)}")