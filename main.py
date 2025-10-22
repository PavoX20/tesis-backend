from fastapi import FastAPI
from contextlib import asynccontextmanager
from app.core.database import init_db
from app.api.routers import (
    catalogo_router,
    materia_prima_router,
    area_router,
    tipo_maquina_router,
    proceso_router,
    diagrama_router,
    diagrama_proceso_router,
    receta_router,
)

@asynccontextmanager
async def lifespan(app: FastAPI):
    init_db()
    yield

app = FastAPI(title="Process Optimizer API", lifespan=lifespan)

# Registro automático de todos los routers
for router in [
    catalogo_router,
    materia_prima_router,
    area_router,
    tipo_maquina_router,
    proceso_router,
    diagrama_router,
    diagrama_proceso_router,
    receta_router,
]:
    app.include_router(router)

@app.get("/")
def root():
    return {"status": "ok"}