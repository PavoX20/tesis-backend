# --- 1. IMPORTACIONES BÁSICAS ---
# Importamos las librerías necesarias
import os
import sys
from pathlib import Path
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

# --- 2. CORRECCIÓN DE RUTA (HACK PARA VERCEL/RENDER) ---
# Le dice a Python dónde encontrar la carpeta 'app'
FILE = Path(__file__).resolve()
ROOT = FILE.parent
if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))

# --- 3. IMPORTACIÓN DE TUS RUTAS ---
from app.core.database import init_db # Importamos init_db
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
)

# --- 4. LISTA DE IP PERMITIDAS (YA NO SE USA) ---
# ALLOWED_IPS = ["190.110.42.214", "127.0.0.1"]

# --- 5. FUNCIÓN 'LIFESPAN' (PARA TU BBDD LOCAL) ---
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Modificado para que solo se ejecute si pones RUN_INIT_DB=1
    # En local, puedes ejecutar: RUN_INIT_DB=1 uvicorn main:app
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

# --- 7. MIDDLEWARE DE FILTRO DE IP (¡COMENTADO!) ---
#
# ¡¡¡HEMOS COMENTADO ESTE BLOQUE!!!
# Ya no queremos bloquear a la gente por IP.
# La seguridad ahora la maneja el Bloque 8 (CORS),
# que solo permite peticiones desde tu URL de Vercel.
#
# @app.middleware("http")
# async def ip_filter_middleware(request: Request, call_next):
#     ip = request.client.host
#     
#     if ip not in ALLOWED_IPS:
#         return JSONResponse(
#             status_code=403, 
#             content={"detail": "Acceso no permitido"}
#         )
#     
#     response = await call_next(request)
#     return response

# --- 8. MIDDLEWARE DE CORS (¡LA SEGURIDAD REAL!) ---
# Esto está perfecto. Render leerá tu variable de entorno
# 'FRONTEND_ORIGIN' y solo permitirá peticiones
# que vengan de tu URL de Vercel (y de localhost).

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
]:
    app.include_router(router)

# --- 10. RUTA RAÍZ ---
@app.get("/")
def root():
    return {"status": "ok"}