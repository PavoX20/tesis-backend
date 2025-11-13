# app/services/stats/selector.py
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import beta
from typing import List, Optional

# Importamos del módulo original (sí, se puede importar nombres con _)
from app.services.stats.distribuciones import (
    Distribuciones,
    _normaliza_nombre,
    _build_dist,
    _is_integer_like,
    _NOMBRE_LEGIBLE,
)

# ---- Especificación de parámetros para modo manual ----
_PARAM_SPECS = {
    "norm": ["media", "desviacion"],
    "expon": ["loc", "scale"],
    "gamma": ["a", "loc", "scale"],
    "lognorm": ["s", "loc", "scale"],
    "beta": ["a", "b", "loc", "scale"],
    "weibull_min": ["c", "loc", "scale"],
    "uniform": ["loc", "scale"],
    "poisson": ["mu"],
}

def parametros_requeridos(nombre: str) -> List[str]:
    """Lista de parámetros esperados para la distribución indicada."""
    nombre = _normaliza_nombre(nombre)
    if nombre not in _PARAM_SPECS:
        raise ValueError(f"Distribucion no soportada: {nombre}")
    return list(_PARAM_SPECS[nombre])

def seleccionar_y_graficar(
    datos,
    nombre: Optional[str] = None,
    parametros: Optional[List[float]] = None,
    umbral: int = 20,
    ax=None,
):
    """
    - Si len(datos) >= umbral: ajuste automático y grafica la mejor distribución.
    - Si len(datos) <  umbral:
        * Si faltan 'nombre' o 'parametros' -> ValueError indicando parámetros requeridos.
        * Si se proveen -> grafica histograma + distribución elegida.
    Devuelve: dict con modo, seleccion, parametros, ranking|None, ax, mensaje.
    """
    x = np.asarray(datos, dtype=float)
    x = x[np.isfinite(x)]
    if len(x) == 0:
        raise ValueError("Sin datos finitos.")

    # ----- AUTO -----
    if len(x) >= umbral:
        d = Distribuciones(x)
        ranking = d.evaluar_distribuciones()
        if not ranking:
            if ax is None:
                _, ax = plt.subplots()
            media = float(np.mean(x))
            ax.hist(x, bins="auto", density=True, alpha=0.4)
            ax.axvline(media, linestyle="--")
            ax.set_title(_NOMBRE_LEGIBLE["simple_average"])
            ax.grid(True, alpha=0.25)
            return {
                "modo": "auto",
                "seleccion": "simple_average",
                "parametros": [round(media, 4)],
                "ranking": [],
                "ax": ax,
                "mensaje": "N menor al requerido; se usó Promedio Simple.",
            }
        best = ranking[0]
        sel_nombre, sel_params = best[4], best[5]
        ax = d.graficar_histograma_y_ajuste(sel_nombre, ax=ax)
        return {
            "modo": "auto",
            "seleccion": sel_nombre,
            "parametros": sel_params,
            "ranking": ranking,
            "ax": ax,
            "mensaje": f"Selección automática con umbral={umbral}.",
        }

    # ----- MANUAL -----
    if nombre is None or parametros is None:
        if nombre is None:
            raise ValueError(f"Datos insuficientes (N<{umbral}). Debe indicar la distribución y sus parámetros.")
        req = parametros_requeridos(nombre)
        raise ValueError(
            f"Datos insuficientes (N<{umbral}). Para '{_normaliza_nombre(nombre)}' ingrese: {', '.join(req)}"
        )

    nombre = _normaliza_nombre(nombre)
    req = parametros_requeridos(nombre)
    if len(parametros) != len(req):
        raise ValueError(f"Número de parámetros inválido para '{nombre}'. Se esperan {len(req)}: {', '.join(req)}.")

    if ax is None:
        _, ax = plt.subplots()

    # Histograma
    if _is_integer_like(x):
        lo, hi = int(np.min(x)), int(np.max(x))
        edges = np.arange(lo - 0.5, hi + 1.5, 1)
        ax.hist(x, bins=edges, density=True, alpha=0.4)
    else:
        ax.hist(x, bins="auto", density=True, alpha=0.4)

    # Curva/PMF manual
    if nombre == "beta":
        a, b, loc, scale = parametros
        xs = np.linspace(loc - 0.05 * scale, loc + 1.05 * scale, 800)
        ys = beta(a=a, b=b, loc=loc, scale=scale).pdf(xs)
        ax.plot(xs, ys)
    else:
        dist = _build_dist(nombre, parametros)
        if nombre == "poisson":
            mu = parametros[0]
            lo = max(0, int(np.floor(mu - 4 * np.sqrt(mu))) if mu > 0 else 0)
            hi = int(np.ceil(mu + 4 * np.sqrt(mu))) if mu > 0 else int(max(5, mu + 10))
            xs = np.arange(lo, hi + 1)
            ax.stem(xs, dist.pmf(xs), basefmt=" ", use_line_collection=True)
            ax.set_xlabel("k"); ax.set_ylabel("PMF")
        elif dist is None:
            media = float(np.mean(x))
            ax.axvline(media, linestyle="--")
        else:
            lo, hi = dist.ppf(1e-4), dist.ppf(1 - 1e-4)
            if not (np.isfinite(lo) and np.isfinite(hi) and lo < hi):
                m, s = dist.mean(), dist.std()
                s = s if (np.isfinite(s) and s > 0) else 1.0
                lo, hi = m - 6 * s, m + 6 * s
            xs = np.linspace(lo, hi, 800)
            ax.plot(xs, dist.pdf(xs))
            ax.set_xlabel("x"); ax.set_ylabel("PDF")

    ax.set_title(_NOMBRE_LEGIBLE.get(nombre, nombre.upper()))
    ax.grid(True, alpha=0.25)

    return {
        "modo": "manual",
        "seleccion": nombre,
        "parametros": [float(p) for p in parametros],
        "ranking": None,
        "ax": ax,
        "mensaje": f"Selección manual con N<{umbral}.",
    }