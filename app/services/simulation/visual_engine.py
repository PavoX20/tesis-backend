import random
from collections import deque, defaultdict
import io
import base64
import matplotlib
matplotlib.use('Agg') 
import matplotlib.pyplot as plt

class MotorSimulacionVisual:
    def __init__(self, procesos_config, conexiones, total_zapatos, buffer_seguridad_inicial=0):
        self.procesos = {p['id']: p for p in procesos_config}
        self.total_zapatos = total_zapatos
        self.buffer_seguridad = buffer_seguridad_inicial
        
        self.reloj = 0.0
        self.colas = {pid: deque() for pid in self.procesos}
        self.estado_maquinas = {pid: 0 for pid in self.procesos} 
        
        # Metas Individuales
        self.produccion_por_proceso = {pid: 0 for pid in self.procesos}
        self.meta_por_proceso = {pid: total_zapatos for pid in self.procesos} 
        self.procesos_activos = {pid: True for pid in self.procesos}

        # Estadísticas
        self.stats = {
            pid: {
                'real_activo': 0.0,
                'real_pausado': 0.0,
                'ideal_activo': 0.0,
                'ideal_pausado': 0.0  
            } 
            for pid in self.procesos
        }
        
        self.produccion_terminada = 0
        self.timeline = []

        # Grafo
        self.grafo_siguientes = defaultdict(list)
        self.grafo_anteriores = defaultdict(list)
        for origen, destino in conexiones:
            if origen in self.procesos and destino in self.procesos:
                self.grafo_siguientes[origen].append(destino)
                self.grafo_anteriores[destino].append(origen)

        self.nodos_iniciales = []
        for pid in self.procesos:
            if pid not in self.grafo_anteriores:
                self.nodos_iniciales.append(pid)
        if not self.nodos_iniciales and self.procesos:
             self.nodos_iniciales.append(min(self.procesos.keys()))

    def _generar_tiempo(self, tiempo_base, variabilidad):
        # Usamos el tiempo base real de la BD.
        # Usamos la variabilidad real (desviación) extraída de los parámetros.
        t = random.normalvariate(tiempo_base, variabilidad)
        return max(0.1, t)

    def correr(self):
        cola_entrada_virtual = deque([i for i in range(self.total_zapatos)])
        tiempo_maximo_seguridad = 50000 
        eventos_futuros = [] 

        while self.produccion_terminada < self.total_zapatos and self.reloj < tiempo_maximo_seguridad:
            
            # 1. ALIMENTAR
            if len(cola_entrada_virtual) > 0:
                while len(cola_entrada_virtual) > 0:
                    zapato_id = cola_entrada_virtual[0] 
                    aceptado = False
                    for pid_inicio in self.nodos_iniciales:
                        if self.procesos_activos[pid_inicio]:
                             self.colas[pid_inicio].append({'id_zapato': zapato_id})
                             aceptado = True
                    if aceptado:
                        cola_entrada_virtual.popleft()
                    else:
                        break

            # 2. SNAPSHOT
            snapshot = self._crear_snapshot()
            self.timeline.append(snapshot)

            # 3. PROCESAR SALIDAS
            nuevos_eventos = []
            for evento in eventos_futuros:
                t_fin, pid, zapato_id = evento
                if t_fin <= self.reloj:
                    self.estado_maquinas[pid] = 0 
                    self.produccion_por_proceso[pid] += 1
                    
                    if self.produccion_por_proceso[pid] >= self.meta_por_proceso[pid]:
                        self.procesos_activos[pid] = False 

                    siguientes = self.grafo_siguientes.get(pid, [])
                    if siguientes:
                        for sig_pid in siguientes:
                            self.colas[sig_pid].append({'id_zapato': zapato_id})
                    else:
                        # --- CORRECCIÓN AQUÍ: Freno de mano para no pasar de 100 ---
                        if self.produccion_terminada < self.total_zapatos:
                            self.produccion_terminada += 1
                        
                        # Si ya llegamos, rompemos el for para no procesar más salidas fantasma
                        if self.produccion_terminada >= self.total_zapatos:
                            break  
                else:
                    nuevos_eventos.append(evento)
            
            eventos_futuros = nuevos_eventos

            # --- CORRECCIÓN EXTRA: Romper el while principal inmediatamente ---
            if self.produccion_terminada >= self.total_zapatos:
                break

            # 4. ASIGNAR MÁQUINAS
            for pid in self.procesos:
                if self.procesos_activos[pid] and len(self.colas[pid]) > 0 and self.estado_maquinas[pid] == 0:
                    zapato = self.colas[pid].popleft()
                    proc_info = self.procesos[pid]
                    duracion = self._generar_tiempo(proc_info['tiempo_base'], proc_info['variabilidad'])
                    
                    self.stats[pid]['ideal_activo'] += proc_info['tiempo_base']
                    
                    tiempo_fin = self.reloj + duracion
                    self.estado_maquinas[pid] = 1 
                    eventos_futuros.append((tiempo_fin, pid, zapato['id_zapato']))

            self.reloj += 0.5 

        # Foto final del 100
        snapshot_final = self._crear_snapshot()
        self.timeline.append(snapshot_final)

        grafica_base64 = self._generar_grafica_imagen()

        return {
            "total_tiempo": round(self.reloj, 2),
            "total_producido": self.produccion_terminada,
            "timeline": self.timeline,
            "grafica_base64": grafica_base64
        }

    def _crear_snapshot(self):
        tabla_procesos = []
        
        # --- DICCIONARIOS REALES ---
        recursos_bodega = defaultdict(int)
        recursos_maquinaria = defaultdict(int)
        personal_area = defaultdict(lambda: {"total": 0, "ocupado": 0})

        for pid, info in self.procesos.items():
            is_working = self.estado_maquinas[pid] == 1
            has_queue = len(self.colas[pid]) > 0
            is_active = self.procesos_activos[pid]

            # Stats
            if is_active:
                if is_working:
                    self.stats[pid]['real_activo'] += 0.5
                elif has_queue:
                    self.stats[pid]['real_pausado'] += 0.5
                else:
                    self.stats[pid]['real_pausado'] += 0.5
            
            estado_str = "ESPERANDO"
            if not is_active: estado_str = "FINALIZADO"
            elif is_working: estado_str = "TRABAJANDO"
            elif has_queue: estado_str = "EN COLA"

            tabla_procesos.append({
                "id_proceso": pid,
                "nombre": info['nombre'],
                "maquinas_count": 1,
                "personal_count": 1 if is_working else 0,
                "meta": self.meta_por_proceso[pid],
                "progreso": self.produccion_por_proceso[pid],
                "activo": is_active,
                "estado": estado_str,
                "tiempo_activo": round(self.stats[pid]['real_activo'], 1),
                "tiempo_pausado": round(self.stats[pid]['real_pausado'], 1)
            })

            # --- USO DE DATOS REALES DE LA BD ---
            nombre_area = info['nombre_area_real']
            nombre_maquina = info['nombre_maquina_real']
            personal_max_real = info.get('personal_max_real', 1) # Dato real del TipoMaquina

            # 1. Agrupación por Área para WIP
            recursos_bodega[(nombre_area, "En Proceso (WIP)")] += len(self.colas[pid])
            
            # 2. Agrupación por Área para Maquinaria
            recursos_maquinaria[(nombre_area, nombre_maquina)] += 1
            
            # 3. Personal por Área Real (CORREGIDO: No más hardcodeo de +2)
            personal_area[nombre_area]["total"] += personal_max_real
            if is_working: 
                personal_area[nombre_area]["ocupado"] += 1

        # Formateo para Frontend
        tabla_bodega = [{"area": k[0], "recurso": k[1], "cantidad": v} for k, v in recursos_bodega.items()]
        tabla_maquinaria = [{"area": k[0], "recurso": k[1], "cantidad": v} for k, v in recursos_maquinaria.items()]
        tabla_personal = [{"area": k, "personal_total": v["total"], "personal_ocupado": v["ocupado"]} for k, v in personal_area.items()]
        
        # Ordenamos las tablas
        tabla_bodega.sort(key=lambda x: x['area'])
        tabla_maquinaria.sort(key=lambda x: x['area'])
        tabla_personal.sort(key=lambda x: x['area'])

        return {
            "tiempo": round(self.reloj, 2),
            "buffer_stock": self.produccion_terminada,
            "cuello_botella": self._detectar_cuello(),
            "nodos": {str(pid): {"cola": len(self.colas[pid]), "ocupado": self.estado_maquinas[pid]==1, "nombre": self.procesos[pid]['nombre']} for pid in self.procesos},
            "tabla_procesos": sorted(tabla_procesos, key=lambda x: x['id_proceso']),
            "tabla_bodega": tabla_bodega,
            "tabla_maquinaria": tabla_maquinaria,
            "tabla_personal": tabla_personal
        }

    def _generar_grafica_imagen(self):
        ids = []
        ideal_act = []
        ideal_pau = []
        real_act = []
        real_pau = []

        for pid in sorted(self.procesos.keys()):
            ids.append(self.procesos[pid]['nombre'])
            s = self.stats[pid]
            ideal_act.append(s['ideal_activo'])
            ideal_pau.append(0) 
            real_act.append(s['real_activo'])
            real_pau.append(s['real_pausado'])

        x = range(len(ids))
        w = 0.35
        x_ideal = [xi - w / 2 for xi in x]
        x_real = [xi + w / 2 for xi in x]

        plt.figure(figsize=(10, 6))
        plt.bar(x_ideal, ideal_act, width=w, label="IDEAL T.ACTIVO", color='#3b82f6')
        plt.bar(x_ideal, ideal_pau, width=w, bottom=ideal_act, label="IDEAL T.PAUSADO", color='#93c5fd')
        plt.bar(x_real, real_act, width=w, label="REAL T.ACTIVO", color='#22c55e')
        plt.bar(x_real, real_pau, width=w, bottom=real_act, label="REAL T.PAUSADO", color='#f59e0b')

        plt.xticks(x, ids, rotation=45, ha='right', fontsize=8)
        plt.ylabel("Tiempo (s)")
        plt.title("EFICIENCIA: IDEAL vs REAL")
        plt.grid(axis="y", alpha=0.25)
        plt.legend(ncols=2)
        plt.tight_layout()

        buf = io.BytesIO()
        plt.savefig(buf, format='png')
        plt.close()
        buf.seek(0)
        return base64.b64encode(buf.read()).decode('utf-8')

    def _detectar_cuello(self):
        max_cola = 0
        pid_cuello = None
        for pid, cola in self.colas.items():
            if len(cola) > max_cola:
                max_cola = len(cola)
                pid_cuello = pid
        if max_cola == 0: return None
        return {"id": pid_cuello, "nombre": self.procesos[pid_cuello]['nombre'], "cantidad_cola": max_cola}