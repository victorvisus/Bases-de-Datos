-- CREAR UN CURSOR

DECLARE
    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 REGIONS%ROWTYPE;

BEGIN
    OPEN C1;
    
    -- para leer una fila
    FETCH C1 INTO V1;
    dbms_output.put_line(V1.region_name);
    FETCH C1 INTO V1;
    dbms_output.put_line(V1.region_name);
    CLOSE C1;

END;