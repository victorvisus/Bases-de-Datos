SET SERVEROUTPUT ON;
DECLARE
    --El resultado de la SELECT hay que guardarlo en una variable
        salario NUMBER;
        nombre employees.first_name%TYPE; --hace que la variable sea del mismo tipo que la columna
BEGIN
    SELECT --IMPORTANT: SOLO PUEDE DEVOLVER UNA FILA
        salary, first_name INTO salario, nombre
    FROM
        employees
    WHERE
        employee_id = 100;
    DBMS_OUTPUT.put_line(salario);
    DBMS_OUTPUT.put_line(nombre);
END;
/