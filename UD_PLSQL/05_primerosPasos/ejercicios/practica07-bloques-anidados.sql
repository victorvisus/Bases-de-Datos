-- BLOQUES ANIDADOS

SET SERVEROUTPUT ON

BEGIN
    dbms_output.put_line('ESTOY EN EL PRIMER BLOQUE');
    DECLARE
        x NUMBER := 10;
    BEGIN
        dbms_output.put_line('Variable bloque 2:'
                             || ' '
                             || x);
    END;

END;