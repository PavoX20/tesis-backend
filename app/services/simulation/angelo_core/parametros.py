import ast
import time
from typing import Any, Dict, List, Optional, Tuple
import numpy as np
import pandas as pd

# ============================================================
# 1. CAST / PARSE (CÓDIGO ORIGINAL INTACTO)
# ============================================================
_TRUE = {"true", "verdadero", "1", "si", "sí", "x", "y", "yes"}
_FALSE = {"false", "falso", "0", "no", "n", ""}

def _to_bool_es(x: Any, default: bool = True) -> bool:
    if x is None or (isinstance(x, float) and pd.isna(x)): return default
    if isinstance(x, bool): return x
    if isinstance(x, (int, float)):
        try: return bool(int(x))
        except: return default
    s = str(x).strip().lower()
    return True if s in _TRUE else False if s in _FALSE else default

def _to_int(x: Any, default: int = 0) -> int:
    try: return int(float(str(x).replace(",", ".")))
    except: return default

def _to_float(x: Any, default: float = 0.0) -> float:
    try: return float(str(x).replace(",", "."))
    except: return default

def _parse_parametros(x: Any) -> Optional[Any]:
    if x is None or (isinstance(x, float) and pd.isna(x)): return None
    if isinstance(x, (list, tuple, dict)): return x
    s = str(x).strip()
    if not s: return None
    if s.startswith("[") or s.startswith("(") or s.startswith("{"):
        try:
            v = ast.literal_eval(s)
            return v if isinstance(v, (list, tuple, dict)) else None
        except: return None
    return None

def _split_csv(x: Any) -> List[str]:
    if x is None or (isinstance(x, float) and pd.isna(x)): return []
    if isinstance(x, (list, tuple)): return [str(v).strip() for v in x if str(v).strip()]
    s = str(x).strip()
    return [p.strip() for p in s.split(",") if p.strip()] if s else []

# ============================================================
# 2. TIME HELPERS (CÓDIGO ORIGINAL INTACTO)
# ============================================================
def _hhmmssms_a_segundos(txt: Any) -> float:
    try:
        s = str(txt).strip()
        if not s: return 0.0
        if "." in s:
            base, ms = s.split(".", 1)
            h, m, sec = base.split(":")
            ms = "".join(ch for ch in ms if ch.isdigit())
            ms = (ms + "000")[:3]
            return int(h) * 3600 + int(m) * 60 + int(sec) + (int(ms) / 1000.0)
        else:
            h, m, sec = s.split(":")
            return int(h) * 3600 + int(m) * 60 + int(sec)
    except: return 0.0

def _segundos_a_hhmmssms(seg: float) -> str:
    seg = max(0.0, float(seg))
    total_ms = int(round(seg * 1000.0))
    hh = total_ms // (3600 * 1000)
    rem = total_ms % (3600 * 1000)
    mm = rem // (60 * 1000)
    rem = rem % (60 * 1000)
    ss = rem // 1000
    ms = rem % 1000
    return f"{hh:02d}:{mm:02d}:{ss:02d}.{ms:03d}"

def _now() -> float:
    return time.time()

# ============================================================
# 3. TREE GET/SET (OPTIMIZADO PARA DICCIONARIOS)
# Aquí ocurre la reducción de líneas. En lugar de bucles for, usamos acceso directo.
# ============================================================

def tree_get(tree, keys, col, default=None):
    """Acceso rápido a datos en memoria (VirtualApp)"""
    if not isinstance(tree, dict) or "data" not in tree:
        return default
        
    row_key = None
    # Lógica de mapeo de claves (igual que el original pero para hash map)
    if "ID_PROCESO" in keys:
        row_key = keys["ID_PROCESO"]
    elif "MATERIA" in keys and "AREA" in keys:
        row_key = f"{keys['AREA']}_{keys['MATERIA']}"
    elif "AREA" in keys and ("MAQUINARIA" in keys or "ID_MAQUINA" in keys):
        maq = keys.get("MAQUINARIA") or keys.get("ID_MAQUINA")
        row_key = f"{keys['AREA']}_{maq}"
    elif "AREA" in keys:
        row_key = keys["AREA"]

    if row_key is not None and row_key in tree["data"]:
        val = tree["data"][row_key].get(col)
        return val if val is not None else default
        
    return default

def tree_set(tree, keys, col, value):
    """Escritura rápida en memoria (VirtualApp)"""
    if not isinstance(tree, dict) or "data" not in tree:
        return False

    row_key = None
    if "ID_PROCESO" in keys:
        row_key = keys["ID_PROCESO"]
    elif "MATERIA" in keys and "AREA" in keys:
        row_key = f"{keys['AREA']}_{keys['MATERIA']}"
    elif "AREA" in keys and ("MAQUINARIA" in keys or "ID_MAQUINA" in keys):
        maq = keys.get("MAQUINARIA") or keys.get("ID_MAQUINA")
        row_key = f"{keys['AREA']}_{maq}"
    elif "AREA" in keys:
        row_key = keys["AREA"]

    if row_key is not None:
        if row_key not in tree["data"]:
            tree["data"][row_key] = keys.copy() # Crear si no existe
        tree["data"][row_key][col] = value
        return True
    return False

# Helpers de compatibilidad para que funciones.py no falle
def _get_tree_areas(app):
    return app.tree_areas

def _get_tree_maquinaria(app):
    return app.tree_maquinaria

# ============================================================
# 4. RATIOS (LÓGICA ORIGINAL)
# ============================================================
def _parse_ratio_float(txt: Any) -> Tuple[float, float]:
    try:
        a, b = (x.strip().replace(",", ".") for x in str(txt).split("/"))
        return float(a), float(b)
    except: return 0.0, 0.0

def _fmt_ratio(actual: float, total: float) -> str:
    actual = float(actual); total = float(total)
    if total < 0: total = 0.0
    if actual < 0: actual = 0.0
    if total > 0: actual = min(actual, total)
    return f"{actual}/{total}"

def proc_get_ratio(app, id_proceso: int, col: str) -> Tuple[float, float]:
    raw = tree_get(app.tree_procesos, {"ID_PROCESO": int(id_proceso)}, col, default="0/0")
    s = str(raw).strip()
    if "/" in s: return _parse_ratio_float(s)
    if s == "": return 0.0, 0.0
    return 0.0, _to_float(s, 0.0)

def proc_set_ratio(app, id_proceso: int, col: str, usado: float, limite: float) -> None:
    tree_set(app.tree_procesos, {"ID_PROCESO": int(id_proceso)}, col, _fmt_ratio(usado, limite))

# ============================================================
# 5. RELOJ (ADAPTADO: SIN UI)
# ============================================================
def iniciar_reloj_proceso(app, id_proceso: int, intervalo_ms: int = 200) -> None:
    # Solo guardamos el tiempo de inicio. No necesitamos el bucle "after" 
    # porque el backend corre a máxima velocidad, no en tiempo real visual.
    tree_set(app.tree_procesos, {"ID_PROCESO": id_proceso}, "inicio_reloj", _now())

# ============================================================
# 6. EXTRAER PROCESO (LÓGICA ORIGINAL)
# ============================================================
def extraer_proceso(datos_df: pd.DataFrame, id_proceso: int) -> Tuple[Any, Dict[str, Any]]:
    mask = datos_df["ID_PROCESO"].astype(int) == int(id_proceso)
    if not mask.any(): return -1, {}

    i = datos_df.index[mask][0]
    row = datos_df.loc[i]
    cant_raw = str(row.get("CANTIDAD", "")).strip()
    cant_list = _parse_parametros(cant_raw) if cant_raw.startswith("[") else None

    # Mapeo exacto
    p = {
        "DIAGRAMA": _to_int(row.get("DIAGRAMA", 0)),
        "AREA": _to_int(row.get("AREA", 0)),
        "ID_PROCESO": _to_int(row.get("ID_PROCESO", id_proceso)),
        "TIPO": str(row.get("TIPO", "")).strip().upper(),
        "ID_MAQUINA": str(row.get("ID_MAQUINA", "")).strip(),
        "MAQUINAS": _to_int(row.get("MAQUINAS", 1), 1),
        "MAX_P": _to_int(row.get("MAX_P", 0)),
        "PERSONAL": _to_int(row.get("PERSONAL", 0)),
        "INCIALES": _to_bool_es(row.get("INCIALES", True), True),
        "ACTIVO": _to_bool_es(row.get("ACTIVO", True), True),
        "META": _to_float(row.get("META", 0), 0.0),
        "PARADA": _to_float(row.get("PARADA", 0), 0.0),
        "MATERIA": _split_csv(row.get("MATERIA", "")),
        "CANTIDAD_CONSUMO": (list(cant_list) if isinstance(cant_list, (list, tuple)) else [_to_float(v, 0.0) for v in _split_csv(cant_raw)]),
        "PRODUCE": _split_csv(row.get("PRODUCE", "")),
        "CANTIDAD_PRODUCE": ([_to_float(v, 0.0) for v in _split_csv(row.get("CANTIDAD_PRODUCE", ""))] if "CANTIDAD_PRODUCE" in datos_df.columns else []),
        "DISTRIBUCION": str(row.get("DISTRIBUCION", "")).strip().lower(),
        "PARAMETROS": _parse_parametros(row.get("PARAMETROS", None)),
        "FINALES": _to_bool_es(row.get("FINALES", False), False),
        "TIEMPO": _to_float(row.get("TIEMPO", 0), 0.0),
        "CAPACIDAD": _to_float(row.get("CAPACIDAD", 0), 0.0),
        "CUELLO_DE_BOTELLA": _to_bool_es(row.get("CUELLO_DE_BOTELLA", False), False),
    }
    return i, p

# ============================================================
# 7. BODEGA (LÓGICA ORIGINAL COMPLETAMENTE PRESERVADA)
# ============================================================
def bodega_movimiento(app, *, modo: str, area_proceso: int, finales: bool, materias: Any = None, cantidades: Any = None) -> bool:
    modo = str(modo).strip().upper()
    tree = app.tree_bodega

    mats = _split_csv(materias)
    if not mats: return True

    if cantidades is None or (isinstance(cantidades, float) and pd.isna(cantidades)): cants = []
    elif isinstance(cantidades, (list, tuple, np.ndarray)): cants = [_to_float(v, 0.0) for v in cantidades]
    else:
        s = str(cantidades).strip()
        if s.startswith("["):
            v = _parse_parametros(s)
            cants = [_to_float(z, 0.0) for z in (v or [])] if isinstance(v, (list, tuple)) else []
        else:
            cants = [_to_float(v, 0.0) for v in _split_csv(s)]

    if not cants: cants = [0.0] * len(mats)
    elif len(cants) == 1 and len(mats) > 1: cants *= len(mats)

    if len(mats) != len(cants): return False

    if modo == "PRODUCIR":
        area_dest = 0 if bool(finales) else int(area_proceso)
        for mat, cant in zip(mats, cants):
            if not mat or cant == 0: continue
            actual = tree_get(tree, {"AREA": area_dest, "MATERIA": mat}, "CANTIDAD", default=0)
            tree_set(tree, {"AREA": area_dest, "MATERIA": mat}, "CANTIDAD", _to_float(actual, 0.0) + float(cant))
        return True

    if modo != "CONSUMIR": return False

    # CONSUMIR: Lógica de áreas permitidas
    area_proceso = int(area_proceso)
    areas_perm = [area_proceso, 0]
    if area_proceso == 0:
        # Busca todas las áreas existentes en la bodega virtual
        areas_exist = set()
        for k in tree.get("data", {}):
            try: areas_exist.add(int(k.split("_")[0]))
            except: pass
        areas_perm = [0] + [a for a in areas_exist if a != 0]

    # PRE-CHECK (Todo o nada)
    for mat, req in zip(mats, cants):
        req = float(req)
        if not mat or req <= 0: continue
        total_disp = 0.0
        for a in areas_perm:
            v = tree_get(tree, {"AREA": int(a), "MATERIA": mat}, "CANTIDAD", default=0)
            total_disp += _to_float(v, 0.0)
        if total_disp + 1e-9 < req: return False

    # CONSUMO REAL
    for mat, req in zip(mats, cants):
        req = float(req)
        if not mat or req <= 0: continue
        restante = req
        for a in areas_perm:
            if restante <= 0: break
            actual = tree_get(tree, {"AREA": int(a), "MATERIA": mat}, "CANTIDAD", default=0)
            actual_f = _to_float(actual, 0.0)
            if actual_f <= 0: continue
            tomar = min(actual_f, restante)
            tree_set(tree, {"AREA": int(a), "MATERIA": mat}, "CANTIDAD", actual_f - tomar)
            restante -= tomar
        if restante > 1e-9: return False
    return True

# ============================================================
# 8. META (LÓGICA ORIGINAL)
# ============================================================
def meta_avanzar(app, *, id_proceso: int, parada: float) -> bool:
    tree = app.tree_procesos
    raw = tree_get(tree, {"ID_PROCESO": id_proceso}, "META", default="0/0")
    try: actual, total = (float(x.strip().replace(",", ".")) for x in str(raw).split("/"))
    except: actual, total = 0.0, 0.0

    actual += float(parada)
    if total > 0: actual = min(actual, total)
    tree_set(tree, {"ID_PROCESO": id_proceso}, "META", f"{actual}/{total}")

    if total > 0 and actual >= total:
        tree_set(tree, {"ID_PROCESO": id_proceso}, "ACTIVO", False)
        tree_set(tree, {"ID_PROCESO": id_proceso}, "ESTADO", "Finalizado")
        return False
    return True

def meta_ya_arranco(app, id_proceso: int) -> bool:
    raw = tree_get(app.tree_procesos, {"ID_PROCESO": id_proceso}, "META", default="0/0")
    try:
        actual, total = (float(x.strip().replace(",", ".")) for x in str(raw).split("/"))
        return total > 0 and actual > 0
    except: return False

# ============================================================
# 9. BLOQUEOS
# ============================================================
def desactivar_todos_los_procesos(app, motivo: str = "") -> None:
    # Adaptado para iterar diccionario
    if isinstance(app.tree_procesos, dict) and "data" in app.tree_procesos:
        for pid in app.tree_procesos["data"]:
            app.tree_procesos["data"][pid]["ACTIVO"] = False
            if motivo: app.tree_procesos["data"][pid]["ESTADO"] = motivo

def apagar_todos_activo_false(app, motivo: str = "PAUSADO C/B") -> None:
    desactivar_todos_los_procesos(app, motivo)

# ============================================================
# 10. MAQUINARIA (LÓGICA ORIGINAL 1x1)
# ============================================================
def maquinaria_movimiento(app, *, modo: str, p: dict) -> bool:
    modo = str(modo).strip().upper()
    area = int(p.get("AREA", 0))
    id_maquina = str(p.get("ID_MAQUINA", "")).strip()
    if not id_maquina: return True
    id_proceso = int(p.get("ID_PROCESO", 0))
    usado, limite = proc_get_ratio(app, id_proceso, "MAQUINAS")
    tree = _get_tree_maquinaria(app)
    
    # Búsqueda en dict
    raw_disp = tree_get(tree, {"AREA": area, "MAQUINARIA": id_maquina}, "CANTIDAD", default=None)
    if raw_disp is None: return False if modo == "CONSUMIR" else True
    
    disp = _to_int(raw_disp, 0)
    paso = 1

    if modo == "CONSUMIR":
        if disp < paso: return False
        if limite > 0 and (usado + paso) > limite: return False
        tree_set(tree, {"AREA": area, "MAQUINARIA": id_maquina}, "CANTIDAD", disp - paso)
        proc_set_ratio(app, id_proceso, "MAQUINAS", usado + paso, limite)
        return True

    if modo == "DEVOLVER":
        tree_set(tree, {"AREA": area, "MAQUINARIA": id_maquina}, "CANTIDAD", disp + paso)
        nuevo = max(0.0, usado - paso)
        proc_set_ratio(app, id_proceso, "MAQUINAS", nuevo, limite)
        return True
    raise ValueError("modo debe ser 'CONSUMIR' o 'DEVOLVER'")

# ============================================================
# 11. PERSONAL (LÓGICA ORIGINAL)
# ============================================================
def personal_normal(app, *, modo: str, p: dict) -> bool:
    modo = str(modo).strip().upper()
    area = int(p.get("AREA", 0))
    req = int(p.get("PERSONAL", 0))
    if req <= 0: return True
    id_proceso = int(p.get("ID_PROCESO", 0))
    usado, limite = proc_get_ratio(app, id_proceso, "PERSONAL")
    tree_areas = _get_tree_areas(app)
    disp = _to_int(tree_get(tree_areas, {"AREA": area}, "PERSONAL", default=0), 0)

    if modo == "CONSUMIR":
        if disp < req: return False
        if limite > 0 and (usado + req) > limite: return False
        tree_set(tree_areas, {"AREA": area}, "PERSONAL", disp - req)
        proc_set_ratio(app, id_proceso, "PERSONAL", usado + req, limite)
        return True

    if modo == "DEVOLVER":
        tree_set(tree_areas, {"AREA": area}, "PERSONAL", disp + req)
        nuevo = max(0.0, usado - req)
        proc_set_ratio(app, id_proceso, "PERSONAL", nuevo, limite)
        return True
    return False

def personal_almacenamiento(app, *, p: dict, material_final: str) -> bool:
    area = int(p.get("AREA", 0))
    material_final = str(material_final).strip()
    if not material_final: return True
    capacidad = _to_float(p.get("PERSONAL", 0), 0.0)
    if capacidad <= 0: return True
    inventario = _to_float(tree_get(app.tree_bodega, {"AREA": area, "MATERIA": material_final}, "CANTIDAD", default=0), 0.0)
    producir = _to_float(p.get("PARADA", 0.0), 0.0)
    return (inventario + producir) <= capacidad

def personal_disponible(app, *, modo: str, p: dict) -> bool:
    tipo = str(p.get("TIPO", "NORMAL")).strip().upper()
    if tipo == "ALMACENAMIENTO":
        produce = p.get("PRODUCE", [])
        material_final = produce[0] if produce else ""
        return personal_almacenamiento(app, p=p, material_final=material_final)
    return personal_normal(app, modo=modo, p=p)

# ============================================================
# 12. CUELLO (LÓGICA ORIGINAL ADAPTADA)
# ============================================================
def cuello_buffer_limite_desde_tabla(app, default: float = 0.0) -> float:
    # No hay tabla visual 'tree_cb', usamos el default que es lo correcto en backend
    return float(default)

def cuello_buffer_disponible(app, *, p: dict) -> bool:
    if not _to_bool_es(p.get("CUELLO_DE_BOTELLA"), False): return True
    if not _to_bool_es(p.get("INCIALES"), True): return True
    id_proceso = int(p.get("ID_PROCESO", 0))

    activo = tree_get(app.tree_procesos, {"ID_PROCESO": id_proceso}, "ACTIVO", default=True)
    if not _to_bool_es(activo, True): return True

    materias = p.get("MATERIA", [])
    if not isinstance(materias, (list, tuple)): materias = [str(materias).strip()]
    if not materias or not materias[0]: return True

    mp_buffer = materias[0]
    limite = cuello_buffer_limite_desde_tabla(app, default=_to_float(p.get("PARADA", 0.0), 0.0))
    if limite <= 0: return True

    area = int(p.get("AREA", 0))
    inv_area = _to_float(tree_get(app.tree_bodega, {"AREA": area, "MATERIA": mp_buffer}, "CANTIDAD", default=0), 0.0)
    inv_0 = 0.0
    if area != 0:
        inv_0 = _to_float(tree_get(app.tree_bodega, {"AREA": 0, "MATERIA": mp_buffer}, "CANTIDAD", default=0), 0.0)

    if (inv_area + inv_0) > limite:
        tree_set(app.tree_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "ESTACIONARIO")
        return False

    tree_set(app.tree_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "ACTIVO")
    return True