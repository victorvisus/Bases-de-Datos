
/** -- COUNT: Devuelve el numero de filas que hay segun el criterio o grupo que hayamos creado
Cuenta todo, incluído las filas duplicadas, pero no cuetna los nulos
**/
SELECT COUNT(localidad) FROM empleado;

SELECT COUNT(salario), COUNT(comision) FROM empleado WHERE salario > 2000;

SELECT localidad, COUNT(codemple) FROM empleado GROUP BY localidad;

SELECT localidad, COUNT(codemple) AS "numempleado" FROM empleado  
GROUP BY localidad HAVING COUNT(codemple) > 3;

/** -- GROUP BY: Agrupa valores, recupera un conjunto de valores de una tabla
Hay que indicarle la columna por la que se quiere hacer la agrupación
**/
SELECT d.coddpto, d.denominacion, COUNT(e.codemple) FROM empleado e
INNER JOIN dpto d ON e.coddpto = d.coddpto GROUP BY d.coddpto, d.denominacion ORDER BY d.coddpto;


/** --HAVING: es el WHERE del GROUP BY
**/
SELECT COUNT(codemple)
FROM empleado
GROUP BY coddpto HAVING MIN(salario) < 5000
ORDER BY coddpto;

SELECT d.coddpto, d.denominacion, COUNT(e.codemple) AS num_empleados, SUM(e.salario) FROM empleado e
INNER JOIN dpto d ON e.coddpto = d.coddpto
GROUP BY d.coddpto, d.denominacion
ORDER BY d.coddpto;

