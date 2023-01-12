-- Uso las tablas de la tarea BD04
/** 2.1. Obtener los apellidos de los empleados. **/
SELECT ape1 || ' ' || ape2 AS Apellidos FROM empleado ORDER BY ape1;

/** 2.2. Obtener los apellidos de los empleados sin repeticiones. **/
SELECT DISTINCT(ape1) FROM empleado ORDER BY ape1;

/** 2.3. Obtener todos los datos de los empleados que se apellidan ’L´opez’. **/
SELECT * FROM empleado WHERE LOWER(ape1) = 'lopez' OR LOWER(ape2) = 'lopez';

/** 2.4. Obtener todos los datos de los empleados que se apellidan ’L´opez’ y los que se apellidan ’P´erez’. **/
SELECT * FROM empleado WHERE LOWER(ape1) = 'lopez' OR LOWER(ape2) = 'lopez' OR LOWER(ape1) = 'perez' OR LOWER(ape2) = 'perez';

/** 2.5. Obtener todos los datos de los empleados que trabajan para el departamento 14. **/
SELECT coddpto FROM empleado;
SELECT * FROM empleado WHERE coddpto = 5;

/** 2.6. Obtener todos los datos de los empleados que trabajan para el departamento 37 y para el departamento 77. **/
SELECT * FROM empleado WHERE coddpto = 5 OR coddpto = 3;

/** 2.7. Obtener todos los datos de los empleados cuyo apellido comience por ’P’. **/
SELECT * FROM empleado WHERE LOWER(ape1) LIKE('l%') OR LOWER(ape2) LIKE('l%') ;

/** 2.8. Obtener el presupuesto total de todos los departamentos. **/
SELECT SUM(presupuesto) FROM dpto;
SELECT SUM(presupuesto), denominacion FROM dpto GROUP BY denominacion;

/** 2.9. Obtener el número de empleados en cada departamento. **/
SELECT d.coddpto, d.denominacion, COUNT(e.codemple) FROM empleado e
    INNER JOIN dpto d ON d.coddpto = e.coddpto
    GROUP BY d.coddpto, d.denominacion
    ORDER BY d.coddpto;

/** 2.10. Obtener un listado completo de empleados, incluyendo por cada empleado los datos del empleado y de su departamento. **/
SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2 AS empleado, d.denominacion AS Departamento
    FROM empleado e
    INNER JOIN dpto d ON d.coddpto = e.coddpto;

SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2 AS empleado, d.denominacion AS Departamento 
    FROM empleado e, dpto d
    WHERE e.coddpto = d.coddpto;

/** 2.11. Obtener un listado completo de empleados, incluyendo el nombre y apellidos del empleado junto al nombre y presupuesto de su departamento. **/
SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2 AS empleado, d.denominacion AS Departamento, d.presupuesto
    FROM empleado e
    INNER JOIN dpto d ON d.coddpto = e.coddpto;

/** 2.12. Obtener los nombres y apellidos de los empleados que trabajen en departamentos cuyo presupuesto sea mayor de 60.000 ¤. **/
SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2 AS empleado, d.denominacion AS Departamento, d.presupuesto
    FROM empleado e
    INNER JOIN dpto d ON d.coddpto = e.coddpto
    WHERE d.presupuesto > 50000;

/** 2.13. Obtener los datos de los departamentos cuyo presupuesto es superior al presupuesto medio de todos los departamentos. **/
SELECT ROUND(AVG(presupuesto),2) FROM dpto;

SELECT presupuesto, denominacion
    FROM dpto
    WHERE presupuesto > (SELECT AVG(presupuesto) FROM dpto); 

/** 2.14. Obtener los nombres (únicamente los nombres) de los departamentos que tienen m´as de dos empleados. **/
-- Departamentos
SELECT d.denominacion FROM dpto d ORDER BY d.coddpto;

-- Numero de empleados por departamento
SELECT d.coddpto, d.denominacion, COUNT(e.codemple) FROM empleado e
    INNER JOIN dpto d ON d.coddpto = e.coddpto
    GROUP BY d.coddpto, d.denominacion
    ORDER BY d.coddpto;
    
-- Consulta del ejercicio
SELECT d.denominacion FROM dpto d
    WHERE d.coddpto IN (
        SELECT e.coddpto FROM empleado e
            GROUP BY e.coddpto
            HAVING COUNT(*) > 2
    );

/** 2.15. Añadir un nuevo departamento: ‘Calidad’, con presupuesto de 40.000 ¤ y código 11. Añadir un empleado vinculado al departamento recién creado: Esther V´azquez, DNI: 89267109 **/
INSERT INTO dpto (coddpto, denominacion, codcentro, coddptodepende, codemplejefe, tipo, presupuesto)
    VALUES(11,'Calidad',3,1,1,'P',40000);

INSERT INTO empleado (codemple, ape1, ape2, nombre, direccion, localidad, telef, coddpto, codcate, fechaingreso, salario, comision)
    VALUES(11,'Vazquez','Lopez','Esther','su calle','Zaragoza',987652362,11,2,'15/02/10',1000,100);

/** 2.16. Aplicar un recorte presupuestario del 10 % a todos los departamentos. **/
SELECT denominacion, presupuesto FROM dpto;

UPDATE dpto SET presupuesto = (presupuesto - (presupuesto * 0.1));

/** 2.17. Reasignar a los empleados del departamento de investigación (código 77) al departamento de Informática (código 14). **/
SELECT codemple, nombre, coddpto FROM empleado;
SELECT coddpto, codemplejefe FROM dpto;

UPDATE empleado SET coddpto = 7 WHERE coddpto = 6;

/** 2.18. Despedir a todos los empleados que trabajan para el departamento de Informática (código 14). **/
DELETE FROM empleado WHERE coddpto = 7;

/** 2.19. Despedir a todos los empleados que trabajen para departamentos cuyo presupuesto sea superior a los 60.000 ¤. **/
DELETE FROM empleado WHERE codemple IN(
    SELECT e.codemple FROM empleado e INNER JOIN dpto d ON d.coddpto = e.coddpto WHERE d.presupuesto > 60000
);

/** 2.20. Despedir a todos los empleados. **/
DELETE FROM empleado CASCADE;
SELECT * FROM empleado;