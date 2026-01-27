from typing import Optional
from sqlmodel import SQLModel, Field, Relationship

# Importamos los modelos para las llaves foráneas
# OJO: Ajusta si tus nombres de archivo son diferentes, pero según tu foto es así:
from app.models.area import Area
from app.models.materia_model import Materia 

# Clase Base (campos compartidos)
class InventarioBase(SQLModel):
    id_area: int = Field(foreign_key="areas.id_area")
    id_materia: int = Field(foreign_key="materias.id_materia")
    cantidad: float = Field(default=0) # Cantidad actual en bodega

# Modelo de Tabla (DB)
class Inventario(InventarioBase, table=True):
    __tablename__ = "inventario"
    __table_args__ = {"extend_existing": True} # Para evitar conflictos al recargar

    id_inventario: Optional[int] = Field(default=None, primary_key=True)

    # Relaciones (Opcional, pero recomendado para consultas futuras)
    # area: Optional[Area] = Relationship()
    # materia: Optional[Materia] = Relationship()

# Schema para Crear/Recibir datos desde el Front
class InventarioCreate(InventarioBase):
    pass

# Schema para Actualizar
class InventarioUpdate(SQLModel):
    cantidad: float