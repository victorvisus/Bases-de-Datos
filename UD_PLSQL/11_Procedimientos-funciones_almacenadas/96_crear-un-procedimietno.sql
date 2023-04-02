-- Crear un procedimiento

CREATE PROCEDURE pro1
IS -- o AS

-- Aqui sería la seccion del DECLARE
    X NUMBER := 10;

BEGIN
    DBMS_OUTPUT.PUT_LINE(X);
END;
/