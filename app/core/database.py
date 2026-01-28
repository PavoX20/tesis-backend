from sqlmodel import SQLModel, create_engine, Session
from sqlalchemy.pool import NullPool  

from app.core.config import settings

engine = create_engine(
    settings.DATABASE_URL, 
    echo=False,
    poolclass=NullPool  

)

def get_session():
    with Session(engine) as session:
        yield session

def init_db():

    try:
        SQLModel.metadata.create_all(engine)
    except Exception as e:
        print(f"Error al inicializar la base de datos: {e}")

        pass