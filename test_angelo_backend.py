import pandas as pd
import sys
import os

# Aseguramos que python encuentre la carpeta app
sys.path.append(os.getcwd())

from app.services.simulation.angelo_core import runner, adapter

# 1. Creamos DATOS FALSOS (Simulando lo que vendría de la BD)
print("--- 1. Generando Datos de Prueba ---")
datos_mock = [
    {
        "DIAGRAMA": 1, "AREA": 1, "ID_PROCESO": 100, "TIPO": "NORMAL",
        "ID_MAQUINA": "MAQ-1", "MAQUINAS": 2, "MAX_P": 2, "PERSONAL": 1,
        "INCIALES": True, "META": 10, "PARADA": 10, "PRODUCE": "S-100",
        "CANTIDAD": 5, "MATERIA": "M-RAW", "DISTRIBUCION": "norm", "PARAMETROS": "[2, 0.5]",
        "CUELLO_DE_BOTELLA": False, "FINALES": False
    },
    {
        "DIAGRAMA": 1, "AREA": 1, "ID_PROCESO": 101, "TIPO": "NORMAL",
        "ID_MAQUINA": "MAQ-1", "MAQUINAS": 1, "MAX_P": 2, "PERSONAL": 1,
        "INCIALES": False, "META": 10, "PARADA": 10, "PRODUCE": "S-101",
        "CANTIDAD": 5, "MATERIA": "S-100", "DISTRIBUCION": "norm", "PARAMETROS": "[3, 1]",
        "CUELLO_DE_BOTELLA": False, "FINALES": True
    }
]
df_datos = pd.DataFrame(datos_mock)
print(f"DataFrame creado con {len(df_datos)} procesos.")

# 2. Ejecutamos la Simulación (Como lo haría el servicio)
print("\n--- 2. Ejecutando Simulación Angelo (Backend) ---")
try:
    meta = 50
    resultado = runner.ejecutar_simulacion_angelo(df_datos, meta)
    
    print("\n--- 3. RESULTADOS OBTENIDOS ---")
    print(f"Status: {resultado['status']}")
    print(f"Tiempo de Cómputo: {resultado['tiempo_computo']:.4f} seg")
    print("\nDetalles por Proceso:")
    
    for pid, info in resultado['detalles_procesos'].items():
        print(f"Proceso {pid}:")
        print(f"   > Buffer Rec: {info['buffer_recomendado']}")
        print(f"   > Estado Final: {info['estado_final']}")
        print(f"   > T. Activo: {info['t_activo']}")
        print(f"   > T. Pausado: {info['t_pausado']}")
        
    print("\n✅ ¡PRUEBA EXITOSA! El cerebro de Angelo está vivo en el Backend.")


    from app.services.simulation.angelo_core import grafica
    
    # Convertimos el formato del test al formato de lista
    lista_res = []
    for pid, info in resultado['detalles_procesos'].items():
        lista_res.append({
            "id_proceso": pid,
            "t_activo": info['t_activo'],
            "t_pausado": info['t_pausado']
        })
        
    print("\n--- 4. Generando Gráfica ---")
    img = grafica.grafico_tiempos_ideal_real(lista_res)
    if img:
        print(f"✅ Gráfica generada correctamente! (Tamaño: {len(img)} chars)")
        print(f"Inicio cadena: {img[:50]}...")
    else:
        print("❌ Error generando gráfica")

except Exception as e:
    print(f"\n❌ ERROR: {e}")
    import traceback
    traceback.print_exc()