from sqlalchemy.orm import Session
from app.models import Catalogo, DiagramaDeFlujo, Proceso, Dependencia
from app.services.simulation.visual_engine import MotorSimulacionVisual
from collections import defaultdict

def ejecutar_simulacion_visual(db: Session, id_producto: int, cantidad: int):
    # 1. Validar Producto
    catalogo = db.query(Catalogo).filter(Catalogo.id_catalogo == id_producto).first()
    if not catalogo:
        raise ValueError("Producto no encontrado")

    # 2. Obtener TODOS los diagramas
    diagramas = db.query(DiagramaDeFlujo).filter(DiagramaDeFlujo.id_catalogo == id_producto).all()
    if not diagramas:
        raise ValueError("El producto no tiene diagramas asociados")
    
    ids_diagramas = [d.id_diagrama for d in diagramas]

    # 3. Obtener TODOS los procesos
    procesos_db = db.query(Proceso).filter(Proceso.id_diagrama.in_(ids_diagramas)).all()
    
    if not procesos_db:
        raise ValueError("No hay procesos definidos en los diagramas")
    
    ids_procesos_encontrados = [p.id_proceso for p in procesos_db]

    # 4. Obtener DEPENDENCIAS
    dependencias_db = db.query(Dependencia).filter(
        Dependencia.id_origen.in_(ids_procesos_encontrados),
        Dependencia.id_destino.in_(ids_procesos_encontrados)
    ).all()

    # 5. Configurar Data
    procesos_config = []
    for p in procesos_db:
        tiempo = float(p.duracion) if p.duracion is not None else 5.0
        variabilidad = 1.0 

        procesos_config.append({
            "id": p.id_proceso,
            "nombre": p.nombre_proceso,
            "tiempo_base": tiempo,
            "variabilidad": variabilidad,
            "id_diagrama": p.id_diagrama
        })

    conexiones = []
    for dep in dependencias_db:
        conexiones.append((dep.id_origen, dep.id_destino))

    if not conexiones:
        # Fallback orden secuencial
        procesos_por_diagrama = defaultdict(list)
        for p in procesos_db:
            procesos_por_diagrama[p.id_diagrama].append(p)
        
        for lista in procesos_por_diagrama.values():
            lista_ordenada = sorted(lista, key=lambda x: x.orden if x.orden else 0)
            for i in range(len(lista_ordenada) - 1):
                conexiones.append((lista_ordenada[i].id_proceso, lista_ordenada[i+1].id_proceso))

    # 6. Correr Motor
    stock_inicial = 50 
    motor = MotorSimulacionVisual(
        procesos_config=procesos_config, 
        conexiones=conexiones, 
        total_zapatos=cantidad,
        buffer_seguridad_inicial=stock_inicial
    )
    
    resultados = motor.correr()

    # RETORNO CORREGIDO: Solo enviamos lo que el motor devuelve
    return {
        "modelo": catalogo.nombre,
        "meta_cantidad": cantidad,
        "resumen": {
            "tiempo_total": resultados['total_tiempo'],
            "items_producidos": resultados['total_producido']
        },
        "timeline": resultados['timeline'],
        # "grafica": resultados['grafica_rendimiento'], <--- ELIMINADO PORQUE YA NO EXISTE
        "grafica_base64": resultados['grafica_base64']  # <--- ESTO ES LO CORRECTO
    }