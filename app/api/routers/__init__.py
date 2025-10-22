from .catalogo_router import router as catalogo_router
from .materia_prima_router import router as materia_prima_router
from .area_router import router as area_router
from .tipo_maquina_router import router as tipo_maquina_router
from .proceso_router import router as proceso_router
from .diagrama_router import router as diagrama_router
from .diagrama_proceso_router import router as diagrama_proceso_router
from .receta_router import router as receta_router

__all__ = [
    "catalogo_router",
    "materia_prima_router",
    "area_router",
    "tipo_maquina_router",
    "proceso_router",
    "diagrama_router",
    "diagrama_proceso_router",
    "receta_router",
]