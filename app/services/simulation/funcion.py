import pandas as pd
import itertools

def combos_personal(df_area: pd.DataFrame, personal_disponible: int) -> pd.DataFrame:
    """
    Genera combinaciones de asignación de personal respetando:
    1. Capacidad máxima de cada máquina (PERSONAL MAX).
    2. Cantidad de máquinas (CANTIDAD MAQUINAS).
    3. Asignaciones fijas del usuario (PERSONAL FIJO).
    """

    required_cols = ['ID_PROCESO', 'PERSONAL MAX']
    for col in required_cols:
        if col not in df_area.columns:

            return pd.DataFrame()

    if 'CANTIDAD MAQUINAS' not in df_area.columns:
        df_area['CANTIDAD MAQUINAS'] = 1
    if 'PERSONAL FIJO' not in df_area.columns:
        df_area['PERSONAL FIJO'] = 0

    rangos_por_proceso = []
    ids_procesos = []
    maquinas_por_proceso = []

    for _, row in df_area.iterrows():
        pid = int(row['ID_PROCESO'])
        p_max = int(row['PERSONAL MAX'])
        c_maq = int(row['CANTIDAD MAQUINAS'])
        p_fijo = int(row.get('PERSONAL FIJO', 0))

        capacidad_total_proceso = p_max * c_maq

        ids_procesos.append(pid)
        maquinas_por_proceso.append(c_maq)

        if p_fijo > 0:

            val_final = min(p_fijo, capacidad_total_proceso)
            rangos_por_proceso.append([val_final])
        else:

            rangos_por_proceso.append(list(range(1, capacidad_total_proceso + 1)))

    todas_combos = list(itertools.product(*rangos_por_proceso))

    df_combos = pd.DataFrame(todas_combos, columns=[f"P_{pid}" for pid in ids_procesos])

    df_combos['TOTAL_PERSONAS'] = df_combos.sum(axis=1)

    df_combos = df_combos[df_combos['TOTAL_PERSONAS'] <= personal_disponible].copy()

    total_maquinas = sum(maquinas_por_proceso)
    df_combos['TOTAL_MAQUINAS'] = total_maquinas

    for i, pid in enumerate(ids_procesos):
        df_combos[f"M_{pid}"] = maquinas_por_proceso[i]

    return df_combos