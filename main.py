import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
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
    tipo_maquina_router,
)

@asynccontextmanager
async def lifespan(app: FastAPI):
    init_db()
    yield

app = FastAPI(title="Process Optimizer API", lifespan=lifespan)

FRONTEND_ORIGIN = os.getenv("FRONTEND_ORIGIN", "*")
app.add_middleware(
    CORSMiddleware,
    allow_origins=[FRONTEND_ORIGIN] if FRONTEND_ORIGIN != "*" else ["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Registro de routers
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
    tipo_maquina_router
]:
    app.include_router(router)

@app.get("/")
def root():
    return {"status": "ok"}