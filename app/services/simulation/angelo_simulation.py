from sqlalchemy.orm import Session
from app.api.schemas.simulation import SimulationRequest
from .angelo_core import adapter, runner, grafica 
import traceback

def run_simulation(db: Session, request: SimulationRequest):
    """
    Punto de entrada: Ejecuta el algoritmo de Buffers de Angelo conectado a la BD.
    """
    # 1. Validaciones
    if not request.productos:
        return {"error": "No se enviaron productos"}

    prod = request.productos[0]

    umbral = request.umbral_pausa if request.umbral_pausa is not None else 0.20
    
    # 2. Obtener Datos (BD)
    df_datos = adapter.db_to_angelo_format(db, prod.id_catalogo)
    
    if df_datos.empty:
        return {"modelo": "Desconocido", "error": "No hay datos."}

    # 3. Correr Simulación (El runner ahora devuelve 'historial' también)
    try:
        resultado = runner.ejecutar_simulacion_angelo(df_datos, prod.cantidad)
    except Exception as e:
        traceback.print_exc()
        return {"error": f"Error simulación: {str(e)}"}

    # 4. Generar Gráfica
    lista_resultados = []
    detalles = resultado.get('detalles_procesos', {})
    
    for pid, info in detalles.items():
        lista_resultados.append({
            "id_proceso": pid,
            "t_activo": info.get("t_activo", "0"),
            "t_pausado": info.get("t_pausado", "0")
        })
        
    grafica_b64 = grafica.grafico_tiempos_ideal_real(lista_resultados)

    # 5. Respuesta Final
    return {
        "modelo": f"Producto {prod.id_catalogo}",
        "meta_cantidad": prod.cantidad,
        "resumen": {
            "tiempo_calculo": f"{resultado.get('tiempo_computo', 0):.2f}s",
            "status": resultado.get('status', 'Error')
        },
        "detalles_procesos": detalles,
        
        # --- NUEVA LÍNEA PARA LA PELÍCULA ---
        # Pasamos el historial que el runner grabó frame a frame
        "historial_animacion": resultado.get('historial', []), 
        
        "grafica_base64": grafica_b64
    }