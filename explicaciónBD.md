# Base de Datos: PRODUCCION_DB v6

La BD modela todo el proceso de fabricación de calzado: desde las materias primas hasta el flujo de procesos y productos finales.

---

## 🧩 1. Estructura general

La BD se divide en tres niveles de lógica:

| Nivel | Qué representa | Tablas clave |
|-------|----------------|---------------|
| Producto | Qué se fabrica (ej: Zapato Airflow, Bambas) | catalogo, diagramas_de_flujo |
| Proceso | Cómo se fabrica (etapas, máquinas, dependencias) | procesos, tipos_maquinas, areas, procesos_dependencias |
| Materiales | Con qué se fabrica (insumos y productos intermedios) | materias_primas, recetas, receta_detalle |

---

## 👟 2. Productos (`catalogo`)

Representa los zapatos terminados que fabrica tu empresa.

```sql
SELECT * FROM catalogo;
```

| id_catalogo | nombre | genero | restriccion | precio |
|--------------|---------|----------|-------------|---------|
| 1 | AIRFLOW | MIXTO | DEPORTIVO | 49.99 |
| 2 | BAMBAS | MIXTO | DEPORTIVO | 39.99 |
| 3 | DANNA | MUJER | ESCOLAR | 29.99 |
| 4 | THIAGO | HOMBRE | ESCOLAR | 34.99 |

Cada producto puede tener uno o varios diagramas de flujo. Solo uno es el principal.

---

## 🔁 3. Diagramas de flujo (`diagramas_de_flujo`)

Cada diagrama describe un conjunto de procesos que forman parte de la fabricación.

**Ejemplo:**
- Diagrama AIRFLOW: flujo principal del zapato.  
- Subdiagrama SUELA: cómo se fabrica la suela (que luego usa el diagrama principal).

```sql
SELECT nombre, es_principal FROM diagramas_de_flujo;
```

| nombre | es_principal |
|---------|--------------|
| Diagrama AIRFLOW | TRUE |
| Subdiagrama SUELA | FALSE |

---

## ⚙️ 4. Áreas y máquinas (`areas`, `tipos_maquinas`)

Modelan los recursos físicos (secciones del taller y sus equipos).

**Ejemplo de áreas:**

| id_area | nombre | tipo | personal |
|----------|--------|------|-----------|
| 1 | CORTE | CORTE | 8 |
| 2 | COSTURA | COSTURA | 20 |
| 3 | MASTER | ENSAMBLE | 10 |

**Ejemplo de máquinas:**

| nombre_maquina | cantidad_maquinas | id_area |
|----------------|-------------------|----------|
| CORTADORAS | 8 | CORTE |
| MAQUINAS DE COSER | 20 | COSTURA |
| PEGADO | 1 | MASTER |

---

## ⚙️ 5. Procesos (`procesos`)

Un proceso es una etapa del diagrama de flujo.

```sql
SELECT nombre_proceso, orden, id_diagrama FROM procesos WHERE id_diagrama=1;
```

| nombre_proceso | orden | diagrama |
|----------------|--------|-----------|
| CORTAR PIEZAS | 1 | Diagrama AIRFLOW |
| COSER PIEZAS | 2 | Diagrama AIRFLOW |
| ENSAMBLAR ZAPATO | 3 | Diagrama AIRFLOW |
| LIMPIAR | 4 | Diagrama AIRFLOW |
| EMPAQUETAR | 5 | Diagrama AIRFLOW |

Cada proceso puede tener:
- Distribución estadística (tiempos de ejecución).
- Tipo de máquina usada.
- Referencia a una receta.

---

## 🔗 6. Dependencias (`procesos_dependencias`)

Conecta procesos entre sí.

```sql
SELECT o.nombre_proceso AS origen, d.nombre_proceso AS depende_de
FROM procesos_dependencias pd
JOIN procesos o ON o.id_proceso=pd.id_origen
JOIN procesos d ON d.id_proceso=pd.id_destino;
```

| origen | depende_de |
|---------|-------------|
| PEGAR SUELA | ENSAMBLAR ZAPATO |

---

## 🧱 7. Materias primas (`materias_primas`)

Lista de materiales e insumos.

| nombre | tipo |
|--------|------|
| CUERO | MP |
| SUELAS | MP |
| PIEZAS CORTADAS | PRODUCTO |
| ZAPATO ARMADO | PRODUCTO |
| ZAPATO TERMINADO | PRODUCTO |

---

## 🧪 8. Recetas (`recetas`, `receta_detalle`)

Definen cómo se transforma una materia prima en un producto.

**Ejemplo 1:** Receta para fabricar suela  
Producto: SUELAS  
Entrada: CUERO  
Cantidad producida: 10 pares

```sql
SELECT * FROM recetas WHERE id_diagrama=(SELECT id_diagrama FROM diagramas_de_flujo WHERE nombre='Subdiagrama SUELA');
```

| id_receta | producto | cantidad_producida |
|------------|-----------|--------------------|
| 1 | SUELAS | 10 |

**Detalle:**

| id_materia (entrada) | cantidad_requerida |
|----------------------|-------------------|
| CUERO | 10 |

**Ejemplo 2:** Receta del zapato terminado  
Producto: ZAPATO TERMINADO  
Entradas: SUELAS, CORDONES, PLANTILLA  
Cantidad producida: 10 pares

| Materia | Cantidad |
|----------|-----------|
| SUELAS | 10 |
| CORDONES | 10 |
| PLANTILLA | 10 |

---

## 🔁 9. Relación completa visual

```
CATALOGO (Zapato AIRFLOW)
 ├── DIAGRAMAS
 │     ├── Diagrama AIRFLOW (principal)
 │     │     ├── Procesos: Cortar, Coser, Ensamblar, Limpiar, Empaquetar
 │     │     │       └── (ENSAMBLAR ZAPATO usa receta de "ZAPATO TERMINADO")
 │     │     └── Dependencia ← (espera a "PEGAR SUELA")
 │     └── Subdiagrama SUELA
 │           ├── Procesos: Cortar Suela, Prensar Suela, Pegar Suela
 │           │       └── (PEGAR SUELA usa receta de "SUELAS")
 │           └── Producto intermedio: SUELAS
 └── MATERIAS PRIMAS
       ├── CUERO, CORDONES, PLANTILLA (entrada)
       └── SUELAS, ZAPATO TERMINADO (salida)
```

---

## 🧠 En resumen

La BD permite:
- Definir productos con múltiples diagramas (principal y subprocesos).  
- Describir procesos con tiempos, máquinas y dependencias.  
- Especificar materiales de entrada/salida con recetas completas.  
- Simular o visualizar la secuencia de producción entre diagramas distintos.
