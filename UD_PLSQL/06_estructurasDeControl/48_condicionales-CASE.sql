-- Clausula condicional CASE
-- Es una manera más simple, que el IF o ELSIF, de construir condiciones multiples
/*
Dependiendo del valor que tenga una variable se ejecuta una opción u otra de la condición CASE
si no se cumple ninguna de las condiciones se ejecuta la última opción -ELSE-
*/

DECLARE
    v1 CHAR(1);
BEGIN
    v1 := 'G';
    CASE v1
        WHEN 'A' THEN
            dbms_output.put_line('Excelente');
        WHEN 'B' THEN
            dbms_output.put_line('Muy bien');
        WHEN 'C' THEN
            dbms_output.put_line('Bien');
        WHEN 'D' THEN
            dbms_output.put_line('Justo');
        WHEN 'F' THEN
            dbms_output.put_line('Pobre');
        ELSE
            dbms_output.put_line('No existe el valor');
    END CASE;
END;
/