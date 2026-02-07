import sys
import os
import heapq
import itertools
import pandas as pd
import warnings
import math
import base64
import matplotlib
matplotlib.use('Agg')

sys.path.append(os.getcwd())
import funciones
import parametros as pm
try:
    import grafica
except ImportError:
    grafica = None
    print("⚠️ Advertencia: grafica.py no encontrado.")

class HeadlessApp:
    def __init__(self, df_datos, df_bodega, df_maq, df_areas):
        self.db_procesos = []
        self.db_bodega = df_bodega.to_dict('records')
        self.db_maquinaria = df_maq.to_dict('records')
        self.db_areas = df_areas.to_dict('records')
        self.proc_state = {} 
        # Inicializamos el diccionario de Cuello de Botella con Buffer
        self.cb_info = {"ID": None, "BUFFER": 0.0}
        
        self.virtual_time = 0.0 
        self.event_queue = []   
        self.counter = itertools.count()
        
        # Historial
        self.historial = {
            "datos": [], "bodega": [], "maq": [], "areas": []
        }
        self.last_snap_time = -0.1 
        
        self._init_procesos(df_datos)

    def _init_procesos(self, df):
        for _, r in df.iterrows():
            row = r.to_dict()
            # Guardamos la meta original numérica antes de transformarla en string "0/100"
            row["META_NUM"] = int(row.get("META", 0))
            
            row["META"] = f"0/{int(row.get('META', 0))}"
            # Aseguramos formato ratio desde el inicio para evitar 1/0
            row["MAQUINAS"] = f"0/{int(row.get('MAQUINAS', 0))}"
            row["PERSONAL"] = f"0/{int(row.get('PERSONAL', 0))}"
            
            row["ACTIVO"] = True
            row["ESTADO"] = "Inactivo"
            # Inicializar tiempos como floats para cálculo preciso
            row["T.ACTIVO"] = 0.0 
            row["T.PAUSADO"] = 0.0
            row["T.INICIO"] = None # Marca de tiempo cuando inicia
            
            if row.get("CUELLO_DE_BOTELLA"):
                self.cb_info["ID"] = row["ID_PROCESO"]
                # Inicialmente el buffer es la meta total para el CB
                self.cb_info["BUFFER"] = float(row["META_NUM"])
                
            self.db_procesos.append(row)

    def after(self, ms, func):
        delay = max(0.001, ms / 1000.0)
        trigger = self.virtual_time + delay
        heapq.heappush(self.event_queue, (trigger, next(self.counter), func))

    def _update_clocks(self, delta):
        if delta <= 0: return
        for p in self.db_procesos:
            if str(p.get("ACTIVO")).lower() != "true":
                continue

            estado = str(p.get("ESTADO", "")).upper()
            
            # Registrar inicio de vida si no está inactivo
            if estado != "INACTIVO" and p["T.INICIO"] is None:
                p["T.INICIO"] = self.virtual_time

            # Solo sumar a ACTIVO si está trabajando realmente
            if "TRABAJANDO" in estado or "PRODUCIENDO" in estado:
                p["T.ACTIVO"] += delta
            
            # El tiempo pausado se calcula matemáticamente en el snapshot

    def run(self):
        print("🚀 Ejecutando simulación con gráficas...")
        ids = [p["ID_PROCESO"] for p in self.db_procesos]
        
        self.virtual_time = 0.0
        self._fill_history_gap(0.0)
        
        for pid in ids:
            funciones.simular_proceso(self, pid, "IDEAL", None, None, None, None, None, 1.0)

        while self.event_queue:
            t, _, func = heapq.heappop(self.event_queue)
            
            delta = t - self.virtual_time
            self._update_clocks(delta)
            
            self._fill_history_gap(t)
            
            self.virtual_time = t
            func()
            
            if self._check_finished(): break
                
        self._fill_history_gap(self.virtual_time)
        print(f"✅ Finalizado en T={self.virtual_time:.3f}s simulados.")
        
        # Calcular Buffer Final antes de reportar
        self._calcular_buffer_final()
        
        self.print_report()
        
        if grafica:
            self.generate_graph()

    def _check_finished(self):
        for p in self.db_procesos:
            if str(p.get("ACTIVO")).lower() == "true": return False
        return True
    
    def _calcular_buffer_final(self):
        # Si no hay ID de Cuello de Botella identificado explícitamente, buscamos el que más tardó
        if self.cb_info["ID"] is None:
            # Lógica simple: el último proceso activo o con mayor carga
            # Por ahora, si no hay CB definido, tomamos el proceso con mayor META
            try:
                max_proc = max(self.db_procesos, key=lambda x: x.get("META_NUM", 0))
                self.cb_info["ID"] = max_proc["ID_PROCESO"]
                self.cb_info["BUFFER"] = float(max_proc["META_NUM"])
            except:
                pass
        else:
            # Si ya existe un CB identificado, aseguramos que el BUFFER sea la Meta Numérica
            # Buscamos el proceso en la DB interna
            proc = next((p for p in self.db_procesos if p["ID_PROCESO"] == self.cb_info["ID"]), None)
            if proc:
                self.cb_info["BUFFER"] = float(proc.get("META_NUM", 0))

    def _fill_history_gap(self, target_time):
        next_snap = round(self.last_snap_time + 0.1, 1)
        epsilon = 1e-9
        while next_snap <= target_time + epsilon:
            self._take_snapshot(next_snap)
            self.last_snap_time = next_snap
            next_snap = round(self.last_snap_time + 0.1, 1)

    def _take_snapshot(self, t):
        def snap(source):
            final_rows = []
            for row in source:
                t_activo = row.get("T.ACTIVO", 0.0)
                t_inicio = row.get("T.INICIO")
                
                if t_inicio is not None:
                    t_vida = t - t_inicio
                    t_pausado = max(0.0, t_vida - t_activo)
                else:
                    t_pausado = 0.0
                
                row["T.PAUSADO"] = t_pausado

                r_copy = row.copy()
                r_copy["T_HIST"] = t
                r_copy["T.ACTIVO"] = f"{t_activo:.3f}"
                r_copy["T.PAUSADO"] = f"{t_pausado:.3f}"
                final_rows.append(r_copy)
            return final_rows

        self.historial["datos"].extend(snap(self.db_procesos))
        self.historial["bodega"].extend([{**r, "T_HIST": t} for r in self.db_bodega])
        self.historial["maq"].extend([{**r, "T_HIST": t} for r in self.db_maquinaria])
        self.historial["areas"].extend([{**r, "T_HIST": t} for r in self.db_areas])

    def print_report(self):
        print("\n" + "="*90)
        print("RESUMEN CUELLO DE BOTELLA (FINAL)")
        # Usamos los datos internos de la clase
        print(pd.DataFrame([{
            "ID_PROCESO_CUELLO": self.cb_info["ID"],
            "BUFFER": self.cb_info["BUFFER"], 
            "TIEMPO_TOTAL_S": self.virtual_time
        }]).to_string(index=False))
        print("="*90)

        # CONFIGURACIÓN PARA MOSTRAR TODO
        pd.set_option('display.max_columns', 20)
        pd.set_option('display.width', 1000)
        pd.set_option('display.max_rows', None)
        
        def print_table(key, title, cols):
            if self.historial[key]:
                df = pd.DataFrame(self.historial[key])
                c_ord = ["T_HIST"] + [c for c in cols if c in df.columns]
                print(f"\n{title} (COMPLETO)")
                print(df[c_ord].to_string(index=False))

        print_table("datos", "HISTORIAL DATOS", ["ID_PROCESO", "INCIALES", "MAQUINAS", "PERSONAL", "META", "ACTIVO", "ESTADO", "T.ACTIVO", "T.PAUSADO"])
        # (Opcional) Comentado para no saturar consola si no es necesario
        # print_table("bodega", "HISTORIAL BODEGA", ["AREA", "MATERIA", "CANTIDAD"])
        # print_table("maq", "HISTORIAL MAQUINARIA", ["AREA", "MAQUINARIA", "CANTIDAD"])
        # print_table("areas", "HISTORIAL AREAS", ["AREA", "PERSONAL"])

    def generate_graph(self):
        print("\n📊 Generando gráfica desde historial...")
        try:
            datos_para_grafica = []
            for p in self.db_procesos:
                datos_para_grafica.append({
                    "id_proceso": p.get("ID_PROCESO"),
                    "t_activo": p.get("T.ACTIVO", 0.0),
                    "t_pausado": p.get("T.PAUSADO", 0.0)
                })
            
            b64_str = grafica.grafico_tiempos_ideal_real(datos_para_grafica)
            
            with open("grafica_base64.txt", "w") as f:
                f.write(b64_str)
            
            # También guardamos el PNG físico por si acaso
            with open("grafica.png", "wb") as f:
                f.write(base64.b64decode(b64_str))
                
            print(f"✅ Gráfica generada exitosamente.")
        except Exception as e:
            print(f"❌ Error en gráfica: {e}")
            import traceback
            traceback.print_exc()

if __name__ == "__main__":
    if not os.path.exists("DATOS.xlsx"):
        print("❌ Falta DATOS.xlsx")
        sys.exit()

    df = pd.read_excel("DATOS.xlsx")
    processed = funciones.preparar_procesos(df)
    
    BODEGA = pd.DataFrame([{"AREA": 0, "MATERIA": "M-001", "CANTIDAD": 1000}, {"AREA": 0, "MATERIA": "S-002", "CANTIDAD": 10}])
    MAQ = pd.DataFrame([{"AREA": 1, "MAQUINARIA": "MAQ-001", "CANTIDAD": 10}, {"AREA": 2, "MAQUINARIA": "MAQ-001", "CANTIDAD": 4}])
    AREAS = pd.DataFrame([{"AREA": 1, "PERSONAL": 12}, {"AREA": 2, "PERSONAL": 8}])
    
    app = HeadlessApp(processed, BODEGA, MAQ, AREAS)
    app.run()