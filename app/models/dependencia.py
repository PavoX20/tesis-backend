from sqlmodel import SQLModel, Field

class Dependencia(SQLModel, table=True):
    __tablename__ = "procesos_dependencias"
    

    __table_args__ = {"extend_existing": True}

    id_origen: int = Field(foreign_key="procesos.id_proceso", primary_key=True)
    id_destino: int = Field(foreign_key="procesos.id_proceso", primary_key=True)