# app/models/simulacion_model.py

try:
    from .proceso_model import Proceso
except ImportError:
    from .proceso_model import Procesos as Proceso

try:
    from .tipo_maquina import TipoMaquina
except ImportError:
    from .tipo_maquina import TipoMaquinas as TipoMaquina

try:
    from .area import Area
except ImportError:
    from .areas import Area

# --- NUEVO: Agregamos el Diagrama para hacer el puente ---
try:
    from .diagrama_de_flujo import DiagramaDeFlujo
except ImportError:
    # Fallbacks comunes por si el nombre de clase varía
    try:
        from .diagrama_de_flujo import Diagrama as DiagramaDeFlujo
    except ImportError:
        from .diagrama_de_flujo import DiagramasDeFlujo as DiagramaDeFlujo