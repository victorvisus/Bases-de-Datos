-- 1. Obtener los nombres y salarios de los empleados con más de 1000 euros de salario por orden alfabético.
SELECT nombre, salario FROM empleado WHERE salario > 1000 ORDER BY nombre ASC;

 -- 2. Obtener el nombre de los empleados cuya comisión es superior al 20% de su salario.
 SELECT nombre, comision FROM empleado;