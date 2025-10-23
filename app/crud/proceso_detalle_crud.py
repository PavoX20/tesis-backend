from sqlmodel import Session, select
from app.models.proceso import Proceso
from app.models.tipo_maquina import TipoMaquina
from app.models.area import Area
from app.models.receta import Receta
from app.models.materia_prima import MateriaPrima

def get_proceso_detalle(session: Session, id_proceso: int):
    # Obtener el proceso principal
    proceso = session.get(Proceso, id_proceso)
    if not proceso:
        return None

    # Obtener tipo de máquina y área
    tipo_maquina = None
    area = None
    if proceso.id_tipomaquina:
        tipo_maquina = session.get(TipoMaquina, proceso.id_tipomaquina)
        if tipo_maquina and tipo_maquina.id_area:
            area = session.get(Area, tipo_maquina.id_area)

    # Obtener receta asociada (si existe)
    receta = session.exec(select(Receta).where(Receta.id_proceso == id_proceso)).first()

    receta_detalle = None
    if receta:
        materia_entrada = (
            session.get(MateriaPrima, receta.id_materia_entrada)
            if receta.id_materia_entrada else None
        )
        materia_salida = (
            session.get(MateriaPrima, receta.id_materia_salida)
            if receta.id_materia_salida else None
        )
        receta_detalle = {
            "id_receta": receta.id_receta,
            "materia_entrada": materia_entrada.nombre if materia_entrada else None,
            "cantidad_entrada": receta.cantidad_entrada,
            "materia_salida": materia_salida.nombre if materia_salida else None,
            "cantidad_salida": receta.cantidad_salida
        }

    # Construir respuesta completa
    return {
        "proceso": {
            "id_proceso": proceso.id_proceso,
            "nombre_proceso": proceso.nombre_proceso,
            "distribucion": proceso.distribucion,
            "parametros": proceso.parametros,
            "duracion": proceso.duracion
        },
        "tipo_maquina": {
            "id_tipomaquina": tipo_maquina.id_tipomaquina if tipo_maquina else None,
            "nombre_maquina": tipo_maquina.nombre_maquina if tipo_maquina else None,
            "cantidad_maquinas": tipo_maquina.cantidad_maquinas if tipo_maquina else None,
            "personal_max": tipo_maquina.personal_max if tipo_maquina else None
        } if tipo_maquina else None,
        "area": {
            "id_area": area.id_area if area else None,
            "nombre": area.nombre if area else None,
            "tipo": area.tipo if area else None,
            "personal": area.personal if area else None,
            "restriccion": area.restriccion if area else None
        } if area else None,
        "receta": receta_detalle
    }