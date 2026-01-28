# funciones.py
from __future__ import annotations

from typing import Any, Dict, Tuple, Optional
import math

import pandas as pd
from .distribuciones import Distribuciones  

from .parametros import (
    _to_bool_es,
    _to_float,
    _parse_parametros,
    iniciar_reloj_proceso,
    extraer_proceso,
    tree_get,
    tree_set,
    bodega_movimiento,
    maquinaria_movimiento,
    personal_disponible,
    meta_avanzar,
    meta_ya_arranco,
    desactivar_todos_los_procesos,
    cuello_buffer_disponible,
    proc_get_ratio,
    proc_set_ratio,
)

# ============================================================
# 1) PREPARAR PROCESOS  (TIEMPO / CAPACIDAD / CUELLO)
# ============================================================
def preparar_procesos(df: pd.DataFrame, *, marcar_activo: bool = True, criterio: str = "moda") -> pd.DataFrame:
    out = df.copy()

    # ACTIVO
    if marcar_activo or "ACTIVO" not in out.columns:
        out["ACTIVO"] = True
    else:
        out["ACTIVO"] = out["ACTIVO"].map(lambda v: _to_bool_es(v, True))

    # FINALES por cambio de AREA (última fila True)
    if "AREA" in out.columns and not out.empty:
        out["FINALES"] = out["AREA"].ne(out["AREA"].shift(-1))
        out.iloc[-1, out.columns.get_loc("FINALES")] = True
        out["FINALES"] = out["FINALES"].astype(bool)
    else:
        out["FINALES"] = True

    out["TIEMPO"] = 0.0
    out["CAPACIDAD"] = 0.0
    out["CUELLO_DE_BOTELLA"] = False

    # cache para no recalcular determinístico repetido
    cache: Dict[Tuple[str, str, str], float] = {}

    for r in out.itertuples(index=True):
        idx = r.Index
        dist_raw = getattr(r, "DISTRIBUCION", None)
        if dist_raw is None:
            continue

        dist = str(dist_raw).strip().lower()
        parms = _parse_parametros(getattr(r, "PARAMETROS", None))
        if not isinstance(parms, (list, tuple)):
            continue

        key = (dist, str(parms), criterio)
        t = cache.get(key)
        if t is None:
            try:
                t = float(Distribuciones.generar_valor_deterministico(dist, parms, criterio=criterio))
            except Exception:
                t = 0.0
            cache[key] = t

        out.at[idx, "TIEMPO"] = t

        personal = _to_float(getattr(r, "PERSONAL", 0), 0.0)
        parada = _to_float(getattr(r, "PARADA", 0), 0.0)
        out.at[idx, "CAPACIDAD"] = (personal * parada / t) if t > 0 else 0.0

    valid = out["CAPACIDAD"] > 0
    if valid.any():
        min_cap = out.loc[valid, "CAPACIDAD"].min()
        out["CUELLO_DE_BOTELLA"] = out["CAPACIDAD"].eq(min_cap) & valid

    return out


# ============================================================
# 2) INDIVIDUAL  (solo maneja el tiempo y luego llama on_finish)
# ============================================================
def individual(app, p: dict, tipo_sim: str = "IDEAL", on_finish=None) -> None:
    tipo_sim = str(tipo_sim).strip().upper()

    if tipo_sim == "IDEAL":
        tiempo = float(p.get("TIEMPO", 0.0) or 0.0)
    else:
        dist = str(p.get("DISTRIBUCION", "")).strip().lower()
        parms = _parse_parametros(p.get("PARAMETROS", []))
        try:
            tiempo = float(Distribuciones.generar_dato_aleatorio(dist, parms) or 0.0)
        except Exception:
            tiempo = 0.0

    tiempo = max(0.0, tiempo)

    def _fin():
        if callable(on_finish):
            on_finish()

    app.root.after(int(tiempo * 1000), _fin)


# ============================================================
# helpers internos: personal 1x1 + liberación máquinas dinámica
# ============================================================
def _areas_get_personal_disponible(app, area: int) -> int:
    # tu interface usa un Treeview "tree_areas" con PERSONAl como número (12, 8, ...)
    raw = tree_get(app.tree_areas, {"AREA": int(area)}, "PERSONAL", default=0)
    try:
        return int(float(str(raw).replace(",", ".")))
    except Exception:
        return 0


def _areas_set_personal_disponible(app, area: int, nuevo: int) -> None:
    tree_set(app.tree_areas, {"AREA": int(area)}, "PERSONAL", max(0, int(nuevo)))


def _proc_personal_ratio_set(app, id_proceso: int, usados: int, limite: int) -> None:
    proc_set_ratio(app, id_proceso, "PERSONAL", float(usados), float(limite))


def _proc_maquinas_ratio_set(app, id_proceso: int, usadas: int, limite: int) -> None:
    proc_set_ratio(app, id_proceso, "MAQUINAS", float(usadas), float(limite))


def _ceil_div(a: int, b: int) -> int:
    if b <= 0:
        return 0
    return (a + b - 1) // b


# ============================================================
# 3) SIMULACIÓN PROCESO (PARALELO REAL DE PERSONAS + MAQUINAS PROGRESIVAS)
# ============================================================
def simular_proceso(
    app,
    id_proceso: int,
    tipo_sim: str,
    bodega,
    areas_df,
    maquinaria_df,
    datos_df,
    resultados_df,
    tiempo_general: float = 1.0,
) -> None:
    """
    LO QUE IMPLEMENTA (tal cual lo explicaste):
    - Reloj personal: ya lo hace iniciar_reloj_proceso() (T.ACTIVO / T.PAUSADO).
    - Máquinas: el proceso puede iniciar con 1 máquina y va "pidiendo" más (1x1) hasta su máximo.
    - Personas: trabajan EN PARALELO (cada una con su propio individual()).
        * Se agregan personas si hay disponibilidad y si las máquinas lo permiten (MAX_P por máquina).
        * Cuando se cumple la meta, NO se agregan más personas; las que están terminan y se liberan.
    - Liberar máquinas: si ya no se requieren por cantidad de personas (MAX_P), se devuelven 1x1.
    - Materia prima: es TODO o NADA por ciclo (si falta una, no arranca ese ciclo).
    """
    tipo_sim = str(tipo_sim).strip().upper()

    # arranca reloj UNA vez
    iniciar_reloj_proceso(app, id_proceso)

    # estado por proceso (workers activos)
    if not hasattr(app, "_proc_state"):
        app._proc_state = {}
    if id_proceso not in app._proc_state:
        app._proc_state[id_proceso] = {"workers": 0, "running": True}

    def _activo() -> bool:
        raw = tree_get(app.tree_procesos, {"ID_PROCESO": int(id_proceso)}, "ACTIVO", default=True)
        return _to_bool_es(raw, True)

    def _set_estado(txt: str):
        tree_set(app.tree_procesos, {"ID_PROCESO": int(id_proceso)}, "ESTADO", txt)

    # ============================================================
    # ✅ REGLA NUEVA: si es IDEAL + es cuello + meta>0 + estado!=ACTIVO -> apagar TODOS
    # ============================================================
    def _apagar_todos_si_cuello_ideal_y_no_activo(p: dict):
        # solo IDEAL
        if tipo_sim != "IDEAL":
            return
        # solo cuello
        if not _to_bool_es(p.get("CUELLO_DE_BOTELLA"), False):
            return
        # solo si ya arrancó (meta actual > 0)
        if not meta_ya_arranco(app, id_proceso):
            return
        # estado actual
        estado = tree_get(app.tree_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", default="")
        estado_u = str(estado).strip().upper()
        if estado_u != "ACTIVO":
            # esto pone ACTIVO=False a TODA la columna
            desactivar_todos_los_procesos(app.tree_procesos, motivo=f"PAUSADO C/B ({estado_u})")

    def _get_workers() -> int:
        try:
            return int(app._proc_state[id_proceso]["workers"])
        except Exception:
            return 0

    def _set_workers(n: int):
        app._proc_state[id_proceso]["workers"] = max(0, int(n))

    def _maquinas_usadas() -> int:
        usadas, _lim = proc_get_ratio(app, id_proceso, "MAQUINAS")
        try:
            return int(float(usadas))
        except Exception:
            return 0

    def _personal_usado() -> int:
        usados, _lim = proc_get_ratio(app, id_proceso, "PERSONAL")
        try:
            return int(float(usados))
        except Exception:
            return 0

    def _devolver_1_persona(area: int, limite_personal: int):
        usados = _personal_usado()
        disp = _areas_get_personal_disponible(app, area)
        _areas_set_personal_disponible(app, area, disp + 1)
        _proc_personal_ratio_set(app, id_proceso, max(0, usados - 1), limite_personal)

    def _tomar_1_persona(area: int, limite_personal: int) -> bool:
        disp = _areas_get_personal_disponible(app, area)
        if disp < 1:
            return False
        usados = _personal_usado()
        if limite_personal > 0 and (usados + 1) > limite_personal:
            return False
        _areas_set_personal_disponible(app, area, disp - 1)
        _proc_personal_ratio_set(app, id_proceso, usados + 1, limite_personal)
        return True

    def _devolver_maquinas_exceso(p: dict, max_p: int):
        usadas = _maquinas_usadas()
        max_maq = int(p.get("MAQUINAS", 1) or 1)
        max_maq = max(1, max_maq)

        _proc_maquinas_ratio_set(app, id_proceso, usadas, max_maq)

        if max_p <= 0:
            return

        w = _get_workers()
        if w <= 0:
            return

        necesarias = _ceil_div(w, max_p)
        necesarias = max(1, necesarias)

        while usadas > necesarias:
            ok = maquinaria_movimiento(app, modo="DEVOLVER", p=p)
            if not ok:
                break
            usadas -= 1
            _proc_maquinas_ratio_set(app, id_proceso, usadas, max_maq)

    def _devolver_todas_las_maquinas(p: dict):
        usadas = _maquinas_usadas()
        max_maq = int(p.get("MAQUINAS", 1) or 1)
        max_maq = max(1, max_maq)

        for _ in range(max(0, usadas)):
            maquinaria_movimiento(app, modo="DEVOLVER", p=p)

        _proc_maquinas_ratio_set(app, id_proceso, 0, max_maq)

    # ------------------------------------------------------------
    # worker (una persona trabajando)
    # ------------------------------------------------------------
    def _lanzar_worker(p_snapshot: dict):
        area = int(p_snapshot.get("AREA", 0))
        limite_personal = int(p_snapshot.get("PERSONAL", 0) or 0)
        parada = float(p_snapshot.get("PARADA", 0.0) or 0.0)

        cantidades_produce = (
            p_snapshot.get("CANTIDAD_PRODUCE")
            if p_snapshot.get("CANTIDAD_PRODUCE")
            else [parada]
        )

        def _on_finish():
            bodega_movimiento(
                app,
                modo="PRODUCIR",
                area_proceso=int(p_snapshot.get("AREA", 0)),
                finales=bool(p_snapshot.get("FINALES", False)),
                materias=p_snapshot.get("PRODUCE", []),
                cantidades=cantidades_produce,
            )

            termino = meta_avanzar(app, id_proceso=int(p_snapshot.get("ID_PROCESO", id_proceso)), parada=parada)

            if str(p_snapshot.get("TIPO", "NORMAL")).strip().upper() != "ALMACENAMIENTO":
                _devolver_1_persona(area, limite_personal)

            _set_workers(_get_workers() - 1)

            max_p = int(p_snapshot.get("MAX_P", 0) or 0)
            _devolver_maquinas_exceso(p_snapshot, max_p=max_p)

            if not termino:
                if _get_workers() <= 0:
                    _devolver_todas_las_maquinas(p_snapshot)
                return

            app.root.after(int(tiempo_general * 1000), _tick)

        individual(app, p_snapshot, tipo_sim, on_finish=_on_finish)

    # ------------------------------------------------------------
    # tick principal
    # ------------------------------------------------------------
    def _tick():
        # 0) si está apagado => no iniciar nuevos workers
        if not _activo():
            try:
                _, p0 = extraer_proceso(datos_df, id_proceso)
            except Exception:
                _set_estado("DESACTIVADO")
                return

            if _get_workers() <= 0:
                _set_estado("DESACTIVADO")
                _devolver_todas_las_maquinas(p0)
                return

            _set_estado("FINALIZANDO")
            # (si es cuello ideal y ya había arrancado, FINALIZANDO != ACTIVO)
            _apagar_todos_si_cuello_ideal_y_no_activo(p0)

            app.root.after(int(tiempo_general * 1000), _tick)
            return

        # refrescar proceso desde datos
        _, p = extraer_proceso(datos_df, id_proceso)

        # 1) CUELLO: setea ESTADO (ACTIVO/ESTACIONARIO)
        cuello_buffer_disponible(app, p=p)

        # ✅ chequeo global justo después de actualizar ESTADO por cuello
        _apagar_todos_si_cuello_ideal_y_no_activo(p)

        estado_actual = tree_get(app.tree_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", default="")
        if str(estado_actual).upper().startswith("ESTACIONARIO"):
            _set_estado("ESTACIONARIO")
            # ✅ estacionario != activo => dispara apagado si corresponde
            _apagar_todos_si_cuello_ideal_y_no_activo(p)

            app.root.after(int(tiempo_general * 1000), _tick)
            return

        # ------------------------------------------------------------
        # 2) MAQUINARIA (progresiva 1x1)
        # ------------------------------------------------------------
        max_maq = int(p.get("MAQUINAS", 1) or 1)
        max_maq = max(1, max_maq)

        usadas = _maquinas_usadas()
        _proc_maquinas_ratio_set(app, id_proceso, usadas, max_maq)

        max_p = int(p.get("MAX_P", 0) or 0)
        w = _get_workers()

        if w > 0 and max_p > 0:
            deseadas = max(1, _ceil_div(w, max_p))
        else:
            deseadas = 1

        deseadas = min(max_maq, deseadas)

        while usadas < deseadas:
            if maquinaria_movimiento(app, modo="CONSUMIR", p=p):
                usadas += 1
                _proc_maquinas_ratio_set(app, id_proceso, usadas, max_maq)
            else:
                break

        if usadas <= 0:
            _set_estado("PAUSADO S/MQ")
            # ✅ pausado != activo => dispara apagado si corresponde
            _apagar_todos_si_cuello_ideal_y_no_activo(p)

            app.root.after(int(tiempo_general * 1000), _tick)
            return

        # ------------------------------------------------------------
        # 3) PERSONAL PARALELO / ALMACENAMIENTO
        # ------------------------------------------------------------
        tipo = str(p.get("TIPO", "NORMAL")).strip().upper()

        if tipo == "ALMACENAMIENTO":
            if not personal_disponible(app, modo="CONSUMIR", p=p):
                _set_estado("ESTACIONARIO ALM")
                _apagar_todos_si_cuello_ideal_y_no_activo(p)

                app.root.after(int(tiempo_general * 1000), _tick)
                return

            ok_bodega = bodega_movimiento(
                app,
                modo="CONSUMIR",
                area_proceso=int(p.get("AREA", 0)),
                finales=bool(p.get("FINALES", False)),
                materias=p.get("MATERIA", []),
                cantidades=p.get("CANTIDAD_CONSUMO", []),
            )
            if not ok_bodega:
                _set_estado("PAUSADO S/M")
                _apagar_todos_si_cuello_ideal_y_no_activo(p)

                app.root.after(int(tiempo_general * 1000), _tick)
                return

            if _get_workers() <= 0:
                _set_workers(1)
                _set_estado("ACTIVO")
                _lanzar_worker(p.copy())
            else:
                _set_estado("ACTIVO")
            return

        # NORMAL
        req_personal = int(p.get("PERSONAL", 0) or 0)
        if req_personal <= 0:
            req_personal = 0

        usados_personal = _personal_usado()
        _proc_personal_ratio_set(app, id_proceso, usados_personal, req_personal)

        if max_p > 0:
            max_workers_por_maquinas = usadas * max_p
        else:
            max_workers_por_maquinas = req_personal

        target_workers = min(req_personal, max_workers_por_maquinas)
        target_workers = max(0, int(target_workers))

        if not _activo():
            _set_estado("FINALIZANDO")
            _apagar_todos_si_cuello_ideal_y_no_activo(p)

            app.root.after(int(tiempo_general * 1000), _tick)
            return

        # ------------------------------------------------------------
        # 4) subir workers 1x1
        # ------------------------------------------------------------
        while _get_workers() < target_workers:
            ok_bodega = bodega_movimiento(
                app,
                modo="CONSUMIR",
                area_proceso=int(p.get("AREA", 0)),
                finales=bool(p.get("FINALES", False)),
                materias=p.get("MATERIA", []),
                cantidades=p.get("CANTIDAD_CONSUMO", []),
            )
            if not ok_bodega:
                _set_estado("PAUSADO S/M")
                # ✅ esta es la condición que tú describiste (estado != ACTIVO)
                _apagar_todos_si_cuello_ideal_y_no_activo(p)
                break

            if not _tomar_1_persona(int(p.get("AREA", 0)), req_personal):
                _set_estado("PAUSADO S/P")
                _apagar_todos_si_cuello_ideal_y_no_activo(p)
                break

            _set_workers(_get_workers() + 1)
            _set_estado("ACTIVO")
            _lanzar_worker(p.copy())

        # ------------------------------------------------------------
        # 5) intentar subir máquinas para permitir más gente
        # ------------------------------------------------------------
        if max_p > 0 and req_personal > 0:
            maquinas_necesarias_para_req = min(max_maq, max(1, _ceil_div(target_workers, max_p)))
        else:
            maquinas_necesarias_para_req = max_maq

        usadas2 = _maquinas_usadas()
        while usadas2 < maquinas_necesarias_para_req:
            if maquinaria_movimiento(app, modo="CONSUMIR", p=p):
                usadas2 += 1
                _proc_maquinas_ratio_set(app, id_proceso, usadas2, max_maq)
            else:
                break

        # ------------------------------------------------------------
        # 6) estado final del tick
        # ------------------------------------------------------------
        if _get_workers() <= 0:
            _set_estado("ESPERANDO")
            _apagar_todos_si_cuello_ideal_y_no_activo(p)  # si ESPERANDO != ACTIVO, aplica regla
        else:
            _set_estado("ACTIVO")

        _devolver_maquinas_exceso(p, max_p=max_p)

        app.root.after(int(tiempo_general * 1000), _tick)

    _tick()


