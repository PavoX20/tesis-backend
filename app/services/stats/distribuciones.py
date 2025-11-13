
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats as st
from scipy.stats import norm, expon, gamma, lognorm, beta, weibull_min, poisson, uniform
import pandas as pd

# Nombres legibles en MAYÚSCULAS (sin tildes)
_NOMBRE_LEGIBLE = {
    "norm":        "DISTRIBUCION NORMAL",
    "expon":       "DISTRIBUCION EXPONENCIAL",
    "gamma":       "DISTRIBUCION GAMMA",
    "lognorm":     "DISTRIBUCION LOG-NORMAL",
    "beta":        "DISTRIBUCION BETA",
    "weibull_min": "DISTRIBUCION WEIBULL MINIMA",
    "uniform":     "DISTRIBUCION UNIFORME",
    "poisson":     "DISTRIBUCION POISSON",
    "simple_average": "PROMEDIO SIMPLE",
}

# Alias utiles (por si escribes "expo", "weibull", etc.)
_ALIAS = {
    "expo": "expon",
    "weibull": "weibull_min",
    "weibull_min": "weibull_min",
    "normal": "norm",
    "log-normal": "lognorm",
    "uniforme": "uniform",
    "poisson": "poisson",
    "beta": "beta",
    "gamma": "gamma",
    "norm": "norm",
    "expon": "expon",
    "lognorm": "lognorm",
    "uniform": "uniform",
}

def _normaliza_nombre(nombre: str) -> str:
    n = str(nombre).strip().lower()
    return _ALIAS.get(n, n)

def _is_integer_like(arr, tol=1e-9):
    arr = np.asarray(arr)
    return np.all(np.isfinite(arr)) and np.all(np.abs(arr - np.round(arr)) < tol)

def _build_dist(nombre, p):
    if nombre == "norm":        return st.norm(loc=p[0], scale=p[1])
    if nombre == "expon":       return st.expon(loc=p[0], scale=p[1])
    if nombre == "gamma":       return st.gamma(a=p[0], loc=p[1], scale=p[2])
    if nombre == "lognorm":     return st.lognorm(s=p[0], loc=p[1], scale=p[2])
    if nombre == "beta":        return st.beta(a=p[0], b=p[1], loc=p[2], scale=p[3])
    if nombre == "weibull_min": return st.weibull_min(c=p[0], loc=p[1], scale=p[2])
    if nombre == "uniform":     return st.uniform(loc=p[0], scale=p[1])
    if nombre == "poisson":     return st.poisson(mu=p[0])
    if nombre == "simple_average": return None
    raise ValueError(f"Distribucion no soportada: {nombre}")

def graficar_distribucion(nombre, parametros, ax=None):
    """Grafica SOLO la distribucion indicada (PDF/PMF)."""
    nombre = _normaliza_nombre(nombre)
    d = _build_dist(nombre, parametros)
    if ax is None: _, ax = plt.subplots()

    if nombre == "poisson":
        mu = parametros[0]
        lo = max(0, int(np.floor(mu - 4*np.sqrt(mu))) if mu > 0 else 0)
        hi = int(np.ceil(mu + 4*np.sqrt(mu))) if mu > 0 else int(max(5, mu+10))
        xs = np.arange(lo, hi + 1)
        ax.stem(xs, d.pmf(xs), basefmt=" ", use_line_collection=True)
        ax.set_xlabel("k"); ax.set_ylabel("PMF")
    else:
        lo, hi = d.ppf(1e-4), d.ppf(1-1e-4)
        if not (np.isfinite(lo) and np.isfinite(hi) and lo < hi):
            m, s = d.mean(), d.std()
            s = s if (np.isfinite(s) and s > 0) else 1.0
            lo, hi = m - 6*s, m + 6*s
        xs = np.linspace(lo, hi, 800)
        ax.plot(xs, d.pdf(xs))
        ax.set_xlabel("x"); ax.set_ylabel("PDF")

    ax.grid(True, alpha=0.25)
    ax.set_title(_NOMBRE_LEGIBLE.get(nombre, nombre.upper()))
    return ax


class Distribuciones:
    """Clase base para evaluar y graficar con datos ya cargados."""
    def __init__(self, datos):
        x = np.asarray(datos, dtype=float)
        x = x[np.isfinite(x)]
        if len(x) == 0:
            raise ValueError("Sin datos finitos.")
        self.datos = x
        self.resultados_evaluacion = []

    def _histograma(self):
        x = self.datos
        n = len(x)
        if n == 1 or np.max(x) == np.min(x):
            return np.array([1.0]), np.array([x[0]-0.5, x[0]+0.5]), np.array([x[0]])
        q75, q25 = np.percentile(x, [75, 25])
        iqr = q75 - q25
        if iqr > 1e-6:
            ancho = 2 * iqr / np.cbrt(n)
        else:
            rango = np.max(x) - np.min(x)
            ancho = rango/10 if rango > 1e-6 else 1.0
        ancho = max(ancho, 1e-6)
        bins = int(np.clip(np.ceil((np.max(x)-np.min(x))/ancho), 1, n))
        cuentas, bordes = np.histogram(x, bins=bins, density=True)
        centros = (bordes[:-1] + bordes[1:]) / 2
        return cuentas, bordes, centros

    @staticmethod
    def _aic_bic(dist_obj, params, data):
        if dist_obj.name == "poisson":
            ll = float(np.sum(dist_obj.logpmf(data, *params))); k = 1
        else:
            ll = float(np.sum(dist_obj.logpdf(data, *params))); k = len(params)
        n = len(data)
        return 2*k - 2*ll, k*np.log(n) - 2*ll

    @staticmethod
    def _chi2_poisson(data, mu):
        data = np.asarray(data, dtype=int)
        lo, hi = int(np.min(data)), int(np.max(data))
        vals = np.arange(lo, hi+1)
        obs, _ = np.histogram(data, bins=np.arange(lo-0.5, hi+1.5, 1))
        exp = len(data) * st.poisson(mu).pmf(vals)
        small = exp < 5
        if np.any(small):
            obs = np.array([obs[~small].sum(), obs[small].sum()])
            exp = np.array([exp[~small].sum(), exp[small].sum()])
        exp = np.where(exp <= 1e-12, 1e-12, exp)
        chi2 = float(np.sum((obs - exp)**2 / exp))
        gl = max(len(obs) - 1 - 1, 1)
        p = float(1 - st.chi2.cdf(chi2, df=gl))
        return chi2, p

    @staticmethod
    def _r2(y, yhat):
        y = np.asarray(y, float); yhat = np.asarray(yhat, float)
        m = np.isfinite(y) & np.isfinite(yhat)
        if m.sum() < 2: return 0.0
        y, yhat = y[m], yhat[m]
        ss_res = float(np.sum((y - yhat)**2))
        ss_tot = float(np.sum((y - y.mean())**2))
        return 1.0 if ss_tot == 0 else 1.0 - ss_res/ss_tot

    def evaluar_distribuciones(self):
        """Devuelve lista ordenada por BIC asc, luego p (desc), luego R2 (desc).
        Cada fila: [titulo_con_metricas, Dks, pks, R2, short_name, params]"""
        self.resultados_evaluacion.clear()
        x = self.datos

        # N pequeño → promedio simple
        if len(x) < 20:
            m = round(float(x.mean()), 4)
            self.resultados_evaluacion.append(
                [f"Promedio Simple (N={len(x)})", None, None, None, "simple_average", [m]]
            )
            return self.resultados_evaluacion

        # Histograma para R² de continuas
        cuentas, _, centros = self._histograma()

        # Beta: reescalar a [0,1]
        minx, maxx = np.min(x), np.max(x)
        datos_beta = (x - minx) / (maxx - minx) if maxx > minx else np.array([0.5])
        datos_beta = datos_beta[(datos_beta > 1e-9) & (datos_beta < 1 - 1e-9)]

        nombres = ["norm","expon","gamma","lognorm","beta","weibull_min","uniform","poisson"]
        filas, orden = [], []

        for short in nombres:
            try:
                dist = getattr(st, short)

                # Fit por caso
                if short == "beta":
                    if len(datos_beta) == 0: 
                        continue
                    params = dist.fit(datos_beta, floc=0, fscale=1)
                elif short == "poisson":
                    if not (_is_integer_like(x) and np.all(x >= 0)):
                        continue
                    params = dist.fit(x)
                    if not np.isfinite(params[0]):
                        continue
                else:
                    params = dist.fit(x)
                    if not np.all(np.isfinite(params)):
                        continue

                # Métricas
                aic, bic = self._aic_bic(dist, params, x)
                Dks = Pks = np.nan

                if short == "poisson":
                    xi = x.astype(int)
                    lo, hi = int(xi.min()), int(xi.max())
                    xs = np.arange(lo, hi+1)
                    obs, _ = np.histogram(xi, bins=np.arange(lo-0.5, hi+1.5,1), density=False)
                    prop = obs / len(xi)
                    pmf = dist.pmf(xs, *params)
                    R2 = self._r2(prop, pmf) if len(prop)==len(pmf) else 0.0
                    chi2, pchi = self._chi2_poisson(xi, params[0])
                    titulo = f"Distrubución de Poisson — χ²: {chi2:.2f} p: {pchi:.4f} R²: {R2:.4f}"
                    orden.append((bic, -pchi, -R2))
                    D_out, P_out = None, None  # no aplica KS
                else:
                    pdf = dist.pdf(centros, *params) if len(centros)>0 else np.zeros(1)
                    R2 = self._r2(cuentas, pdf)
                    try:
                        Dks, Pks = st.kstest(x, short, args=params)
                    except:
                        Dks, Pks = np.nan, np.nan
                    # ── Título con métricas (como el tuyo):
                    legible = {
                        "norm":"Distribución Normal",
                        "expon":"Distribución Exponencial",
                        "gamma":"Distribución Gamma",
                        "lognorm":"Distribución Log-Normal",
                        "beta":"Distribución Beta",
                        "weibull_min":"Distribución Weibull mínima",
                        "uniform":"Distribución Uniforme",
                    }[short]
                    titulo = f"{legible} — KS: {float(Dks):.4f} p: {float(Pks):.4f} R²: {R2:.4f}"
                    orden.append((bic, -(Pks if np.isfinite(Pks) else -1), -R2))
                    D_out = float(Dks) if np.isfinite(Dks) else None
                    P_out = float(Pks) if np.isfinite(Pks) else None

                # Guardar fila
                params = [round(float(p),4) for p in params]
                filas.append([titulo, D_out, P_out, float(R2), short, params])

            except:
                continue

        if not orden:
            m = round(float(x.mean()), 4)
            self.resultados_evaluacion.append(["Promedio Simple", None, None, None, "simple_average", [m]])
            return self.resultados_evaluacion

        idx = np.lexsort((np.array(orden)[:,2], np.array(orden)[:,1], np.array(orden)[:,0]))
        self.resultados_evaluacion = [filas[i] for i in idx.tolist()]
        return self.resultados_evaluacion


    # ================== GRAFICAR (usa datos de la clase) ==================
    def graficar_histograma_y_ajuste(self, nombre: str | None = None, ax=None):
        """
        - Si nombre es None -> usa la PRIMERA de evaluar_distribuciones() y sus params.
        - Si nombre es dado  -> usa los params de esa distribucion del ranking; si no existe, hace fit.
        Titulo: SOLO el nombre legible (DISTRIBUCION NORMAL, etc).
        """
        x = self.datos
        if ax is None: _, ax = plt.subplots()

        # Histograma
        if _is_integer_like(x):
            lo, hi = int(x.min()), int(x.max())
            edges = np.arange(lo - 0.5, hi + 1.5, 1)
            ax.hist(x, bins=edges, density=True, alpha=0.4)
        else:
            ax.hist(x, bins="auto", density=True, alpha=0.4)

        # Asegurar ranking
        if not self.resultados_evaluacion:
            self.evaluar_distribuciones()

        # Elegir nombre y parametros
        if nombre is None:
            best = self.resultados_evaluacion[0]
            nombre = best[4]
            parametros = best[5]
        else:
            nombre = _normaliza_nombre(nombre)
            parametros = None
            for fila in self.resultados_evaluacion:
                if fila[4] == nombre:
                    parametros = fila[5]; break
            if parametros is None:
                # respaldo: fit rapido
                if nombre == "beta":
                    xmin, xmax = x.min(), x.max()
                    if xmax <= xmin:
                        raise ValueError("No se puede ajustar beta (datos constantes).")
                    y = (x - xmin) / (xmax - xmin)
                    y = y[(y > 1e-9) & (y < 1 - 1e-9)]
                    if len(y) == 0:
                        raise ValueError("Beta: datos degenerados para reescalado.")
                    a, b, _, _ = st.beta.fit(y, floc=0, fscale=1)
                    parametros = [float(a), float(b), 0.0, 1.0]
                elif nombre == "poisson":
                    if not (_is_integer_like(x) and np.all(x >= 0)):
                        raise ValueError("Poisson requiere enteros ≥ 0.")
                    mu, = st.poisson.fit(x)
                    parametros = [float(mu)]
                else:
                    pars = getattr(st, nombre).fit(x)
                    parametros = [float(p) for p in pars]

        # Dibujar curva/pmf
        if nombre == "beta":
            # mapear a escala original
            xmin, xmax = x.min(), x.max()
            r = max(xmax - xmin, 1.0)
            xs = np.linspace(xmin - 0.05*r, xmax + 0.05*r, 800)
            ys = np.zeros_like(xs)
            m = (xs >= xmin) & (xs <= xmax)
            ys[m] = st.beta(a=parametros[0], b=parametros[1], loc=0, scale=1).pdf(
                (xs[m]-xmin)/(xmax-xmin)
            ) / (xmax - xmin)
            ax.plot(xs, ys)
        else:
            d = _build_dist(nombre, parametros)
            if d is None:
                media = parametros[0]
                ax.axvline(media, linestyle="--")
                ax.set_title(_NOMBRE_LEGIBLE["simple_average"])
                ax.grid(True, alpha=0.25)
                return ax
            if nombre == "poisson":
                mu = parametros[0]
                lo = max(0, int(np.floor(mu - 4*np.sqrt(mu))) if mu > 0 else 0)
                hi = int(np.ceil(mu + 4*np.sqrt(mu))) if mu > 0 else int(max(5, mu+10))
                xs = np.arange(lo, hi + 1)
                ax.stem(xs, d.pmf(xs), basefmt=" ", use_line_collection=True)
                ax.set_xlabel("k"); ax.set_ylabel("PMF")
            else:
                lo, hi = d.ppf(1e-4), d.ppf(1-1e-4)
                if not (np.isfinite(lo) and np.isfinite(hi) and lo < hi):
                    m, s = d.mean(), d.std()
                    s = s if (np.isfinite(s) and s > 0) else 1.0
                    lo, hi = m - 6*s, m + 6*s
                xs = np.linspace(lo, hi, 800)
                ax.plot(xs, d.pdf(xs))
                ax.set_xlabel("x"); ax.set_ylabel("PDF")

        # Titulo SOLO con el nombre legible
        ax.set_title(_NOMBRE_LEGIBLE.get(nombre, nombre.upper()))
        ax.grid(True, alpha=0.25)
        return ax


# ------------------ DEMO RAPIDA ------------------
# 

# if __name__ == "__main__":
#     rng = np.random.default_rng(123)
#     datos = rng.normal(10, 2, 300)

#     rng = [2,2,2,2,22,3,3,3,3,3,3,5,5,5,5,5,5,2,2,2,2,22,1,3,3,3,3,3,3,5,5,5,5,5,5]
#     d = Distribuciones(datos)

#     x = d.evaluar_distribuciones()

#     df = pd.DataFrame(x, columns=["TITULO","KS","P","R2","DISTR","PARAMETROS"])
#     print(df)

#     # mayores a 20
#     d.graficar_histograma_y_ajuste()
#     plt.show()

#     d.graficar_histograma_y_ajuste("expon")
#     plt.show()

#     # menores a 20
#     graficar_distribucion("norm", [10.0, 2.0])
#     plt.show()
