import sys
import os
from pathlib import Path

# --- ¡ESTA ES LA SOLUCIÓN! ---
# Añade la carpeta raíz del proyecto al path de Python
# para que pueda encontrar la carpeta 'app'
FILE = Path(__file__).resolve()
ROOT = FILE.parent
if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))
# --- FIN DE LA SOLUCIÓN ---

# Ahora el resto de tu código
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Ya no importamos 'asynccontextmanager' ni 'init_db'
# porque eliminamos el 'lifespan'

from app.api.routers import (
    catalogo_router,
    materia_router,
    area_router,
    tipo_maquina_router,
    proceso_router,
    diagrama_router,
    receta_router,
    diagrama_detalle_router,
    proceso_detalle_router,
    grafo_router,
    dependencia_router,
)

# Eliminamos la función 'lifespan' y la variable 'RUN_INIT_DB'
app = FastAPI(title="Process Optimizer API")

# CORS simplificado (Permitir todo)
# Esto elimina la necesidad de la variable 'FRONTEND_ORIGIN'
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
# Si esto falla ahora, es porque uno de ESTOS
# archivos tiene un error de código dentro.
for r in [
    catalogo_router,
    materia_router,
    area_router,
    tipo_maquina_router,
    proceso_router,
    diagrama_router,
    receta_router,
    diagrama_detalle_router,
    proceso_detalle_router,
    grafo_router,
    dependencia_router,
]:
    app.include_router(r)

@app.get("/")
def root():
    return {"status": "ok"}