/**
1. Obtener los nombres y salarios de los empleados que cobran más de 985 euros y
tienen una comisión es superior al 5% de su salario.
**/
SELECT nombre, salario FROM empleado WHERE salario > 985 AND comision > (salario * 0.05);

SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2, e.salario, e.comision, (e.comision / e.salario) * 100 AS "PORCENTAJE"
    FROM empleado e
    WHERE e.salario > 985 AND e.comision > (e.salario * 0.05);
--Solucion
select nombre,ape1,salario from empleado where salario > 1000 and comision > salario * 0.05;

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
    NVL2(e.comision, e.salario + e.comision, e.salario) AS "SUELDO TOTAL Euros",
    NVL2(e.comision, e.salario + e.comision, e.salario) * 166.386 AS "SUELDO TOTAL ptas"
    FROM empleado e
    WHERE NVL2(e.comision, e.salario + e.comision, e.salario) > 1350
    ORDER BY e.coddpto, e.nombre;
    
--Solucion
select coddpto,codemple,nombre,ape1,(salario+nvl(comision,0))*166.386
from empleado where salario+nvl(comision,0)>1800
order by coddpto,nombre,ape1;

/**
3.	Obtener un listado con los nombres, y apellidos de los empleados y sus años
de antigüedad en la empresa, ordenado por años de antigüedad siendo los que más
años llevan los primeros que deban aparecer.
**/
SELECT e.nombre, e.ape1, e.ape2, e.fechaingreso,
    TRUNC(MONTHS_BETWEEN(SYSDATE,e.fechaingreso)/12, 0) AS Antigüedad
    FROM empleado e
    ORDER BY Antigüedad DESC;
    
--Solucion: el 4 en el order by indica el nº de atributo por el que lo ordena
SELECT nombre,ape1,ape2, (sysdate-fechaingreso)/365.20 as "AntigÃ¼edad" from empleado order by 4 desc;

/**
4. Obtener el nombre de los empleados que trabajan en un departamento con presupuesto
superior a 50.000 euros pero menor de 60000 euros. Hay que usar predicado cuantificado
**/
SELECT e.nombre, d.coddpto AS "CODIGO DPTO", d.denominacion, d.presupuesto AS "PRESUPUESTO DPTO" FROM empleado e
  JOIN dpto d ON d.coddpto = e.coddpto
  WHERE d.presupuesto = ANY (
    SELECT d.presupuesto FROM dpto d WHERE d.presupuesto > 50000 AND d.presupuesto < 60000)
  ORDER BY e.coddpto;
-- No da ningun resultado debido a que no hay ningun dpto que cumpla con la condición
-- SELECT d.presupuesto FROM dpto d ;

--Solucion:
select ape1,nombre from empleado where coddpto= some(select coddpto from dpto where presupuesto>50000 and presupuesto<60000);

/**
5. Obtener en orden alfabético los nombres de empleado cuyo salario es inferior
al mínimo de los empleados del departamento 1.
**/
SELECT e.nombre, e.salario 
    FROM empleado e
    WHERE /* salario < al menor salario de los empleados del dpto 1*/
    e.salario < (
        SELECT MIN(e1.salario) FROM empleado e1 WHERE e1.coddpto = 1);
--Corrección: 5.- parcialmente bien resuelta, no ordenadas el resultado.
--Solucion
select nombre,ape1,salario from empleado where salario < (select min(salario) from empleado where coddpto=1);

/**
6. Obtener el nombre de los empleados que trabajan en el departamento del cuál es
jefe el empleado con código 1.
**/
SELECT e.nombre || ' ' || e.ape1 AS nombre, e.coddpto, d.denominacion, d.codemplejefe
    FROM empleado e
    INNER JOIN dpto d ON e.coddpto = d.coddpto
    WHERE d.codemplejefe = 1;
--Corrección: 6.- parcialmente bien resuelta, sobra la última condición de la setencia. SI LA QUITO NO FUNCIONA CORRECTAMENTE
--Solucion
select nombre,ape1 from empleado where coddpto = some (select coddpto from dpto where codemplejefe=1);

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

--Solucion
select nombre,ape1 from empleado where substr(ape1,1,1) between 'P' and 'S';

/**
8. Obtener los nombres de los empleados que viven en ciudades en las que hay algún
centro de trabajo
**/
SELECT nombre, localidad
    FROM empleado
    WHERE UPPER(localidad) = ANY (
        SELECT UPPER(localidad) FROM centro
    );

--Solucion
select ape1, nombre from empleado where upper(localidad) in (select upper(localidad) from centro);

/**
9. Obtener en orden alfabético los salarios y nombres de los empleados cuyo salario
sea superior al 60% del máximo salario de la empresa.
**/
SELECT e.nombre, e.salario
    FROM empleado e
    WHERE e.salario > (
        SELECT MAX(e.salario) * 0.6 FROM empleado e);
--Corrección: 9.- parcialmente bien resuelta, no ordenadas el resultado.
--Solucion
select salario,nombre from empleado where salario >(select max(salario) * 0.6 from empleado) order by nombre;

/**
10.	El nombre y apellidos del empleado que más salario cobra
**/
SELECT e.nombre, e.ape1, e.ape2, e.salario
    FROM empleado e
    WHERE e.salario = (
        SELECT MAX(e.salario)FROM empleado e);

--Solucion
select nombre,ape1,ape2, salario from empleado where salario=(select MAX(salario) from empleado);

/**
11. Obtener las localidades y número de empleados de aquellas en las que viven
más de 3 empleados
**/
SELECT localidad, COUNT(codemple) AS num_empleados FROM empleado  
    GROUP BY localidad
    HAVING COUNT(codemple) > 3;

--Solucion
select localidad,count(*) from empleado group by localidad having count(*) > 3 order by 2;

/**
12. Obtener los nombres de todos los centros y los departamentos que se ubican en
cada uno, así como aquellos centros que no tienen departamentos.
**/
-- Consulta sin modificar la tabla del ejercicio, usando el campo codcentro en vez del nombre
SELECT c.codcentro, d.denominacion AS Departamento FROM centro c
    LEFT OUTER JOIN dpto d ON c.codcentro = d.codcentro
    ORDER BY c.codcentro;

--Solucion
select tc.direccion,td.denominacion from centro tc left join dpto td on tc.codcentro=td.codcentro order by 1,2;

/**
-- NO Exite un campo nombre. Modifico la tabla, para  poder trabajar con los nombres
-- Inserto un centro nuevo que no tiene departamentos, para poder comprobar que,
la consulta, lista también los centros que no tienen departamentos
**/
-- Modificación de la tabla
ALTER TABLE centro ADD (nombre_centro VARCHAR2(20));
-- Actualizar contenido de los registros existentes
UPDATE centro SET NOMBRE_CENTRO = 'centro1' WHERE codcentro = 1;
UPDATE centro SET NOMBRE_CENTRO = 'centro2' WHERE codcentro = 2;
UPDATE centro SET NOMBRE_CENTRO = 'centro3' WHERE codcentro = 3;
-- Insertar un nuevo registro -centro- que no tiene asignado ningun departamento
INSERT INTO centro (codcentro, direccion, localidad, nombre_centro) VALUES (9,'nueva_dir', 'nueva_loc', 'centro9');
-- Consulta
SELECT c.codcentro, c.nombre_centro, d.denominacion AS Departamentos FROM centro c
    LEFT OUTER JOIN dpto d ON c.codcentro = d.codcentro
    ORDER BY c.nombre_centro;

/**
13.	Obtener el nombre del departamento de más alto nivel, es decir, aquel que no
depende de ningún otro.
**/
SELECT * FROM dpto d WHERE d.coddptodepende IS null;
--Corrección: 13.- bien resuelta, no existia el campo nombre, podrías haber devuelto denominación que es el campo que contiene el nombre.
--Solucion
select denominacion from dpto where coddptodepende is null;


/**
14.	Obtener el departamento que más empleados tiene
**/
--SELECT MAX(COUNT(*)) from empleado group by coddpto;
SELECT d.coddpto, d.denominacion, COUNT(e.codemple) AS num_empleados
    FROM dpto d
    INNER JOIN empleado e ON d.coddpto = e.coddpto
    GROUP BY d.denominacion, d.coddpto
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*)) from empleado group by coddpto);

--Usando "tabla temporal"
SELECT t.coddpto, t.denominacion, t.num_empleados
    FROM (
        SELECT d.coddpto, d.denominacion, COUNT(*) AS num_empleados
            FROM empleado e, dpto d
            WHERE d.coddpto = e.coddpto
            GROUP BY d.denominacion, d.coddpto
        ) t
    WHERE t.num_empleados = (
        SELECT MAX(t2.num_empleados) FROM  (
            SELECT d.denominacion, COUNT(*) AS num_empleados
                FROM empleado e, dpto d
                WHERE d.coddpto = e.coddpto
                GROUP BY d.denominacion
            ) t2);

--Solucion
select denominacion from dpto,empleado where empleado.coddpto=dpto.coddpto
    group by dpto.coddpto,denominacion 
    having count(empleado.codemple)>=all(
        select count(codemple)
            from empleado
            group by coddpto
        );

/**
15.	Obtener todos los departamentos existentes en la empresa y los empleados (si
los tiene) que pertenecen a él.
**/
SELECT d.coddpto, d.denominacion, e.nombre || ' ' || e.ape1 AS Empleado
    FROM dpto d
    INNER JOIN empleado e ON d.coddpto = e.coddpto
    ORDER BY d.coddpto;
-- MAL: Al no usar LEFT JOIN descarta los departamentos que no tienen empleados
--Corrección: 15.- mal resuelta, deberias usar left join para mostrar todos los departamentos. No deberías usar group by, solo order by.

/** Muestra todos los departamentos existentes en la empresa y el numero de empleados
de cada departamente (si los tiene) que pertenecen a él
**/
SELECT d.coddpto, d.denominacion, COUNT(e.codemple) FROM dpto d
    INNER JOIN empleado e ON d.coddpto = e.coddpto
    GROUP BY d.denominacion, d.coddpto;

--Solucion
select denominacion,nombre,ape1,ape2 from dpto td left join empleado te on td.coddpto=te.coddpto order by 1;

/**
16.	Obtener un listado ordenado alfabéticamente donde aparezcan los nombres de 
los empleados y a continuación el literal "tiene comisión" si la tiene o "no tiene
comisión" si no la tiene.
--NVL2(expresion, valor1, valor2): si el valor de la expresión NO es nulo nos devuelve el primer valor, y si es null el segundo
**/
SELECT e.nombre || ' ' || e.ape1 AS Empleado, NVL2(e.comision, 'tiene comision', 'no tiene comision') AS Comision
    FROM empleado e
    ORDER BY e.nombre ASC;

--Solucion
Select nombre, ape1,ape2, 'tiene comision' as Comision from empleado where comision is not null
UNION
Select nombre, ape1,ape2, 'no tiene comision' as Comision from empleado where comision is null order by 4,2;

--O bien con la funciÃ³n decode
Select nombre, ape1,ape2, decode(nvl(comision,0),0,'tiene comision','no tiene comision') as Comision from empleado;

/**
17.	Obtener un listado de las localidades en las que hay centros y no vive ningún
empleado ordenado alfabéticamente.
**/
SELECT c.localidad FROM centro c
    LEFT OUTER JOIN empleado e ON c.localidad = e.localidad;

--Corrección: 17.- mal resuelta, deberías usar not in o minus.
--MAL, la Solucion es esta
select upper(tc.localidad) from centro tc minus select upper(te.localidad) from empleado te order by 1;

-- TambiÃ©n podrÃ­a hacerse con not in: 
select upper(c.localidad) from centro c WHERE UPPER(c.localidad) NOT IN (SELECT UPPER(e.localidad) from empleado e) order by c.localidad;

/**
18.	Obtener a los nombres, apellidos de los empleados que no son jefes de departamento.
**/
SELECT e.codemple, e.nombre, e.ape1 || ' ' || e.ape2 AS apellidos
    FROM empleado e
    WHERE e.codemple NOT IN (
        SELECT d.codemplejefe FROM dpto d
        );

--Solucion
select nombre,ape1,ape2 from empleado where codemple not in (select codemplejefe from dpto);

/**
19.	Esta cuestión puntúa doble. Se desea dar una gratificación por navidades en
función de la antigüedad en la empresa siguiendo estas pautas:
a.	Si lleva entre 1 y 5 años, se le dará 100 euros
b.	Si lleva entre 6 y 10 años, se le dará 50 euros por año
c.	Si lleva entre 11 y 20 años, se le dará 70 euros por año
d.	Si lleva más de 21 años, se le dará 100 euros por año
**/
SELECT nombre, FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) AS Antiguedad,
        CASE
        
            -- a.Si lleva entre 1 y 5 años, se le dará 100 euros
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) BETWEEN 1 AND 5
            THEN 100
            -- b.Si lleva entre 6 y 10 años, se le dará 50 euros por año
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) BETWEEN 6 AND 10
            THEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) * 50
            -- c.Si lleva entre 11 y 20 años, se le dará 70 euros por año
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) BETWEEN 11 AND 20
            THEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) * 70
            -- d.Si lleva más de 21 años, se le dará 100 euros por año
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) >= 21
            THEN FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) * 100
            -- Para cualquier otro caso
            ELSE FLOOR(MONTHS_BETWEEN(SYSDATE, fechaingreso)/12) * 0
            
        END AS gratificacion
    FROM empleado
    ORDER BY nombre;
    
--Solucion
select nombre,ape1,ape2, 100 as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 1 and 5
union
select nombre,ape1,ape2, 50*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 6 and 10
union
select nombre,ape1,ape2, 70*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 11 and 20
union
select nombre,ape1,ape2, 100*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365)> 21;