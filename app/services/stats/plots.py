# app/services/stats/plots.py
from io import BytesIO
import matplotlib
matplotlib.use("Agg")  # backend sin GUI
import matplotlib.pyplot as plt

def ax_to_png_bytes(ax) -> bytes:
    buf = BytesIO()
    fig = ax.get_figure() if ax.get_figure() else plt.gcf()
    fig.tight_layout()
    fig.savefig(buf, format="png", dpi=120, bbox_inches="tight")
    plt.close(fig)
    return buf.getvalue()