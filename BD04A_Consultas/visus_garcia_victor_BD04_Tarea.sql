/* ----------------------------------------------------------------- CONSULTA 1 */
-- 1. Obtener los nombres y salarios de los empleados con m�s de 1000 euros de
-- salario por orden alfab�tico.
SELECT nombre, salario FROM empleado WHERE salario > 1000 ORDER BY nombre ASC;

/* ----------------------------------------------------------------- CONSULTA 2 */
-- 2. Obtener el nombre de los empleados cuya comisi�n es superior al 20% de su
-- salario.
-- SELECT nombre, comision FROM empleado WHERE comision >= salario*0.2;
SELECT nombre, comision FROM empleado WHERE comision > salario*0.2;
/* No se obtiene ning�n resultado */

/* ----------------------------------------------------------------- CONSULTA 3 */
-- 3. Obtener el c�digo de empleado, c�digo de departamento, nombre y sueldo
-- total en pesetas de aquellos empleados cuyo sueldo total (salario m�s comisi�n)
-- supera los 1800 euros. Presentarlos ordenados por c�digo de departamento
-- y dentro de �stos por orden alfab�tico.

-- �ORDEN ALFAB�TICO SOBRE EL NOMBRE DEL EMPLEADO O SOBRE LA DENOMINACI�N DEL DEPARTAMENTO? --
SELECT e.codemple, e.coddpto, e.nombre, e.salario*166.386 AS Sueldo_ptas, e.salario FROM empleado e
  JOIN dpto d ON d.coddpto = e.coddpto
  WHERE e.salario+e.comision > 1800 ORDER BY d.coddpto, d.denominacion;

/** Soluci�n del profesor ---
 * Cualquier operaci�n que se haga con un valor NULL devuelve un NULL. Por ejemplo,
 * si se intenta dividir por NULL, no nos aparecer� ning�n error sino que como resultado
 * obtendremos un NULL (no se producir� ning�n error tal y como puede suceder si 
 * intent�ramos dividir por cero).
 * 
 * NVL(valor, expr1): 
 * Si valor es NULL, entonces devuelve expr1. Ten en cuenta que expr1 debe ser del
 * mismo tipo que valor.
 **/  
select coddpto,codemple,nombre,ape1,(salario+nvl(comision,0))*166.386, (salario+nvl(comision,0))
from empleado where salario+nvl(comision,0)>1800
order by coddpto,nombre,ape1;

/* ----------------------------------------------------------------- CONSULTA 4 */
-- 4. Obtener una listado ordenado por a�os en la empresa con los nombres, y
-- apellidos de los empleados y los a�os de antig�edad en la empresa
SELECT nombre || ' ' || ape1 || ' ' || ape2 AS Empleado,
  TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) AS Antig�edad
  FROM empleado
  ORDER BY Antig�edad;

/** Soluci�n del profesor --- */
SELECT nombre,ape1,ape2, (sysdate-fechaingreso)/365.20 as "Antig�edad" from empleado
order by 3;

/* ----------------------------------------------------------------- CONSULTA 5 */
-- 5. Obtener el nombre de los empleados que trabajan en un departamento con
-- presupuesto superior a 50.000 euros. Hay que usar predicado cuantificado

-- No he conseguido encontrar el predicado Cuantificado en la unidad de trabajo --
SELECT e.nombre, d.coddpto AS cod_Dpto, d.denominacion, d.presupuesto FROM empleado e
  INNER JOIN dpto d ON d.coddpto = e.coddpto
  WHERE d.presupuesto > 50000;

/* Con subconsulta */
SELECT e.nombre FROM empleado e WHERE e.coddpto IN (
  SELECT d.coddpto FROM dpto d WHERE d.presupuesto > 50000
);

SELECT e.nombre, e.coddpto AS cod_Dpto FROM empleado e
  WHERE e.coddpto > SOME (
  SELECT coddpto FROM dpto WHERE presupuesto > 50000
);

SELECT e.nombre, d.coddpto AS cod_Dpto, d.denominacion, d.presupuesto FROM empleado e
  JOIN dpto d ON d.coddpto = e.coddpto
  WHERE d.presupuesto > ANY (
  SELECT d.presupuesto FROM dpto d WHERE d.presupuesto > 50000)
  ORDER BY e.coddpto;

/** Soluci�n del profesor --- */
select ape1,nombre from empleado where coddpto= some(select coddpto from dpto where
presupuesto>50000);

/* ----------------------------------------------------------------- CONSULTA 6 */
-- 6. Obtener en orden alfab�tico los nombres de empleado cuyo salario es
-- inferior al m�nimo de los empleados del departamento 1.
--SELECT MIN(e2.salario) FROM empleado e2 WHERE e2.coddpto = 1;
SELECT e.nombre, e.salario FROM empleado e
  WHERE e.salario < (
  SELECT MIN(e2.salario) FROM empleado e2 WHERE e2.coddpto = 1
);

/* ----------------------------------------------------------------- CONSULTA 7 */
-- 7. Obtener los nombre de empleados que trabajan en el departamento del cu�l 
-- es jefe el empleado con c�digo 1.
/* SElECT e.codemple, e.nombre, e.coddpto, d.denominacion, d.codemplejefe
  FROM empleado e
  JOIN dpto d ON e.coddpto = d.coddpto
  WHERE d.codemplejefe = 1;*/
  
-- Opci�n Subconsulta
SELECT e.nombre FROM empleado e
  WHERE e.coddpto = (
  SELECT d.coddpto FROM dpto d
  WHERE d.codemplejefe = 1
);
-- Opci�n JOIN
SElECT e.nombre
  FROM empleado e
  JOIN dpto d ON e.coddpto = d.coddpto
  WHERE d.codemplejefe = 1;

/** Soluci�n del profesor --- */
select nombre,ape1 from empleado where coddpto = some (select coddpto from dpto
where codemplejefe=1);

/* ----------------------------------------------------------------- CONSULTA 8 */
--  8. Obtener los nombres de los empleados cuyo primer apellido empiece por las
-- letras p, q, r, s.
SELECT e.nombre, e.ape1, e.ape2 FROM empleado e
  WHERE
  e.ape1 LIKE('p%')
  OR e.ape1 LIKE('q%')
  OR e.ape1 LIKE('r%')
  OR e.ape1 LIKE('s%')
;
/* No devuelve ninguno debido a que no existe ning�n registro que cumpla la condici�n
y mucho menos en min�sculas */

-- Opcionalmente con el car�cter indicado en Mayusculas, si que obtenemos valores
SELECT e.nombre, e.ape1, e.ape2 FROM empleado e
  WHERE
  e.ape1 LIKE('P%')
  OR e.ape1 LIKE('Q%')
  OR e.ape1 LIKE('R%')
  OR e.ape1 LIKE('S%')
;

-- Tambi�n podemos convertir en min�sculas el campo ape1 para hacer la comparaci�n
SELECT e.nombre, e.ape1, e.ape2 FROM empleado e
  WHERE
  LOWER(e.ape1) LIKE('p%')
  OR LOWER(e.ape1) LIKE('q%')
  OR LOWER(e.ape1) LIKE('r%')
  OR LOWER(e.ape1) LIKE('s%')
;

/* ----------------------------------------------------------------- CONSULTA 9 */
--  9. Obtener los nombres de los empleados que viven en ciudades en las que hay
-- alg�n centro de trabajo
SELECT e.nombre FROM empleado e, centro c
  WHERE UPPER(e.localidad) = UPPER(c.localidad)
;

/* ----------------------------------------------------------------- CONSULTA 10 */
--  10. Obtener en orden alfab�tico los salarios y nombres de los empleados cuyo
-- salario sea superior al 60% del m�ximo salario de la empresa.
SELECT e.nombre, e.salario FROM empleado e
  WHERE e.salario >= (
  SELECT MAX(e.salario) FROM empleado e)*0.6
;

/* ----------------------------------------------------------------- CONSULTA 11 */
-- 11. El nombre y apellidos del empleado que m�s salario cobra
SELECT e.nombre, e.salario FROM empleado e
  WHERE e.salario = (
  SELECT MAX(e.salario) FROM empleado e)
;

/* ----------------------------------------------------------------- CONSULTA 12 */
--  12. Obtener las localidades y n�mero de empleados de aquellas en las que
-- viven m�s de 3 empleados
/* SELECT e.localidad, COUNT(e.nombre) FROM empleado e
  GROUP BY e.localidad; */
SELECT e.localidad, COUNT(e.nombre) FROM empleado e
  GROUP BY e.localidad
  HAVING COUNT(e.nombre)>3
;

/* ----------------------------------------------------------------- CONSULTA 13 */
-- 13. Obtener el departamento que m�s empleados tiene
SELECT e.coddpto, COUNT(e.nombre) AS num_emple FROM empleado e
  GROUP BY e.coddpto
  ORDER BY num_emple;


/* ----------------------------------------------------------------- CONSULTA 14 */
--  14. Obtener los nombres de todos los centros y los departamentos que se
-- ubican en cada uno,as� como aquellos centros que no tienen departamentos.

/* Los centros no tienen nombre, uso la direcci�n*/
SELECT c.direccion, d.denominacion FROM centro c
JOIN dpto d ON d.codcentro = c.codcentro
ORDER BY c.codcentro;

SELECT c.direccion, d.denominacion FROM centro c, dpto d 
WHERE d.codcentro = c.codcentro
ORDER BY c.codcentro;

/* ----------------------------------------------------------------- CONSULTA 15 */
--  15. Obtener el nombre del departamento de m�s alto nivel, es decir, aquel
-- que no depende de ning�n otro.
SELECT d.denominacion, d.coddptodepende FROM dpto d WHERE d.coddptodepende IS NULL;

/* ----------------------------------------------------------------- CONSULTA 16 */
--  16. Obtener todos los departamentos existentes en la empresa y los empleados
-- (si los tiene) que pertenecen a �l.
/* Entiendo que se refiere al n�mero de empleados */
SELECT d.denominacion, COUNT(e.nombre) FROM dpto d
  JOIN empleado e ON e.coddpto = d.coddpto
  GROUP BY d.denominacion;

/* ----------------------------------------------------------------- CONSULTA 17 */
--  17. Obtener un listado ordenado alfab�ticamente donde aparezcan los nombres
-- de los empleados y a continuaci�n el literal "tiene comisi�n" si la tiene, y
-- "no tiene comisi�n" si no la tiene.
SELECT e.nombre,
  DECODE(TO_CHAR(e.comision), NULL, 'no tiene comision',
                              'tiene comision') AS comision_emp
  FROM empleado e
;

/* ----------------------------------------------------------------- CONSULTA 18 */
-- 18. Obtener un listado de las localidades en las que hay centros y no vive
-- ning�n empleado ordenado alfab�ticamente.
SELECT e.localidad FROM empleado e, dpto d
  WHERE d.coddpto = e.coddpto
  AND e.localidad
  NOT IN (
    SELECT UPPER(c.localidad) FROM centro c
);

/* ----------------------------------------------------------------- CONSULTA 19 */
--  19. Esta cuesti�n punt�a por 2. Se desea dar una gratificaci�n por navidades
-- en funci�n de la antig�edad en la empresa siguiendo estas pautas:
-- (a) Si lleva entre 1 y 5 a�os, se le dar� 100 euros
-- (b) Si lleva entre 6 y 10 a�os, se le dar� 50 euros por a�o
-- (c) Si lleva entre 11 y 20 a�os, se le dar� 70 euros por a�o
-- (d) Si lleva m�s de 21 a�os, se le dar� 100 euros por a�o
SELECT nombre || ' ' || ape1 || ' ' || ape2 AS Empleado,
  TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) AS Antig�edad,
  CASE 
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) >= 1 AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) <= 5
      THEN 100
      
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) >= 6 AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) <= 10
      THEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0)*50
      
    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) >= 11 AND
      TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) <= 20
      THEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0)*70

    WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0) >= 21
      THEN TRUNC(MONTHS_BETWEEN(SYSDATE,fechaingreso)/12, 0)*100

    END gratificacion

  FROM empleado
  ORDER BY Antig�edad
;
/* ----------------------------------------------------------------- CONSULTA 20 */
--  20. Obtener a los nombres, apellidos de los empleados que no son jefes de
-- departamento.
SELECT e.codemple, e.nombre, e.ape1, e.ape2 FROM empleado e
  JOIN dpto d ON e.coddpto = d.coddpto
  WHERE e.codemple != d.codemplejefe;