-- SINTAXIS DE EXCEPCIONES

SET SERVEROUTPUT ON;

DECLARE
    empl employees%ROWTYPE;
BEGIN
    SELECT * INTO empl
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.put_line(empl.first_name);
    
EXCEPTION
-- Bloque de excepciones, cuando se produce algun tipo de error, el programa se dirige a este bloque

    WHEN ex1 THEN --Cuando se produce la exection ex1 se ejecuta el siguiente código
        NULL;
    WHEN ex2 THEN
        NULL;
    WHEN OTHERS THEN --Cuando no esta gestionada la exeception se va a este punto
        NULL;
END;
/
