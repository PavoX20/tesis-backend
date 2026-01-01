import pandas as pd
import itertools

def combos_personal(df_area: pd.DataFrame, personal_disponible: int) -> pd.DataFrame:
    """
    Genera combinaciones de asignación de personal respetando:
    1. Capacidad máxima de cada máquina (PERSONAL MAX).
    2. Cantidad de máquinas (CANTIDAD MAQUINAS).
    3. Asignaciones fijas del usuario (PERSONAL FIJO).
    """
    
    # Validar columnas necesarias
    required_cols = ['ID_PROCESO', 'PERSONAL MAX']
    for col in required_cols:
        if col not in df_area.columns:
            # Si falta alguna, retornamos vacío para no romper el flujo
            return pd.DataFrame()

    # Asegurar que existan las columnas opcionales con valores default
    if 'CANTIDAD MAQUINAS' not in df_area.columns:
        df_area['CANTIDAD MAQUINAS'] = 1
    if 'PERSONAL FIJO' not in df_area.columns:
        df_area['PERSONAL FIJO'] = 0

    # Lista de rangos posibles para cada proceso
    rangos_por_proceso = []
    ids_procesos = []
    maquinas_por_proceso = []

    for _, row in df_area.iterrows():
        pid = int(row['ID_PROCESO'])
        p_max = int(row['PERSONAL MAX'])
        c_maq = int(row['CANTIDAD MAQUINAS'])
        p_fijo = int(row.get('PERSONAL FIJO', 0))
        
        # Capacidad técnica real = Máquinas * PersonalPorMaquina
        capacidad_total_proceso = p_max * c_maq
        
        ids_procesos.append(pid)
        maquinas_por_proceso.append(c_maq)

        # LÓGICA DE FIJOS:
        if p_fijo > 0:
            # Si el usuario fijó un valor, LA ÚNICA opción es ese valor.
            # (Limitado por la capacidad física para evitar errores)
            val_final = min(p_fijo, capacidad_total_proceso)
            rangos_por_proceso.append([val_final])
        else:
            # Si es 0 (automático), probamos desde 1 hasta la capacidad total
            # Rango: [1, 2, ..., capacidad_total]
            rangos_por_proceso.append(list(range(1, capacidad_total_proceso + 1)))

    # Generar Producto Cartesiano (Todas las combinaciones posibles)
    # Esto crea una lista de tuplas: [(1,1,1), (1,1,2), ...]
    todas_combos = list(itertools.product(*rangos_por_proceso))

    # Convertir a DataFrame temporal
    df_combos = pd.DataFrame(todas_combos, columns=[f"P_{pid}" for pid in ids_procesos])

    # Calcular totales
    df_combos['TOTAL_PERSONAS'] = df_combos.sum(axis=1)

    # Filtrar: Solo nos sirven las que usan MENOS o IGUAL personal que el disponible
    # (El service.py luego ordena por eficiencia para elegir la mejor)
    df_combos = df_combos[df_combos['TOTAL_PERSONAS'] <= personal_disponible].copy()
    
    # Agregar columnas de Máquinas (M_{pid}) que son estáticas pero requeridas por el service
    # El service espera ver cuántas máquinas se usaron. Asumimos que se usan todas las disponibles
    # para maximizar flujo, o se podría calcular dinámicamente. Por simplicidad y robustez:
    total_maquinas = sum(maquinas_por_proceso)
    df_combos['TOTAL_MAQUINAS'] = total_maquinas
    
    for i, pid in enumerate(ids_procesos):
        df_combos[f"M_{pid}"] = maquinas_por_proceso[i]

    return df_combos