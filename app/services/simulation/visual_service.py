from sqlalchemy.orm import Session
from app.models import Catalogo, DiagramaDeFlujo, Proceso, Dependencia, Receta, TipoMaquina, Area
from app.services.simulation.visual_engine import MotorSimulacionVisual
from collections import defaultdict
import ast  # Necesario para leer la data histórica real

def ejecutar_simulacion_visual(db: Session, id_producto: int, cantidad: int):
    # 1. Validar Producto
    catalogo = db.query(Catalogo).filter(Catalogo.id_catalogo == id_producto).first()
    if not catalogo:
        raise ValueError("Producto no encontrado")

    # 2. Obtener Diagramas
    diagramas = db.query(DiagramaDeFlujo).filter(DiagramaDeFlujo.id_catalogo == id_producto).all()
    if not diagramas:
        raise ValueError("El producto no tiene diagramas asociados")
    
    ids_diagramas = [d.id_diagrama for d in diagramas]

    # 3. Obtener Procesos con sus MAQUINAS y AREAS reales
    resultados_consulta = db.query(Proceso, TipoMaquina, Area)\
        .outerjoin(TipoMaquina, Proceso.id_tipomaquina == TipoMaquina.id_tipomaquina)\
        .outerjoin(Area, TipoMaquina.id_area == Area.id_area)\
        .filter(Proceso.id_diagrama.in_(ids_diagramas))\
        .all()
    
    if not resultados_consulta:
        raise ValueError("No hay procesos definidos en los diagramas")
    
    procesos_db = [r[0] for r in resultados_consulta]
    ids_procesos_encontrados = [p.id_proceso for p in procesos_db]

    # 4. Cálculo de Materiales (Informativo)
    try:
        recetas = db.query(Receta).filter(Receta.id_proceso.in_(ids_procesos_encontrados)).all()
    except Exception as e:
        print(f"ADVERTENCIA: Error al consultar recetas: {e}")

    # 5. Dependencias
    dependencias_db = db.query(Dependencia).filter(
        Dependencia.id_origen.in_(ids_procesos_encontrados),
        Dependencia.id_destino.in_(ids_procesos_encontrados)
    ).all()

    # 6. Configurar Data con DATOS HISTÓRICOS REALES (Sin Hardcoding)
    procesos_config = []
    
    for row in resultados_consulta:
        proc = row[0]
        maq = row[1]
        area = row[2]

        nombre_area = area.nombre if area else "Sin Área Asignada"
        nombre_maquina = maq.nombre_maquina if maq else "Manual / Sin Máquina"
        
        # --- LÓGICA DE TIEMPO REAL (Idéntica a service.py) ---
        # 1. Intentar usar DURACION (Campo nuevo)
        tiempo = float(proc.duracion) if proc.duracion is not None else 0.0
        
        # 2. Si no hay duración, usar PARAMETROS (Data Histórica)
        # Esto elimina el "hardcodeo" de 5.0 segundos.
        variabilidad = 1.0
        if tiempo <= 0:
            try:
                if proc.parametros:
                    # Convertimos "[30, 5]" a lista real
                    params_list = ast.literal_eval(proc.parametros)
                    if isinstance(params_list, list) and len(params_list) > 0:
                        # El primer valor es la media (tiempo base)
                        tiempo = float(params_list[0])
                        # El segundo valor es la variabilidad
                        if len(params_list) > 1:
                            variabilidad = float(params_list[1])
            except Exception as e:
                print(f"Error parseando params proc {proc.id_proceso}: {e}")
        
        # 3. Solo si FALLA TODO (Base de datos vacía), usamos un mínimo técnico
        # para que no crashee la división por cero.
        if tiempo <= 0.1:
            tiempo = 5.0 # Último recurso técnico
            
        # Capacidad real
        personal_max_real = int(maq.personal_max) if maq and maq.personal_max else 1

        procesos_config.append({
            "id": proc.id_proceso,
            "nombre": proc.nombre_proceso,
            "tiempo_base": tiempo,       # Ahora usará los 30 min históricos si no hay duración
            "variabilidad": variabilidad,
            "id_diagrama": proc.id_diagrama,
            "nombre_area_real": nombre_area,
            "nombre_maquina_real": nombre_maquina,
            "personal_max_real": personal_max_real
        })

    conexiones = []
    for dep in dependencias_db:
        conexiones.append((dep.id_origen, dep.id_destino))

    # Fallback
    if not conexiones:
        procesos_por_diagrama = defaultdict(list)
        for p in procesos_db:
            procesos_por_diagrama[p.id_diagrama].append(p)
        
        for lista in procesos_por_diagrama.values():
            lista_ordenada = sorted(lista, key=lambda x: x.orden if x.orden else 0)
            for i in range(len(lista_ordenada) - 1):
                conexiones.append((lista_ordenada[i].id_proceso, lista_ordenada[i+1].id_proceso))

    # 7. Motor
    stock_inicial = 50 
    motor = MotorSimulacionVisual(
        procesos_config=procesos_config, 
        conexiones=conexiones, 
        total_zapatos=cantidad,
        buffer_seguridad_inicial=stock_inicial
    )
    
    resultados = motor.correr()

    return {
        "modelo": catalogo.nombre,
        "meta_cantidad": cantidad,
        "resumen": {
            "tiempo_total": resultados['total_tiempo'],
            "items_producidos": resultados['total_producido']
        },
        "timeline": resultados['timeline'],
        "grafica_base64": resultados['grafica_base64']
    }