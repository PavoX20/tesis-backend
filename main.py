# --- 1. IMPORTACIONES BÁSICAS ---
# Importamos las librerías necesarias
import os
import sys
from pathlib import Path
from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

# --- 2. CORRECCIÓN DE RUTA (HACK PARA VERCEL) ---
# Esto es necesario para que Vercel pueda encontrar tu carpeta 'app'
# Tu 'main.py' está en la raíz, pero tus imports (ej. app.core) están adentro.
# Uvicorn local lo entiende, pero Vercel necesita esta ayuda.
FILE = Path(__file__).resolve()
ROOT = FILE.parent
if str(ROOT) not in sys.path:
    sys.path.append(str(ROOT))

# --- 3. IMPORTACIÓN DE TUS RUTAS ---
# Ahora que Vercel ya sabe dónde está la carpeta 'app',
# importamos todos los routers que definiste en 'app/api/routers/__init__.py'
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

# --- 4. LISTA DE IP PERMITIDAS (SEGURIDAD) ---
# ¡¡¡AQUÍ ESTÁ LA CORRECCIÓN!!!
# Añadimos "127.0.0.1" para que te permita el acceso en local.
ALLOWED_IPS = ["190.110.42.214", "127.0.0.1"]  # Tu IP pública + IP Local

# --- 5. FUNCIÓN 'LIFESPAN' (PARA TU BBDD LOCAL) ---
# Esto se ejecuta cuando corres 'uvicorn' en tu local.
# Inicia la conexión con la base de datos al arrancar.
@asynccontextmanager
async def lifespan(app: FastAPI):
    print("INFO:     Ejecutando init_db() al arrancar...")
    init_db()
    print("INFO:     Base de datos inicializada.")
    yield
    print("INFO:     Cerrando aplicación.")

# --- 6. CREACIÓN DE LA APP ---
# Creamos la aplicación FastAPI y le decimos que use tu función 'lifespan'.
app = FastAPI(title="Process Optimizer API", lifespan=lifespan)

# --- 7. MIDDLEWARE DE FILTRO DE IP (SEGURIDAD) ---
# Esto es un "guardia de seguridad". Se ejecuta ANTES que cualquier ruta.
# Revisa la IP del visitante y la compara con tu lista 'ALLOWED_IPS'.
@app.middleware("http")
async def ip_filter_middleware(request: Request, call_next):
    ip = request.client.host  # Obtiene la IP del visitante
    
    if ip not in ALLOWED_IPS:
        # Si la IP no está en la lista, lo bloquea con un error 403.
        return JSONResponse(
            status_code=403, 
            content={"detail": "Acceso no permitido"}
        )
    
    # Si la IP está en la lista, lo deja pasar a la siguiente función.
    response = await call_next(request)
    return response

# --- 8. MIDDLEWARE DE CORS (PERMISOS DE FRONTEND) ---
# Esto le dice al navegador desde qué otras URLs (Frontends)
# se permite hacer peticiones a este Backend.
# He combinado tus dos bloques de CORS en uno solo.

# Lee la variable de entorno 'FRONTEND_ORIGIN' (para Vercel)
frontend_origin = os.getenv("FRONTEND_ORIGIN", "*")

# Define tus orígenes locales
local_origins = [
    "http://localhost:5173",
    "http://127.0.0.1:5173",
]

# Decide qué lista de orígenes usar
if frontend_origin == "*":
    allow_origins = ["*"]  # Permite todo (ideal para Vercel si no tienes dominio)
else:
    allow_origins = local_origins + [frontend_origin] # Combina local + Vercel

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- 9. REGISTRO DE RUTAS ---
# Aquí le decimos a la app principal que incluya
# todas las rutas que definiste en tus archivos de router.
# (Nota: Tenías 'tipo_maquina_router' dos veces, lo dejé solo una vez).
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
# Una ruta simple para saber que la API está funcionando.
@app.get("/")
def root():
    return {"status": "ok"}