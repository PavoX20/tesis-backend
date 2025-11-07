import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

# Ya no importamos 'asynccontextmanager' ni 'init_db'
# from contextlib import asynccontextmanager
# from app.core.database import init_db

# --- ADVERTENCIA ---
# El error 'exit status 1' está casi seguro
# DENTRO de uno de estos archivos que importas.
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
# Vercel no debe ejecutar init_db() al arrancar
app = FastAPI(title="Process Optimizer API")

# CORS simplificado
# Como dijiste que no hay frontend, abrimos todo a "*"
# Esto elimina la necesidad de la variable 'FRONTEND_ORIGIN'
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Permitir todos los orígenes
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
# El 'crash' (exit status 1) ocurre cuando Python
# intenta importar uno de estos routers y ese
# archivo tiene un error (como el de Pandas).
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