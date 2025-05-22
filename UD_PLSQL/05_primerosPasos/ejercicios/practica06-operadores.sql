-- OPERADORES

SET SERVEROUTPUT ON;

DECLARE
/* OPERADORES MÁS HABITUALES
    + SUMA
    - RESTA
    / DIVISION
    * MULTIPLICACION
    ** EXPONENTE
    || CONCATENAR
**/
    x NUMBER;
    z NUMBER := 10;
    a VARCHAR2(100) := 'example';
    d DATE := '10-01-1990';
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(x+10);
    -- Si un operador de una expresion es NULL el resultado siempre es NULL
    
    x := 5;
    DBMS_OUTPUT.PUT_LINE(x+10);
    
    DBMS_OUTPUT.PUT_LINE(x * z);
    
    DBMS_OUTPUT.PUT_LINE(a || ' ' || x);
    
    -- Fecha
    DBMS_OUTPUT.PUT_LINE(SYSDATE);
    DBMS_OUTPUT.PUT_LINE(d);
    DBMS_OUTPUT.PUT_LINE(d + 1); --Muestra el dia siguiente
    
END;