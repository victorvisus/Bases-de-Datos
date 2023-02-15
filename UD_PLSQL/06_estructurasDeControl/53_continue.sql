-- comando CONTINUE
DECLARE
    x NUMBER := 0;
BEGIN
    LOOP -- CON CONTINUE SALTAMOS AQUI
        dbms_output.put_line('Inside loop:  x = ' || to_char(x));
        x := x + 1;
        IF x < 3 THEN CONTINUE;
        END IF;
        dbms_output.put_line('DESPUÉS DE CONTINUE: x = ' || to_char(x));
        EXIT WHEN x = 5;
    END LOOP;

    dbms_output.put_line('DESPUÉS DEL LOOP: x = ' || to_char(x));
END;
/