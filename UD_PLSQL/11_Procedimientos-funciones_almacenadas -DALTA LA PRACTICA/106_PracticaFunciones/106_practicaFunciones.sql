/*******************************************************************************
1. Crear una función que tenga como parámetro un número de departamento y que 
devuelve la suma de los salarios de dicho departamento. La imprimimos por pantalla.
• Si el departamento no existe debemos generar una excepción con dicho mensaje
• Si el departamento existe, pero no hay empleados dentro, también debemos generar
una excepción para indicarlo
********************************************************************************/
CREATE OR REPLACE FUNCTION sum_dpto(
    dpto_id NUMBER)
    RETURN NUMBER  
AS
    dpto_estado NUMBER; -- Si es = 1 existe el dpto, si es 0 no existe
    num_empl NUMBER;
    suma NUMBER;
BEGIN
    --Compruebo que el dpto existe
    SELECT COUNT(d.department_id) INTO dpto_estado FROM departments d WHERE d.department_id = dpto_id;
    
    --Cuento el num. de empleados del dpto, y lo guardo en num_empl
    SELECT COUNT(employees.employee_id) INTO num_empl FROM employees WHERE employees.department_id = dpto_id;
    
    -- Si el ID de dpto. no existe ERROR
    IF dpto_estado = 0 THEN
        RAISE_APPLICATION_ERROR(-20500, 'El departamento no existe');
    ELSIF num_empl = 0 THEN
        RAISE_APPLICATION_ERROR(-20501, 'El departamento no tiene empleados');
    ELSE
        SELECT SUM(employees.salary) INTO suma FROM employees WHERE employees.department_id = dpto_id;
    END IF;

    RETURN suma;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO EXISTE EL Departamento');
       
END sum_dpto;
/

set serveroutput on
DECLARE
    dpto_id NUMBER;
    salarios employees.salary%TYPE;

BEGIN
    dpto_id := 270;
    salarios := sum_dpto(dpto_id);
    DBMS_OUTPUT.PUT_LINE('Los sueldos de los salarios ascienden: ' || salarios);
END;
/