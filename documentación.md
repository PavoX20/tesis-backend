# API Docs — v6.1 (Materias, Receta, Áreas, Tipos de Máquinas, Procesos, Dependencias)

**Entorno:** local  
**Base URL:** `http://127.0.0.1:8000`  
**Auth:** no requerida (dev)

Esta versión agrega:
- Campo `tipo` en **procesos** con valores `NORMAL` | `ALMACENAMIENTO`.
- Endpoint de **lookup de procesos** para combos con filtros por artículo (catálogo), diagrama, exclusiones y tipo.
- Endpoints para **dependencias** con operación para **reemplazar predecesores** de un proceso.

---

## Esquema de BD (resumen de cambios relevantes)

- `procesos.tipo` (`VARCHAR`) con check lógico en la API: `{"NORMAL","ALMACENAMIENTO"}`. Default `NORMAL`.
- `procesos_dependencias` con PK compuesta `(id_origen, id_destino)`.

> Si necesitas el DDL completo de la versión 6 ya aplicada, avisa y lo incluyo en un archivo `.sql` aparte.

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
```bash
curl -s -X POST http://127.0.0.1:8000/materias \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Betun","unidad":"UNIDAD","tipo":"materia_prima","costo":1.50}'
```

### GET `/materias`
Lista materias (paginado simple).
```bash
curl -s "http://127.0.0.1:8000/materias?skip=0&limit=50"
```

### GET `/materias/{id_materia}`
```bash
curl -s http://127.0.0.1:8000/materias/14
```

### PUT `/materias/{id_materia}`
```bash
curl -s -X PUT http://127.0.0.1:8000/materias/13 \
  -H "Content-Type: application/json" \
  -d '{"costo":0.25}'
```

### DELETE `/materias/{id_materia}`
```bash
curl -s -X DELETE http://127.0.0.1:8000/materias/13
```

---

## Receta (N IN / N OUT por proceso)

Tabla única `receta` con `rol` ∈ `{"IN","OUT"}` y `cantidad` > 0.

### GET `/receta/proceso/{id_proceso}`
```bash
curl -s http://127.0.0.1:8000/receta/proceso/1
```

### PUT `/receta/proceso/{id_proceso}`
Reemplaza por completo entradas y salidas del proceso.
```bash
curl -s -X PUT http://127.0.0.1:8000/receta/proceso/1 \
  -H "Content-Type: application/json" \
  -d '{
    "entradas":[{"id_materia":12,"cantidad":0.5}],
    "salidas":[{"id_materia":14,"cantidad":1.0}]
  }'
```

---

## Áreas

### GET `/areas/`
```bash
curl -s "http://127.0.0.1:8000/areas/"
```

### GET `/areas/{id_area}`
```bash
curl -s "http://127.0.0.1:8000/areas/7"
```

### POST `/areas/`  → `201 Created`
```bash
curl -si -X POST http://127.0.0.1:8000/areas/ \
  -H "Content-Type: application/json" \
  -d '{"nombre":"TEST_AREA","tipo":"OTRO","personal":0,"restriccion":"MIXTO"}'
```

### PUT `/areas/{id_area}`
```bash
curl -si -X PUT http://127.0.0.1:8000/areas/7 \
  -H "Content-Type: application/json" \
  -d '{"personal":12}'
```

### DELETE `/areas/{id_area}`  → `204 No Content`
```bash
curl -si -X DELETE http://127.0.0.1:8000/areas/7
```

---

## Tipos de Máquinas

### GET `/tipos-maquinas/`
Filtro opcional por `?area_id=`.
```bash
curl -s "http://127.0.0.1:8000/tipos-maquinas/"
curl -s "http://127.0.0.1:8000/tipos-maquinas/?area_id=4"
```

### GET `/tipos-maquinas/{id_tipomaquina}`
```bash
curl -s "http://127.0.0.1:8000/tipos-maquinas/9"
```

### POST `/tipos-maquinas/`  → `201 Created`
```bash
curl -si -X POST http://127.0.0.1:8000/tipos-maquinas/ \
  -H "Content-Type: application/json" \
  -d '{"nombre_maquina":"PRENSA","cantidad_maquinas":1,"personal_max":2,"id_area":4}'
```

### PUT `/tipos-maquinas/{id_tipomaquina}`
```bash
curl -si -X PUT http://127.0.0.1:8000/tipos-maquinas/16 \
  -H "Content-Type: application/json" \
  -d '{"personal_max":2}'
```

### DELETE `/tipos-maquinas/{id_tipomaquina}` → `204 No Content`
```bash
curl -si -X DELETE http://127.0.0.1:8000/tipos-maquinas/16
```

---

## Procesos

### Modelo (resumen)
- `tipo`: `NORMAL` | `ALMACENAMIENTO` (default `NORMAL`).
- `distribucion`: `norm | weibull_min | expon | lognorm | gamma` (opcional).
- `id_tipomaquina`: nullable.
- `orden`: entero ≥ 1.

### POST `/procesos/`
Crea un proceso dentro de un diagrama. Si no envías `orden` válido, se inserta al final y recalcula.
```bash
curl -s -X POST http://127.0.0.1:8000/procesos/ \
  -H "Content-Type: application/json" \
  -d '{
    "nombre_proceso":"COSER PIEZAS",
    "tipo":"NORMAL",
    "distribucion":"weibull_min",
    "parametros":"[1.6,0.9,1]",
    "id_diagrama":6,
    "orden":2
  }'
```

### GET `/procesos/{id_diagrama}`
Lista procesos del diagrama, ordenados por `orden`.
```bash
curl -s "http://127.0.0.1:8000/procesos/6"
```

### PUT `/procesos/{id_proceso}`
Actualiza campos del proceso (nombre, tipo, distribución, etc.).

### PATCH `/procesos/{id_proceso}/maquina`  → response `Proceso`
Asigna o desasigna `id_tipomaquina`.
```bash
curl -si -X PATCH http://127.0.0.1:8000/procesos/10/maquina \
  -H "Content-Type: application/json" \
  -d '{"id_tipomaquina":16}'
```

### GET `/procesos/lookup`
Devuelve una lista compacta para combos y búsquedas.

**Query params**
- `q`: texto a buscar por nombre.
- `diagrama_id`: filtra por un diagrama específico.
- `catalogo_id`: filtra por un artículo (catálogo). Úsalo para listar solo procesos del **mismo artículo**.
- `exclude_id`: excluye un proceso concreto (p. ej. el proceso actual).
- `tipo`: `NORMAL` | `ALMACENAMIENTO`.
- `skip`, `limit`: paginación.

**Ejemplos**
```bash
# Paginado base
curl -s "http://127.0.0.1:8000/procesos/lookup?skip=0&limit=20"

# Solo procesos del diagrama 6
curl -s "http://127.0.0.1:8000/procesos/lookup?diagrama_id=6&limit=50"

# Solo procesos del mismo artículo (catálogo) 5 y excluyendo el 10
curl -s "http://127.0.0.1:8000/procesos/lookup?catalogo_id=5&exclude_id=10&limit=50"

# Búsqueda por nombre
curl -s "http://127.0.0.1:8000/procesos/lookup?q=coser&limit=20"

# Solo tipo ALMACENAMIENTO
curl -s "http://127.0.0.1:8000/procesos/lookup?tipo=ALMACENAMIENTO&limit=50"
```

**Respuesta (ejemplo)**
```json
[
  {
    "id_proceso": 10,
    "nombre_proceso": "COSER PIEZAS",
    "orden": 2,
    "id_diagrama": 6,
    "tipo": "NORMAL",
    "diagrama_nombre": "Diagrama ZAPATO NOVA",
    "catalogo_id": 5
  }
]
```

---

## Dependencias

### Conceptos
- **Predecesores** de P: procesos que deben completarse antes de P. Representan aristas `predecesor -> P`.
- **Sucesores** de P: procesos a los que P apunta. Aristas `P -> sucesor`.
- Por defecto, se exigen dependencias **dentro del mismo diagrama**. Puedes desactivar la restricción vía `?exigir_mismo_diagrama=false` para permitir dependencias entre **diagramas del mismo artículo**.
- La API evita ciclos directos obvios y referencias inexistentes.

### GET `/dependencias/procesos/{id_proceso}`
Lista predecesores y sucesores del proceso.
```bash
curl -s "http://127.0.0.1:8000/dependencias/procesos/10"
```
**Respuesta (ejemplo)**
```json
{
  "predecesores": [
    { "id_proceso": 12, "nombre_proceso": "CORTAR SUELA", "orden": 1, "id_diagrama": 7 },
    { "id_proceso": 11, "nombre_proceso": "ENSAMBLAR ZAPATO", "orden": 3, "id_diagrama": 6 }
  ],
  "sucesores": []
}
```

### PUT `/dependencias/procesos/{id_proceso}`  → `204 No Content`
**Reemplaza todos los predecesores** del proceso dado por la lista enviada.
```bash
# Reemplaza predecesores de 10 por [11,12]
curl -si -X PUT "http://127.0.0.1:8000/dependencias/procesos/10?exigir_mismo_diagrama=false" \
  -H "Content-Type: application/json" \
  -d '{"predecesores":[11,12]}'
```
Verifica:
```bash
curl -s "http://127.0.0.1:8000/dependencias/procesos/10"
```

### POST `/dependencias/`
Crea una arista puntual `id_origen -> id_destino`. Útil para pruebas rápidas.
```bash
curl -s -X POST "http://127.0.0.1:8000/dependencias/?exigir_mismo_diagrama=true" \
  -H "Content-Type: application/json" \
  -d '{"id_origen":10,"id_destino":11}'
```

### DELETE `/dependencias/`
Elimina una arista puntual `id_origen -> id_destino`.
```bash
curl -s -X DELETE "http://127.0.0.1:8000/dependencias/?id_origen=10&id_destino=11"
```

**Errores comunes**
- `400 Bad Request`: proceso inexistente, ciclo directo o restricción de diagrama infringida.
- `404 Not Found`: arista a eliminar no existe.
- `422 Unprocessable Entity`: JSON inválido.

---

### GET `/datos-proceso/`
Lista mediciones (paginado y filtros).
**Query params**
- `proceso_id`: filtra por proceso.
- `fecha_desde` | `fecha_hasta`: ISO `YYYY-MM-DD`.
- `operario`: texto (contiene).
- `skip`, `limit`: paginación.
- `order`: `"asc"` (por fecha asc) | `"desc"` (default).

```bash
# Todas (paginado por defecto)
curl -L -s "http://127.0.0.1:8000/datos-proceso/"

# Por proceso y rango de fechas
curl -L -s "http://127.0.0.1:8000/datos-proceso/?proceso_id=27&fecha_desde=2024-10-01&fecha_hasta=2024-10-31"
```

### GET `/datos-proceso/{id_medicion}`
Obtiene una medición específica.
```bash
curl -L -s "http://127.0.0.1:8000/datos-proceso/958"
```

### PUT `/datos-proceso/{id_medicion}`
Actualiza una medición existente (reemplazo total de campos enviados).
```bash
curl -L -s -X PUT "http://127.0.0.1:8000/datos-proceso/958"   -H "Content-Type: application/json"   -d '{"cantidad":2,"notas":"Ajuste de control"}'
```

### DELETE `/datos-proceso/{id_medicion}` → `204 No Content`
Elimina una medición.
```bash
curl -L -s -X DELETE "http://127.0.0.1:8000/datos-proceso/958"
```

**Errores comunes**
- `404 Not Found`: proceso/medición inexistente.
- `422 Unprocessable Entity`: payload inválido (tipos o formatos).

---

## Endpoints de apoyo

### GET `/diagramas-detalle/{id_catalogo}`
Detalle del diagrama principal y subdiagramas, procesos, dependencias y **recetas** por proceso.
```bash
curl -s "http://127.0.0.1:8000/diagramas-detalle/1"
```

### GET `/procesos-detalle/{id_proceso}`
Proceso + tipo de máquina + área + (si existe) receta del proceso.
```bash
curl -s "http://127.0.0.1:8000/procesos-detalle/1"
```

---

## Notas de integración Frontend
- Para el combobox de nombres de procesos, usar `GET /procesos/lookup` con `catalogo_id` para limitar por artículo; alternar a “todos” quitando ese filtro.
- Para datos de proceso, listar/filtrar con `GET /datos-proceso/` y escribir con `POST`/`PUT`/`DELETE` según corresponda.
---

## Análisis estadístico de tiempos de proceso (módulo `/analysis`)

**Estado:** estable (v7)  
**Objetivo:** sugerir distribuciones de probabilidad para los tiempos de un proceso, o permitir que el usuario elija y visualice la distribución manualmente.

### 1. Datos de entrada usados por el módulo

Los endpoints de `/analysis` **no reciben los datos crudos del proceso** en el body. Ellos mismos los leen de la BD:

- Tabla: `datos_proceso`
- Campos relevantes:
  - `id_proceso` (FK a `procesos.id_proceso`)
  - `tiempo_total_seg` (`TEXT`, valor numérico en segundos guardado como string)
  - `tiempo_total_min` (no se usa de momento para el cálculo)
- Lógica interna (en `app/crud/dato_proceso_crud.get_tiempos_proceso`):
  - Se consultan todos los registros con ese `id_proceso`.
  - Se toma el campo `tiempo_total_seg` y se convierte a `float`.
  - Se filtran valores `NULL` o vacíos.

> Si un proceso tiene menos de `N` mediciones válidas (según `umbral`), el back entra en modo **manual**.

---

### 2. Endpoint GET — Selección automática / modo manual

**URL**  
```http
GET /analysis/processes/{proceso_id}/distribution?umbral={N}
```

**Parámetros**

- `proceso_id` (path, `int`): id del proceso en la tabla `procesos`.
- `umbral` (query, `int`, opcional, default `20`):
  - Si `n_muestras >= umbral` → se intenta selección automática de distribución.
  - Si `n_muestras < umbral` → se obliga a modo manual.

**Respuesta (`200 OK`, `AutoResponse` o `ManualResponse`)**

Hay dos modos posibles:

#### 2.1. Caso A — Modo *manual* (N de muestras menor que el umbral)

Ejemplo real con `id_proceso = 834` y solo 14 mediciones:

```bash
curl "$BASE/analysis/processes/834/distribution"
```

Respuesta:

```json
{
  "modo": "manual",
  "seleccion": null,
  "parametros": [],
  "mensaje": "Proceso con solo 14 mediciones (<20). Selecciona distribución y parámetros manualmente.",
  "ranking": [],
  "image_base64": null
}
```

- `modo`: `"manual"`.
- `seleccion`: `null` (no se sugiere nada todavía).
- `parametros`: array vacío.
- `mensaje`: texto explicativo, pensado para mostrar en el Front.
- `ranking`: vacío (no hay ranking cuando no se intenta auto–fit).
- `image_base64`: `null` (no hay gráfica aún).

**Uso esperado en el Front**

1. El front llama a `/analysis/processes/{id}/distribution` para saber si hay suficientes datos.
2. Si recibe `modo="manual"`:
   - Muestra un mensaje tipo “Hay menos de N mediciones, selecciona distribución y parámetros manualmente”.
   - Habilita el formulario para que el usuario elija la distribución y escriba parámetros.
   - (Opcional) Usa el endpoint de parámetros (ver sección 3) para saber qué parámetros pedir.

#### 2.2. Caso B — Modo *auto* (cuando existan suficientes datos)

Cuando `n_muestras >= umbral`, el endpoint intentará ajustar varias distribuciones y devolver:

```jsonc
{
  "modo": "auto",
  "seleccion": "norm",
  "parametros": [10.1, 2.0],
  "mensaje": "Distribución sugerida: Normal(μ=10.1, σ=2.0)",
  "ranking": [
    {
      "titulo": "Normal",
      "ks": 0.08,
      "p": 0.95,
      "r2": 0.98,
      "distrib": "norm",
      "parametros": [10.1, 2.0]
    },
    {
      "titulo": "Weibull mínima",
      "ks": 0.12,
      "p": 0.80,
      "r2": 0.96,
      "distrib": "weibull_min",
      "parametros": [1.5, 0.0, 9.8]
    }
    // ...
  ],
  "image_base64": "<PNG de la mejor distribución en base64>"
}
```

- `modo`: `"auto"`.
- `seleccion`: *nombre corto* de la distribución seleccionada (`"norm"`, `"weibull_min"`, etc).
- `parametros`: lista de parámetros mejores para esa distribución seleccionada.
- `mensaje`: resumen listo para mostrar al usuario.
- `ranking`: lista ordenada (mejor a peor) con métricas por distribución:
  - `ks`, `p`, `r2` pueden venir en `null` si no aplican.
  - `distrib`: el código a usar en otros endpoints (`"norm"`, `"weibull_min"`, `"...")`).
  - `parametros`: parámetros asociados a esa distribución del ranking.
- `image_base64`: PNG en base64 que el Front puede mostrar como `<img src="data:image/png;base64,..." />`.

> En tu entorno actual aún no tienes un ejemplo real de modo `auto` porque la mayoría de procesos tienen menos de 20 mediciones.

**Errores posibles**

- `404 Proceso sin datos`  
  - El proceso existe pero no tiene ningún registro válido en `datos_proceso`.

---

### 3. Endpoint GET — Parámetros requeridos por distribución

Este endpoint sirve para saber **qué parámetros** debe capturar el usuario para cada distribución soportada.

**URL**  
```http
GET /analysis/distributions/{nombre}/params
```

**Parámetros**

- `nombre` (path, `str`): nombre interno de la distribución, por ejemplo:
  - `"norm"`
  - `"weibull_min"`
  - `"lognorm"`
  - `"expon"`
  - `"gamma"`

**Respuestas de ejemplo**

```bash
curl "$BASE/analysis/distributions/norm/params"
```

```json
["media", "desviacion"]
```

```bash
curl "$BASE/analysis/distributions/weibull_min/params"
```

```json
["c", "loc", "scale"]
```

Uso típico en el Front:

1. Cuando el usuario selecciona `"norm"` en el combo de distribuciones, el Front pregunta:
   ```http
   GET /analysis/distributions/norm/params
   ```
2. Con el arreglo resultante (`["media","desviacion"]`) crea los inputs correspondientes:
   - `media` (float)
   - `desviacion` (float)

---

### 4. Endpoint POST — Selección manual con parámetros

Cuando el back está en modo manual, o cuando el usuario quiere forzar una distribución distinta a la auto–elegida, se usa este endpoint.

**URL**  
```http
POST /analysis/processes/{proceso_id}/distribution/manual
```

**Body (`ManualRequest`)**

```json
{
  "nombre": "norm",
  "parametros": [10.0, 2.0],
  "umbral": 20
}
```

- `nombre`: código interno de la distribución (`"norm"`, `"weibull_min"`, etc.).
- `parametros`: lista de parámetros *en el mismo orden* que entrega el endpoint `/analysis/distributions/{nombre}/params`.
- `umbral`: se reusa para la lógica interna (normalmente `20`).

**Ejemplo exitoso**

```bash
curl -X POST "$BASE/analysis/processes/834/distribution/manual" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "norm",
    "parametros": [10.0, 2.0],
    "umbral": 20
  }'
```

Respuesta:

```json
{
  "modo": "manual",
  "seleccion": "norm",
  "parametros": [10.0, 2.0],
  "mensaje": "Selección manual con N<20.",
  "image_base64": "<PNG en base64 con la gráfica ajustada>"
}
```

**Ejemplo de error (distribución no soportada)**

```bash
curl -X POST "$BASE/analysis/processes/834/distribution/manual" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "no_existe",
    "parametros": [1,2,3],
    "umbral": 20
  }'
```

Respuesta:

```json
{ "detail": "Distribucion no soportada: no_existe" }
```

---

### 5. Resumen de flujos Front–Back esperados

#### 5.1. Al seleccionar un proceso en el diagrama

1. Front llama a:
   ```http
   GET /analysis/processes/{proceso_id}/distribution
   ```
2. Si `modo = "auto"`:
   - Muestra la gráfica sugerida (`image_base64`).
   - Muestra combo “Distribución recomendada” con ranking (`ranking`).
3. Si `modo = "manual"`:
   - Muestra mensaje de que hay pocas mediciones.
   - No hay gráfica todavía.
   - Habilita el formulario para que el usuario introduzca distribución y parámetros.

#### 5.2. Al cambiar manualmente la distribución o parámetros

1. El usuario selecciona `"norm"` o `"weibull_min"`, etc.
2. Front consulta qué parámetros pedir:
   ```http
   GET /analysis/distributions/{nombre}/params
   ```
3. El usuario captura los valores.
4. Front llama a:
   ```http
   POST /analysis/processes/{proceso_id}/distribution/manual
   ```
5. Back responde con:
   - `mensaje` para mostrar.
   - `image_base64` de la gráfica.
   - `seleccion` + `parametros` que se pueden guardar en la tabla `procesos` (campos `distribucion` y `parametros`) si lo desean.

> Los endpoints de `/analysis` **no guardan nada en la tabla `procesos` por sí solos**. Solo calculan y devuelven sugerencias y gráficas. El guardado de `distribucion` y `parametros` en `procesos` se hace desde otros endpoints (por ejemplo, `PATCH /procesos/{id}`) cuando implementemos esa parte.
