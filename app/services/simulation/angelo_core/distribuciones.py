import matplotlib
# ESTA LÍNEA ES CRUCIAL PARA QUE FUNCIONE SIN VENTANAS (HEADLESS)
matplotlib.use('Agg') 

import numpy as np
import matplotlib.pyplot as plt
from scipy import stats as st
from scipy.stats import norm, expon, gamma, lognorm, beta, weibull_min, poisson, uniform

class Distribuciones:
    def __init__(self, datos):
        """
        Inicializa la clase con datos para análisis estadístico.
        Args:
            datos: Lista o array de datos numéricos
        """
        self.datos_originales = np.array(datos, dtype=float) 
        self.datos = self.datos_originales[np.isfinite(self.datos_originales)]

        if len(self.datos) == 0:
            raise ValueError("Los datos de entrada están vacíos o solo contienen valores no finitos.")
        
        self.resultados_evaluacion = [] 
        
    def _calcular_r2(self, y_real, y_pred):
        y_real = np.array(y_real)
        y_pred = np.array(y_pred)
        
        valid_indices = np.isfinite(y_real) & np.isfinite(y_pred)
        if not np.any(valid_indices): 
            return 0.0

        y_real_filtered = y_real[valid_indices]
        y_pred_filtered = y_pred[valid_indices]

        if len(y_real_filtered) < 2: 
            return 0.0

        ss_res = np.sum((y_real_filtered - y_pred_filtered) ** 2)
        ss_tot = np.sum((y_real_filtered - np.mean(y_real_filtered)) ** 2)
        
        if ss_tot == 0: 
            return 1.0 
        
        r2 = 1 - (ss_res / ss_tot)
        return r2

    def histograma(self):
        datos = self.datos
        n = len(datos)

        if n == 0:
            return np.array([]), np.array([]), np.array([])
        if n == 1:
            return np.array([1.0]), np.array([datos[0] - 0.5, datos[0] + 0.5]), np.array([datos[0]])
        if np.max(datos) == np.min(datos):
            return np.array([1.0]), np.array([datos[0] - 0.5, datos[0] + 0.5]), np.array([datos[0]])

        q75, q25 = np.percentile(datos, [75, 25])
        iqr = q75 - q25
        
        ancho_bin = 0.0
        if iqr > 1e-6: 
            ancho_bin = 2 * iqr / np.cbrt(n)
        else: 
            rango_datos = np.max(datos) - np.min(datos)
            ancho_bin = rango_datos / 10 if rango_datos > 1e-6 else 1.0

        if ancho_bin <= 1e-6: 
            ancho_bin = 1.0 

        range_data = np.max(datos) - np.min(datos)
        bins = int(np.ceil(range_data / ancho_bin))
        if bins < 1: bins = 1 
        if bins > n: bins = n 

        cuentas, bordes = np.histogram(datos, bins=bins, density=True)
        puntos_medios = (bordes[:-1] + bordes[1:]) / 2

        return cuentas, bordes, puntos_medios

    def _histograma_para_beta(self, datos_normalizados):
        datos_normalizados_validos = datos_normalizados[np.isfinite(datos_normalizados)]

        n = len(datos_normalizados_validos)
        if n == 0:
            return np.array([]), np.array([]), np.array([])
        if n == 1:
            return np.array([1.0]), np.array([0, 1]), np.array([0.5]) 
        if np.max(datos_normalizados_validos) == np.min(datos_normalizados_validos):
            return np.array([1.0]), np.array([0, 1]), np.array([0.5]) 

        num_bins = min(50, max(1, int(n**0.5))) 
        if num_bins < 5 and n > 1: num_bins = max(5, int(n/5)) 

        cuentas, bordes = np.histogram(datos_normalizados_validos, bins=num_bins, range=(0.0, 1.0), density=True)
        centros = (bordes[:-1] + bordes[1:]) / 2
        return cuentas, bordes, centros

    def evaluar_distribuciones(self, verbose=False):
        UMBRAL_DATOS_SUFICIENTES = 20
        VALOR_CONSTANTE_POR_DEFECTO_POCOS_DATOS = 3 

        self.resultados_evaluacion.clear() 

        if len(self.datos) < UMBRAL_DATOS_SUFICIENTES:
            if len(self.datos) > 0:
                promedio_simple = np.mean(self.datos)
                self.resultados_evaluacion.append([
                    f"Promedio Simple (N={len(self.datos)})", 
                    None, None, None, 
                    "simple_average", 
                    [round(promedio_simple, 4)] 
                ])
            else: 
                self.resultados_evaluacion.append([
                    f"Valor Constante por Defecto (N=0 válidos)",
                    None, None, None, "default_constant", [VALOR_CONSTANTE_POR_DEFECTO_POCOS_DATOS]
                ])
            return self.resultados_evaluacion

        cuentas_hist_base, bordes_hist_base, centros_hist_base = self.histograma()
        
        distribuciones_a_evaluar = {
            "norm": "Distribución Normal",
            "expon": "Distribución Exponencial",
            "gamma": "Distribución Gamma",
            "lognorm": "Distribución Log-Normal",
            "beta": "Distribución Beta", 
            "weibull_min": "Distribución Weibull Mínima",
            "uniform": "Distribución Uniforme",
            "poisson": "Distribución de Poisson" 
        }
        
        datos_para_beta = self.datos
        min_datos = np.min(datos_para_beta)
        max_datos = np.max(datos_para_beta)
        
        if max_datos > min_datos:
            datos_para_beta = (datos_para_beta - min_datos) / (max_datos - min_datos)
        elif len(datos_para_beta) > 0:
            datos_para_beta = np.full_like(datos_para_beta, 0.5)
        
        for dist_name, nombre_legible in distribuciones_a_evaluar.items():
            D_ks_val, p_ks_val, r2_rounded = np.nan, np.nan, 0.0 
            parametros = None 
            
            try:
                distribucion = getattr(st, dist_name)
                current_data_for_fit = None 

                if dist_name == "beta":
                    valid_beta_data = datos_para_beta[(datos_para_beta > 1e-9) & (datos_para_beta < 1 - 1e-9)]
                    if len(valid_beta_data) > 0:
                        current_data_for_fit = valid_beta_data
                        parametros = distribucion.fit(current_data_for_fit, floc=0, fscale=1)
                    elif max_datos == min_datos and len(datos_para_beta) > 0:
                         current_data_for_fit = np.array([0.5])
                         parametros = distribucion.fit(current_data_for_fit, floc=0, fscale=1)
                    else:
                        continue 

                elif dist_name == "poisson":
                    if not (np.all(np.equal(np.mod(self.datos, 1), 0)) and np.all(self.datos >= 0)):
                        continue 
                    current_data_for_fit = self.datos
                    try:
                        parametros = distribucion.fit(current_data_for_fit)
                    except:
                        continue
                else:
                    current_data_for_fit = self.datos
                    parametros = distribucion.fit(current_data_for_fit)

                if parametros is not None and current_data_for_fit is not None and len(current_data_for_fit) > 0:
                    if dist_name == "poisson":
                        datos_validos_enteros = current_data_for_fit[np.logical_and(np.isfinite(current_data_for_fit), np.equal(np.mod(current_data_for_fit, 1), 0))]
                        if len(datos_validos_enteros) > 0:
                            min_val_int = int(np.floor(np.min(datos_validos_enteros)))
                            max_val_int = int(np.ceil(np.max(datos_validos_enteros)))
                            discrete_points = np.arange(min_val_int, max_val_int + 1)
                            bins_discrete = np.arange(min_val_int - 0.5, max_val_int + 1.5, 1)

                            if len(discrete_points) > 0 and len(bins_discrete) >= 2:
                                observed_counts, _ = np.histogram(datos_validos_enteros, bins=bins_discrete, density=False)
                                observed_proportions = observed_counts / len(datos_validos_enteros)
                                fitted_pmf = distribucion.pmf(discrete_points, *parametros)
                                if len(observed_proportions) == len(fitted_pmf):
                                    r2_rounded = self._calcular_r2(observed_proportions, fitted_pmf)
                    else: 
                        if len(self.datos) >= 2 and max_datos > min_datos and len(centros_hist_base) > 0:
                            pdf_ajustada = distribucion.pdf(centros_hist_base, *parametros)
                            r2_rounded = self._calcular_r2(cuentas_hist_base, pdf_ajustada)

                    try:
                        D_ks_val, p_ks_val = st.kstest(current_data_for_fit, dist_name, args=parametros)
                    except:
                        D_ks_val, p_ks_val = np.nan, np.nan
                else:
                    r2_rounded = 0.0
                    D_ks_val, p_ks_val = np.nan, np.nan

                param_list_rounded = []
                if parametros is not None:
                    for pv in parametros:
                        if isinstance(pv, (int, float)):
                            param_list_rounded.append(round(pv, 4))
                        else:
                            param_list_rounded.append(pv) 

                ks_str = f"KS: {D_ks_val:.4f} p: {p_ks_val:.4f}" if not np.isnan(D_ks_val) else "KS: N/A"
                r2_str = f"R²: {r2_rounded:.4f}"
                
                self.resultados_evaluacion.append([
                    f"{nombre_legible} — {ks_str} {r2_str}", 
                    D_ks_val, p_ks_val, r2_rounded, dist_name, param_list_rounded
                ])

            except Exception:
                pass
            
        self.resultados_evaluacion.sort(key=lambda x: (
            x[2] if x[2] is not None and not np.isnan(x[2]) else -1, 
            x[3] if x[3] is not None and not np.isnan(x[3]) else -1
        ), reverse=True) 

        return self.resultados_evaluacion
    
    def graficar_mejores_ajustes(self, titulo="Comparación de Ajustes de Distribuciones", max_distribuciones=3):
        # Desactivado para ejecución headless
        pass
    
    @staticmethod
    def generar_dato_aleatorio(nombre_distribucion: str, parametros: list):
        distribuciones_generacion = {
            "norm": lambda p: norm.rvs(loc=p[0], scale=p[1]),
            "expon": lambda p: expon.rvs(loc=p[0], scale=p[1]), 
            "gamma": lambda p: gamma.rvs(a=p[0], loc=p[1], scale=p[2]), 
            "lognorm": lambda p: lognorm.rvs(s=p[0], loc=p[1], scale=p[2]), 
            "beta": lambda p: beta.rvs(a=p[0], b=p[1], loc=p[2], scale=p[3]), 
            "weibull_min": lambda p: weibull_min.rvs(c=p[0], loc=p[1], scale=p[2]), 
            "uniform": lambda p: uniform.rvs(loc=p[0], scale=p[1]), 
            "poisson": lambda p: poisson.rvs(mu=p[0]) 
        }
        if nombre_distribucion not in distribuciones_generacion: return 0.0
        try: return distribuciones_generacion[nombre_distribucion](parametros)
        except: return 0.0

    @staticmethod
    def generar_valor_deterministico(nombre_distribucion: str, parametros: list, criterio: str = "moda"):
        try:
            if nombre_distribucion == "norm":
                dist = st.norm(loc=parametros[0], scale=parametros[1])
            elif nombre_distribucion == "expon":
                dist = st.expon(loc=parametros[0], scale=parametros[1])
            elif nombre_distribucion == "gamma":
                dist = st.gamma(a=parametros[0], loc=parametros[1], scale=parametros[2])
            elif nombre_distribucion == "lognorm":
                dist = st.lognorm(s=parametros[0], loc=parametros[1], scale=parametros[2])
            elif nombre_distribucion == "beta":
                dist = st.beta(a=parametros[0], b=parametros[1], loc=parametros[2], scale=parametros[3])
            elif nombre_distribucion == "weibull_min":
                dist = st.weibull_min(c=parametros[0], loc=parametros[1], scale=parametros[2])
            elif nombre_distribucion == "uniform":
                dist = st.uniform(loc=parametros[0], scale=parametros[1])
            elif nombre_distribucion == "poisson":
                dist = st.poisson(mu=parametros[0])
            else:
                return 0.0

            if criterio == "media": return float(dist.mean())
            if criterio == "mediana": return float(dist.median())

            if nombre_distribucion == "poisson":
                mu = parametros[0]
                if abs(mu - round(mu)) < 1e-12 and mu >= 1: return int(round(mu) - 1)
                return int(np.floor(mu))

            if nombre_distribucion == "uniform":
                return float((parametros[0] + parametros[0] + parametros[1]) / 2.0)

            try:
                # Aproximación rápida a la moda para distribuciones continuas
                if nombre_distribucion == "norm": return parametros[0]
                # Fallback al cálculo completo si es necesario
                mean = dist.mean(); std = dist.std()
                lo = mean - 3*std; hi = mean + 3*std
                xs = np.linspace(lo, hi, 100)
                ys = dist.pdf(xs)
                return float(xs[np.argmax(ys)])
            except:
                return float(dist.median())
        except:
            return 0.0