-- DECLARACION DE VARIABLES
SET SERVEROUTPUT ON

DECLARE
    -- inicializa las variables
    name VARCHAR2(100);
    lastname VARCHAR2(100);
    
BEGIN
    -- inicializamos las variables, le damos un valor
    name := 'Victor';
    lastname := 'Visús';

    -- imprime
    DBMS_OUTPUT.PUT_LINE(name);
    DBMS_OUTPUT.PUT_LINE(lastname);
    
    DBMS_OUTPUT.PUT_LINE(name || ' ' || lastname);
END;