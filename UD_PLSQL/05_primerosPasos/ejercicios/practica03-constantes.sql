-- CONSTANTES y NULL
SET SERVEROUTPUT ON;

DECLARE
    x  CONSTANT NUMBER := 10;
    -- Las constantes, como en cualquier lenguaje, no se puede cambiar su valor
    
     z  NUMBER NOT NULL := 20;
     -- Esta variable no puede estar vacia
BEGIN
    dbms_output.put_line(x);
    z := 30;
    dbms_output.put_line(z);
END;