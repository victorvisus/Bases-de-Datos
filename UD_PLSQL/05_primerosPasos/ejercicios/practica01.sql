-- Para habilitar la salida por pantalla
SET SERVEROUTPUT ON

BEGIN
    DBMS_OUTPUT.PUT_LINE(100);
    DBMS_OUTPUT.PUT_LINE('Hola' ||' ' || 'sigue');
END;