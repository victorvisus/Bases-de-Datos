-- Atributos de CURSORES

/*
cursor_name%NOTFOUND
cursor_name%FOUND
cursor_name%ISOPEN
cursor_name%ROWCOUNT
*/

-- RECORRER UN CURSOR CON UN LOOP ----------------------------------------------
DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 REGIONS%ROWTYPE;
BEGIN
    OPEN C1;
    
    LOOP
        FETCH C1 INTO V1;
        EXIT WHEN C1%NOTFOUND; --Para controlar la terminación del loop
        dbms_output.put_line(V1.region_name);
    END LOOP;
    
    CLOSE C1; --Cerrar siempre que se considere que no se va a usar el cursor
END;
/
-- RECORRER UN CURSOR CON UN FOR -----------------------------------------------
DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
BEGIN
    FOR i IN C1 LOOP
        dbms_output.put_line(i.region_name);
    END LOOP;
    /* Con FOR no es necesario realizar los comandos del cursor, ni el open, ni close, ni fetch*/
END;
/