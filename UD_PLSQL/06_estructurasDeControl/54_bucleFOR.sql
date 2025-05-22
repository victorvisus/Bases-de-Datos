-- bucle FOR
SET SERVEROUTPUT ON

DECLARE
    i VARCHAR2(100) := 'aaaaa';
    -- esta variable i es totalmente independiente de la i del FOR
BEGIN
    FOR i IN 1..10 LOOP -- tiene que ser tipo PLS_INTEGER
                dbms_output.put_line(i);
    END LOOP;
    
    --a la inversa
        FOR i IN REVERSE 1..10 LOOP -- tiene que ser tipo PLS_INTEGER
                dbms_output.put_line('al reves: ' || i);
    END LOOP;

    --Salida del bucle
        FOR i IN 1..15 LOOP -- tiene que ser tipo PLS_INTEGER
                    dbms_output.put_line('hasta 10: ' || i);
        EXIT WHEN i = 10;
    END LOOP;

    dbms_output.put_line(i);
END;