import sys
import os
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Configuración rápida de conexión
# NOTA: Pon la contraseña real aquí entre comillas
DATABASE_URL="postgresql://postgres.ihnqsldtgehizbzfckey:NuevaPassword11234@aws-1-us-east-1.pooler.supabase.com:5432/postgres"
# Setup mínimo de la app para importar modelos
sys.path.append(os.getcwd())
from app.services.simulation.angelo_core.adapter import db_to_angelo_format

def validar_datos_bd():
    print("🔌 Conectando a Supabase...")
    
    try:
        engine = create_engine(DATABASE_URL)
        SessionLocal = sessionmaker(bind=engine)
        db = SessionLocal()
        print("✅ Conexión establecida.")
    except Exception as e:
        print(f"❌ Error conectando a BD: {e}")
        return

    # ID DEL PRODUCTO A PROBAR (Airflow = 110)
    ID_CATALOGO = 110 
    META = 100

    print(f"🔍 Extrayendo datos para Catalogo ID: {ID_CATALOGO} | Meta: {META}")
    
    try:
        # Llamamos al adaptador
        df_datos, df_bod, df_maq, df_are = db_to_angelo_format(db, ID_CATALOGO, META)
        
        if df_datos.empty:
            print("❌ ERROR: El DataFrame volvió vacío.")
            return

        print("\n✅ DATOS EXTRAÍDOS CON ÉXITO")
        print("=" * 100)
        
        # Seleccionamos columnas clave para visualizar
        cols_clave = [
            "ID_PROCESO", "NOMBRE", "INCIALES", "META", 
            "PARADA", "MATERIA", "PRODUCE"
        ]
        
        # Ajustamos el ancho para que se vea bien en consola
        pd.set_option('display.max_columns', None)
        pd.set_option('display.width', 1000)
        
        print(df_datos[cols_clave].to_string(index=False))
        print("=" * 100)
        
        print(f"\n📦 Bodega Inicial ({len(df_bod)} items):")
        print(df_bod.head())

    except Exception as e:
        print(f"🔥 Error Crítico durante la extracción: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    validar_datos_bd()