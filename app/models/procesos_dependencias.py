from sqlmodel import SQLModel, Field, ForeignKey

class ProcesoDependencia(SQLModel, table=True):
    __tablename__ = "procesos_dependencias"

    id_origen: int = Field(foreign_key="procesos.id_proceso", primary_key=True)
    id_destino: int = Field(foreign_key="procesos.id_proceso", primary_key=True)