-- Ejercicio PL/SQL ------------------------------------------------------------

/*******************************************************************************
2. Escribir un bloque PL/SQL que cuente el número de filas que hay en la tabla
productos, deposita el resultado en la variable v_num, y visualiza su contenido.
********************************************************************************/
DECLARE
    v_num NUMBER(2);
    
BEGIN

    SELECT COUNT(*) INTO v_num FROM AGENTES;
    
    DBMS_OUTPUT.put_line(v_num);
END;
/


-- CREATE OR REPLACE PROCEDURE -------------------------------------------------
-- 1.- Ejemplos de creación procedimientos. -------------------

/*******************************************************************************
1) Escribir un procedimiento que reciba dos números y visualice su suma.
********************************************************************************/
CREATE OR REPLACE PROCEDURE pr_suma (num1 NUMBER, num2 NUMBER)
IS
    suma NUMBER(2);
BEGIN
    suma := num1 + num2;
    dbms_output.put_line('La suma es: ' || suma);
END pr_suma;
/

EXECUTE pr_suma(2,3);
/
/*******************************************************************************
2) Codificar un procedimiento que reciba una cadena y la visualice al revés.
********************************************************************************/
CREATE OR REPLACE PROCEDURE right_to_left(cadena VARCHAR2)
IS
    anedac VARCHAR2(100);
    contador PLS_INTEGER := LENGTH(cadena);
    
BEGIN
    FOR i IN REVERSE 1..contador LOOP
        anedac := anedac || SUBSTR(cadena, i, 1);
    END LOOP;

    dbms_output.put_line(anedac);
END right_to_left;
/

EXECUTE right_to_left('cadena al reves');
/
/*******************************************************************************
3) Escribir una función que reciba una fecha y devuelva el año, en número,
correspondiente a esa fecha.
********************************************************************************/
CREATE OR REPLACE FUNCTION anio(fecha DATE)
RETURN NUMBER
AS
    v_anio NUMBER(4);
BEGIN
    v_anio := TO_NUMBER(TO_CHAR(fecha, 'YYYY'));

    RETURN v_anio;
END anio;
/

BEGIN
    dbms_output.put_line(anio('20-03-1978'));
END;
/