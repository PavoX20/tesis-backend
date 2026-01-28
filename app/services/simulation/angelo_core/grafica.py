import matplotlib
matplotlib.use('Agg') # Importante: Modo "sin cabeza" para servidores (evita errores de GUI)
import matplotlib.pyplot as plt
import pandas as pd
import io
import base64

def grafico_tiempos_ideal_real(resultados_lista):
    """
    Genera la gráfica de barras apiladas (IDEAL vs REAL) y la devuelve como Base64.
    Recibe una lista de diccionarios con formato:
    [
      {'id_proceso': 100, 't_activo': '00:00:10.500', 't_pausado': '...', ...},
      ...
    ]
    """
    if not resultados_lista:
        return None

    # 1. Preparar DataFrame
    rows = []
    for item in resultados_lista:
        rows.append({
            "ID": item.get("id_proceso"),
            "REAL_T_ACTIVO": item.get("t_activo", "0"),
            "REAL_T_PAUSADO": item.get("t_pausado", "0"),
            # NOTA: Angelo compara vs IDEAL. Como por ahora no tenemos tiempos "Ideales" 
            # calculados aparte, usaremos 0 o un estimado para que la gráfica no falle.
            # En el futuro, esto debería venir del campo "TIEMPO_ESTANDAR" de la BD.
            "IDEAL_T_ACTIVO": "0", 
            "IDEAL_T_PAUSADO": "0" 
        })
    
    df = pd.DataFrame(rows)

    # 2. Función auxiliar de conversión (Original de Angelo)
    def to_float(x):
        if isinstance(x, (int, float)): return float(x)
        if isinstance(x, str):
            # Limpieza de formato horario HH:MM:SS a segundos totales
            if ":" in x:
                try:
                    h, m, s = x.split(":")
                    return int(h) * 3600 + int(m) * 60 + float(s)
                except: return 0.0
            return float(x.strip().replace(".", "").replace(",", "."))
        return 0.0

    cols = ["IDEAL_T_ACTIVO", "IDEAL_T_PAUSADO", "REAL_T_ACTIVO", "REAL_T_PAUSADO"]
    for c in cols:
        df[c] = df[c].apply(to_float)

    # 3. Generar Gráfica (Código de Angelo adaptado)
    ids = df["ID"].astype(str).tolist()
    x = range(len(ids))
    w = 0.35

    x_ideal = [xi - w / 2 for xi in x]
    x_real = [xi + w / 2 for xi in x]

    plt.figure(figsize=(10, 6)) # Tamaño ajustado para web

    # Barras Ideales (Azules/Celestes)
    plt.bar(x_ideal, df["IDEAL_T_ACTIVO"], width=w, label="Ideal Activo", color='#93c5fd')
    plt.bar(x_ideal, df["IDEAL_T_PAUSADO"], width=w, bottom=df["IDEAL_T_ACTIVO"], label="Ideal Pausado", color='#bfdbfe')

    # Barras Reales (Verdes/Naranjas)
    plt.bar(x_real, df["REAL_T_ACTIVO"], width=w, label="Real Activo", color='#22c55e')
    plt.bar(x_real, df["REAL_T_PAUSADO"], width=w, bottom=df["REAL_T_ACTIVO"], label="Real Pausado", color='#f97316')

    plt.xticks(x, ids, rotation=45)
    plt.ylabel("Tiempo (Segundos)")
    plt.title("Comparativa de Tiempos por Proceso")
    plt.grid(axis="y", alpha=0.3)
    plt.legend()
    plt.tight_layout()

    # 4. Guardar en memoria (BytesIO) en vez de mostrar
    buffer = io.BytesIO()
    plt.savefig(buffer, format='png')
    plt.close()
    buffer.seek(0)
    
    # 5. Convertir a Base64 string
    image_base64 = base64.b64encode(buffer.getvalue()).decode('utf-8')
    return image_base64