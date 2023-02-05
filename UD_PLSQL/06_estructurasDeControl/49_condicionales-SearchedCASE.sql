-- SEARCHED CASE
/*
Permite hacer un poco más complejas que el CASE, no solo con igualdad si no con 
otro tipos de operadores
*/
SET SERVEROUTPUT ON;

DECLARE
    bonus NUMBER;
BEGIN
    bonus := 300;
    CASE
        WHEN bonus > 500 THEN
            dbms_output.put_line('Excelente');
        WHEN bonus <= 500 AND bonus > 250 THEN
            dbms_output.put_line('Very Good');
        WHEN bonus <= 250 AND bonus > 100 THEN
            dbms_output.put_line('Excelente');
        ELSE
            dbms_output.put_line('POOR!!!');
    END CASE;

END;