import pandas as pd
import numpy as np

data = [
    {
        "id_catalogo": 110,
        "nombre_catalogo": "Airflow",
        "genero_catalogo": None,
        "restriccion_catalogo": None,
        "precio_catalogo": None,

        "id_diagrama": 34,
        "nombre_diagrama": "Diagrama Airflow Principal",
        "descripcion_diagrama": "Flujo principal del producto",
        "es_principal": True,

        "id_proceso": 1675,
        "nombre_proceso": "Pegado de pieza X (ej.)",
        "tipo_proceso": "NORMAL",
        "orden_proceso": 1,
        "distribucion": "norm",
        "parametros_distribucion": [1, 5, 3],
        "duracion_base": None,

        "id_tipomaquina": 10,
        "nombre_maquina": "PEGADO",
        "cantidad_maquinas": 1,
        "personal_max_maquina": 2,

        "id_area": 4,
        "nombre_area": "ANSANI",
        "tipo_area": "ENSAMBLE",
        "personal_area": 10,
        "restriccion_area": "ESCOLAR",
        "personal_asignado_maquina": 1,

        "procesos_predecesores": [],
        "procesos_sucesores": [1700],

        "materias_in": [
            {"id": 1, "nombre": "CUERO", "unidad": "M2", "cantidad": 2.0}
        ],
        "materias_out": [],

        "materias_in_ids": [1],
        "materias_in_nombres": ["CUERO"],
        "materias_in_cantidades": [2.0],

        "materias_out_ids": [],
        "materias_out_nombres": [],
        "materias_out_cantidades": [],

        "es_subdiagrama": False,
        "id_diagrama_padre": np.nan
    },

    {
        "id_catalogo": 110,
        "nombre_catalogo": "Airflow",
        "genero_catalogo": None,
        "restriccion_catalogo": None,
        "precio_catalogo": None,

        "id_diagrama": 35,
        "nombre_diagrama": "Airflow Subdiagrama Suela",
        "descripcion_diagrama": "Subdiagrama del producto",
        "es_principal": False,

        "id_proceso": 1700,
        "nombre_proceso": "Proceso Final Armado (ej)",
        "tipo_proceso": "NORMAL",
        "orden_proceso": 2,
        "distribucion": "norm",
        "parametros_distribucion": [1, 5, 3],
        "duracion_base": None,

        "id_tipomaquina": 3,
        "nombre_maquina": "ARMADOR DE PUNTA",
        "cantidad_maquinas": 1,
        "personal_max_maquina": 2,

        "id_area": 3,
        "nombre_area": "MASTER",
        "tipo_area": "ENSAMBLE",
        "personal_area": 10,
        "restriccion_area": "MIXTO",
        "personal_asignado_maquina": 1,

        "procesos_predecesores": [1675],
        "procesos_sucesores": [],

        "materias_in": [
            {"id": 1, "nombre": "CUERO", "unidad": "M2", "cantidad": 2.0}
        ],
        "materias_out": [
            {"id": 3, "nombre": "SUELAS", "unidad": "PAR", "cantidad": 5.0}
        ],

        "materias_in_ids": [1],
        "materias_in_nombres": ["CUERO"],
        "materias_in_cantidades": [2.0],

        "materias_out_ids": [3],
        "materias_out_nombres": ["SUELAS"],
        "materias_out_cantidades": [5.0],

        "es_subdiagrama": True,
        "id_diagrama_padre": 34
    }
]

df = pd.DataFrame(data)

print(df)