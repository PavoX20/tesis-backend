# 🧩 Process Optimizer API — Documentación

API desarrollada con **FastAPI + SQLModel** para administrar catálogos, áreas, procesos, máquinas, diagramas y recetas de producción.

Base URL local:
```
http://127.0.0.1:8000
```

---

## 🧭 Rutas globales

### 🩵 Estado de la API
```bash
curl http://127.0.0.1:8000/
```
**Respuesta**
```json
{"status": "ok"}
```

---

## 📦 Catálogo (`/catalogo`)

### Obtener todos los catálogos
```bash
curl http://127.0.0.1:8000/catalogo/
```

### Obtener catálogo por ID
```bash
curl http://127.0.0.1:8000/catalogo/1
```

### Crear un nuevo catálogo
```bash
curl -X POST http://127.0.0.1:8000/catalogo/ -H "Content-Type: application/json" -d '{
  "nombre": "AIRFLOW",
  "descripcion": "Deportivo Casual",
  "genero": "MIXTO",
  "restriccion": "DEPORTIVO",
  "precio": 49.99
}'
```

### Actualizar catálogo
```bash
curl -X PUT http://127.0.0.1:8000/catalogo/1 -H "Content-Type: application/json" -d '{"precio": 59.99}'
```

### Eliminar catálogo
```bash
curl -X DELETE http://127.0.0.1:8000/catalogo/1
```

---

## ⚙️ Áreas (`/areas`)

### Obtener todas las áreas
```bash
curl http://127.0.0.1:8000/areas/
```

### Crear área
```bash
curl -X POST http://127.0.0.1:8000/areas/ -H "Content-Type: application/json" -d '{
  "nombre": "CORTE",
  "tipo": "CORTE",
  "personal": 8,
  "restriccion": "MIXTO"
}'
```

---

## 🧱 Tipos de Máquinas (`/tipos-maquinas`)

### Obtener tipos de máquinas
```bash
curl http://127.0.0.1:8000/tipos-maquinas/
```

### Crear tipo de máquina
```bash
curl -X POST http://127.0.0.1:8000/tipos-maquinas/ -H "Content-Type: application/json" -d '{
  "nombre_maquina": "Máquina de Corte",
  "cantidad_maquinas": 3,
  "personal_max": 8,
  "id_area": 1
}'
```

---

## ⚗️ Materias Primas (`/materias-primas`)

### Obtener materias primas
```bash
curl http://127.0.0.1:8000/materias-primas/
```

### Crear materia prima
```bash
curl -X POST http://127.0.0.1:8000/materias-primas/ -H "Content-Type: application/json" -d '{
  "nombre": "Cuero Natural",
  "unidad": "M2",
  "costo": 10.5,
  "tipo": "MP"
}'
```

---

## 🔁 Procesos (`/procesos`)

### Obtener todos los procesos
```bash
curl http://127.0.0.1:8000/procesos/
```

### Crear proceso
```bash
curl -X POST http://127.0.0.1:8000/procesos/ -H "Content-Type: application/json" -d '{
  "nombre_proceso": "CORTE",
  "distribucion": "norm",
  "parametros": "[2.5, 0.7]",
  "id_tipomaquina": 1
}'
```

### Actualizar proceso
```bash
curl -X PUT http://127.0.0.1:8000/procesos/1 -H "Content-Type: application/json" -d '{"distribucion": "weibull_min"}'
```

### Eliminar proceso
```bash
curl -X DELETE http://127.0.0.1:8000/procesos/1
```

---

## 🧬 Recetas (`/recetas`)

### Obtener recetas
```bash
curl http://127.0.0.1:8000/recetas/
```

### Crear receta
```bash
curl -X POST http://127.0.0.1:8000/recetas/ -H "Content-Type: application/json" -d '{
  "id_proceso": 1,
  "id_materia_entrada": 1,
  "cantidad_entrada": 5.0,
  "id_materia_salida": 2,
  "cantidad_salida": 5.0
}'
```

---

## 🧩 Diagramas (`/diagramas`)

### Obtener diagramas
```bash
curl http://127.0.0.1:8000/diagramas/
```

### Crear diagrama
```bash
curl -X POST http://127.0.0.1:8000/diagramas/ -H "Content-Type: application/json" -d '{
  "nombre": "Diagrama AIRFLOW",
  "descripcion": "Flujo de procesos de AIRFLOW",
  "id_catalogo": 1
}'
```

---

## 🔗 Relación Diagrama–Proceso (`/diagrama-proceso`)

### Obtener relaciones
```bash
curl http://127.0.0.1:8000/diagrama-proceso/
```

### Crear relación
```bash
curl -X POST http://127.0.0.1:8000/diagrama-proceso/ -H "Content-Type: application/json" -d '{
  "id_diagrama": 1,
  "id_proceso": 1,
  "orden": 1
}'
```

---

## 🧠 Diagrama Detalle (`/diagramas-detalle`)

Devuelve la información completa de un producto, su diagrama y los procesos asociados.

### Obtener detalle por ID de catálogo
```bash
curl http://127.0.0.1:8000/diagramas-detalle/1
```

**Respuesta ejemplo**
```json
{
  "catalogo": {"id_catalogo":1,"nombre":"AIRFLOW","genero":"MIXTO","restriccion":"DEPORTIVO","descripcion":"Deportivo Casual"},
  "diagrama": {"id_diagrama":1,"nombre":"Diagrama 1","descripcion":"Deportivo Casual"},
  "procesos": [
    {"orden":1,"id_proceso":1,"nombre_proceso":"CORTAR","distribucion":"norm","parametros":"[2.5, 0.7]"},
    {"orden":2,"id_proceso":2,"nombre_proceso":"COSER","distribucion":"weibull_min","parametros":"[1.6, 0.9,1]"}
  ]
}
```

---

## ⚙️ Proceso Detalle (`/procesos-detalle`)

Devuelve todo sobre un proceso: máquina, área, receta.

### Obtener detalle de proceso
```bash
curl http://127.0.0.1:8000/procesos-detalle/1
```

**Respuesta ejemplo**
```json
{
  "proceso": {
    "id_proceso": 1,
    "nombre_proceso": "CORTE",
    "distribucion": "norm",
    "parametros": "[2.5, 0.7]",
    "duracion": null
  },
  "tipo_maquina": null,
  "area": null,
  "receta": {
    "id_receta": 1,
    "materia_entrada": "CUERO",
    "cantidad_entrada": 10.0,
    "materia_salida": "CUERO SINTETETICO",
    "cantidad_salida": 10.0
  }
}
```

---

## 🧾 Autores
- **Desarrollador:** [Tu nombre]
- **Backend:** FastAPI + SQLModel
- **Base de datos:** PostgreSQL (Supabase)
