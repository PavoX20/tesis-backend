# --- 1. IMPORTACIONES BÁSICAS ---
import os
import sys
from pathlib import Path
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

# --- 2. CORRECCIÓN DE RUTA (HACK PARA VERCEL/RENDER) ---
FILE = Path(__file__).resolve()
ROOT = FILE.parent
if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))

# --- 3. IMPORTACIÓN DE TUS RUTAS ---
from app.core.database import init_db
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
    dato_proceso_router,
    analysis_router,
    inventario_router,
    simulation_router # Importamos el router unificado
)

# --- 4. LISTA DE IP PERMITIDAS (YA NO SE USA) ---
# ALLOWED_IPS = ["190.110.42.214", "127.0.0.1"]

# --- 5. FUNCIÓN 'LIFESPAN' ---
@asynccontextmanager
async def lifespan(app: FastAPI):
    if os.getenv("RUN_INIT_DB") == "1":
        print("INFO:     Ejecutando init_db() al arrancar...")
        init_db()
        print("INFO:     Base de datos inicializada.")
    else:
        print("INFO:     Omitiendo init_db() (RUN_INIT_DB no es '1').")
    yield
    print("INFO:     Cerrando aplicación.")

# --- 6. CREACIÓN DE LA APP ---
app = FastAPI(title="Process Optimizer API", lifespan=lifespan)

# --- 7. MIDDLEWARE DE FILTRO DE IP (COMENTADO) ---
# ... (Igual que antes)

# --- 8. MIDDLEWARE DE CORS ---
frontend_origin = os.getenv("FRONTEND_ORIGIN", "*")
local_origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
]

if frontend_origin == "*":
    allow_origins = ["*"]
else:
    allow_origins = local_origins + [frontend_origin] 

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- 9. REGISTRO DE RUTAS ---

# A. Rutas Estándar
for router in [
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
    dato_proceso_router,
    analysis_router,
    inventario_router
]:
    app.include_router(router)

# B. Ruta de Simulación (Configuración Especial)
# IMPORTANTE: Usamos el prefijo "/simulacion" para coincidir con:
# 1. El frontend antiguo (/simulacion/run)
# 2. El frontend nuevo (/simulacion/visual-run)
app.include_router(
    simulation_router, # Accedemos al objeto router dentro del módulo
    prefix="/simulacion", 
    tags=["Simulación"]
)

# --- 10. RUTA RAÍZ ---
@app.get("/")
def root():
    return {"status": "ok"}