# test_excel_simulation.py
import pandas as pd
import sys
import os
import ast

# Ajustar path
sys.path.append(os.getcwd())
from app.services.simulation.angelo_core import runner

def clean_bool(val):
    # Convierte "TRUE", "verdadero", 1, etc. a True booleano
    s = str(val).strip().upper()
    return s in ["TRUE", "VERDADERO", "1", "SI", "YES"]

def probar_con_excel_original():
    print("📂 Cargando DATOS.xlsx original...")
    
    try:
        # 1. Cargar Procesos
        df_procesos = pd.read_excel("DATOS.xlsx")
        
        # --- LIMPIEZA BLINDADA DE DATOS ---
        # Normalizar nombres de columnas
        df_procesos.columns = [c.strip().upper() for c in df_procesos.columns]
        
        # Forzar ID_PROCESO a String (para coincidir con runner.py)
        df_procesos["ID_PROCESO"] = df_procesos["ID_PROCESO"].astype(str)
        
        # Forzar INCIALES a Booleano Real (Crucial)
        if "INCIALES" in df_procesos.columns:
            df_procesos["INCIALES"] = df_procesos["INCIALES"].apply(clean_bool)
        
        # Asegurar que existan columnas clave (aunque estén vacías)
        required_cols = ["DIAGRAMA", "AREA", "MATERIA", "PRODUCE", "PARAMETROS", "META"]
        for col in required_cols:
            if col not in df_procesos.columns:
                print(f"⚠️ Aviso: Columna {col} faltaba, se agregó por defecto.")
                df_procesos[col] = ""
        
        # Rellenar Meta por defecto si falta
        if "META" in df_procesos.columns:
            df_procesos["META"] = df_procesos["META"].fillna(100)

        print(f"✅ Procesos cargados y saneados: {len(df_procesos)} filas")
        print(df_procesos[["ID_PROCESO", "INCIALES", "MATERIA", "PARAMETROS"]].head())

        # 2. Generar Entorno Base (Igual que Angelo)
        print("\n🛠️ Generando entorno base...")
        
        df_bodega = pd.DataFrame([
            {"AREA": 0, "MATERIA": "M-001", "CANTIDAD": 999999}, # Stock infinito para probar
            {"AREA": 0, "MATERIA": "S-002", "CANTIDAD": 10},
            {"AREA": 0, "MATERIA": "S-001", "CANTIDAD": 0},
            # Agregamos materias extra por si acaso
            {"AREA": 0, "MATERIA": "M-002", "CANTIDAD": 999999},
        ])

        df_maquinaria = pd.DataFrame([
            {"AREA": 1, "MAQUINARIA": "MAQ-001", "CANTIDAD": 10},
            {"AREA": 2, "MAQUINARIA": "MAQ-001", "CANTIDAD": 4},
        ])

        df_areas = pd.DataFrame([
            {"AREA": 1, "PERSONAL": 12},
            {"AREA": 2, "PERSONAL": 8},
        ])

        # 3. EJECUTAR
        print("\n🚀 Iniciando Simulación...")
        resultado = runner.ejecutar_optimizacion(
            df_procesos, 
            df_bodega, 
            df_maquinaria, 
            df_areas
        )
        
        # 4. REPORTAR
        print("\n" + "=" * 60)
        print(f"🧠 STATUS FINAL: {resultado['status']}")
        print(f"🔄 Iteraciones: {resultado['iteracion']}")
        
        detalles = resultado.get("detalles_procesos", {})
        print(f"\n📋 Resultados por Proceso:")
        
        # Filtramos solo algunos para no llenar la pantalla
        count = 0
        for pid, info in detalles.items():
            prod = info.get('producido', '?') # Ojo: en runner nuevo no devuelve 'producido' en detalles
            estado = info['estado_final']
            # Para saber cuánto produjo, miramos el historial si está disponible o inferimos
            # En el runner actual 'detalles' tiene: nombre, buffer, estado, t_activo...
            
            es_cuello = "🔴 CUELLO" if info['es_cuello'] else "🟢"
            print(f"   {es_cuello} ID {pid}: {info['nombre']} | Est: {estado} | Buff: {info['buffer_recomendado']}")
            count += 1
            if count > 15: 
                print("   ... (más procesos)")
                break

    except Exception as e:
        print(f"🔥 Error Crítico: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    probar_con_excel_original()