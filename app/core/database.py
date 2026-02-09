from sqlmodel import SQLModel, create_engine, Session
from sqlalchemy.pool import NullPool  
from app.core.config import settings

# 1. Configuración del Engine 
# Aseguramos que DATABASE_URL sea string por si settings devuelve un objeto URL
engine = create_engine(
    str(settings.DATABASE_URL), 
    echo=False,
    poolclass=NullPool  
)

# 2. Tu función original (Mantenla, es útil para otras partes de tu app)
def get_session():
    with Session(engine) as session:
        yield session

def init_db():
    try:
        SQLModel.metadata.create_all(engine)
        print("✅ Base de datos (SQLModel) inicializada/verificada.")
    except Exception as e:
        print(f"❌ Error al inicializar la base de datos: {e}")
        pass

# 3. LA CORRECCIÓN IMPORTANTE:
# Definimos get_db usando 'Session(engine)' en lugar del 'SessionLocal' que no existía.
def get_db():
    """
    Dependency para obtener la sesión de base de datos en los endpoints.
    Compatible con router de simulación.
    """
    with Session(engine) as session:
        yield session