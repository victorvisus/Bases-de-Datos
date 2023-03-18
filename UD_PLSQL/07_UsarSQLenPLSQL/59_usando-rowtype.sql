--%ROWTYPE
-- Para guardar toda la informacion que devuelve la consulta
SET SERVEROUTPUT ON;
DECLARE
    --El resultado de la SELECT hay que guardarlo en una variable
        salario NUMBER;
        nombre employees.first_name%TYPE; --hace que la variable sea del mismo tipo que la columna
        empleado employees%ROWTYPE; --Crea un objeto con la misma estructura que la tabla indicada
BEGIN
    SELECT
        * INTO empleado
    FROM
        employees
    WHERE
        employee_id = 100;
    DBMS_OUTPUT.put_line(empleado.salary);
    DBMS_OUTPUT.put_line(empleado.first_name);
    
    --Cualquier modificacion NO afecta a la tabla, afecta a la variable.
END;
/