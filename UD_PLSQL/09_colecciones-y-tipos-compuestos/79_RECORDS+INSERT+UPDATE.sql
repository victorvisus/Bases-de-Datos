--Objeto Tipo RECORD con INSERT y UPDATE
SET SERVEROUTPUT ON

CREATE TABLE regiones AS SELECT * FROM regions WHERE region_id = 0;

DECLARE
    --Variables para Exception OTHERS
    code_exc NUMBER;
    message_exc VARCHAR2(100);
    
    --Variables del programa
    reg1 regions%ROWTYPE;

BEGIN
    SELECT * INTO reg1 FROM regions WHERE region_id = 1;
    --INSERT
    INSERT INTO regiones VALUES reg1;
    
EXCEPTION
    WHEN OTHERS THEN
        code_exc := SQLCODE;
        message_exc := SQLERRM;
        
        dbms_output.put_line('Error desconocido, más info:');
        dbms_output.put_line('Cód. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/

DECLARE
    --Variables para Exception OTHERS
    code_exc NUMBER;
    message_exc VARCHAR2(100);
    
    --Variables del programa
    reg1 regions%ROWTYPE;

BEGIN
    reg1.region_id := 1;
    reg1.region_name := 'Australia';
    --UPDATE
    UPDATE regiones SET ROW = reg1 WHERE region_id = 1; --con la clausula SET ROW le decimos que actualice toda la fila con la variable RECORD
    
EXCEPTION
    WHEN OTHERS THEN
        code_exc := SQLCODE;
        message_exc := SQLERRM;
        
        dbms_output.put_line('Error desconocido, más info:');
        dbms_output.put_line('Cód. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/