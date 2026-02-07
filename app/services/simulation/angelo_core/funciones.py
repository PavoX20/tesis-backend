from __future__ import annotations
import pandas as pd
from distribuciones import Distribuciones
import parametros as pm

def preparar_procesos(df: pd.DataFrame) -> pd.DataFrame:
    out = df.copy()
    out["TIEMPO"] = 0.0; out["CAPACIDAD"] = 0.0; out["CUELLO_DE_BOTELLA"] = False
    for idx, r in out.iterrows():
        dist = str(r.get("DISTRIBUCION", "")).strip().lower()
        parms = pm._parse_parametros(r.get("PARAMETROS", ""))
        try: t = float(Distribuciones.generar_valor_deterministico(dist, parms, criterio="moda"))
        except: t = 0.0
        out.at[idx, "TIEMPO"] = t
        if t > 0: out.at[idx, "CAPACIDAD"] = 1.0 / t 

    valid_t = out[out["TIEMPO"] > 0]["TIEMPO"]
    t_min = valid_t.min() if not valid_t.empty else 0.0
    out["T_MIN"] = t_min

    if out["CAPACIDAD"].sum() > 0:
        min_cap = out[out["CAPACIDAD"] > 0]["CAPACIDAD"].min()
        out.loc[out["CAPACIDAD"] == min_cap, "CUELLO_DE_BOTELLA"] = True
    out["ACTIVO"] = True
    return out

def individual(app, p: dict, speed: float = 1.0, on_finish=None):
    tiempo = float(p.get("TIEMPO", 0.0))
    t_min = float(p.get("T_MIN", 0.0))
    
    # Normalización por T_MIN (Regla de Angelo)
    if t_min > 0: tiempo = tiempo / t_min
    else: tiempo = 0.0
    
    tiempo = max(0.0, tiempo)
    # Convertir a ms
    ms = int(tiempo * 1000)
    app.after(max(1, ms), on_finish)

def simular_proceso(app, id_proceso, tipo, bodega, areas, maq, datos_df, res, tiempo_gen):
    if id_proceso not in app.proc_state: app.proc_state[id_proceso] = {"workers": 0}

    def _tick():
        activo = pm.tree_get(app.db_procesos, {"ID_PROCESO": id_proceso}, "ACTIVO")
        if not pm._to_bool_es(activo, True):
            pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "Finalizado")
            return 
        
        p = None
        for row in app.db_procesos:
            if str(row.get("ID_PROCESO")) == str(id_proceso): p = row; break
        if not p: return

        # ---------------------------------------------------------
        # LÓGICA DE RECURSOS (Restaurada)
        # ---------------------------------------------------------
        
        # 1. Verificar BODEGA (Consumo)
        # Si no hay material, PAUSAR y reintentar
        ok_bodega = pm.bodega_movimiento(
            app, 
            modo="CONSUMIR", 
            area_proceso=int(p.get("AREA", 0)), 
            finales=False, 
            materias=p.get("MATERIA"), 
            cantidades=p.get("CANTIDAD_CONSUMO")
        )
        
        if not ok_bodega:
            pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "PAUSADO S/M")
            # Reintentar en 0.1s (simulado)
            app.after(100, _tick) 
            return

        # 2. Verificar MAQUINARIA y PERSONAL
        ok_maq = pm.maquinaria_movimiento(app, modo="CONSUMIR", p=p)
        ok_pers = pm.personal_disponible(app, modo="CONSUMIR", p=p)

        if ok_maq and ok_pers:
            # Si tiene todo, TRABAJAR
            pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "Trabajando...")
            
            def _on_finish():
                # Al terminar:
                # 1. Devolver recursos (Mq/Pers)
                pm.maquinaria_movimiento(app, modo="DEVOLVER", p=p)
                pm.personal_disponible(app, modo="DEVOLVER", p=p)
                
                # 2. Producir salida a Bodega
                pm.bodega_movimiento(
                    app, 
                    modo="PRODUCIR", 
                    area_proceso=int(p.get("AREA", 0)), 
                    finales=pm._to_bool_es(p.get("FINALES", False)), 
                    materias=p.get("PRODUCE"), 
                    cantidades=p.get("CANTIDAD_PRODUCE") or p.get("PARADA")
                )

                # 3. Avanzar Meta
                parada = float(p.get("PARADA", 1.0))
                sigue = pm.meta_avanzar(app, id_proceso=id_proceso, parada=parada)
                
                if sigue:
                    pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "Produciendo")
                    app.after(1, _tick) 
                else:
                    pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", "Finalizado")

            individual(app, p, on_finish=_on_finish)
        
        else:
            # Si falta Maquina o Personal, devolver lo que se haya tomado (incluido material)
            if ok_maq: pm.maquinaria_movimiento(app, modo="DEVOLVER", p=p)
            if ok_pers: pm.personal_disponible(app, modo="DEVOLVER", p=p)
            
            # Devolver material consumido porque no se pudo trabajar
            pm.bodega_movimiento(
                app, 
                modo="PRODUCIR", # "Producir" de vuelta lo consumido
                area_proceso=int(p.get("AREA", 0)), 
                finales=False, 
                materias=p.get("MATERIA"), 
                cantidades=p.get("CANTIDAD_CONSUMO")
            )
            
            estado = "PAUSADO S/MQ" if not ok_maq else "PAUSADO S/P"
            pm.tree_set(app.db_procesos, {"ID_PROCESO": id_proceso}, "ESTADO", estado)
            app.after(100, _tick)

    _tick()