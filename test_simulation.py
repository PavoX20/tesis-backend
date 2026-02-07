import sys
import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# --- 1. AJUSTE DE RUTAS ---
# Añadimos la raíz del proyecto al path
current_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.append(current_dir)

# Intentamos importar el servicio
try:
    from app.services.simulation.run_simulation import run_simulation_service
    print("✅ Servicio de simulación importado correctamente.")
except ImportError as e:
    print(f"❌ Error crítico importando el servicio: {e}")
    print(f"   Ruta actual: {sys.path}")
    sys.exit(1)


DATABASE_URL = "postgresql://postgres.ihnqsldtgehizbzfckey:NuevaPassword11234@aws-1-us-east-1.pooler.supabase.com:5432/postgres"


def main():
    print(f"🔌 Conectando a BD: {DATABASE_URL} ...")
    
    try:
        engine = create_engine(DATABASE_URL)
        SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
        db = SessionLocal()
        
        # Prueba de conexión simple
        with engine.connect() as conn:
            print("✅ Conexión exitosa a la Base de Datos.")
            
    except Exception as e:
        print(f"❌ Error conectando a la BD: {e}")
        print("   Verifica las credenciales en 'test_simulation.py'")
        sys.exit(1)

    # --- 3. PARÁMETROS DE PRUEBA ---
    ZAPATO_ID = 110  # ID del Airflow
    META = 50        # Producir 50 pares
    
    print(f"\n🧪 Iniciando TEST de Simulación para Zapato ID={ZAPATO_ID}, Meta={META}")
    
    try:
        # Llamada al servicio real
        resultado = run_simulation_service(db, ZAPATO_ID, META)
        
        if "error" in resultado:
            print(f"\n❌ Error devuelto por el servicio: {resultado['error']}")
        else:
            print("\n✨ ¡PRUEBA EXITOSA!")
            meta = resultado['simulation_metadata']
            res = resultado['results']
            
            print(f"   - Tiempo Total: {meta['total_time_seconds']}s")
            print(f"   - Cuello de Botella: Proceso {meta['bottleneck_process_id']}")
            
            # Info de la gráfica
            chart_len = len(res['chart_base64'])
            print(f"   - Gráfica Base64 generada: {'SÍ' if chart_len > 0 else 'NO'} ({chart_len} caracteres)")
            
            # Info del historial
            filas_hist = len(res['history_main'])
            print(f"   - Historial generado: {filas_hist} pasos registrados.")
            
            print("\n📂 Revisa 'debug_dataframe_simulacion.xlsx' y 'grafica.png' en la carpeta.")

    except Exception as e:
        print(f"\n🔥 Excepción no controlada durante la ejecución: {e}")
        import traceback
        traceback.print_exc()
    finally:
        db.close()

if __name__ == "__main__":
    main()