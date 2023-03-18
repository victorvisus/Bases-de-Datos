-- EXCEPCIONES PREDEFINIDAS --
SET SERVEROUTPUT ON;

DECLARE
    empl employees%rowtype;
BEGIN
    SELECT * INTO empl
    FROM employees
    WHERE employee_id > 100;

    dbms_output.put_line(empl.first_name);
EXCEPTION
/* Hay miles pero Las más frecuentes */
-- NO_DATA_FOUND -> La consulta no encuentra datos
-- TOO_MANY_ROWS -> La query devuelve demasiadas filas
-- ZERO_DIVIDE -> Error aritmético
-- DUP_VAL_ON_INDEX -> La clave ya existe.

    --Capturamos el error
    WHEN no_data_found THEN
        --Le decimos que imprima un mensaje, en vez de su mensaje predecinido
        dbms_output.put_line('empleado inexistente');
    WHEN too_many_rows THEN
        dbms_output.put_line('demasiados empleados');
    WHEN OTHERS THEN
        dbms_output.put_line('error inexperado');
END;
/