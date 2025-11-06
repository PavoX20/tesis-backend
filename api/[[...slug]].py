# api/[[...slug]].py
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

try:
    # si tu instancia está en app/main.py
    from main import app
except ModuleNotFoundError:
    # fallback si la instancia está en main.py (raíz)
    from main import app