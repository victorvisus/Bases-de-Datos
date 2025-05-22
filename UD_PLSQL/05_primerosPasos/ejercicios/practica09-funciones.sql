-- FUNCIONES
-- Se pueden usar las mismas que SQL, pero se ejecutan en el motor PL
SET SERVEROUTPUT ON;

DECLARE
    x      VARCHAR2(50);
    mayus  VARCHAR2(100);
    fecha DATE;
    z NUMBER := 109.80;
BEGIN
    x := 'hello';
    dbms_output.put_line(substr(x, 1, 3));
    
    mayus := UPPER(x);
    dbms_output.put_line(mayus);
    
    fecha := SYSDATE;
    dbms_output.put_line(fecha);
    
    dbms_output.put_line(floor(z));
END;
/

-- No se pueden utilizar funciones de grupo (count, avg...)