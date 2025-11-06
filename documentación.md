# API Docs — Materias, Receta, Áreas y Tipos de Máquinas (v6)

> **Entorno:** local  
> **Base URL:** `http://127.0.0.1:8000`  
> **Auth:** no requerida (dev)

Este documento extiende la versión v5. Agrega **Áreas**, **Tipos de Máquinas** y la asignación de **máquina por proceso**.

---

## Esquema relevante (resumen)

- **materias**: catálogo de insumos y resultados intermedios/finales.  
  - `tipo` ∈ `{"materia_prima","materia_procesada","otro"}`  
  - `unidad` ∈ `{"M2","PAR","KG","UNIDAD"}`
- **receta**: **una fila por materia** usada o producida por el **proceso**:  
  - Campos: `id_receta`, `id_proceso`, `id_materia`, `rol`, `cantidad`  
  - `rol` ∈ `{"IN","OUT"}`  
  - `cantidad` > 0  
  - Un **proceso** puede tener **N entradas** y **N salidas**.
- **areas**: catálogo de áreas de trabajo.  
  - `tipo` ∈ `{"CORTE","COSTURA","ENSAMBLE","OTRO"}`
- **tipos_maquinas**: tipos de máquina, cada uno asociado opcionalmente a un `id_area`.
- **procesos**: puede referenciar una máquina vía `id_tipomaquina` (nullable).

> **Duplicidad de nombres por área**: Se **permite** que exista, por ejemplo, `PRENSA` en `área 1` y en `área 2`. Para evitar duplicados **dentro de la misma área** se sugiere este índice opcional:
```sql
CREATE UNIQUE INDEX IF NOT EXISTS uq_tm_nombre_area
ON public.tipos_maquinas (LOWER(nombre_maquina), id_area);
```

> **Nota sobre rutas con slash**: Las rutas aquí listadas usan **barra final**. Llama, por ejemplo, `/areas/` y `/tipos-maquinas/?area_id=4`.

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
- `200 OK`: objeto creado (según implementación actual)
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
> - `rol`: `"IN"` (entrada) o `"OUT"` (salida)  
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

## Áreas

### GET `/areas/`
Lista áreas.

```bash
curl -s "http://127.0.0.1:8000/areas/"
```

### GET `/areas/{id_area}`
Obtiene un área por id.

```bash
curl -s "http://127.0.0.1:8000/areas/7"
```

### POST `/areas/`  → `201 Created`
Crea un área.

**Body**
```json
{ "nombre":"MASTER", "tipo":"ENSAMBLE", "personal":10, "restriccion":"MIXTO" }
```

```bash
curl -si -X POST http://127.0.0.1:8000/areas/ \
  -H "Content-Type: application/json" \
  -d '{"nombre":"TEST_AREA","tipo":"OTRO","personal":0,"restriccion":"MIXTO"}'
```

### PUT `/areas/{id_area}`
Actualiza un área.

```bash
curl -si -X PUT http://127.0.0.1:8000/areas/7 \
  -H "Content-Type: application/json" \
  -d '{"personal":12}'
```

### DELETE `/areas/{id_area}`  → `204 No Content`
Elimina un área.

```bash
curl -si -X DELETE http://127.0.0.1:8000/areas/7
```

---

## Tipos de Máquinas

### GET `/tipos-maquinas/`
Lista tipos de máquinas. Filtro opcional por área: `?area_id={id_area}`.

```bash
# Todos
curl -s "http://127.0.0.1:8000/tipos-maquinas/"

# Por área
curl -s "http://127.0.0.1:8000/tipos-maquinas/?area_id=4"
```

### GET `/tipos-maquinas/{id_tipomaquina}`
Obtiene un tipo de máquina por id.

```bash
curl -s "http://127.0.0.1:8000/tipos-maquinas/9"
```

### POST `/tipos-maquinas/`  → `201 Created`
Crea un tipo de máquina.

**Body**
```json
{
  "nombre_maquina": "PRENSA",
  "cantidad_maquinas": 1,
  "personal_max": 2,
  "id_area": 4
}
```

```bash
curl -si -X POST http://127.0.0.1:8000/tipos-maquinas/ \
  -H "Content-Type: application/json" \
  -d '{"nombre_maquina":"PRENSA","cantidad_maquinas":1,"personal_max":2,"id_area":4}'
```

**Errores comunes**
- `400 Bad Request`: `id_area` inválido (no existe).

### PUT `/tipos-maquinas/{id_tipomaquina}`
Actualiza un tipo de máquina. Solo se modifican campos enviados.

```bash
curl -si -X PUT http://127.0.0.1:8000/tipos-maquinas/16 \
  -H "Content-Type: application/json" \
  -d '{"personal_max":2}'
```

### DELETE `/tipos-maquinas/{id_tipomaquina}` → `204 No Content`
Elimina un tipo de máquina.

```bash
curl -si -X DELETE http://127.0.0.1:8000/tipos-maquinas/16
```

---

## Asignar máquina a un proceso

### PATCH `/procesos/{id_proceso}/maquina`
Asigna o desasigna `id_tipomaquina` al proceso.

**Body**
```json
{ "id_tipomaquina": 16 }   // usar null para desasignar
```

```bash
# Asignar
curl -si -X PATCH http://127.0.0.1:8000/procesos/10/maquina \
  -H "Content-Type: application/json" \
  -d '{"id_tipomaquina": 16}'

# Desasignar
curl -si -X PATCH http://127.0.0.1:8000/procesos/10/maquina \
  -H "Content-Type: application/json" \
  -d '{"id_tipomaquina": null}'
```

**Respuestas**
- `200 OK`: proceso actualizado
- `400 Bad Request`: `id_tipomaquina` inválido
- `404 Not Found`: proceso no existe

---

## Endpoints de apoyo

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

## Troubleshooting rápido

- `307 Temporary Redirect`: Llama con barra final, ej. `/tipos-maquinas/` o usa `-L`.  
- `422 Unprocessable Entity`: placeholders como `{ID_TM}` deben ser **enteros reales**.  
- `400 Bad Request` en `POST /tipos-maquinas/`: verifica que `id_area` exista.  
- `409 Conflict` al crear tipo de máquina: si activas el índice de unicidad por (nombre, área) y envías un duplicado en la **misma** área.
