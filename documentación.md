# 📘 API Documentación - Process Optimizer (ZAPATO NOVA Ejemplo Real)

Esta documentación describe todos los endpoints creados, con ejemplos **reales** usados en pruebas de backend y útiles para integración con el **frontend React**.

---

## 🧩 1. Catálogo (Artículos)

### Crear nuevo artículo
**POST** `/catalogo/`

#### Ejemplo de petición
```bash
curl -X POST "http://127.0.0.1:8000/catalogo/" -H "Content-Type: application/json" -d '{
  "nombre": "ZAPATO NOVA",
  "descripcion": "Deportivo mixto",
  "genero": "MIXTO",
  "restriccion": "DEPORTIVO",
  "precio": 45.50
}'
```

#### Respuesta
```json
{
  "message": "Artículo creado correctamente",
  "data": {
    "nombre": "ZAPATO NOVA",
    "restriccion": "DEPORTIVO",
    "id_catalogo": 5,
    "descripcion": "Deportivo mixto",
    "genero": "MIXTO",
    "precio": "45.50"
  }
}
```

---

## 🧭 2. Diagramas

### Crear diagrama principal
**POST** `/diagramas/`
```bash
curl -X POST "http://127.0.0.1:8000/diagramas/" -H "Content-Type: application/json" -d '{
  "nombre": "Diagrama ZAPATO NOVA",
  "descripcion": "Flujo principal del ZAPATO NOVA",
  "id_catalogo": 5,
  "es_principal": true
}'
```

**Respuesta**
```json
{
  "message": "Diagrama creado correctamente",
  "data": {
    "id_catalogo": 5,
    "descripcion": "Flujo principal del ZAPATO NOVA",
    "id_diagrama": 6,
    "es_principal": true,
    "nombre": "Diagrama ZAPATO NOVA"
  }
}
```

### Crear subdiagrama
**POST** `/diagramas/`
```bash
curl -X POST "http://127.0.0.1:8000/diagramas/" -H "Content-Type: application/json" -d '{
  "nombre": "Subdiagrama SUELA NOVA",
  "descripcion": "Subproceso de suela para ZAPATO NOVA",
  "id_catalogo": 5,
  "es_principal": false
}'
```
**Respuesta**
```json
{
  "message": "Diagrama creado correctamente",
  "data": {
    "id_catalogo": 5,
    "descripcion": "Subproceso de suela para ZAPATO NOVA",
    "id_diagrama": 7,
    "es_principal": false,
    "nombre": "Subdiagrama SUELA NOVA"
  }
}
```

---

## ⚙️ 3. Procesos

### Crear procesos principales
```bash
curl -X POST "http://127.0.0.1:8000/procesos/" -H "Content-Type: application/json" -d '{
  "nombre_proceso": "CORTAR PIEZAS",
  "parametros": "[2.5,0.7]",
  "distribucion": "norm",
  "id_diagrama": 6,
  "orden": 1
}'
```

**Respuesta**
```json
{
  "message": "Proceso creado correctamente",
  "data": {
    "nombre_proceso": "CORTAR PIEZAS",
    "distribucion": "norm",
    "id_tipomaquina": null,
    "id_diagrama": 6,
    "id_receta": null,
    "orden": 1,
    "duracion": null,
    "id_proceso": 9,
    "parametros": "[2.5,0.7]"
  }
}
```

Ejemplo adicional:
- COSER PIEZAS → id_proceso: 10  
- ENSAMBLAR ZAPATO → id_proceso: 11

### Crear procesos secundarios (Subdiagrama)
```bash
curl -X POST "http://127.0.0.1:8000/procesos/" -H "Content-Type: application/json" -d '{
  "nombre_proceso": "PEGAR SUELA",
  "parametros": "[0.6,0,1.3]",
  "distribucion": "lognorm",
  "id_diagrama": 7,
  "orden": 2
}'
```

**Respuesta**
```json
{
  "message": "Proceso creado correctamente",
  "data": {
    "nombre_proceso": "PEGAR SUELA",
    "distribucion": "lognorm",
    "id_diagrama": 7,
    "id_proceso": 13
  }
}
```

---

## 🔗 4. Dependencias

### Crear relación entre procesos (ej. Subdiagrama → Diagrama principal)
**POST** `/dependencias/`
```bash
curl -X POST "http://127.0.0.1:8000/dependencias/" -H "Content-Type: application/json" -d '{
  "id_origen": 13,
  "id_destino": 11
}'
```
**Respuesta**
```json
{
  "message": "Dependencia creada correctamente",
  "data": {
    "id_destino": 11,
    "id_origen": 13
  }
}
```

### Consultar dependencias por diagrama
```bash
curl -X GET "http://127.0.0.1:8000/dependencias/6" -H "accept: application/json"
```
**Respuesta**
```json
{
  "id_diagrama": 6,
  "dependencias": [
    {"id_origen": 13, "id_destino": 11}
  ]
}
```

---

## 🧪 5. Recetas

### Crear receta para un proceso
**POST** `/recetas/`
```bash
curl -X POST "http://127.0.0.1:8000/recetas/" -H "Content-Type: application/json" -d '{
  "id_diagrama": 6,
  "id_proceso": 11,
  "id_producto": 1,
  "cantidad_producida": 10
}'
```
**Respuesta**
```json
{
  "message": "Receta creada correctamente",
  "data": {
    "cantidad_producida": "10.00",
    "id_producto": 1,
    "id_proceso": 11,
    "id_receta": 4,
    "id_diagrama": 6
  }
}
```

---

## ⚗️ 6. Detalles de Receta

### Crear detalle de receta (materiales usados)
**POST** `/receta-detalle/`
```bash
curl -X POST "http://127.0.0.1:8000/receta-detalle/" -H "Content-Type: application/json" -d '{
  "id_receta": 4,
  "id_materia": 3,
  "cantidad_requerida": 10,
  "cantidad_unitaria": 1
}'
```
**Respuesta**
```json
{
  "message": "Detalle de receta creado correctamente",
  "data": {
    "id_receta": 4,
    "id_materia": 3,
    "cantidad_requerida": "10.00",
    "cantidad_unitaria": "1.00",
    "id_detalle": 5
  }
}
```

---

## 🧱 7. Consulta completa de un grafo

**GET** `/grafo/{id_diagrama}`
```bash
curl -X GET "http://127.0.0.1:8000/grafo/6" -H "accept: application/json"
```

**Respuesta**
```json
{
  "diagrama": {"id": 6, "nombre": "Diagrama ZAPATO NOVA"},
  "procesos": [
    {"id_proceso": 9, "nombre_proceso": "CORTAR PIEZAS", "orden": 1},
    {"id_proceso": 10, "nombre_proceso": "COSER PIEZAS", "orden": 2},
    {"id_proceso": 11, "nombre_proceso": "ENSAMBLAR ZAPATO", "orden": 3}
  ],
  "dependencias": [{"id_origen": 13, "id_destino": 11}],
  "recetas": [{
    "id_receta": 4,
    "producto": "ZAPATO TERMINADO",
    "cantidad_producida": 10.0,
    "materiales": [
      {"nombre": "SUELAS", "cantidad": 10.0}
    ]
  }]
}
```

---

## 🧭 Flujo completo Frontend → Backend

1️⃣ Crear **catálogo** (`/catalogo/`)  
2️⃣ Crear **diagrama principal y subdiagramas** (`/diagramas/`)  
3️⃣ Crear **procesos** asociados (`/procesos/`)  
4️⃣ Crear **dependencias** (`/dependencias/`)  
5️⃣ Crear **receta** de proceso final (`/recetas/`)  
6️⃣ Crear **detalles de receta** (`/receta-detalle/`)  
7️⃣ Consultar **grafo completo** (`/grafo/{id_diagrama}`)

---

💡 **Sugerencia para el frontend**
- Crear funciones reutilizables en `api/` como `createCatalogo()`, `createDiagrama()`, etc.  
- Manejar respuestas con `axios` y mostrar errores de validación desde el backend.

---
