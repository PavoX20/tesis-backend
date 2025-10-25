Perfecto.
Con tu estructura actual y la nueva BD v6, necesitaremos 10 endpoints principales para cubrir todo el flujo del frontend (diagramas, procesos, dependencias, recetas y materiales).

Te los clasifico por módulo para que actualices los routers y cruds de forma organizada.

⸻

🧩 1. Catálogo (productos finales)

Archivo: catalogo_router.py / catalogo_crud.py

Método	Ruta	Descripción
GET /catalogos	Listar todos los productos.	
GET /catalogos/{id}	Obtener un producto específico.	
POST /catalogos	Crear producto.	
PUT /catalogos/{id}	Actualizar.	
DELETE /catalogos/{id}	Eliminar.	


⸻

🔁 2. Diagramas de flujo

Archivo: diagrama_router.py / diagrama_crud.py

Método	Ruta	Descripción
GET /diagramas	Listar todos o por id_catalogo.	
GET /diagramas/{id}	Obtener diagrama con descripción.	
POST /diagramas	Crear nuevo diagrama (principal o secundario).	
PUT /diagramas/{id}	Editar nombre o descripción.	
DELETE /diagramas/{id}	Eliminar diagrama y procesos asociados.	

Adicional (nuevo):

Método	Ruta	Descripción
GET /diagramas/{id}/grafo	Devuelve JSON completo del diagrama: procesos, dependencias, recetas y materiales (para el canvas).	


⸻

⚙️ 3. Procesos

Archivo: proceso_router.py / proceso_crud.py

Método	Ruta	Descripción
GET /procesos	Listar todos o filtrar por id_diagrama.	
GET /procesos/{id}	Obtener detalles completos (nombre, orden, distribución, máquina, receta, dependencias).	
POST /procesos	Crear proceso dentro de un diagrama.	
PUT /procesos/{id}	Editar nombre, orden, parámetros o receta asociada.	
DELETE /procesos/{id}	Eliminar.	


⸻

🔗 4. Dependencias entre procesos

Archivo: proceso_detalle_router.py / diagrama_detalle_crud.py (renombrable a dependencia_router.py)

Método	Ruta	Descripción
GET /dependencias	Listar todas.	
GET /dependencias/{id_proceso}	Mostrar de qué depende y quién depende del proceso.	
POST /dependencias	Crear relación origen → destino.	
DELETE /dependencias	Eliminar relación.	


⸻

🧪 5. Recetas

Archivo: receta_router.py / receta_crud.py

Método	Ruta	Descripción
GET /recetas	Listar todas o filtrar por diagrama.	
GET /recetas/{id}	Mostrar receta + materiales de entrada.	
POST /recetas	Crear nueva receta.	
PUT /recetas/{id}	Actualizar cantidades o producto final.	
DELETE /recetas/{id}	Eliminar receta y su detalle.	


⸻

🧱 6. Detalle de receta (materiales usados)

Archivo: receta_router.py o receta_detalle_router.py

Método	Ruta	Descripción
POST /recetas/{id}/detalles	Agregar material requerido.	
DELETE /recetas/{id}/detalles/{id_detalle}	Quitar material.	
PUT /recetas/{id}/detalles/{id_detalle}	Editar cantidad.	


⸻

🧰 7. Materias primas

Archivo: materia_prima_router.py / materia_prima_crud.py

Método	Ruta	Descripción
GET /materias-primas	Listar todas.	
GET /materias-primas/{id}	Obtener detalle.	
POST /materias-primas	Crear nueva materia.	
PUT /materias-primas/{id}	Actualizar costo o unidad.	
DELETE /materias-primas/{id}	Eliminar.	


⸻

🏭 8. Áreas

Archivo: area_router.py / area_crud.py

Método	Ruta	Descripción
GET /areas	Listar todas.	
POST /areas	Crear área.	
PUT /areas/{id}	Editar personal o tipo.	
DELETE /areas/{id}	Eliminar.	


⸻

⚙️ 9. Tipos de máquinas

Archivo: tipo_maquina_router.py / tipo_maquina_crud.py

Método	Ruta	Descripción
GET /maquinas	Listar todas o por área.	
POST /maquinas	Crear tipo de máquina.	
PUT /maquinas/{id}	Editar nombre o cantidad.	
DELETE /maquinas/{id}	Eliminar.	


⸻

🧠 10. Endpoint combinado para el front (clave para el canvas)

Nuevo archivo: grafo_router.py
Nuevo crud: grafo_crud.py

Método	Ruta	Descripción
GET /grafo/{id_diagrama}	Devuelve estructura completa:	

{
  "procesos": [{ "id": 1, "nombre": "CORTAR", "orden": 1, "diagrama": "Airflow" }],
  "dependencias": [{ "origen": 6, "destino": 7 }],
  "recetas": [{ "id": 2, "producto": "SUELAS", "entradas": ["CUERO"] }]
}

Ideal para renderizar el canvas. |

⸻

Siguientes pasos
	1.	Crear los archivos vacíos grafo_router.py y grafo_crud.py.
	2.	Enlazarlos en main.py con app.include_router(...).
	3.	Implementar primero /grafo/{id_diagrama} (el endpoint más usado por el frontend).

¿Quieres que empecemos por construir /grafo/{id_diagrama} (devolver todo el diagrama con procesos, dependencias y recetas listas para dibujar)?