import requests
import json
import base64
import time

# --- CONFIGURACIÓN PARA AIRFLOW ---
# Asegúrate de que tu backend esté corriendo en este puerto
URL = "http://localhost:8000/simulacion/visual-run" 

# Según tus CSVs: 
# ID 110 = Airflow Diagrama Principal
ID_CATALOGO_AIRFLOW = 110  

# Meta de producción para estresar el algoritmo
CANTIDAD_META = 5

def probar_simulacion():
    print(f"🏭 Iniciando prueba de simulación para: AIRFLOW (ID {ID_CATALOGO_AIRFLOW})")
    print(f"🎯 Meta de producción: {CANTIDAD_META} unidades")
    print("-" * 60)

    # Payload exacto como lo espera tu Pydantic Schema
    payload = {
        "productos": [
            {
                "id_catalogo": ID_CATALOGO_AIRFLOW,
                "cantidad": CANTIDAD_META
            }
        ],
        "umbral_pausa": 0.20 # Sensibilidad del algoritmo
    }

    start_time = time.time()

    try:
        # 1. Enviar Petición al Backend
        print("⏳ Enviando datos al cerebro de Angelo...")
        response = requests.post(URL, json=payload)
        
        # 2. Verificar Status
        if response.status_code == 200:
            data = response.json()
            total_time = time.time() - start_time
            
            print(f"\n✅ ¡ÉXITO! Respuesta recibida en {total_time:.2f}s")
            print("=" * 60)
            
            # --- ANÁLISIS DE RESULTADOS ---
            
            resumen = data.get("resumen", {})
            print(f"🧠 Status Algoritmo: {resumen.get('status')}")
            print(f"🔄 Iteraciones realizadas: {resumen.get('iteraciones')} (Si es > 1, optimizó buffers)")
            
            detalles = data.get("detalles_procesos", {})
            print(f"\n📋 REPORTE DE PROCESOS ({len(detalles)} detectados):")
            print(f"{'PROCESO':<40} | {'BUFFER REC.':<12} | {'ESTADO'}")
            print("-" * 70)
            
            cuello_detectado = False
            
            for nombre, info in detalles.items():
                es_cuello = info.get("es_cuello", False)
                estado_str = "🔴 CUELLO DE BOTELLA" if es_cuello else "🟢 Normal"
                buffer = f"{info.get('buffer_recomendado', 0)} u."
                
                if es_cuello: cuello_detectado = True
                
                # Imprimimos filas, resaltando el cuello
                prefix = "👉 " if es_cuello else "   "
                print(f"{prefix}{nombre:<37} | {buffer:<12} | {estado_str}")

            print("-" * 70)
            if not cuello_detectado:
                print("⚠️ No se marcó ningún proceso como Cuello de Botella (Revisar columna 'CAPACIDAD').")

            # --- VERIFICACIÓN DE ANIMACIÓN ---
            historial = data.get("historial_animacion", [])
            print(f"\n🎬 Película generada: {len(historial)} frames totales.")
            if len(historial) > 0:
                print(f"   - Inicio: T={historial[0]['timestamp']}s")
                print(f"   - Fin:    T={historial[-1]['timestamp']}s")
                
                # Verificamos si en el último frame se llegó a la meta
                last_frame = historial[-1]["procesos"]
                print("   - Estado Final (Muestra):")
                count = 0
                for k, v in last_frame.items():
                    if count < 3: # Mostrar solo los primeros 3 para no saturar consola
                        print(f"     * {k}: {v['producido']}")
                    count += 1
                if count > 3: print("     * ...")

            # --- GUARDAR GRÁFICA ---
            grafica = data.get("grafica_base64")
            if grafica:
                filename = "resultado_airflow.png"
                with open(filename, "wb") as f:
                    f.write(base64.b64decode(grafica))
                print(f"\n📊 Gráfica guardada como: '{filename}' (Ábrela para ver Tiempos Reales vs Ideales)")

        else:
            print(f"\n❌ ERROR DEL SERVIDOR ({response.status_code}):")
            try:
                print(json.dumps(response.json(), indent=2))
            except:
                print(response.text)

    except Exception as e:
        print(f"\n🔥 EXCEPCIÓN DE CONEXIÓN: {str(e)}")
        print("Pasos para solucionar:")
        print("1. ¿Está corriendo el backend? (uvicorn main:app --reload)")
        print("2. ¿El puerto es el correcto? (8000)")

if __name__ == "__main__":
    probar_simulacion()