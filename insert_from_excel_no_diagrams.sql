-- Generated from Excel: create/resolve procesos per (cat, proceso) and insert datos_proceso
BEGIN;
CREATE TEMP TABLE _map (catalogo_nombre text, proceso_nombre text, id_proceso int);
INSERT INTO public.catalogo (nombre) SELECT 'Airflow' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Airflow');
INSERT INTO public.catalogo (nombre) SELECT 'Bambas' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Bambas');
INSERT INTO public.catalogo (nombre) SELECT 'Dakar 120' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Dakar 120');
INSERT INTO public.catalogo (nombre) SELECT 'Dakar 122' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Dakar 122');
INSERT INTO public.catalogo (nombre) SELECT 'Dana 420' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Dana 420');
INSERT INTO public.catalogo (nombre) SELECT 'Dana 428' WHERE NOT EXISTS (SELECT 1 FROM public.catalogo WHERE nombre='Dana 428');
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de lado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de lado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Armado de lado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de lado') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de lado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Armado de lado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de punta') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Armado de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de punta') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Armado de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de punta') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Armado de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Armado de talón') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Armado de talón'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Armado de talón', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Arreglo capellada') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Arreglo capellada'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Arreglo capellada', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Calentamiento equipo') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Calentamiento equipo'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Calentamiento equipo', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cambio de molde') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cambio de molde'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Cambio de molde', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cambio de molde') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cambio de molde'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Cambio de molde', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cardado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cardado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Cardado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cardado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cardado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Cardado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Clavado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Clavado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Clavado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación capellada') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación capellada'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación capellada', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de chapeta') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de chapeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de chapeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de cinta en puntas') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de cinta en puntas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de cinta en puntas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de contrafuerte') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de contrafuerte'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de contrafuerte', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de contrafuerte') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de contrafuerte'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Colocación de contrafuerte', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de esponja a lengüeta') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de esponja a lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de esponja a lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de flor') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de flor'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Colocación de flor', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de forro') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de forro'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de forro', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de forro') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de forro'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de forro', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de forro') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de forro'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Colocación de forro', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de hipodérmica') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de hipodérmica'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Colocación de hipodérmica', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de hipodérmica') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de hipodérmica'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Colocación de hipodérmica', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de hipodérmica') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de hipodérmica'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Colocación de hipodérmica', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de kiotex') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de kiotex'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Colocación de kiotex', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de kiotex en puntas') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de kiotex en puntas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de kiotex en puntas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de laterales') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de laterales'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de laterales', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de lengüeta') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de lengüeta') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de pieza colita') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de pieza colita'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de pieza colita', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de puntadura') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de puntadura'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de puntadura', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de puntadura') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de puntadura'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Colocación de puntadura', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de talón') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de talón'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de talón', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de termoadherible') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de termoadherible'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de termoadherible', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de termoadherible') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de termoadherible'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de termoadherible', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de tiras laterales') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de tiras laterales'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de tiras laterales', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de u') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de u'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Colocación de u', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de u') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de u'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Colocación de u', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Corte de elásticos') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Corte de elásticos'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Corte de elásticos', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Corte de plantillas') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Corte de plantillas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Corte de plantillas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de cola') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de cola'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Cosido de cola', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de colita') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de colita'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Cosido de colita', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de elástico 1') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de elástico 1'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Cosido de elástico 1', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de elástico 2') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de elástico 2'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Cosido de elástico 2', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de hebilla') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de hebilla'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Cosido de hebilla', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de zigzag') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de zigzag'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Cosido de zigzag', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cosido de zigzag') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cosido de zigzag'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Cosido de zigzag', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cuero') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cuero'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Cuero', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Cuero') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Cuero'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Cuero', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Decoración de punta') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Decoración de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Decoración de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Decorado de cuello') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Decorado de cuello'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Decorado de cuello', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Decorado de cuello') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Decorado de cuello'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Decorado de cuello', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Decorado de talón') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Decorado de talón'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Decorado de talón', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Decorado de velcros y correas') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Decorado de velcros y correas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Decorado de velcros y correas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Descalzado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Descalzado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Descalzado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Descalzado') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Descalzado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Descalzado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Descalzado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Descalzado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Descalzado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Descalzado y perchado') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Descalzado y perchado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Descalzado y perchado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Destallado') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Destallado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Destallado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Doblado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Doblado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Doblado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Ejecución costurera autómata') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Ejecución costurera autómata'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Ejecución costurera autómata', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Emplantillado') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Emplantillado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Emplantillado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Empuntillado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Empuntillado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Empuntillado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Etiqueta lengüeta') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Etiqueta lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Etiqueta lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Etiquetado y embalaje') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Etiquetado y embalaje'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Etiquetado y embalaje', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Etiquetado y embalaje') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Etiquetado y embalaje'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Etiquetado y embalaje', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Hitex') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Hitex'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Hitex', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Ingreso de piezas en el vastidor') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Ingreso de piezas en el vastidor'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Ingreso de piezas en el vastidor', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Inyección del PVC') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Inyección del PVC'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Inyección del PVC', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Jaleteado') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Jaleteado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Jaleteado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Lijado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Lijado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Lijado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Lijado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Lijado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Lijado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Limpieza de residuos de adhesivo') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Limpieza de residuos de adhesivo'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Limpieza de residuos de adhesivo', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Limpieza de residuos de adhesivo') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Limpieza de residuos de adhesivo'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Limpieza de residuos de adhesivo', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Limpieza de residuos de adhesivo') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Limpieza de residuos de adhesivo'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Limpieza de residuos de adhesivo', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Limpieza de suelas') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Limpieza de suelas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Limpieza de suelas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Mesa de manualidades') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Mesa de manualidades'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Mesa de manualidades', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Mesa puesta de hebilla') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Mesa puesta de hebilla'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Mesa puesta de hebilla', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Ojetillado') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Ojetillado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Ojetillado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pega capellada') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pega capellada'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Pega capellada', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pega capellada') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pega capellada'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Pega capellada', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pega suela') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pega suela'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Pega suela', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pega suela') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pega suela'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Pega suela', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Perforación de piezas') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Perforación de piezas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Perforación de piezas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pintado de flor') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pintado de flor'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Pintado de flor', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pintado de hebillero') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pintado de hebillero'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Pintado de hebillero', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Planchado') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Planchado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Planchado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Planchado') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Planchado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Planchado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Prensado-reactivación pegamento') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Prensado-reactivación pegamento'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Prensado-reactivación pegamento', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Prensado-reactivación pegamento') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Prensado-reactivación pegamento'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Prensado-reactivación pegamento', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Preparación para costurera autómata') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Preparación para costurera autómata'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Preparación para costurera autómata', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Quemado de hilos') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Quemado de hilos'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Quemado de hilos', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Quemado de hilos') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Quemado de hilos'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Quemado de hilos', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Remachado de flor') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Remachado de flor'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Remachado de flor', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Revisión') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Revisión'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Revisión', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Revisión') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Revisión'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Revisión', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Revisión') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Revisión'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Revisión', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Revisión') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Revisión'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Revisión', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Ribeteado') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Ribeteado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Ribeteado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Salida del vastidor') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Salida del vastidor'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Salida del vastidor', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Sintético') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Sintético'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Sintético', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Sintético') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Sintético'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Sintético', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Terminación de lengüeta') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Terminación de lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Terminación de lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de chapeta') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de chapeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado de chapeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de colita') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de colita'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado de colita', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de cuello') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de cuello'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Tizado de cuello', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de lateral') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de lateral'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Tizado de lateral', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de lateral') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de lateral'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado de lateral', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de lengüeta') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de lengüeta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Tizado de lengüeta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de punta') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Tizado de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de talón') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de talón'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Tizado de talón', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de talón') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de talón'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado de talón', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de talón y lateral') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de talón y lateral'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Tizado de talón y lateral', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de u') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de u'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Tizado de u', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Unión de reina (zigzag doble)') AND c.nombre='Dana 428'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Unión de reina (zigzag doble)'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 428', 'Unión de reina (zigzag doble)', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Unión de reina (zigzag doble)') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Unión de reina (zigzag doble)'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Unión de reina (zigzag doble)', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pegado en mesa de manualidades') AND c.nombre='Airflow'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pegado en mesa de manualidades'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Airflow', 'Pegado en mesa de manualidades', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de cuello') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de cuello'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Tizado de cuello', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de contrafuerte') AND c.nombre='Dakar 120'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de contrafuerte'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 120', 'Colocación de contrafuerte', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Colocación de contrafuerte') AND c.nombre='Dakar 122'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Colocación de contrafuerte'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dakar 122', 'Colocación de contrafuerte', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Pintado de correas') AND c.nombre='Dana 420'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Pintado de correas'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Dana 420', 'Pintado de correas', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
WITH p_exist AS (  SELECT p.id_proceso  FROM public.procesos p  JOIN public.datos_proceso dp ON dp.id_proceso = p.id_proceso  JOIN public.catalogo c ON c.id_catalogo = dp.id_catalogo  WHERE lower(p.nombre_proceso)=lower('Tizado de punta') AND c.nombre='Bambas'  LIMIT 1), ins AS (  INSERT INTO public.procesos (nombre_proceso)  SELECT 'Tizado de punta'  WHERE NOT EXISTS (SELECT 1 FROM p_exist)  RETURNING id_proceso) INSERT INTO _map (catalogo_nombre, proceso_nombre, id_proceso) SELECT 'Bambas', 'Tizado de punta', COALESCE((SELECT id_proceso FROM p_exist),(SELECT id_proceso FROM ins));
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:21.933368', '21.933368', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.933368')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.933368')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:10.785155', '10.785155', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.785155')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.785155')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:12.910994', '12.910994', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.910994')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.910994')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.596300', '14.5963', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.596300')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.5963')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.679570', '14.67957', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.679570')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.67957')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:16.516221', '16.516222', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.516221')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.516222')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:17.023120', '17.02312', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.023120')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.02312')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:17.833803', '17.833803', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.833803')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.833803')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:18.030844', '18.030844', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.030844')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.030844')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.023626', '22.023626', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.023626')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.023626')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:24.576286', '24.576286', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.576286')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.576286')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:25.269770', '25.26977', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.269770')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.26977')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:29.984337', '29.984337', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.984337')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.984337')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:34.090072', '34.090072', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.090072')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.090072')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:36.131995', '36.131995', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de lado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.131995')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.131995')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:29.531629', '29.5316298', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.531629')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.5316298')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:30.064009', '30.0640098', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.064009')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.0640098')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:54.754971', '54.7549714', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.754971')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.7549714')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:55.141321', '55.1413215', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.141321')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.1413215')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:20.639594', '20.6395946', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.639594')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.6395946')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:24.089775', '24.0897759', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.089775')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.0897759')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:00:34.300390', '34.3003906', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.300390')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.3003906')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-19', '0:01:00.314570', '60.3145701', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.314570')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.3145701')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-03', '0:00:42.215676', '42.2156766', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.215676')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.2156766')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-03', '0:00:26.724580', '26.72458', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.724580')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.72458')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:36.570915', '36.570915', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.570915')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.570915')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:41.412170', '41.41217', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.412170')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.41217')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:42.380746', '42.380746', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.380746')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.380746')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:55.403845', '55.403845', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.403845')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.403845')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:59.911849', '59.911849', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.911849')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.911849')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:12.930302', '72.930302', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:12.930302')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '72.930302')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:44.905576', '104.905576', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:44.905576')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '104.905576')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:49.257326', '109.257327', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:49.257326')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '109.257327')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:54.956019', '114.956019', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Armado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:54.956019')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '114.956019')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:09.000000', '9.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:09.000000', '9.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:09.000000', '9.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:10.000000', '10.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:19.000000', '19.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:20.000000', '20.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Arreglo capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:09:00.000000', '540.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Calentamiento equipo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:09:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '540.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:11:57.000000', '717.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Calentamiento equipo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:11:57.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '717.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:04:59.071672', '299.071672', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:59.071672')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '299.071672')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:08.000000', '248.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '248.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:05:45.000000', '345.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:05:45.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '345.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:12:57.000000', '777.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:12:57.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '777.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:15:15.000000', '915.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:15:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '915.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:15:46.000000', '946.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cambio de molde'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:15:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '946.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:17.939723', '17.939723', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.939723')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.939723')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:18.081165', '18.081165', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.081165')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.081165')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:20.331675', '20.331675', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.331675')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.331675')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:21.288920', '21.28892', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.288920')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.28892')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:21.877497', '21.877497', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.877497')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.877497')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.563557', '22.563557', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.563557')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.563557')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.901547', '22.901547', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.901547')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.901547')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:23.841891', '23.841891', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.841891')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.841891')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:35.370761', '35.370761', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.370761')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.370761')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:15.065389', '15.065389', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.065389')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.065389')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:16.369242', '16.3692425', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.369242')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.3692425')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:17.244799', '17.2447995', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.244799')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.2447995')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.081138', '19.0811385', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.081138')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.0811385')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.186007', '19.1860075', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.186007')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.1860075')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.627017', '19.627017', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.627017')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.627017')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.050149', '20.050149', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.050149')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.050149')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.109473', '20.1094735', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.109473')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.1094735')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:34.205343', '34.2053435', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.205343')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.2053435')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:54.801178', '54.8011785', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cardado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.801178')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.8011785')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:19.494647', '19.494647', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.494647')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.494647')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:18.771196', '18.77119633333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.771196')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.77119633333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:18.995464', '18.99546466666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.995464')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.99546466666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:19.294258', '19.29425833333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.294258')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.29425833333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:20.585331', '20.585331', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.585331')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.585331')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:20.875585', '20.875585', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.875585')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.875585')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:22.597893', '22.59789366666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.597893')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.59789366666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:25.170804', '25.17080433333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.170804')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.17080433333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:18.940141', '18.94014125', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.940141')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.94014125')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:20.619168', '20.619168', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.619168')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.619168')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:22.591541', '22.59154175', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Clavado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.591541')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.59154175')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:04.000000', '4.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:06.000000', '6.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:12.000000', '12.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:13.000000', '13.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:14.000000', '14.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:14.000000', '14.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:01:40.700000', '100.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:40.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '100.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:01:41.900000', '101.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:41.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '101.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-21', '0:01:46.100000', '106.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:46.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '106.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:01:45.566666', '105.5666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:45.566666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '105.5666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-09-10', '0:01:45.866666', '105.8666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:45.866666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '105.8666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-10', '0:01:47.366666', '107.3666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:47.366666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '107.3666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:12.851993', '72.851993', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:12.851993')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '72.851993')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:12.686526', '72.686526', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:12.686526')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '72.686526')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:13.019760', '73.01976', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:13.019760')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '73.01976')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:17.320624', '77.320624', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:17.320624')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '77.320624')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:56.382285', '116.382285', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:56.382285')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '116.382285')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:19.618854', '79.618854', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:19.618854')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '79.618854')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:12.270128', '72.270128', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:12.270128')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '72.270128')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-22', '0:01:11.999862', '71.999862', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:11.999862')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '71.999862')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:09.046437', '9.0464372', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.046437')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.0464372')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-23', '0:00:27.462761', '27.462761', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.462761')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.462761')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-23', '0:00:13.506580', '13.506581', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.506580')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.506581')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-23', '0:00:12.611063', '12.6110636', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.611063')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.6110636')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-23', '0:00:15.691632', '15.6916324', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.691632')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.6916324')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-23', '0:00:09.698909', '9.6989094', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de cinta en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.698909')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.6989094')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:16.506068', '16.5060681', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.506068')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.5060681')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:19.178118', '19.1781189', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.178118')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.1781189')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:19.432684', '19.4326849', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.432684')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.4326849')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:19.868116', '19.868116', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.868116')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.868116')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:21.083963', '21.083963', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.083963')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.083963')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.858237', '10.85823786666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.858237')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.85823786666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.934367', '10.93436773333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.934367')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.93436773333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:39.550000', '39.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:50.100000', '50.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:43.533333', '43.53333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.533333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.53333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-14', '0:00:41.275000', '41.275', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.275000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.275')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-14', '0:01:09.900000', '69.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:09.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '69.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 60.0, '2024-08-19', '0:00:29.200000', '29.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 60.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 60.0, '2024-08-19', '0:00:42.200000', '42.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 60.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-18', '0:00:38.800000', '38.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-18', '0:00:40.700000', '40.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-09-18', '0:00:52.425000', '52.425', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de esponja a lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:52.425000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '52.425')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:21.942191', '21.9421918', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.942191')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.9421918')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:27.614452', '27.61445235', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.614452')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.61445235')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:19.022472', '19.02247205', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.022472')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.02247205')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-11-05', '0:00:25.270734', '25.2707344', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.270734')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.2707344')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-11-05', '0:00:22.548746', '22.54874603333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.548746')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.54874603333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:00:39.900000', '39.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:00:53.250000', '53.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:01:38.250000', '98.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:38.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '98.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-14', '0:01:18.100000', '78.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:18.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '78.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-14', '0:01:35.266666', '95.26666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:35.266666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '95.26666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:01:23.200000', '83.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:23.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '83.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:02:06.840000', '126.84', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:06.840000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '126.84')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:02:10.240000', '130.24', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:10.240000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '130.24')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-08-19', '0:03:45.600000', '225.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:45.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '225.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:01:15.700000', '75.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:15.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '75.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:01:17.900000', '77.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:17.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '77.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:02:00.300000', '120.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:00.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '120.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:41.162355', '41.1623556', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.162355')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.1623556')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:40.693140', '40.6931401', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.693140')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.6931401')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-10-28', '0:00:40.730506', '40.73050673333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.730506')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.73050673333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-10-28', '0:00:35.359820', '35.35982019999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.359820')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.35982019999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:46.241411', '46.2414115', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de forro'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.241411')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.2414115')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:18.842010', '18.84201', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.842010')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.84201')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:12.621738', '12.621738', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.621738')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.621738')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:15.158253', '15.1582535', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.158253')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.1582535')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:22.576202', '22.5762025', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.576202')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.5762025')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:23.158744', '23.1587445', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.158744')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.1587445')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:16.275750', '16.27575', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.275750')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.27575')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:12.927215', '12.9272155', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.927215')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.9272155')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:14.407245', '14.4072455', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.407245')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.4072455')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:15.155168', '15.155168', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.155168')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.155168')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:16.197425', '16.1974255', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.197425')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.1974255')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:13.268529', '13.268529', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.268529')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.268529')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.168736', '15.168736', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.168736')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.168736')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.522943', '15.522943', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.522943')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.522943')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.633557', '15.633557', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.633557')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.633557')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:17.506717', '17.506717', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.506717')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.506717')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:20.308547', '20.308547', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.308547')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.308547')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:22.338833', '22.338833', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.338833')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.338833')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:11.748756', '11.7487565', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.748756')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.7487565')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:13.066951', '13.0669515', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.066951')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.0669515')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:16.406548', '16.4065485', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.406548')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.4065485')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.405223', '19.405223', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.405223')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.405223')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:39.658555', '39.658555', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.658555')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.658555')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:49.767113', '49.767113', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Colocación de hipodérmica'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.767113')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.767113')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:00:06.800000', '6.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de kiotex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:00:07.950000', '7.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de kiotex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:00:07.250000', '7.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de kiotex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:00:07.500000', '7.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de kiotex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-09-12', '0:00:06.950000', '6.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de kiotex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:00:08.300000', '8.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:00:13.800000', '13.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:09.000000', '9.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:09.400000', '9.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:10.400000', '10.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:11.250000', '11.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:11.400000', '11.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de kiotex en puntas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-14', '0:00:53.500000', '53.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:00:41.600000', '41.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-14', '0:00:43.333333', '43.33333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.333333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.33333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-14', '0:00:53.500000', '53.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:00:41.600000', '41.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:07.100000', '7.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:36.800000', '36.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-14', '0:01:23.000000', '83.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:23.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '83.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-14', '0:01:13.225000', '73.225', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:13.225000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '73.225')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 8.0, '2024-08-19', '0:01:46.875000', '106.875', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 8.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:46.875000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '106.875')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-19', '0:02:14.466666', '134.4666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:14.466666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '134.4666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:01:30.400000', '90.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:30.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '90.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:14.000000', '14.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:14.100000', '14.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:15.800000', '15.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:13.966666', '13.96666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.966666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.96666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-12', '0:00:19.325000', '19.325', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.325000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.325')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-12', '0:00:19.625000', '19.625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.625000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-12', '0:00:25.300000', '25.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:51.800000', '51.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:59.900000', '59.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:01:01.266666', '61.26666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.266666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.26666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-21', '0:02:08.950000', '128.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de pieza colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:08.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '128.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:10.050000', '10.05', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.050000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.05')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:10.550000', '10.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:11.550000', '11.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:13.250000', '13.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:10.050000', '10.05', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.050000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.05')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:10.550000', '10.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:11.550000', '11.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:13.250000', '13.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-16', '0:00:14.950000', '14.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:10.900000', '10.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:12.033333', '12.03333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.033333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.03333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-18', '0:00:15.866666', '15.86666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.866666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.86666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:04.380374', '4.3803745', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.380374')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.3803745')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:05.425805', '5.4258058', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.425805')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.4258058')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:05.814203', '5.8142038', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.814203')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.8142038')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:05.970866', '5.9708662', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.970866')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.9708662')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:06.281154', '6.2811547', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.281154')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.2811547')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:06.323084', '6.3230848', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.323084')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.3230848')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:05.718375', '5.71837595', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.718375')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.71837595')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:06.073921', '6.07392145', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.073921')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.07392145')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.779185', '9.779185850000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de puntadura'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.779185')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.779185850000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:51.200000', '51.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:51.800000', '51.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:54.000000', '54.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:54.200000', '54.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:55.800000', '55.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-21', '0:00:59.900000', '59.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:00:54.300000', '54.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-21', '0:02:08.950000', '128.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:08.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '128.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:02:01.266666', '121.2666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:01.266666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '121.2666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-10', '0:00:54.650000', '54.65', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.650000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.65')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-10', '0:00:55.400000', '55.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-10', '0:00:50.700000', '50.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-10', '0:00:58.600000', '58.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-10'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:01:02.500000', '62.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:01:10.350000', '70.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:10.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '70.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:20.591556', '20.5915563', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.591556')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.5915563')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:21.362717', '21.3627174', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.362717')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.3627174')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:22.467591', '22.4675918', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.467591')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.4675918')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:23.067632', '23.0676329', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.067632')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.0676329')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:23.185101', '23.1851013', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.185101')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.1851013')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:26.607992', '26.6079925', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.607992')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.6079925')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:33.617341', '33.6173416', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.617341')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.6173416')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:38.786364', '38.7863643', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.786364')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.7863643')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:26.314285', '26.3142859', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de termoadherible'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.314285')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.3142859')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:37.080000', '37.08', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.080000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.08')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:37.920000', '37.92', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.920000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.92')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:41.640000', '41.64', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.640000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.64')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:42.840000', '42.84', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.840000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.84')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:43.800000', '43.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:45.160000', '45.16', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:45.160000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '45.16')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:48.960000', '48.96', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:48.960000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '48.96')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:00:54.080000', '54.08', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de tiras laterales'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.080000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.08')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-08-14', '0:02:34.400000', '154.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:34.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '154.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 28.0, '2024-08-14', '0:00:37.392857', '37.39285714285715', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 28.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.392857')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.39285714285715')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:01:25.350000', '85.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:25.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '85.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:01:48.950000', '108.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:48.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '108.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-14', '0:02:10.950000', '130.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:10.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '130.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-08-19', '0:03:12.933333', '192.9333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:12.933333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '192.9333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:03:18.440000', '198.44', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:18.440000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '198.44')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-08-19', '0:03:22.840000', '202.84', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:22.840000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '202.84')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-21', '0:01:36.250000', '96.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:36.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '96.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-21', '0:01:58.933333', '118.9333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Colocación de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:58.933333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '118.9333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:08.350000', '8.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Corte de elásticos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:05.300000', '5.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Corte de elásticos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:05.300000', '5.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Corte de elásticos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:08.350000', '8.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Corte de elásticos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:08.100000', '8.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Corte de elásticos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:00:03.700000', '3.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:00:05.200000', '5.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.150000', '4.15', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.150000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.15')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.250000', '4.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:03.166666', '3.166666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.166666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.166666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:03.400000', '3.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:05.300000', '5.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:03.666666', '3.666666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.666666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.666666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:03.733333', '3.733333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.733333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.733333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:06.000000', '6.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:04.000000', '4.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:04.500000', '4.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-15', '0:00:11.533333', '11.53333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Corte de plantillas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.533333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.53333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-08-14', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cosido de cola'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-08-14', '0:01:02.000000', '62.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cosido de cola'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-14', '0:00:57.700000', '57.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cosido de cola'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-14', '0:00:57.200000', '57.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cosido de cola'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-14', '0:00:41.866666', '41.86666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Cosido de cola'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-14'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.866666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.86666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:18.100000', '18.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:19.700000', '19.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:15.000000', '15.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:16.466666', '16.46666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.466666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.46666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:17.566666', '17.56666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.566666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.56666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:26.550000', '26.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Cosido de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-09-13', '0:00:49.600000', '49.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 1'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:47.950000', '47.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 1'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:47.950000', '47.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 1'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:48.700000', '48.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 1'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:48.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '48.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:01:02.350000', '62.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 1'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:38.400000', '38.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 2'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:41.033333', '41.03333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 2'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.033333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.03333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-09-13', '0:00:32.525000', '32.525', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 2'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.525000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.525')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:43.600000', '43.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 2'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:53.500000', '53.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de elástico 2'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-09-13', '0:00:47.400000', '47.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:46.850000', '46.85', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.850000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.85')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:46.900000', '46.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-09-13', '0:00:47.400000', '47.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:53.550000', '53.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:17.800000', '17.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:18.900000', '18.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:21.200000', '21.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:21.600000', '21.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-12', '0:00:21.425000', '21.425', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.425000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.425')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:30.733333', '30.73333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.733333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.73333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:16.933333', '16.93333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.933333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.93333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:17.133333', '17.13333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.133333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.13333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:17.933333', '17.93333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.933333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.93333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:04.350000', '4.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Cosido de zigzag'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:06.000000', '6.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:16.000000', '16.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:16.000000', '16.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:16.000000', '16.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:30.000000', '30.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:32.000000', '32.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:34.000000', '34.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:34.000000', '34.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:38.000000', '38.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:40.000000', '40.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:46.000000', '46.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:46.000000', '46.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:46.000000', '46.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:54.000000', '54.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:02.000000', '62.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:18.000000', '78.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:18.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '78.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:10.000000', '10.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:20.000000', '20.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:22.000000', '22.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:24.000000', '24.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:26.000000', '26.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:28.000000', '28.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:34.000000', '34.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:36.000000', '36.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:36.000000', '36.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:38.000000', '38.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:40.000000', '40.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:40.000000', '40.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:42.000000', '42.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:42.000000', '42.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:44.000000', '44.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:44.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '44.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:46.000000', '46.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:54.000000', '54.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:02.000000', '62.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:04.000000', '64.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '64.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:04.000000', '64.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '64.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:08.000000', '68.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '68.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:16.000000', '76.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '76.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:16.000000', '76.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '76.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:20.000000', '80.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:20.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '80.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:20.000000', '80.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:20.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '80.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:22.000000', '82.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:22.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '82.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:26.000000', '86.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:26.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '86.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:28.000000', '88.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:28.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '88.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:32.000000', '92.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:32.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '92.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:40.000000', '100.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:40.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '100.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:01:46.000000', '106.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '106.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:02:12.000000', '132.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:12.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '132.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:02:38.000000', '158.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:38.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '158.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-08-28', '0:02:50.000000', '170.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Cuero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:50.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '170.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:56.691543', '56.6915433', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decoración de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.691543')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.6915433')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:01:10.370648', '70.3706489', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decoración de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:10.370648')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '70.3706489')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:01:13.459441', '73.4594417', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decoración de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:13.459441')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '73.4594417')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:59.100436', '59.1004361', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decoración de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.100436')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.1004361')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:01:03.140501', '63.14050140000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decoración de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:03.140501')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '63.14050140000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-11-05', '0:00:35.394514', '35.39451473333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.394514')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.39451473333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-11-05', '0:01:16.488482', '76.48848266666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:16.488482')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '76.48848266666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-11-05', '0:00:51.330089', '51.33008966666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.330089')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.33008966666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-11-05', '0:00:10.800125', '10.800125', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.800125')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.800125')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-11-05', '0:00:54.924839', '54.9248395', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.924839')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.9248395')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-11-05', '0:01:05.892091', '65.8920915', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:05.892091')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '65.8920915')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-11-05', '0:01:02.208492', '62.2084925', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.208492')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.2084925')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:59.206055', '59.206055', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Decorado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.206055')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.206055')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:00:54.700000', '54.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:00:57.900000', '57.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:00:59.700000', '59.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:01:04.400000', '64.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:04.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '64.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:01:09.700000', '69.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:09.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '69.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-11', '0:01:41.800000', '101.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:41.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '101.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-11', '0:01:11.900000', '71.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Decorado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-11'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:11.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '71.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:56.053137', '56.0531372', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decorado de velcros y correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.053137')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.0531372')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:55.912602', '55.9126029', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decorado de velcros y correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.912602')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.9126029')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:53.176643', '53.176643', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decorado de velcros y correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.176643')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.176643')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:01:06.371286', '66.3712868', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decorado de velcros y correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:06.371286')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '66.3712868')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:01:02.579897', '62.57989730000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Decorado de velcros y correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.579897')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.57989730000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:23.360503', '23.36050333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.360503')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.36050333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:27.627458', '27.627458', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.627458')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.627458')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:54.900924', '54.90092475', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.900924')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.90092475')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-03', '0:00:16.058800', '16.0588006', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.058800')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.0588006')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.406771', '20.4067715', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.406771')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.4067715')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:21.332502', '21.3325025', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.332502')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.3325025')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:29.192160', '29.19216', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.192160')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.19216')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:31.517601', '31.517601', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:31.517601')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '31.517601')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:32.395882', '32.395882', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.395882')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.395882')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-03', '0:00:14.879753', '14.8797536', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.879753')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.8797536')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 6.0, '2024-10-03', '0:00:19.423835', '19.4238355', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 6.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.423835')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.4238355')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:40.669800', '40.6698005', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Descalzado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.669800')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.6698005')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:03.000000', '3.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:03.000000', '3.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:04.000000', '4.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:15.000000', '15.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:15.000000', '15.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:00:19.000000', '19.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Descalzado y perchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.200000', '4.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.700000', '4.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.850000', '4.85', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.850000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.85')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:04.950000', '4.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:05.000000', '5.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:05.100000', '5.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-15', '0:00:05.500000', '5.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:00.750000', '0.75', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:00.750000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '0.75')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.000000', '1.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.100000', '1.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.550000', '1.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.600000', '1.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.650000', '1.65', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.650000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.65')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.800000', '1.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.950000', '1.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:02.250000', '2.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Destallado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:02.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '2.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:46.842860', '46.8428605', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Doblado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.842860')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.8428605')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-28', '0:00:49.248228', '49.24822875', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Doblado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.248228')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.24822875')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-28', '0:00:50.383270', '50.3832704', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Doblado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.383270')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.3832704')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-10-28', '0:00:52.383244', '52.3832442', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Doblado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:52.383244')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '52.3832442')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:57.565241', '57.5652416', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Doblado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.565241')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.5652416')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:56.000000', '56.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:52.000000', '52.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:52.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '52.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:57.000000', '57.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:56.000000', '56.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:55.000000', '115.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:55.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '115.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:47.000000', '107.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:47.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '107.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:19.000000', '79.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:19.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '79.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:55.000000', '55.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:57.000000', '57.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:02.000000', '62.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:01.000000', '61.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ejecución costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:18.093473', '18.093473', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.093473')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.093473')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-30', '0:00:11.068610', '11.06861', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.068610')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.06861')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-30', '0:00:12.970900', '12.9709005', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.970900')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.9709005')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-30', '0:00:10.590127', '10.590127', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.590127')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.590127')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:18.547392', '18.547392', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.547392')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.547392')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:13.772058', '13.772058', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.772058')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.772058')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:13.783222', '13.783222', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.783222')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.783222')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:11.384732', '11.384732', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.384732')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.384732')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-30', '0:00:13.428152', '13.428152', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.428152')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.428152')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-30', '0:00:17.026494', '17.026494', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.026494')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.026494')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-30', '0:00:15.574202', '15.574202', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Emplantillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.574202')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.574202')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-12', '0:01:08.000000', '68.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '68.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:01:10.550000', '70.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:10.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '70.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:01:13.200000', '73.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:13.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '73.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:01:50.250000', '110.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:50.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '110.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-12', '0:01:14.633333', '74.63333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:14.633333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '74.63333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-12', '0:02:07.650000', '127.65', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Empuntillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:07.650000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '127.65')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:00:47.300000', '47.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Etiqueta lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:00:48.900000', '48.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Etiqueta lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:48.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '48.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-22', '0:00:49.503258', '49.503258', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Etiqueta lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.503258')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.503258')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-22', '0:00:53.815213', '53.8152133', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Etiqueta lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.815213')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.8152133')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:56.637055', '56.63705545000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Etiqueta lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.637055')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.63705545000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:20.003121', '20.003121', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.003121')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.003121')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:15.689074', '15.689074', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.689074')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.689074')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:16.721406', '16.721406', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.721406')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.721406')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:16.862858', '16.86285833333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.862858')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.86285833333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:14.763643', '14.7636435', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.763643')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.7636435')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:15.882958', '15.8829585', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.882958')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.8829585')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 6.0, '2024-09-19', '0:00:17.543581', '17.543581', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 6.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.543581')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.543581')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 12.0, '2024-09-19', '0:00:13.650266', '13.65026666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 12.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.650266')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.65026666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:20.381565', '20.381565', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.381565')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.381565')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:11.833031', '11.833031', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.833031')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.833031')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:12.785947', '12.7859475', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.785947')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.7859475')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:14.709354', '14.709354', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.709354')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.709354')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:12.398418', '12.398418', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.398418')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.398418')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:14.574872', '14.574872', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.574872')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.574872')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:15.113741', '15.11374133333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.113741')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.11374133333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:15.186318', '15.18631866666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.186318')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.18631866666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:15.747077', '15.74707766666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.747077')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.74707766666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:15.964371', '15.96437133333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.964371')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.96437133333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-10-03', '0:00:16.022204', '16.022204', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.022204')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.022204')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:13.506557', '13.506558', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.506557')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.506558')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:13.982143', '13.98214375', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.982143')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.98214375')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:14.893512', '14.893512', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.893512')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.893512')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:16.618889', '16.61888925', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.618889')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.61888925')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-10-03', '0:00:17.128598', '17.12859825', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Etiquetado y embalaje'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.128598')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.12859825')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:03:04.000000', '184.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '184.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:03:11.000000', '191.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:11.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '191.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:03:19.000000', '199.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:19.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '199.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:03:31.000000', '211.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:31.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '211.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:03:31.000000', '211.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:03:31.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '211.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:00.000000', '240.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '240.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:03.000000', '243.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:03.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '243.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:06.000000', '246.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '246.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:15.000000', '255.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '255.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-22', '0:04:16.000000', '256.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Hitex'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:04:16.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '256.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:56.000000', '56.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:56.000000', '56.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:57.000000', '57.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:58.000000', '58.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:58.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '58.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:00.000000', '60.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:47.000000', '107.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:47.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '107.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:55.000000', '115.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Ingreso de piezas en el vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:55.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '115.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:26.695805', '26.695805', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.695805')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.695805')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:35.356028', '35.356028', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.356028')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.356028')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:35.879182', '35.879182', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.879182')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.879182')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:37.648183', '37.648183', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.648183')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.648183')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:38.061398', '38.061398', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.061398')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.061398')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:49.873682', '49.873682', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.873682')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.873682')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:49.984548', '49.984548', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.984548')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.984548')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:50.333927', '50.333927', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.333927')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.333927')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:50.441667', '50.441667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.441667')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.441667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:50.894641', '50.894641', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.894641')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.894641')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:51.072891', '51.072891', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.072891')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.072891')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:51.660973', '51.660973', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.660973')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.660973')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:53.584303', '53.584303', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.584303')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.584303')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:55.778305', '55.778305', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:55.778305')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '55.778305')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:56.684837', '56.684837', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.684837')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.684837')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:57.979245', '57.979245', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.979245')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.979245')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:59.017077', '59.017077', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.017077')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.017077')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:59.026924', '59.026924', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.026924')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.026924')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:59.288141', '59.288141', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.288141')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.288141')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:00.163343', '60.163343', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.163343')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.163343')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:01.357086', '61.357086', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.357086')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.357086')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:01.712587', '61.712587', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.712587')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.712587')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:02.176094', '62.176094', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.176094')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.176094')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:02.948411', '62.948411', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.948411')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.948411')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:01:03.795260', '63.79526', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Inyección del PVC'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:03.795260')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '63.79526')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:42.799036', '42.7990361', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:42.799036')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '42.7990361')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:43.316069', '43.3160693', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.316069')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.3160693')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-28', '0:00:53.858564', '53.8585642', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.858564')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.8585642')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-28', '0:00:49.172258', '49.17225835', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:49.172258')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '49.17225835')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-28', '0:00:35.436699', '35.436699', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-28'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.436699')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.436699')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:13.450393', '13.450393', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.450393')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.450393')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:13.752279', '13.752279', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.752279')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.752279')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.216299', '14.216299', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.216299')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.216299')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.002841', '15.002841', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.002841')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.002841')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.334984', '15.334984', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.334984')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.334984')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.041461', '19.041461', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.041461')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.041461')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.206711', '19.206711', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.206711')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.206711')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.287026', '19.287026', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.287026')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.287026')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.354928', '19.354928', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.354928')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.354928')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:20.914772', '20.914772', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.914772')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.914772')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:18.093125', '18.0931255', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.093125')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.0931255')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.262822', '19.262822', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.262822')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.262822')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:19.519279', '19.519279', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.519279')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.519279')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.073627', '20.073627', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.073627')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.073627')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.210233', '20.210233', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.210233')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.210233')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.402777', '20.4027775', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.402777')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.4027775')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.439755', '20.4397555', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.439755')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.4397555')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.805928', '20.8059285', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.805928')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.8059285')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:21.398128', '21.398128', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.398128')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.398128')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:22.193410', '22.1934105', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.193410')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.1934105')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:24.660218', '24.6602185', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.660218')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.6602185')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:29.271237', '29.2712375', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Lijado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.271237')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.2712375')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:41.112444', '41.112444', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.112444')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.112444')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:53.940068', '53.940068', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.940068')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.940068')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:01:01.298951', '61.298951', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.298951')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.298951')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:51.966511', '51.966511', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.966511')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.966511')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:47.631352', '47.631352', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.631352')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.631352')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:47.401561', '47.401561', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.401561')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.401561')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:47.966897', '47.966897', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.966897')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.966897')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:53.107785', '53.107785', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.107785')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.107785')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:54.439242', '54.439242', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.439242')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.439242')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:02.477886', '62.477886', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:02.477886')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '62.477886')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:03.411227', '63.411227', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:03.411227')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '63.411227')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:05.330370', '65.33037', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:05.330370')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '65.33037')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:07.214800', '67.2148', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:07.214800')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '67.2148')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:07.303213', '67.303213', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:07.303213')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '67.303213')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:23.300433', '83.300433', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:23.300433')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '83.300433')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:01:00.974958', '60.974958', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Limpieza de residuos de adhesivo'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.974958')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.974958')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-16', '0:00:14.005683', '14.005683', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.005683')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.005683')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 6.0, '2024-10-16', '0:00:12.770419', '12.770419', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 6.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.770419')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.770419')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 8.0, '2024-10-16', '0:00:11.626726', '11.626726625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 8.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.626726')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.626726625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 7.0, '2024-10-16', '0:00:13.851721', '13.85172128571429', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 7.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.851721')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.85172128571429')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-16', '0:00:11.442473', '11.4424739', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.442473')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.4424739')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-10-16', '0:00:11.558743', '11.55874338461538', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.558743')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.55874338461538')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 27.0, '2024-10-16', '0:00:13.012010', '13.01201092592593', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 27.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.012010')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.01201092592593')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 70.0, '2024-10-16', '0:00:10.753716', '10.75371668571429', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Limpieza de suelas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 70.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.753716')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.75371668571429')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-24', '0:01:13.466017', '73.4660172', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:13.466017')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '73.4660172')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:27.200000', '27.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Mesa puesta de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:27.200000', '27.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Mesa puesta de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:32.075000', '32.075', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Mesa puesta de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.075000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.075')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:32.625000', '32.625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Mesa puesta de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.625000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-29', '0:00:32.625000', '32.625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Mesa puesta de hebilla'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.625000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-16', '0:00:13.500000', '13.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-09-16', '0:00:19.933333', '19.93333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.933333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.93333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-16', '0:00:20.450000', '20.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:15.333333', '15.33333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.333333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.33333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:15.633333', '15.63333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.633333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.63333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:18.366666', '18.36666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.366666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.36666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-16', '0:00:18.866666', '18.86666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Ojetillado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-16'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.866666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.86666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:23.710426', '23.710426', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.710426')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.710426')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:23.931591', '23.931591', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.931591')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.931591')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:24.933148', '24.933148', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.933148')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.933148')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:25.410701', '25.410701', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.410701')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.410701')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:28.514439', '28.514439', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.514439')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.514439')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:29.873538', '29.873538', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.873538')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.873538')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:30.473665', '30.473665', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.473665')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.473665')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:33.320976', '33.320976', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.320976')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.320976')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:34.910192', '34.910192', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.910192')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.910192')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:37.654126', '37.654126', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.654126')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.654126')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:41.602106', '41.602106', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.602106')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.602106')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:41.658025', '41.658025', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.658025')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.658025')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.856286', '22.856286', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.856286')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.856286')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.937670', '22.93767', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.937670')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.93767')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:23.429361', '23.429361', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.429361')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.429361')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:24.686751', '24.686751', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.686751')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.686751')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:25.053009', '25.053009', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.053009')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.053009')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:25.716856', '25.716856', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.716856')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.716856')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:26.588642', '26.588642', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.588642')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.588642')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:26.774814', '26.774814', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.774814')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.774814')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:29.387888', '29.387888', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.387888')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.387888')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:29.662626', '29.662626', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega capellada'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.662626')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.662626')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:13.639059', '13.639059', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.639059')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.639059')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.254230', '14.254231', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.254230')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.254231')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.293908', '14.293908', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.293908')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.293908')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.401615', '14.401615', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.401615')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.401615')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:14.478326', '14.478326', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.478326')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.478326')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.199803', '15.199803', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.199803')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.199803')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.666612', '15.666612', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.666612')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.666612')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:16.391597', '16.391597', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.391597')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.391597')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:16.523356', '16.523357', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.523356')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.523357')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:27.993719', '27.993719', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.993719')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.993719')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:14.655048', '14.655048', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.655048')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.655048')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.282476', '15.282476', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.282476')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.282476')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.889419', '15.889419', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.889419')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.889419')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:15.991897', '15.991897', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.991897')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.991897')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:16.855080', '16.85508', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.855080')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.85508')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:16.949729', '16.949729', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.949729')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.949729')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:17.339394', '17.339394', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.339394')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.339394')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:18.070543', '18.070543', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.070543')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.070543')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:18.156769', '18.156769', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.156769')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.156769')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:19.333885', '19.333885', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.333885')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.333885')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:28.802808', '28.802808', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.802808')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.802808')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:37.010969', '37.010969', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.010969')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.010969')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:18.638628', '18.638628', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.638628')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.638628')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:36.359656', '36.359656', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.359656')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.359656')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:21.801660', '21.80166', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.801660')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.80166')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:15.563703', '15.563703', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.563703')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.563703')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:31.095268', '31.095268', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:31.095268')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '31.095268')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 0.5, '2024-11-05', '0:00:22.937826', '22.937826', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 0.5)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.937826')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.937826')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:33.299144', '33.299144', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.299144')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.299144')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:23.932091', '23.932091', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.932091')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.932091')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:18.946091', '18.946091', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Pega suela'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.946091')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.946091')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-08-15', '0:01:09.076923', '69.07692307692308', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Perforación de piezas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:09.076923')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '69.07692307692308')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:40.625000', '40.625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Perforación de piezas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.625000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-22', '0:00:28.947905', '28.947905', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Perforación de piezas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.947905')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.947905')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-22', '0:00:31.833286', '31.8332864', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Perforación de piezas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:31.833286')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '31.8332864')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-22', '0:00:41.360306', '41.3603061', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Perforación de piezas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.360306')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.3603061')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 50.0, '2024-08-29', '0:00:05.360000', '5.36', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 50.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.360000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.36')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.050000', '1.05', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.050000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.05')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.250000', '1.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.300000', '1.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.300000', '1.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.450000', '1.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.650000', '1.65', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.650000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.65')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.950000', '1.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Pintado de hebillero'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:11.923197', '11.923197', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.923197')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.923197')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:12.775727', '12.775727', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.775727')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.775727')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.924477', '15.924477', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.924477')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.924477')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.422203', '19.422203', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.422203')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.422203')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:21.430914', '21.430914', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.430914')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.430914')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.452928', '22.452928', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.452928')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.452928')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:26.826735', '26.826735', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.826735')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.826735')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:28.296290', '28.29629', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.296290')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.29629')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:34.421719', '34.421719', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.421719')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.421719')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:35.911068', '35.911068', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.911068')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.911068')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:28.063382', '28.063383', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:28.063382')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '28.063383')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:36.354963', '36.354963', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:36.354963')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '36.354963')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:24.416748', '24.4167485', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.416748')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.4167485')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:24.976713', '24.976713', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.976713')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.976713')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:26.688636', '26.688636', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.688636')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.688636')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:29.576255', '29.576255', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Planchado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.576255')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.576255')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:15.787715', '75.787715', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:15.787715')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '75.787715')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:33.219066', '33.21906633333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.219066')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.21906633333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:33.437834', '33.43783433333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.437834')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.43783433333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:34.107121', '34.10712166666666', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.107121')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.10712166666666')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:35.500910', '35.50091033333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.500910')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.50091033333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:27.303635', '27.30363575', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.303635')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.30363575')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:39.760676', '39.76067666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.760676')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.76067666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-09-19', '0:00:31.469841', '31.46984175', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:31.469841')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '31.46984175')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 3.0, '2024-09-19', '0:00:47.236039', '47.236039', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 3.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:47.236039')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '47.236039')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:41.393564', '41.393564', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.393564')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.393564')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:45.405817', '45.405817', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:45.405817')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '45.405817')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:53.210573', '53.210573', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:53.210573')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '53.210573')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:56.626874', '56.626874', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:56.626874')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '56.626874')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:57.183495', '57.183495', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.183495')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.183495')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:57.785857', '57.785857', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:57.785857')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '57.785857')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:59.075023', '59.075023', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:59.075023')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '59.075023')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:01:00.530135', '60.530135', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.530135')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.530135')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:01:01.355250', '61.35525', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.355250')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.35525')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:01:01.371719', '61.371719', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Prensado-reactivación pegamento'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.371719')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.371719')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:33.000000', '33.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:33.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '33.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:35.000000', '35.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:37.000000', '37.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:38.000000', '38.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:38.000000', '38.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:38.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '38.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:43.000000', '43.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:46.000000', '46.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:46.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '46.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:50.000000', '50.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:01:06.000000', '66.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Preparación para costurera autómata'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '66.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-24', '0:00:14.559188', '14.5591882', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Quemado de hilos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.559188')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.5591882')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-24', '0:00:14.625508', '14.6255082', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Quemado de hilos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.625508')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.6255082')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:17.095033', '17.09503306666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Quemado de hilos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.095033')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.09503306666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:20.607106', '20.6071061', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Quemado de hilos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.607106')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.6071061')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:16.839654', '16.8396543', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Quemado de hilos'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.839654')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.8396543')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-11-05', '0:00:06.530260', '6.530260866666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Remachado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.530260')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.530260866666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-11-05', '0:00:07.289075', '7.289075', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Remachado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.289075')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.289075')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:07.325366', '7.325366', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Remachado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.325366')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.325366')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:07.158623', '7.1586235', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Remachado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.158623')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.1586235')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-05', '0:00:06.539286', '6.539286049999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Remachado de flor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.539286')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.539286049999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:30.091333', '30.091333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.091333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.091333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:30.466753', '30.466753', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.466753')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.466753')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:44.229569', '44.229569', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:44.229569')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '44.229569')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:24.363714', '24.3637145', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.363714')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.3637145')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:01:23.251190', '83.25119', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:23.251190')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '83.25119')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:08.980983', '8.980983', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.980983')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.980983')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:09.335652', '9.335652', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.335652')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.335652')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:09.603127', '9.603127', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.603127')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.603127')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:11.610494', '11.610494', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.610494')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.610494')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:11.827011', '11.827011', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.827011')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.827011')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.110600', '15.1106', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.110600')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.1106')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:15.468738', '15.468738', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.468738')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.468738')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:16.668108', '16.668108', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.668108')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.668108')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:17.560701', '17.560701', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.560701')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.560701')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:18.725425', '18.725425', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.725425')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.725425')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:19.779903', '19.779903', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.779903')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.779903')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.323241', '22.323241', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.323241')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.323241')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:22.705459', '22.705459', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.705459')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.705459')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:25.278011', '25.278011', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:25.278011')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '25.278011')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-09-19', '0:00:34.024121', '34.024121', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.024121')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.024121')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-09-19', '0:00:21.848252', '21.848252', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-19'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.848252')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.848252')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:10.127760', '10.12776', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.127760')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.12776')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:07.413239', '7.413239', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.413239')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.413239')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:13.342943', '13.342943', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.342943')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.342943')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:17.416349', '17.416349', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.416349')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.416349')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:21.771830', '21.77183', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.771830')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.77183')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:15.526883', '15.5268835', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.526883')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.5268835')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:17.365367', '17.365367', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.365367')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.365367')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:17.447021', '17.4470215', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.447021')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.4470215')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-10-03', '0:00:35.644772', '35.644772', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:35.644772')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '35.644772')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.041487', '20.041487', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.041487')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.041487')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.602074', '20.6020745', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.602074')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.6020745')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:20.993741', '20.9937415', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.993741')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.9937415')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:23.348065', '23.348065', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.348065')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.348065')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:23.641583', '23.641583', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.641583')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.641583')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 2.0, '2024-10-03', '0:00:32.145293', '32.1452935', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Revisión'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-03'
    AND (dp.cantidad IS NOT DISTINCT FROM 2.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.145293')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.1452935')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 9.0, '2024-08-15', '0:00:41.222222', '41.22222222222222', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 9.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.222222')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.22222222222222')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:00:45.100000', '45.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:45.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '45.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:37.400000', '37.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 51.0, '2024-08-15', '0:00:51.470588', '51.47058823529412', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 51.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:51.470588')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '51.47058823529412')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 14.0, '2024-08-29', '0:00:52.000000', '52.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 14.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:52.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '52.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-08-29', '0:01:06.733333', '66.73333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:06.733333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '66.73333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-08-29', '0:01:07.133333', '67.13333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:07.133333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '67.13333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:50.450000', '50.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-08-29', '0:01:33.000000', '93.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Ribeteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:33.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '93.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:06.000000', '6.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:06.000000', '6.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:07.000000', '7.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:08.000000', '8.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:13.000000', '13.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:21.000000', '21.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:27.000000', '27.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:29.000000', '29.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:30.000000', '30.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-08-12', '0:00:52.000000', '52.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Salida del vastidor'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:52.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '52.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-10-18', '0:00:16.531626', '16.53162623076923', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.531626')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.53162623076923')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-10-18', '0:00:16.683042', '16.68304276923077', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.683042')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.68304276923077')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-10-18', '0:00:19.569607', '19.56960723076923', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:19.569607')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '19.56960723076923')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-10-18', '0:00:23.230200', '23.23020006666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.230200')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.23020006666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 13.0, '2024-10-21', '0:00:18.661969', '18.66196953846154', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 13.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.661969')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.66196953846154')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 11.0, '2024-10-21', '0:00:26.424780', '26.42478090909091', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 11.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:26.424780')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '26.42478090909091')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 15.0, '2024-10-21', '0:00:22.033703', '22.03370353333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 15.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.033703')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.03370353333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 16.0, '2024-10-21', '0:00:22.026761', '22.0267615625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 16.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.026761')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.0267615625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 17.0, '2024-10-21', '0:00:22.457638', '22.45763847058824', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 17.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.457638')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.45763847058824')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 12.0, '2024-10-21', '0:00:34.997739', '34.99773966666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 12.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:34.997739')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '34.99773966666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 23.0, '2024-10-21', '0:00:21.395283', '21.395283', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 23.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.395283')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.395283')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 18.0, '2024-10-21', '0:00:29.289128', '29.28912872222222', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Sintético'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 18.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:29.289128')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '29.28912872222222')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-18', '0:00:43.500000', '43.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Terminación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-09-18', '0:01:01.800000', '61.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Terminación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:01.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '61.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:00:50.900000', '50.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Terminación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-18', '0:01:03.950000', '63.95', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Terminación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:03.950000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '63.95')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:54.532963', '54.53296385', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Terminación de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:54.532963')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '54.53296385')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:41.914209', '41.914209', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:41.914209')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '41.914209')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:30.073096', '30.073096', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:30.073096')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '30.073096')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:24.542226', '24.542226', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:24.542226')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '24.542226')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:37.104899', '37.104899', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.104899')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.104899')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:27.529346', '27.529346', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:27.529346')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '27.529346')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:39.169339', '39.169339', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.169339')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.169339')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:23.346214', '23.346214', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.346214')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.346214')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 1.0, '2024-11-05', '0:00:23.479466', '23.479466', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-05'
    AND (dp.cantidad IS NOT DISTINCT FROM 1.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.479466')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.479466')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-23', '0:00:20.222409', '20.22240952', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.222409')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.22240952')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-23', '0:00:20.255863', '20.25586344', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.255863')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.25586344')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-23', '0:00:21.450000', '21.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-23', '0:00:14.302374', '14.30237426666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.302374')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.30237426666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-23', '0:00:17.605810', '17.60581085', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de chapeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.605810')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.60581085')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-23', '0:00:09.554597', '9.554597366666666', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.554597')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.554597366666666')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-23', '0:00:12.320859', '12.3208591', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.320859')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.3208591')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-23', '0:00:07.291304', '7.291304766666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.291304')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.291304766666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-23', '0:00:08.911573', '8.91157316', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.911573')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.91157316')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-23', '0:00:08.267071', '8.26707156', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de colita'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.267071')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.26707156')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:10.434747', '10.4347479', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.434747')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.4347479')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:10.925048', '10.925048', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.925048')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.925048')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.123964', '9.1239642', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.123964')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.1239642')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.450808', '9.450808949999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.450808')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.450808949999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.933894', '9.93389455', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.933894')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.93389455')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.274493', '10.274493', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.274493')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.274493')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.495257', '10.4952573', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.495257')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.4952573')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.992902', '10.99290245', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.992902')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.99290245')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.278876', '10.27887643333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.278876')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.27887643333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.839451', '10.83945186666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.839451')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.83945186666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:07.838993', '7.83899335', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.838993')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.83899335')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:07.210582', '7.21058245', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.210582')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.21058245')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:07.486735', '7.486735299999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.486735')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.486735299999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:07.445175', '7.44517585', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.445175')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.44517585')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:06.409252', '6.40925285', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.409252')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.40925285')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-30', '0:00:05.789376', '5.7893767', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-30'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.789376')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.7893767')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-10-18', '0:00:04.920078', '4.920078075', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.920078')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.920078075')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-10-18', '0:00:08.800262', '8.800262974999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.800262')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.800262974999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-10-18', '0:00:09.219382', '9.2193822', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.219382')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.2193822')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-10-18', '0:00:09.342030', '9.342030675', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.342030')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.342030675')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-23', '0:00:16.793533', '16.79353365', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.793533')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.79353365')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-23', '0:00:14.087078', '14.08707835', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.087078')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.08707835')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-23', '0:00:16.128633', '16.1286331', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:16.128633')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '16.1286331')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:06.868670', '6.868670433333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.868670')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.868670433333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:06.522099', '6.5220992', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.522099')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.5220992')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:06.513361', '6.513361466666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.513361')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.513361466666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:06.359055', '6.3590553', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.359055')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.3590553')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-24', '0:00:06.913667', '6.913667333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de lengüeta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-24'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.913667')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.913667333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:11.973342', '11.9733421', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.973342')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.9733421')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:12.836474', '12.8364741', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.836474')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.8364741')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:14.914301', '14.9143014', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.914301')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.9143014')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:11.548016', '11.5480161', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.548016')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.5480161')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:13.172973', '13.1729731', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.172973')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.1729731')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:10.724513', '10.7245138', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.724513')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.7245138')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-23', '0:00:09.136715', '9.136715800000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-23'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.136715')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.136715800000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:02.750972', '2.7509722', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:02.750972')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '2.7509722')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:03.388968', '3.388968', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.388968')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.388968')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:04.559443', '4.559443', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.559443')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.559443')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:05.053355', '5.053355', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.053355')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.053355')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:05.669571', '5.66957165', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.669571')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.66957165')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:05.798014', '5.79801455', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.798014')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.79801455')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:06.051914', '6.051914699999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.051914')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.051914699999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:06.917616', '6.91761625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.917616')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.91761625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:06.985099', '6.98509995', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:06.985099')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '6.98509995')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:11.470958', '11.4709581', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.470958')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.4709581')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-10-21', '0:00:07.657079', '7.657079475000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:07.657079')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '7.657079475000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:10.546442', '10.5464429', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.546442')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.5464429')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:08.729910', '8.72991015', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:08.729910')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '8.72991015')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:09.501949', '9.5019495', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.501949')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.5019495')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:12.038557', '12.0385576', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.038557')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.0385576')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:13.400883', '13.4008831', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.400883')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.4008831')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:11.600428', '11.600428', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.600428')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.600428')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:12.636129', '12.63612955', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.636129')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.63612955')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-22', '0:00:10.190386', '10.1903861', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de talón'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.190386')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.1903861')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:03.475000', '3.475', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:03.475000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '3.475')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:04.000000', '4.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:05.475000', '5.475', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.475000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.475')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:05.750000', '5.75', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.750000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.75')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-18', '0:00:14.429988', '14.4299881', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:14.429988')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '14.4299881')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-18', '0:00:17.922207', '17.9222077', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.922207')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.9222077')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-18', '0:00:20.660765', '20.6607658', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:20.660765')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '20.6607658')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-18', '0:00:21.206155', '21.2061557', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.206155')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.2061557')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-18', '0:00:21.824509', '21.8245093', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de talón y lateral'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-18'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:21.824509')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '21.8245093')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:04.225000', '4.225', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:04.225000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '4.225')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 40.0, '2024-08-15', '0:00:05.550000', '5.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 40.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:05.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '5.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-22', '0:00:10.693438', '10.69343836', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.693438')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.69343836')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-22', '0:00:12.064203', '12.06420344', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:12.064203')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '12.06420344')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-22', '0:00:13.364539', '13.36453916', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.364539')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.36453916')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 25.0, '2024-10-22', '0:00:11.784252', '11.7842522', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Tizado de u'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-22'
    AND (dp.cantidad IS NOT DISTINCT FROM 25.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.784252')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.7842522')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:15.450000', '15.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:17.100000', '17.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:17.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '17.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:18.350000', '18.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:18.350000', '18.35', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.350000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.35')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:18.500000', '18.5', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:18.500000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '18.5')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:22.800000', '22.8', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 428'
WHERE m.catalogo_nombre = 'Dana 428' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:22.800000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '22.8')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:13.200000', '13.2', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:13.200000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '13.2')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:15.000000', '15.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:15.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '15.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-12', '0:00:43.700000', '43.7', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.700000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.7')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-12', '0:00:32.850000', '32.85', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:32.850000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '32.85')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:23.066666', '23.06666666666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:23.066666')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '23.06666666666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:40.100000', '40.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:40.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '40.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-08-12', '0:00:44.100000', '44.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Unión de reina (zigzag doble)'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-12'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:44.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '44.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:01:45.900000', '105.9', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:45.900000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '105.9')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:01:10.000000', '70.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:10.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '70.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 6.0, '2024-08-15', '0:01:21.000000', '81.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 6.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:21.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '81.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 4.0, '2024-08-15', '0:02:01.000000', '121.0', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 4.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:02:01.000000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '121.0')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 8.0, '2024-08-15', '0:01:32.625000', '92.625', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 8.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:32.625000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '92.625')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:01:30.400000', '90.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:30.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '90.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 5.0, '2024-08-15', '0:01:00.600000', '60.6', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 5.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:00.600000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '60.6')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-08-15', '0:01:16.400000', '76.4', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Pegado en mesa de manualidades'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-15'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:01:16.400000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '76.4')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:10.434747', '10.4347479', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.434747')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.4347479')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2024-10-21', '0:00:10.925048', '10.925048', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.925048')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.925048')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.123964', '9.1239642', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.123964')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.1239642')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.450808', '9.450808949999999', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.450808')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.450808949999999')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:09.933894', '9.93389455', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.933894')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.93389455')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.274493', '10.274493', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.274493')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.274493')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.495257', '10.4952573', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.495257')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.4952573')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-10-21', '0:00:10.992902', '10.99290245', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.992902')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.99290245')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.278876', '10.27887643333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.278876')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.27887643333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-10-21', '0:00:10.839451', '10.83945186666667', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Tizado de cuello'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-10-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.839451')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.83945186666667')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:39.550000', '39.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:50.100000', '50.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:43.533333', '43.53333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 120'
WHERE m.catalogo_nombre = 'Dakar 120' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.533333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.53333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:39.550000', '39.55', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:39.550000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '39.55')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-09-13', '0:00:50.100000', '50.1', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:50.100000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '50.1')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:37.833333', '37.83333333333334', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:37.833333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '37.83333333333334')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 30.0, '2024-09-13', '0:00:43.533333', '43.53333333333333', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dakar 122'
WHERE m.catalogo_nombre = 'Dakar 122' AND m.proceso_nombre = 'Colocación de contrafuerte'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-09-13'
    AND (dp.cantidad IS NOT DISTINCT FROM 30.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:43.533333')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '43.53333333333333')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.050000', '1.05', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.050000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.05')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.250000', '1.25', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.250000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.25')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.300000', '1.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.300000', '1.3', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.300000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.3')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.450000', '1.45', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.450000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.45')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-08-29', '0:00:01.650000', '1.65', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Dana 420'
WHERE m.catalogo_nombre = 'Dana 420' AND m.proceso_nombre = 'Pintado de correas'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-08-29'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:01.650000')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '1.65')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-06', '0:00:11.686733', '11.6867338', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-06'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:11.686733')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '11.6867338')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-06', '0:00:09.335824', '9.335824200000001', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-06'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:09.335824')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '9.335824200000001')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 20.0, '2024-11-06', '0:00:10.839199', '10.83919925', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Bambas'
WHERE m.catalogo_nombre = 'Bambas' AND m.proceso_nombre = 'Tizado de punta'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2024-11-06'
    AND (dp.cantidad IS NOT DISTINCT FROM 20.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:10.839199')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '10.83919925')
);
INSERT INTO public.datos_proceso (id_proceso, id_catalogo, cantidad, fecha, tiempo_total_min, tiempo_total_seg, operario, notas)
SELECT m.id_proceso, c.id_catalogo, 10.0, '2025-03-21', '0:00:00.191430', '0.1914304', NULL, NULL
FROM _map m JOIN public.catalogo c ON c.nombre = 'Airflow'
WHERE m.catalogo_nombre = 'Airflow' AND m.proceso_nombre = 'Jaleteado'
AND NOT EXISTS (
  SELECT 1 FROM public.datos_proceso dp
  WHERE dp.id_proceso = m.id_proceso AND dp.id_catalogo = c.id_catalogo
    AND dp.fecha = '2025-03-21'
    AND (dp.cantidad IS NOT DISTINCT FROM 10.0)
    AND (dp.tiempo_total_min IS NOT DISTINCT FROM '0:00:00.191430')
    AND (dp.tiempo_total_seg IS NOT DISTINCT FROM '0.1914304')
);
COMMIT;