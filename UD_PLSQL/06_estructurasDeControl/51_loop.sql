-- Bucle LOOP
DECLARE
    x NUMBER := 1;
BEGIN
    LOOP
        dbms_output.put_line(x);
        x := x + 1;
        -- con la clausula IF se controla que el bucle tenga un final
        /*IF x = 11 THEN
            EXIT;
        END IF;
        */
        -- otra forma de hacer terminar al bucle, ESTA ES LA MÁS ADECUADA
        EXIT WHEN x=11;
    END LOOP;
END;