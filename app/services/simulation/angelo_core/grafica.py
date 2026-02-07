import matplotlib
matplotlib.use('Agg') # Importante: Modo "sin cabeza"
import matplotlib.pyplot as plt
import pandas as pd
import io
import base64

def grafico_tiempos_ideal_real(resultados_lista):
    """
    Genera la gráfica de barras apiladas (IDEAL vs REAL) y la devuelve como Base64.
    """
    if not resultados_lista:
        return None

    rows = []
    for item in resultados_lista:
        rows.append({
            "ID": str(item.get("id_proceso")), # Asegurar que ID sea string
            "REAL_T_ACTIVO": item.get("t_activo", "0"),
            "REAL_T_PAUSADO": item.get("t_pausado", "0"),
            "IDEAL_T_ACTIVO": "0", 
            "IDEAL_T_PAUSADO": "0" 
        })
    
    df = pd.DataFrame(rows)

    # --- CORRECCIÓN CLAVE AQUÍ ---
    def to_float(x):
        try:
            # Si ya es número, devolverlo
            if isinstance(x, (int, float)): return float(x)
            # Si es string, intentar conversión directa (Python usa punto para decimales)
            return float(x)
        except:
            return 0.0

    cols = ["IDEAL_T_ACTIVO", "IDEAL_T_PAUSADO", "REAL_T_ACTIVO", "REAL_T_PAUSADO"]
    for c in cols:
        df[c] = df[c].apply(to_float)

    ids = df["ID"].tolist()
    x = range(len(ids))
    w = 0.35

    x_ideal = [xi - w / 2 for xi in x]
    x_real = [xi + w / 2 for xi in x]

    plt.figure(figsize=(10, 6))

    # Barras Ideales (Azules - Placeholder en 0 por ahora)
    plt.bar(x_ideal, df["IDEAL_T_ACTIVO"], width=w, label="Ideal Activo", color='#93c5fd')
    plt.bar(x_ideal, df["IDEAL_T_PAUSADO"], width=w, bottom=df["IDEAL_T_ACTIVO"], label="Ideal Pausado", color='#bfdbfe')

    # Barras Reales (Verdes y Naranjas)
    # 1. Base: Tiempo Activo (Verde)
    plt.bar(x_real, df["REAL_T_ACTIVO"], width=w, label="Real Activo", color='#22c55e')
    # 2. Top: Tiempo Pausado (Naranja) - Se apila sobre el activo
    plt.bar(x_real, df["REAL_T_PAUSADO"], width=w, bottom=df["REAL_T_ACTIVO"], label="Real Pausado", color='#f97316')

    plt.xticks(x, ids, rotation=45)
    plt.ylabel("Tiempo (Segundos)")
    plt.title("Comparativa de Tiempos por Proceso")
    plt.grid(axis="y", alpha=0.3)
    plt.legend()
    plt.tight_layout()

    buffer = io.BytesIO()
    plt.savefig(buffer, format='png')
    plt.close()
    buffer.seek(0)
    
    image_base64 = base64.b64encode(buffer.getvalue()).decode('utf-8')
    return image_base64