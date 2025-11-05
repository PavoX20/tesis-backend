# API Docs — Materias & Receta (v5)

> **Entorno:** local  
> **Base URL:** `http://127.0.0.1:8000`  
> **Auth:** no requerida (dev)

Este documento cubre los endpoints **nuevos/ajustados** para:
- **Materias** (`/materias`)
- **Receta** con **N entradas** y **N salidas** por **proceso** (`/receta/proceso/{id_proceso}`)

---

## Esquema relevante (resumen)

- **materias**: catálogo de insumos y resultados intermedios/finales.
  - `tipo` ∈ `{"materia_prima","materia_procesada","otro"}`
  - `unidad` ∈ `{"M2","PAR","KG","UNIDAD"}`
- **receta**: **una fila por materia** usada o producida por el **proceso**:
  - Campos: `id_receta`, `id_proceso`, `id_materia`, `rol`, `cantidad`
  - `rol` ∈ `{"IN","OUT"}`
  - `cantidad` > 0
  - Un **proceso** puede tener **N entradas** y **N salidas** (no hay restricción de única salida).

---

## Materias

### Modelo (respuesta)
```json
{
  "id_materia": 14,
  "nombre": "Resultado proceso 1",
  "unidad": "UNIDAD",
  "costo": 0.00,
  "tipo": "materia_procesada"
}
```

### POST `/materias`
Crea una materia.

**Body**
```json
{
  "nombre": "Betun",
  "unidad": "UNIDAD",
  "tipo": "materia_prima",
  "costo": 1.5
}
```

**Ejemplo**
```bash
curl -s -X POST http://127.0.0.1:8000/materias \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Betun","unidad":"UNIDAD","tipo":"materia_prima","costo":1.50}'
```

**Respuestas**
- `200 OK`: objeto creado
- `400 Bad Request`: validaciones (unidad/tipo inválidos, costo < 0)

---

### GET `/materias`
Lista materias (paginado simple).

**Query**
- `skip` (int, default 0)
- `limit` (int, default 50)

**Ejemplo**
```bash
curl -s "http://127.0.0.1:8000/materias?limit=50"
```

---

### GET `/materias/{id_materia}`
Obtiene una materia por id.

```bash
curl -s http://127.0.0.1:8000/materias/14
```

**Respuestas**
- `200 OK`
- `404 Not Found`

---

### PUT `/materias/{id_materia}`
Actualiza una materia.

**Body (parcial o total)**
```json
{
  "nombre": "Algodon",
  "unidad": "UNIDAD",
  "tipo": "materia_prima",
  "costo": 0.20
}
```

**Ejemplo**
```bash
curl -s -X PUT http://127.0.0.1:8000/materias/13 \
  -H "Content-Type: application/json" \
  -d '{"costo":0.25}'
```

---

### DELETE `/materias/{id_materia}`
Elimina una materia.

```bash
curl -s -X DELETE http://127.0.0.1:8000/materias/13
```

**Respuestas**
- `200 OK` / `204 No Content` (según implementación)
- `404 Not Found`
- `409 Conflict` (si hay FK en uso; depende de reglas ON DELETE)

---

## Receta (N IN / N OUT por proceso)

> Tabla única `receta`:
> - (proceso, materia, **rol**) con **cantidad**.
> - `rol`: `"IN"` (entrada) o `"OUT"` (salida).  
> - **Un proceso puede tener N entradas** y **N salidas**.

### GET `/receta/proceso/{id_proceso}`
Devuelve las filas de receta del proceso separadas en `entradas` y `salidas`.

**Ejemplo**
```bash
curl -s http://127.0.0.1:8000/receta/proceso/1
```

**Respuesta (ejemplo)**
```json
{
  "entradas": [
    {
      "id_receta": 21,
      "id_proceso": 1,
      "id_materia": 12,
      "rol": "IN",
      "cantidad": 0.5,
      "materia_nombre": "Betun",
      "unidad": "UNIDAD"
    }
  ],
  "salidas": [
    {
      "id_receta": 22,
      "id_proceso": 1,
      "id_materia": 14,
      "rol": "OUT",
      "cantidad": 1.0,
      "materia_nombre": "Resultado proceso 1",
      "unidad": "UNIDAD"
    }
  ]
}
```

---

### PUT `/receta/proceso/{id_proceso}`
**Reemplaza por completo** la receta del proceso indicado (borra lo anterior y crea lo enviado).

**Body**
```json
{
  "entradas": [
    { "id_materia": 12, "cantidad": 0.5 }
  ],
  "salidas": [
    { "id_materia": 14, "cantidad": 1.0 }
  ]
}
```

**Validaciones**
- `cantidad` > 0
- `id_materia` debe existir
- Si envías arrays vacíos, se eliminarán todas las filas de ese rol

**Ejemplos**

1) **Proceso A** produce “Resultado proceso 1” a partir de “Betun”:
```bash
curl -s -X PUT http://127.0.0.1:8000/receta/proceso/{ID_PROCESO_A} \
  -H "Content-Type: application/json" \
  -d '{
    "entradas":[{"id_materia": 12, "cantidad": 0.5}],
    "salidas":[ {"id_materia": 14, "cantidad": 1}]
  }'
```

2) **Proceso B** consume “Resultado proceso 1” + “Algodon” y produce “Resultado proceso 2”:
```bash
# Crear "Resultado proceso 2" si no existe
curl -s -X POST http://127.0.0.1:8000/materias \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Resultado proceso 2","unidad":"UNIDAD","tipo":"materia_procesada","costo":0.00}'

# Supón que devuelve id 15
curl -s -X PUT http://127.0.0.1:8000/receta/proceso/{ID_PROCESO_B} \
  -H "Content-Type: application/json" \
  -d '{
    "entradas":[
      {"id_materia": 14, "cantidad": 1},
      {"id_materia": 13, "cantidad": 0.2}
    ],
    "salidas":[ {"id_materia": 15, "cantidad": 1}]
  }'
```

---

## Endpoints de apoyo (ya existentes/ajustados)

### GET `/diagramas-detalle/{id_catalogo}`
Detalle del diagrama principal y subdiagramas, procesos, dependencias y **recetas** por proceso (en `entradas/salidas`).

```bash
curl -s http://127.0.0.1:8000/diagramas-detalle/1
```

### GET `/procesos-detalle/{id_proceso}`
Devuelve proceso + tipo de máquina + área + (si existe) receta del proceso.

```bash
curl -s http://127.0.0.1:8000/procesos-detalle/1
```

---

## Notas y convenciones

- `tipo` de materia: `materia_prima`, `materia_procesada` u `otro`.
- `unidad` de materia: `M2`, `PAR`, `KG`, `UNIDAD`.
- **Receta**: los endpoints trabajan a nivel de **proceso**.
- La salida de un proceso puede ser usada como **entrada** de otro (encadenamiento).

---

## Ejemplos con IDs reales (de tu entorno)

- **Materias** recién creadas:  
  - Betun → `12`  
  - Algodon → `13`  
  - Resultado proceso 1 → `14`

**Proceso A** (produce Resultado proceso 1 a partir de Betun):
```bash
curl -s -X PUT http://127.0.0.1:8000/receta/proceso/{ID_PROCESO_A} \
  -H "Content-Type: application/json" \
  -d '{
    "entradas":[{"id_materia": 12, "cantidad": 0.5}],
    "salidas":[ {"id_materia": 14, "cantidad": 1}]
  }'
```

**Proceso B** (consume Resultado proceso 1 + Algodon → produce Resultado proceso 2):
```bash
# crear salida (si no existe)
curl -s -X POST http://127.0.0.1:8000/materias \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Resultado proceso 2","unidad":"UNIDAD","tipo":"materia_procesada","costo":0.00}'

# asume id 15 para Resultado proceso 2
curl -s -X PUT http://127.0.0.1:8000/receta/proceso/{ID_PROCESO_B} \
  -H "Content-Type: application/json" \
  -d '{
    "entradas":[
      {"id_materia": 14, "cantidad": 1},
      {"id_materia": 13, "cantidad": 0.2}
    ],
    "salidas":[ {"id_materia": 15, "cantidad": 1}]
  }'
```

---

## Troubleshooting rápido

- **`UndefinedColumn: procesos.id_receta`**: borra `id_receta` del modelo `Proceso` y cualquier referencia en CRUD/routers.
- **ImportError `RecetaDetalle` / `MateriaPrima`**: fueron removidos. Cambia a `Receta` y `Materia`.
- **`module ... has no attribute 'routes'`**: estás pasando un *módulo* a `include_router`. Exporta el objeto `router` en `app/api/routers/__init__.py` y usa esas variables en `main.py`.
