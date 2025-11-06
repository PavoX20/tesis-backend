# app/main.py
import os
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

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
)

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Evita que el deploy falle si no hay DB en Vercel
    if os.getenv("RUN_INIT_DB") == "1":
        init_db()
    yield

app = FastAPI(title="Process Optimizer API", lifespan=lifespan)

# CORS único
FRONTEND_ORIGIN = os.getenv("FRONTEND_ORIGIN", "*")
DEV = {"http://localhost:5173", "http://127.0.0.1:5173"}
allow_origins = ["*"] if FRONTEND_ORIGIN == "*" else list(DEV | {FRONTEND_ORIGIN})

app.add_middleware(
    CORSMiddleware,
    allow_origins=allow_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Routers
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