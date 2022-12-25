/**
1. Obtener los nombres y salarios de los empleados que cobran más de 985 euros y
tienen una comisión es superior al 5% de su salario.
**/
SELECT nombre, salario FROM empleado WHERE salario > 985 AND comision > (salario * 0.05);

SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2, e.salario, e.comision, (e.comision / e.salario) * 100 AS "PORCENTAJE"
    FROM empleado e
    WHERE e.salario > 985 AND e.comision > (e.salario * 0.05);

/**
2. Obtener el código de empleado, código de departamento, nombre y sueldo total 
en pesetas de aquellos empleados cuyo sueldo total (salario más comisión) supera 
los 1350 euros. Presentarlos ordenados por código de departamento y dentro de 
éstos por orden alfabético.
**/
/*
--NVL(expresion, valor): lo que hace es devolver el valor, si la primera expresión tiene un valor null.
SELECT e.nombre, NVL(e.salario + e.comision, e.salario) AS "SUELDO TOTAL" FROM empleado e;
--NVL2(expresion, valor1, valor2): si el valor de la expresión NO es nulo nos devuelve el primer valor, y si es null el segundo
SELECT e.nombre, NVL2(e.comision, e.salario + e.comision, e.salario) AS "SUELDO TOTAL" FROM empleado e;
*/
SELECT e.codemple, e.coddpto, e.nombre, e.salario,
    NVL(e.comision, 0) AS "COMISION",
    NVL2(e.comision, e.salario + e.comision, e.salario) * 166.386 AS "SUELDO TOTAL ptas"
    FROM empleado e
    WHERE NVL2(e.comision, e.salario + e.comision, e.salario) > 1350
    ORDER BY e.coddpto, e.nombre;

/**
3.	Obtener un listado con los nombres, y apellidos de los empleados y sus años
de antigüedad en la empresa, ordenado por años de antigüedad siendo los que más
años llevan los primeros que deban aparecer.
**/
SELECT e.nombre, e.ape1, e.ape2, e.fechaingreso,
    TRUNC(MONTHS_BETWEEN(SYSDATE,e.fechaingreso)/12, 0) AS Antigüedad
    FROM empleado e
    ORDER BY Antigüedad DESC;

/**
4. Obtener el nombre de los empleados que trabajan en un departamento con presupuesto
superior a 50.000 euros pero menor de 60000 euros. Hay que usar predicado cuantificado
**/
SELECT e.nombre, d.coddpto AS "CODIGO DPTO", d.denominacion, d.presupuesto AS "PRESUPUESTO DPTO" FROM empleado e
  JOIN dpto d ON d.coddpto = e.coddpto
  WHERE d.presupuesto = ANY (
    SELECT d.presupuesto FROM dpto d WHERE d.presupuesto > 50000 AND d.presupuesto < 60000)
  ORDER BY e.coddpto;

/**
5. Obtener en orden alfabético los nombres de empleado cuyo salario es inferior
al mínimo de los empleados del departamento 1.
**/
SELECT e.nombre, e.salario 
    FROM empleado e
    WHERE /* salario < al menor salario de los empleados del dpto 1*/
    e.salario < (
        SELECT MIN(e1.salario) FROM empleado e1 WHERE e1.coddpto = 1);

/**
6. Obtener el nombre de los empleados que trabajan en el departamento del cuál es
jefe el empleado con código 1.
**/
SELECT e.nombre || ' ' || e.ape1 AS nombre, e.coddpto, d.denominacion, d.codemplejefe
    FROM empleado e
    INNER JOIN dpto d ON e.coddpto = d.coddpto
    WHERE d.codemplejefe = 1;

/**
7. Obtener los nombres de los empleados cuyo primer apellido empiece por una de
las siguientes letras: p, q, r, s.
**/
SELECT e.nombre, e.ape1 FROM empleado e
  WHERE
    LOWER(e.ape1) LIKE('p%')
    OR LOWER(e.ape1) LIKE('q%')
    OR LOWER(e.ape1) LIKE('r%')
    OR LOWER(e.ape1) LIKE('s%');

/**
8. Obtener los nombres de los empleados que viven en ciudades en las que hay algún
centro de trabajo
**/


/**
9. Obtener en orden alfabético los salarios y nombres de los empleados cuyo salario
sea superior al 60% del máximo salario de la empresa.
**/
SELECT e.nombre, e.salario
    FROM empleado e
    WHERE e.salario > (
        SELECT MAX(e.salario) * 0.6 FROM empleado e);

/**
10.	El nombre y apellidos del empleado que más salario cobra
**/
SELECT e.nombre, e.ape1, e.ape2
    FROM empleado e
    WHERE e.salario = (
        SELECT MAX(e.salario)FROM empleado e);

/**
11. Obtener las localidades y número de empleados de aquellas en las que viven
más de 3 empleados
**/
SELECT localidad, COUNT(codemple) AS "num_empleado" FROM empleado  
GROUP BY localidad HAVING COUNT(codemple) > 3;

/**
12. Obtener los nombres de todos los centros y los departamentos que se ubican en
cada uno, así como aquellos centros que no tienen departamentos.

-- NO Exite un campo nombre. Modifico la tabla
**/
ALTER TABLE centro ADD (nombre_centro VARCHAR2(20));

INSERT INTO centro (nombre_centro) VALUES (centro1) WHERE codcentro = 1;
UPDATE centro SET nombre_centro = centro2 WHERE codcentro = 2;
UPDATE centro SET nombre_centro = centro3 WHERE codcentro = 3;

INSERT INTO centro (codcentro, direccion, localidad, nombre_centro) VALUES (9,nueva_dir, nueva_loc, centro9);

SELECT c.codcentro, d.denominacion FROM centro c
LEFT OUTER JOIN dpto d ON c.codcentro = d.codcentro
ORDER BY c.codcentro;


