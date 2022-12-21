-- 1. Obtener los nombres y salarios de los empleados que cobran más de 985 euros y tienen una comisión es superior al 5% de su salario.
SELECT e.nombre || ' ' || e.ape1 || ' ' || e.ape2, e.salario, e.comision, (e.comision / e.salario) * 100 AS PORCENTAJE
    FROM empleado e
    WHERE e.salario > 985 AND e.comision > (e.salario * 0.05);

