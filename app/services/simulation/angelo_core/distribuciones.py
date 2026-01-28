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
        # Convertir los datos a un arreglo NumPy, asegurando dtype float para consistencia
        # Y MÁS IMPORTANTE: nos quedamos solo con los datos finitos (quitamos NaN e Inf)
        self.datos_originales = np.array(datos, dtype=float) 
        self.datos = self.datos_originales[np.isfinite(self.datos_originales)] # Filtro inicial

        # Validar que los datos finitos no estén vacíos
        if len(self.datos) == 0:
            raise ValueError("Los datos de entrada están vacíos o solo contienen valores no finitos (NaN/Inf). Se requiere al menos un punto de datos válido para el análisis.")
        
        self.resultados_evaluacion = [] 
        
    def _calcular_r2(self, y_real, y_pred):
        """Calcula el coeficiente de determinación (R²)."""
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
        """Calcula los componentes de un histograma (densidad), trabajando con datos finitos."""
        datos = self.datos # Ya está filtrado en __init__
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
            rango_datos = np.max(datos) - np.min(datos) # Estos son finitos porque n>1 y no son todos iguales
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
        """Calcula el histograma para datos normalizados en el rango [0,1], optimizado para Beta."""
        # Trabajar solo con datos normalizados válidos (que ya deberían ser finitos y en [0,1])
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
        """
        Evalúa múltiples distribuciones de probabilidad contra los datos,
        calcula métricas de ajuste y las ordena.
        
        Args:
            verbose (bool): Si True, muestra mensajes informativos
        
        Returns:
            list: Lista de resultados ordenados por ajuste
        """
        UMBRAL_DATOS_SUFICIENTES = 20
        VALOR_CONSTANTE_POR_DEFECTO_POCOS_DATOS = 3 

        self.resultados_evaluacion.clear() 

        # Usar los datos filtrados de NaNs/Infs para el umbral
        if len(self.datos) < UMBRAL_DATOS_SUFICIENTES:
            if len(self.datos) > 0:
                promedio_simple = np.mean(self.datos)
                resultado_promedio = [
                    f"Promedio Simple (N={len(self.datos)})", 
                    None, None, None, 
                    "simple_average", 
                    [round(promedio_simple, 4)] 
                ]
                self.resultados_evaluacion.append(resultado_promedio)
                if verbose:
                    print(f"INFO: Menos de {UMBRAL_DATOS_SUFICIENTES} datos válidos ({len(self.datos)}). Se calculará solo el promedio.")
            else: 
                # Este caso ocurre si todos los datos originales eran NaN/Inf
                resultado_constante = [
                    f"Valor Constante por Defecto (N=0 válidos)",
                    None, None, None, "default_constant", [VALOR_CONSTANTE_POR_DEFECTO_POCOS_DATOS]
                ]
                self.resultados_evaluacion.append(resultado_constante)
                if verbose:
                    print(f"INFO: Cero datos válidos. Se usará el valor constante por defecto: {VALOR_CONSTANTE_POR_DEFECTO_POCOS_DATOS}.")
            return self.resultados_evaluacion

        # Continuar si hay suficientes datos válidos
        if verbose:
            print(f"INFO: Suficientes datos válidos ({len(self.datos)} >= {UMBRAL_DATOS_SUFICIENTES}). Iniciando evaluación de distribuciones.")

        # Calcular histograma base solo con datos válidos
        cuentas_hist_base, bordes_hist_base, centros_hist_base = self.histograma()
        
        # Si todos los datos válidos son iguales, mostrar advertencia
        if verbose and len(self.datos) > 0 and np.max(self.datos) == np.min(self.datos):
            print("ADVERTENCIA: Todos los datos válidos son idénticos, lo cual limita la significancia de los ajustes de distribución.")

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
        
        # Preparar datos normalizados para Beta
        datos_para_beta = self.datos # Ya son los datos filtrados
        min_datos = np.min(datos_para_beta)
        max_datos = np.max(datos_para_beta)
        
        if max_datos > min_datos:
            datos_para_beta = (datos_para_beta - min_datos) / (max_datos - min_datos)
        elif len(datos_para_beta) > 0: # Caso de datos válidos idénticos
            datos_para_beta = np.full_like(datos_para_beta, 0.5)
        
        # Iterar sobre cada distribución para ajustar y evaluar
        for dist_name, nombre_legible in distribuciones_a_evaluar.items():
            # Inicializar variables de resultado para evitar "variable local no asociada"
            D_ks_val, p_ks_val, r2_rounded = np.nan, np.nan, 0.0 
            parametros = None 
            
            try:
                distribucion = getattr(st, dist_name)

                # --- Ajuste de Distribución ---
                current_data_for_fit = None # Datos a usar para el fit de esta distribución

                if dist_name == "beta":
                    # Filtrar datos para que estén estrictamente entre 0 y 1 para beta.fit(floc=0, fscale=1)
                    valid_beta_data = datos_para_beta[(datos_para_beta > 1e-9) & (datos_para_beta < 1 - 1e-9)]
                    if len(valid_beta_data) > 0:
                        current_data_for_fit = valid_beta_data
                        parametros = distribucion.fit(current_data_for_fit, floc=0, fscale=1)
                    elif max_datos == min_datos and len(datos_para_beta) > 0: # Caso de datos válidos idénticos
                         current_data_for_fit = np.array([0.5]) # Usar valor central
                         parametros = distribucion.fit(current_data_for_fit, floc=0, fscale=1)
                    else:
                        if verbose:
                            print(f"INFO: No hay datos válidos para ajustar {nombre_legible} (rango estrictamente 0-1). Saltando.")
                        continue # Saltar esta distribución si no hay datos válidos

                elif dist_name == "poisson":
                    # Validación para Poisson: datos deben ser enteros no negativos y finitos
                    # Usamos 'self.datos' aquí porque es el conjunto de datos válidos ya filtrado.
                    if not (np.all(np.equal(np.mod(self.datos, 1), 0)) and np.all(self.datos >= 0)):
                        if verbose:
                            print(f"ADVERTENCIA: Datos no válidos (no enteros, negativos) para {nombre_legible}. Saltando.")
                        continue 
                    current_data_for_fit = self.datos # Usar los datos válidos si pasan la validación
                    
                    try:
                        parametros = distribucion.fit(current_data_for_fit)
                        if np.isnan(parametros[0]) or np.isinf(parametros[0]):
                            raise ValueError("Parámetro mu (lambda) de Poisson inválido.")
                    except RuntimeError as e: 
                        if verbose:
                            print(f"ERROR de tiempo de ejecución al ajustar {nombre_legible}: {e}. Saltando.")
                        continue
                    except ValueError as e:
                        if verbose:
                            print(f"ERROR de valor al ajustar {nombre_legible}: {e}. Saltando.")
                        continue

                else: # Para otras distribuciones (Normal, Exponencial, etc.)
                    current_data_for_fit = self.datos # Usar los datos válidos
                    parametros = distribucion.fit(current_data_for_fit)
                    if any(np.isnan(p) or np.isinf(p) for p in parametros):
                        raise ValueError("Parámetros de distribución ajustados contienen NaN/Inf.")

                # --- Métricas de Evaluación (R² y KS) ---
                # Solo calcular métricas si tenemos parámetros y datos suficientes
                if parametros is not None and current_data_for_fit is not None and len(current_data_for_fit) > 0:
                    # Calcular R²
                    if dist_name == "poisson":
                        # Usar solo los datos válidos y enteros para R2 de Poisson
                        datos_validos_enteros = current_data_for_fit[np.logical_and(np.isfinite(current_data_for_fit), np.equal(np.mod(current_data_for_fit, 1), 0))]
                        if len(datos_validos_enteros) > 0:
                            min_val_int = int(np.floor(np.min(datos_validos_enteros)))
                            max_val_int = int(np.ceil(np.max(datos_validos_enteros)))
                            
                            if min_val_int == max_val_int: 
                                discrete_points = np.array([min_val_int])
                                bins_discrete = np.array([min_val_int - 0.5, min_val_int + 0.5])
                            else:
                                discrete_points = np.arange(min_val_int, max_val_int + 1)
                                bins_discrete = np.arange(min_val_int - 0.5, max_val_int + 1.5, 1)

                            if len(discrete_points) > 0 and len(bins_discrete) >= 2:
                                observed_counts, _ = np.histogram(datos_validos_enteros, bins=bins_discrete, density=False)
                                observed_proportions = observed_counts / len(datos_validos_enteros)
                                fitted_pmf = distribucion.pmf(discrete_points, *parametros)
                                
                                if len(observed_proportions) == len(fitted_pmf):
                                    r2_rounded = self._calcular_r2(observed_proportions, fitted_pmf)
                                else: r2_rounded = 0.0
                            else: r2_rounded = 0.0
                        else: r2_rounded = 0.0
                    else: # Distribuciones continuas
                        if len(self.datos) >= 2 and max_datos > min_datos and len(centros_hist_base) > 0:
                            pdf_ajustada = distribucion.pdf(centros_hist_base, *parametros)
                            r2_rounded = self._calcular_r2(cuentas_hist_base, pdf_ajustada)
                        else:
                            r2_rounded = 0.0

                    # Calcular Kolmogorov-Smirnov (KS)
                    try:
                        # kstest necesita datos y un nombre de distribución o argumentos
                        # Si los datos son discretos, kstest puede advertir o fallar si no se maneja bien
                        # Aquí intentamos con los datos filtrados válidos.
                        D_ks_val, p_ks_val = st.kstest(current_data_for_fit, dist_name, args=parametros)
                    except Exception as ks_error:
                        if verbose:
                            print(f"ERROR calculando KS para {nombre_legible}: {ks_error}. D y p-valor serán N/A.")
                        D_ks_val, p_ks_val = np.nan, np.nan
                else: # Si no se pudo ajustar o no hay datos suficientes para métricas
                    r2_rounded = 0.0
                    D_ks_val, p_ks_val = np.nan, np.nan

                # --- Almacenar Resultados ---
                param_list_rounded = []
                if parametros is not None:
                    for pv in parametros:
                        if isinstance(pv, (int, float)):
                            param_list_rounded.append(round(pv, 4))
                        else:
                            param_list_rounded.append(pv) 

                ks_str = f"KS: {D_ks_val:.4f} p: {p_ks_val:.4f}" if not np.isnan(D_ks_val) and not np.isnan(p_ks_val) else "KS: N/A"
                r2_str = f"R²: {r2_rounded:.4f}"
                nombre_completo_resumen = f"{nombre_legible} — {ks_str} {r2_str}"
                
                self.resultados_evaluacion.append([
                    nombre_completo_resumen, D_ks_val, p_ks_val, r2_rounded, dist_name, param_list_rounded
                ])

            except ValueError as ve:
                if verbose:
                    print(f"ERROR de valor al ajustar/evaluar {nombre_legible}: {ve}. Saltando.")
            except RuntimeError as re:
                if verbose:
                    print(f"ERROR de tiempo de ejecución al ajustar/evaluar {nombre_legible}: {re}. Saltando.")
            except AttributeError as ae: # Captura el error específico de 'poisson_gen' si persiste
                if verbose:
                    print(f"ERROR de atributo al procesar {nombre_legible}: {ae}. Saltando.")
            except Exception as e: # Captura cualquier otro error inesperado
                if verbose:
                    print(f"ERROR inesperado al procesar {nombre_legible}: {e}. Saltando.")
            
        # Ordenar resultados
        self.resultados_evaluacion.sort(key=lambda x: (
            x[2] if x[2] is not None and not np.isnan(x[2]) else -1, # p-valor
            x[3] if x[3] is not None and not np.isnan(x[3]) else -1  # R2
        ), reverse=True) 

        return self.resultados_evaluacion
    
    def graficar_mejores_ajustes(self, titulo="Comparación de Ajustes de Distribuciones", max_distribuciones=3):
        """
        Grafica los mejores ajustes de distribuciones.
        
        Args:
            titulo (str): Título del gráfico
            max_distribuciones (int): Número máximo de distribuciones a graficar
        """
        if not self.resultados_evaluacion:
            print("No hay resultados para graficar. Ejecute evaluar_distribuciones() primero.")
            return
            
        plt.figure(figsize=(12, 8))
        
        # Usar solo datos finitos para el histograma
        datos_finitos = self.datos[np.isfinite(self.datos)]
        if len(datos_finitos) == 0:
            print("No hay datos finitos para graficar el histograma.")
            return

        # Generar histograma solo si hay suficientes datos para ello (más de un bin)
        if len(datos_finitos) > 1:
            counts, bins, _ = plt.hist(datos_finitos, bins=30, density=True, alpha=0.5, label='Datos Observados')
            bin_centers = (bins[:-1] + bins[1:]) / 2
        else: # Si solo hay un dato finito, crear un histograma trivial
            counts, bin_centers = np.array([1.0]), np.array([datos_finitos[0]])
            bins = np.array([datos_finitos[0]-0.5, datos_finitos[0]+0.5])

        num_dist_to_plot = min(max_distribuciones, len(self.resultados_evaluacion)) 
        for i in range(num_dist_to_plot):
            dist_info = self.resultados_evaluacion[i]
            
            # Extracción segura de información
            dist_name_full = dist_info[0] if len(dist_info) > 0 and isinstance(dist_info[0], str) else "N/A"
            dist_short_name = dist_info[4] if len(dist_info) > 4 and isinstance(dist_info[4], str) else None
            r2_val = dist_info[3] if len(dist_info) > 3 else None 
            params = dist_info[5] if len(dist_info) > 5 and isinstance(dist_info[5], list) else None
            
            # Continuar si la información de la distribución no es válida
            if dist_short_name is None or params is None: 
                continue

            try:
                dist = getattr(st, dist_short_name)
                
                if dist_short_name == "poisson":
                    # Para Poisson, usar solo datos finitos y enteros para las métricas y graficación
                    valid_poisson_data = datos_finitos[np.logical_and(np.isfinite(datos_finitos), np.equal(np.mod(datos_finitos, 1), 0))]
                    if len(valid_poisson_data) == 0: continue

                    min_val_int = int(np.floor(np.min(valid_poisson_data)))
                    max_val_int = int(np.ceil(np.max(valid_poisson_data)))
                    x_vals = np.arange(min_val_int, max_val_int + 1)
                    
                    if len(x_vals) == 0 or len(params) == 0: continue
                    
                    y_vals = dist.pmf(x_vals, *params)
                    plt.plot(x_vals, y_vals, label=f"{dist_name_full} (R²={r2_val:.2f})", linestyle='--')
                else: # Distribuciones continuas
                    if len(bin_centers) == 0 or len(params) == 0: continue
                    pdf_values = dist.pdf(bin_centers, *params)
                    plt.plot(bin_centers, pdf_values, label=f"{dist_name_full} (R²={r2_val:.2f})", linestyle='--')
                    
            except Exception as e:
                print(f"No se pudo graficar {dist_short_name} debido a un error: {e}")

        plt.title(titulo)
        plt.xlabel("Valor")
        plt.ylabel("Densidad")
        plt.legend()
        plt.grid(True)
        plt.show()
    
    @staticmethod
    def generar_dato_aleatorio(nombre_distribucion: str, parametros: list):
        """
        Genera un único dato aleatorio de una distribución dada.
        
        Args:
            nombre_distribucion (str): Nombre de la distribución
            parametros (list): Lista de parámetros de la distribución
            
        Returns:
            float: Valor aleatorio generado
        """
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

        if nombre_distribucion not in distribuciones_generacion:
            raise ValueError(f"Distribución no soportada para generación: '{nombre_distribucion}'.")
        
        if not isinstance(parametros, (list, tuple)):
            raise ValueError("Los parámetros deben ser una lista o tupla.")

        try:
            return distribuciones_generacion[nombre_distribucion](parametros)
        except IndexError:
            raise ValueError(f"Número de parámetros incorrecto para la distribución '{nombre_distribucion}'.")
        except Exception as e:
            raise ValueError(f"Error al generar dato para '{nombre_distribucion}' con parámetros {parametros}: {e}")

    @staticmethod
    def generar_muestras_aleatorias(nombre_distribucion: str, parametros: list, size: int = 1):
        """
        Genera múltiples datos aleatorios (una muestra) de una distribución dada.
        
        Args:
            nombre_distribucion (str): Nombre de la distribución
            parametros (list): Lista de parámetros de la distribución
            size (int): Número de muestras a generar
            
        Returns:
            array: Array de valores aleatorios generados
        """
        if not isinstance(size, int) or size <= 0:
            raise ValueError("El tamaño (size) debe ser un entero positivo mayor que cero.")

        try:
            dist_object = getattr(st, nombre_distribucion)
            dist_rvs_func = dist_object.rvs
        except AttributeError:
              raise ValueError(f"Distribución no soportada o inexistente en scipy.stats: '{nombre_distribucion}'.")
        
        kwargs = {}
        if nombre_distribucion == "norm": kwargs = {'loc': parametros[0], 'scale': parametros[1]}
        elif nombre_distribucion == "expon": kwargs = {'loc': parametros[0], 'scale': parametros[1]}
        elif nombre_distribucion == "gamma": kwargs = {'a': parametros[0], 'loc': parametros[1], 'scale': parametros[2]}
        elif nombre_distribucion == "lognorm": kwargs = {'s': parametros[0], 'loc': parametros[1], 'scale': parametros[2]}
        elif nombre_distribucion == "beta": kwargs = {'a': parametros[0], 'b': parametros[1], 'loc': parametros[2], 'scale': parametros[3]}
        elif nombre_distribucion == "weibull_min": kwargs = {'c': parametros[0], 'loc': parametros[1], 'scale': parametros[2]}
        elif nombre_distribucion == "uniform": kwargs = {'loc': parametros[0], 'scale': parametros[1]}
        elif nombre_distribucion == "poisson": kwargs = {'mu': parametros[0]}
        else:
            raise ValueError(f"Parámetros de generación no definidos para la distribución: '{nombre_distribucion}'.")

        try:
            return dist_rvs_func(size=size, **kwargs)
        except IndexError:
              raise ValueError(f"Número de parámetros incorrecto para la distribución '{nombre_distribucion}'.")
        except Exception as e:
            raise ValueError(f"Error al generar muestras para '{nombre_distribucion}' con parámetros {parametros} y size {size}: {e}")
    
    @staticmethod
    def generar_valor_deterministico(nombre_distribucion: str, parametros: list, criterio: str = "moda"):
        """
        Devuelve un valor determinístico representativo de la distribución indicada.
        - criterio: 'moda' (por defecto), 'media', 'mediana'
        - Usa el mismo convenio de parámetros que generar_dato_aleatorio.

        Retorna:
            float (o int en discretas como Poisson)
        """
        if not isinstance(parametros, (list, tuple)):
            raise ValueError("Los parámetros deben ser una lista o tupla.")

        # Construir la distribución "congelada" (frozen) con el mismo mapeo de params
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
                raise ValueError(f"Distribución no soportada: '{nombre_distribucion}'.")
        except IndexError:
            raise ValueError(f"Número de parámetros incorrecto para la distribución '{nombre_distribucion}'.")

        criterio = str(criterio).lower().strip()
        if criterio not in {"moda", "media", "mediana"}:
            raise ValueError("criterio debe ser 'moda', 'media' o 'mediana'.")

        # Casos media / mediana (directos y determinísticos)
        if criterio == "media":
            return float(dist.mean())
        if criterio == "mediana":
            return float(dist.median())

        # === MODA (valor más probable) ===
        # Discretas vs continuas:
        # - Poisson: modo = floor(mu), salvo el caso mu entero -> {mu-1, mu} (elegimos mu-1 por convención clásica)
        if nombre_distribucion == "poisson":
            mu = parametros[0]
            # Si mu es entero, hay dos modas: mu y mu-1 -> retornamos mu-1
            if abs(mu - round(mu)) < 1e-12 and mu >= 1:
                return int(round(mu) - 1)
            # General
            return int(np.floor(mu))

        # - Uniforme: no tiene moda única; devolvemos el centro del intervalo (igual a la media)
        if nombre_distribucion == "uniform":
            a = parametros[0]
            b = parametros[0] + parametros[1]
            return float((a + b) / 2.0)

        # Para continuas generales:
        # Hallamos el máximo de la pdf en un intervalo robusto (cuantiles internos)
        # Evitamos extremos (inf) y caídas numéricas.
        def _seguro_ppf(d, q, fallback):
            v = d.ppf(q)
            if np.isfinite(v):
                return v
            return fallback

        # Intervalo base usando cuantiles; si dan inf, hacemos fallback a media ± 10*std
        mean = dist.mean()
        std = dist.std()
        lo = _seguro_ppf(dist, 1e-6, mean - 10*(std if np.isfinite(std) and std > 0 else 1.0))
        hi = _seguro_ppf(dist, 1 - 1e-6, mean + 10*(std if np.isfinite(std) and std > 0 else 1.0))

        if not np.isfinite(lo) or not np.isfinite(hi) or lo >= hi:
            # Último fallback: usar un rango razonable alrededor de la media
            lo = mean - 10*(std if np.isfinite(std) and std > 0 else 1.0)
            hi = mean + 10*(std if np.isfinite(std) and std > 0 else 1.0)
            if lo >= hi:
                # Si aún falla, devolvemos la mediana como proxy determinístico
                return float(dist.median())

        # Muestreamos densamente y elegimos el argmax de la pdf
        xs = np.linspace(lo, hi, 1001)
        try:
            ys = dist.pdf(xs)
            idx = int(np.argmax(ys))
            modo = xs[idx]
            if np.isfinite(modo):
                return float(modo)
            else:
                return float(dist.median())
        except Exception:
            # Si la pdf falla por parámetros raros, devolvemos la mediana como valor estable
            return float(dist.median())


# Reproducible
rng = np.random.default_rng(42)

# 1) Normal (media 10, desvío 2)
datos_norm = list(rng.normal(loc=10, scale=2, size=500))

# 2) Exponencial (scale=3)
datos_expon = list(rng.exponential(scale=3.0, size=500))

# 3) Gamma (shape k=2.5, scale=1.5)
datos_gamma = list(rng.gamma(shape=2.5, scale=1.5, size=500))

# 4) Lognormal (sigma=0.6, scale ~ e^1.2)
datos_lognorm = list(np.exp(rng.normal(loc=1.2, scale=0.6, size=500)))

# 5) Beta en [0,1] (a=2, b=5)  -> útil para probar Beta directamente
datos_beta01 = list(rng.beta(a=2.0, b=5.0, size=500))

# 6) Uniforme [20, 35]
datos_uniforme = list(rng.uniform(low=20.0, high=35.0, size=500))

# 7) Weibull_min (c=1.8, scale=2.0)
datos_weibull = list((rng.weibull(a=1.8, size=500)) * 2.0)

# 8) Poisson (mu=7)  -> ¡enteros no negativos!
datos_poisson = list(rng.poisson(lam=7, size=500))

# 9) Mezcla (Normal 70% + Exponencial 30%) -> para ver cómo se comporta
mix = list(np.concatenate([
    rng.normal(loc=5, scale=1.2, size=350),
    rng.exponential(scale=2.0, size=150)
]))

# 10) Con NaN e Inf (para testear tu filtrado)
datos_con_nan_inf = datos_norm[:480] + [np.nan, np.inf, -np.inf] + list(rng.normal(10, 2, size=17))

# 11) Pocos datos (<20) -> debe devolver promedio simple
pocos_datos = [12.0, 11.5, 12.3, 13.1, 10.8, 11.9, 12.2]

# 12) Todos iguales -> histograma trivial, R² limitado
todos_iguales = [7.0] * 100

def probar(nombre, datos, graficar=True, max_distrib=3):
    print(f"\n=== PRUEBA: {nombre} (N={len(datos)}) ===")
    d = Distribuciones(datos)
    res = d.evaluar_distribuciones(verbose=True)
    # Mostrar top 5
    for r in res[:5]:
        nombre_legible, D, p, r2, short, params = r
        print(f"- {nombre_legible}")
        print(f"  dist='{short}', KS(D={D}, p={p}), R²={r2}, params={params}")
    if graficar and len(res) > 0:
        d.graficar_mejores_ajustes(
            titulo=f"Mejores ajustes — {nombre}",
            max_distribuciones=max_distrib
        )

if __name__ == "__main__":
    # Corre lo que necesites (elige algunos para empezar)
    probar("Normal", datos_norm)
    probar("Exponencial", datos_expon)
    probar("Gamma", datos_gamma)
    probar("Lognormal", datos_lognorm)
    probar("Beta[0,1]", datos_beta01)
    probar("Uniforme", datos_uniforme)
    probar("Weibull", datos_weibull)
    probar("Poisson", datos_poisson, graficar=True)  # Poisson usará pmf y bins discretos
    probar("Mezcla Normal+Expon", mix)
    probar("Con NaN/Inf", datos_con_nan_inf)
    probar("Pocos datos (<20)", pocos_datos, graficar=False)
    probar("Todos iguales", todos_iguales, graficar=False)
