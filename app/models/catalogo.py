from sqlmodel import SQLModel, Field, Column, String, Numeric

class Catalogo(SQLModel, table=True):
    __tablename__ = "catalogo"

    id_catalogo: int | None = Field(default=None, primary_key=True)
    nombre: str = Field(sa_column=Column(String(255), nullable=False))
    descripcion: str | None = None
    genero: str | None = Field(default=None)
    restriccion: str | None = Field(default=None)
    precio: float | None = Field(default=None, sa_column=Column(Numeric(10,2)))