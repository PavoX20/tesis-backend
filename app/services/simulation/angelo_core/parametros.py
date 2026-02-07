import ast
from typing import Any, Dict, List
import pandas as pd

def _to_bool_es(x: Any, default: bool = True) -> bool:
    if x is None: return default
    if isinstance(x, bool): return x
    s = str(x).strip().lower()
    return True if s in {"true", "verdadero", "1", "si"} else False if s in {"false", "falso", "0", "no"} else default

def _to_float(x: Any, default: float = 0.0) -> float:
    try: return float(str(x).replace(",", "."))
    except: return default

def _parse_parametros(raw):
    if isinstance(raw, (list, tuple)): return raw
    try:
        s = str(raw).strip().replace("[", "").replace("]", "")
        return [float(x.strip()) for x in s.split(",")] if s else []
    except: return []

def _split_csv(x):
    s = str(x).strip()
    return [p.strip() for p in s.split(",") if p.strip()] if s else []

def _normalize(val):
    s = str(val).strip()
    try:
        f = float(s)
        if f.is_integer(): return str(int(f))
        return str(f)
    except: return s

# MOTOR DE DATOS
def tree_get(data_list, filtro, columna, default=None):
    for row in data_list:
        match = True
        for k, v in filtro.items():
            if _normalize(row.get(k, "")) != _normalize(v):
                match = False; break
        if match: return row.get(columna, default)
    return default

def tree_set(data_list, filtro, columna, nuevo_valor):
    for row in data_list:
        match = True
        for k, v in filtro.items():
            if _normalize(row.get(k, "")) != _normalize(v):
                match = False; break
        if match:
            row[columna] = nuevo_valor
            return True
    return False

# LÓGICA DE NEGOCIO
def iniciar_reloj_proceso(app, id): pass
def extraer_proceso(df, id): return -1, {}

def meta_avanzar(app, *, id_proceso, parada):
    raw = tree_get(app.db_procesos, {"ID_PROCESO": id_proceso}, "META", "0/0")
    try: act, tot = (float(x) for x in str(raw).split("/"))
    except: act, tot = 0.0, 0.0
    act += float(parada)
    if tot > 0: act = min(act, tot)
    tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "META", f"{int(act)}/{int(tot)}")
    
    if tot > 0 and act >= tot:
        tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ACTIVO", False)
        tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "Finalizado")
        return False
    return True

def meta_ya_arranco(app, id): return False
def cuello_buffer_disponible(app, *, p): return True

def proc_get_ratio(app, id, tipo):
    raw = tree_get(app.db_procesos, {"ID_PROCESO": id}, tipo, "0/0")
    try: a, b = str(raw).split("/"); return float(a), float(b)
    except: return 0.0, 0.0

def proc_set_ratio(app, id, tipo, u, t):
    tree_set(app.db_procesos, {"ID_PROCESO": id}, tipo, f"{int(u)}/{int(t)}")

def bodega_movimiento(app, *, modo, area_proceso, finales, materias, cantidades):
    mats = _split_csv(materias)
    if not mats: return True
    if cantidades is None: cants = [0.0] * len(mats)
    elif isinstance(cantidades, (int, float)): cants = [float(cantidades)]
    elif isinstance(cantidades, list): cants = [float(x) for x in cantidades]
    else: cants = [0.0] * len(mats)
    
    if len(cants) < len(mats): cants = cants * (len(mats) // len(cants) + 1)
    cants = cants[:len(mats)]

    if modo == "PRODUCIR":
        area = 0 if finales else area_proceso
        for m, c in zip(mats, cants):
            if c <= 0: continue
            act = _to_float(tree_get(app.db_bodega, {"AREA": area, "MATERIA": m}, "CANTIDAD", 0))
            if not tree_set(app.db_bodega, {"AREA": area, "MATERIA": m}, "CANTIDAD", act + c):
                app.db_bodega.append({"AREA": area, "MATERIA": m, "CANTIDAD": act + c})
        return True

    if modo == "CONSUMIR":
        for m, c in zip(mats, cants):
            if c <= 0: continue
            act = _to_float(tree_get(app.db_bodega, {"AREA": 0, "MATERIA": m}, "CANTIDAD", 0))
            if act < c: return False
        
        for m, c in zip(mats, cants):
            if c <= 0: continue
            act = _to_float(tree_get(app.db_bodega, {"AREA": 0, "MATERIA": m}, "CANTIDAD", 0))
            tree_set(app.db_bodega, {"AREA": 0, "MATERIA": m}, "CANTIDAD", act - c)
        return True
    return False

def maquinaria_movimiento(app, *, modo, p):
    area = int(p.get("AREA", 0))
    maq = str(p.get("ID_MAQUINA", ""))
    if not maq: return True
    
    # --- CORRECCIÓN: Respetar límite original ---
    usado, lim = proc_get_ratio(app, int(p["ID_PROCESO"]), "MAQUINAS")
    if lim == 0:
        raw_maq = p.get("MAQUINAS", "1")
        if "/" in str(raw_maq): lim = float(str(raw_maq).split("/")[1])
        else: lim = float(raw_maq) if float(raw_maq) > 0 else 1.0
    # ------------------------------------------

    disp = int(tree_get(app.db_maquinaria, {"AREA": area, "MAQUINARIA": maq}, "CANTIDAD", 0))

    if modo == "CONSUMIR":
        if disp >= 1:
            tree_set(app.db_maquinaria, {"AREA": area, "MAQUINARIA": maq}, "CANTIDAD", disp - 1)
            proc_set_ratio(app, int(p["ID_PROCESO"]), "MAQUINAS", usado + 1, lim)
            return True
        return False
    if modo == "DEVOLVER":
        tree_set(app.db_maquinaria, {"AREA": area, "MAQUINARIA": maq}, "CANTIDAD", disp + 1)
        proc_set_ratio(app, int(p["ID_PROCESO"]), "MAQUINAS", max(0, usado - 1), lim)
        return True
    return False

def personal_disponible(app, modo, p):
    area = int(p.get("AREA", 0))
    
    # --- CORRECCIÓN: Respetar límite original ---
    usado, lim = proc_get_ratio(app, int(p["ID_PROCESO"]), "PERSONAL")
    if lim == 0:
        raw_per = p.get("PERSONAL", "0")
        if "/" in str(raw_per): lim = float(str(raw_per).split("/")[1])
        else: lim = float(raw_per)
    
    req = int(lim) 
    if req == 0: return True 
    # ------------------------------------------

    disp = int(tree_get(app.db_areas, {"AREA": area}, "PERSONAL", 0))

    if modo == "CONSUMIR":
        if disp >= req:
            tree_set(app.db_areas, {"AREA": area}, "PERSONAL", disp - req)
            proc_set_ratio(app, int(p["ID_PROCESO"]), "PERSONAL", usado + req, lim)
            return True
        return False
    if modo == "DEVOLVER":
        tree_set(app.db_areas, {"AREA": area}, "PERSONAL", disp + req)
        proc_set_ratio(app, int(p["ID_PROCESO"]), "PERSONAL", max(0, usado - req), lim)
        return True
    return True

def _areas_get_personal_disponible(app, area): return int(tree_get(app.db_areas, {"AREA": area}, "PERSONAL", 0))
def _areas_set_personal_disponible(app, area, val): tree_set(app.db_areas, {"AREA": area}, "PERSONAL", val)