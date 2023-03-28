-- EJERCICIO 5 -------------------------------------------------------------

-- 1)
SELECT nombre FROM trabajador
    WHERE nombre = ALL (
        SELECT id_supv FROM trabajador
    )
    GROUP BY nombre
    HAVING UPPER(nombre) LIKE('%RR%')
);
--- cuestión 1: Parcialmente bien resuelta, la condicion de la primera consulta nunca se puede complir.

-- 2)
SELECT id_supv, COUNT(id_t) AS Num_trabajadores FROM trabajador
    GROUP BY id_supv;

-- 3)
SELECT LOWER(nombre) FROM trabajador
    WHERE tarifa = (
        SELECT MAX(tarifa) FROM trabajador
    ) OR (
        SELECT MIN(tarifa) FROM trabajador
    );
--- cuestión 3: mal resuelta. Estructura erronea OR. Deberías usar UNION con dos consultas o IN en una subconsulta y los valores obtenidos de las dos subconsultas.

-- 4)
SELECT t.nombre FROM trabajador t
    JOIN asignacion a ON a.id_t = t.id_t
    WHERE t.id_t NOT IN (
        SELECT a1.id_t FROM asignacion a1
    );

-- 5)
SELECT dir FROM edificio
    WHERE nivel_calidad > (
        SELECT AVG(nivel_calidad) FROM edificio
);

-- 6)
SELECT (t.tarifa * a.num_dias) AS Coste FROM trabajador t, edificio e, asignacion a
    WHERE a.id_t = t.id_t AND a.id_e = e.id_e
    GROUP BY e.categoria
    HAVING e.categoria = 3 AND t.oficio = 'ALBAÑIL';
--- cuestión 6: parcialmente bien resuelta. deberías usar LEFT join para que aparezcan los edificios tambien sin coste.

-- 7)
SELECT t.nombre, (t.tarifa * a.num_dias) AS Importe FROM trabajadores t
    JOIN asignacion a ON t.id_t = a.id_t
    JOIN edificio e ON a.id_e = e.id_e
    WHERE a.fecha_inicio BETWEEN '2001-10-01' AND '2001-10-30'
    GROUP BY e.categoria
    HAVING e.categoria = 1;
--- cuestión 7: parcialmente bien resuelta. deberías usar LEFT join para que aparezcan los trabajadores que no ganan



