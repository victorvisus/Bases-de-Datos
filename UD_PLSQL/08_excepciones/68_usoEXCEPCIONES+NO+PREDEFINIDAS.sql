-- EXCEPCIONES NO PREDEFINIDAS --
/*
Primero debemos saber el cód. del error 
*/
DECLARE
    mi_excep EXCEPTION; --Se crea un Objeto tipo EXCEPTION
    PRAGMA exception_init ( mi_excep, -937 );
    --PRAGMA Es una orden al compilador, lo que esta haciendo es asociar mi objeto EXCEPTION con el cod. de error -937
    
    v1  NUMBER;
    v2  NUMBER;
BEGIN
    SELECT employee_id, SUM(salary) INTO v1, v2 FROM employees;
    DBMS_OUTPUT.put_line(v1);
EXCEPTION
    WHEN mi_excep THEN
        dbms_output.put_line('Función de grupo incorrecta');
    WHEN OTHERS THEN
        dbms_output.put_line('Error indefino');
END;