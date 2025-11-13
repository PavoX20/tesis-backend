from sqlmodel import SQLModel, create_engine, Session
from sqlalchemy.pool import NullPool  # ¡Importante!
from app.core.config import settings

# --- ESTA ES LA CORRECIÓN ---
# Cuando te conectas a un "pooler" externo como PgBouncer (Supabase),
# debes deshabilitar el pooling de SQLAlchemy usando `poolclass=NullPool`.
# De lo contrario, tienes un "pool dentro de otro pool", lo que agota
# las conexiones de Supabase rápidamente.
engine = create_engine(
    settings.DATABASE_URL, 
    echo=False,
    poolclass=NullPool  # Deshabilita el pool de SQLAlchemy
)

# Esta función ya estaba correcta, pero es la clave.
# El `with` se asegura de que la sesión se cierre y 
# la conexión se devuelva al pool de Supabase.
def get_session():
    with Session(engine) as session:
        yield session

# Función para crear las tablas (se llama en el lifespan de main.py)
def init_db():
    # En un entorno de producción, esto es mejor manejarlo
    # con migraciones (ej. Alembic), pero para el arranque está bien.
    try:
        SQLModel.metadata.create_all(engine)
    except Exception as e:
        print(f"Error al inicializar la base de datos: {e}")
        # Es posible que la base de datos ya esté conectada o haya un error de conexión
        pass