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


try:
    from .diagrama_de_flujo import DiagramaDeFlujo
except ImportError:
    try:
        from .diagrama_de_flujo import Diagrama as DiagramaDeFlujo
    except ImportError:
        from .diagrama_de_flujo import DiagramasDeFlujo as DiagramaDeFlujo