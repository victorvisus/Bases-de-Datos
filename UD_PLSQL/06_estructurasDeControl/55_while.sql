-- Bucle WHILE
DECLARE
    done  BOOLEAN := false;
    x     NUMBER := 0;
BEGIN
    WHILE done LOOP
        dbms_output.put_line('No imprimas esto.');
        done := true;
    END LOOP;
    
    -- negacion de la condicion
        WHILE NOT done LOOP
        dbms_output.put_line('estoy aqui');
        done := true;
    END LOOP;

    WHILE x < 10 LOOP
        dbms_output.put_line(x);
        x := x + 1;
        
        EXIT WHEN x = 5; --también se puede poner un exit si se quiere salir antes de que se cumpla la condicion
    END LOOP;

END;