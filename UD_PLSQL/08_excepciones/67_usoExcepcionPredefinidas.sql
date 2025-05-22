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
/* Hay miles pero Las m�s frecuentes */
-- NO_DATA_FOUND -> La consulta no encuentra datos
-- TOO_MANY_ROWS -> La query devuelve demasiadas filas
-- ZERO_DIVIDE -> Error aritm�tico
-- DUP_VAL_ON_INDEX -> La clave ya existe.

    --Capturamos el error
    WHEN no_data_found THEN
        --Le decimos que imprima un mensaje, en vez de su mensaje predecinido
        dbms_output.put_line('empleado inexistente');
    WHEN too_many_rows THEN
        dbms_output.put_line('demasiados empleados');
    WHEN OTHERS THEN
        dbms_output.put_line('error inexperado');
        dbms_output.put_line('C�d. de error ' || SQLCODE);
        dbms_output.put_line('Mensaje de error ' || SQLERRM);
END;
/