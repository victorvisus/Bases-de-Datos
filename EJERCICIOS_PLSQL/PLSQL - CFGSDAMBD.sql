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
-- 1.- Ejemplos de creación procedimientos. ---------------

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

-- CREATE OR REPLACE FUNCTION -------------------------------------------------
-- 2.- Ejemplos de creación funciones. --------------------

/*******************************************************************************
4) Escribir un bloque PL/SQL que haga uso de la función anterior
********************************************************************************/
DECLARE
    fecha DATE;
    anyo NUMBER;
BEGIN
    fecha := '01-05-1999';

    anyo := anio(fecha);
    dbms_output.put_line(anyo);
END;
/

/*******************************************************************************
5) Dado el siguiente procedimiento: */
CREATE OR REPLACE PROCEDURE crear_depart (
    v_num_dept depart.dept_no%TYPE,
    v_dnombre depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
    v_loc depart.loc%TYPE DEFAULT 'PROVISIONAL')
IS
BEGIN
    INSERT INTO depart
    VALUES (v_num_dept, v_dnombre, v_loc);
END crear_depart;
/
/*
Indicar cuáles de las siguientes llamadas son correctas y cuáles incorrectas, en este
último caso escribir la llamada correcta usando la notación posicional (en los casos que
se pueda):
    1º. crear_depart;
OK  2º. crear_depart(50);
    3º. crear_depart('COMPRAS');
OK  4º. crear_depart(50,'COMPRAS');
    5º. crear_depart('COMPRAS', 50);
    6º. crear_depart('COMPRAS', 'VALENCIA');
OK  7º. crear_depart(50, 'COMPRAS', 'VALENCIA');
    8º. crear_depart('COMPRAS', 50, 'VALENCIA');
    9º. crear_depart('VALENCIA', ‘COMPRAS’);
    10º. crear_depart('VALENCIA', 50);
********************************************************************************/

/*******************************************************************************
6) Desarrollar una función que devuelva el número de años completos que hay entre
dos fechas que se pasan como argumentos.
********************************************************************************/
CREATE OR REPLACE FUNCTION num_anyos(f_ini DATE, f_fin DATE) RETURN NUMBER AS
    v_num_anio NUMBER(6);

BEGIN
    --MONTHS_BETWEEN returns number of months between dates date1 and date2
    --FLOOR returns the largest integer equal to or less than n
    
    --v_num_anio := floor(months_between(f_fin, f_ini) /12);

    --The ABS() function returns the absolute value of a number.
    --TRUNC() Suprime los valores o decimales que se le indiquen

    v_num_anio := ABS(TRUNC(MONTHS_BETWEEN(f_fin, f_ini) / 12)); 

    RETURN v_num_anio;
END num_anyos;
/
BEGIN
    dbms_output.put_line(
        num_anyos('01-05-1652', '01-05-2001')
    );
END test;
/

/*******************************************************************************
7) Escribir una función que, haciendo uso de la función anterior devuelva los 
trienios que hay entre dos fechas. (Un trienio son tres años completos).
********************************************************************************/
CREATE OR REPLACE FUNCTION calc_trienio(f_ini DATE, f_fin DATE) RETURN NUMBER AS
    v_num_trienio NUMBER;
    
BEGIN
    v_num_trienio := TRUNC(num_anyos(f_ini, f_fin) / 3, 0);
    
    RETURN v_num_trienio;
END calc_trienio;
/

BEGIN
    dbms_output.put_line(
        calc_trienio('01-05-1652', '01-05-2001')
    );
END test;
/


-- PROCEDIMIENTOS Y FUNCIONES -------------------------------------------------
-- 3 .- Ejemplos de procedimientos y funciones. -----------

/*******************************************************************************
8) Codificar un procedimiento que reciba una lista de hasta 5 números y visualice
su suma.
********************************************************************************/
CREATE OR REPLACE PROCEDURE suma_nums(
    num01 NUMBER DEFAULT 0,
    num02 NUMBER DEFAULT 0,
    num03 NUMBER DEFAULT 0,
    num04 NUMBER DEFAULT 0,
    num05 NUMBER DEFAULT 0
) AS
    v_result NUMBER;
    v_print VARCHAR2(50);
    
    TYPE v_numeros IS VARRAY(5) OF NUMBER;
    lista_nums v_numeros := v_numeros(num01, num02, num03, num04, num05);
BEGIN
    
    v_result := 0;
    v_print := 'El resultado de ';
    
    FOR i IN 1 .. lista_nums.COUNT() LOOP
        v_result := v_result + lista_nums(i);

        IF lista_nums(i) <> 0 THEN
            v_print := v_print || ' + ' || lista_nums(i);
        END IF;
    END LOOP;
    
    dbms_output.put_line(v_print || ' es ' || v_result);
    
END suma_nums;
/
BEGIN
    suma_nums(0,2,3,4,5);
END test;
/

/*******************************************************************************
9) Escribir una función que devuelva solamente caracteres alfabéticos sustituyendo
cualquier otro carácter por blancos a partir de una cadena que se pasará en la
llamada.
********************************************************************************/
CREATE OR REPLACE FUNCTION alfa(
    cad VARCHAR2
) RETURN VARCHAR2
AS
    nueva_cad VARCHAR2(30);
    car CHARACTER;

BEGIN
    -- lee la cadena recibida con un loop con repetición según su longitud
    FOR i IN 1 .. LENGTH(cad) LOOP
        -- Extrae el caracter de la cadena en la posición i del loop
        car := SUBSTR(cad, i , 1);
        -- Si el caracter no esta en los códigos ASCII indicados pone un espacio en blanco
        IF (ASCII(car) NOT BETWEEN 65 AND 90) AND (ASCII(car) NOT BETWEEN 97 AND 122) THEN
            car := ' ';
        END IF;
        -- Concatena el caracter a la nueva cadena
        nueva_cad := nueva_cad || car;
    
    END LOOP;
    
    RETURN nueva_cad;
END alfa;
/
BEGIN
    dbms_output.put_line(alfa('v1ct0r 3s m4j0'));
END test;
/

/*******************************************************************************
10) Implementar un procedimiento que reciba un importe y visualice el desglose del
cambio en unidades monetarias de 1, 5, 10, 25, 50, 100, 200, 500, 1000, 2000, 5000
Ptas. en orden inverso al que aparecen aquí enumeradas.
********************************************************************************/
CREATE OR REPLACE PROCEDURE cambio(
    importe NUMBER
) AS
    cambio NUMBER;
BEGIN
    null;
END cambio;
/


-- CURSOR ... IS ... -----------------------------------------------------------
-- 3 .- Ejemplos de procedimientoscon cursores. -----------

-- CAMBIO A LA BBDD HR --
/*******************************************************************************
1) Desarrollar un procedimiento que visualice el apellido y la fecha de alta de
todos los empleados ordenados por apellido.
********************************************************************************/
CREATE OR REPLACE PROCEDURE ver_emple
AS

    CURSOR empleados IS SELECT e.last_name, e.hire_date FROM employees e ORDER BY e.last_name ASC;
BEGIN

    FOR i IN empleados LOOP
        dbms_output.put_line(i.last_name || ' ' || i.hire_date);
    END LOOP;

END ver_emple;
/
BEGIN
    ver_emple();
END test;
/

/*******************************************************************************
2) Codificar un procedimiento que muestre el nombre de cada departamento y el
número de empleados que tiene.
********************************************************************************/
CREATE OR REPLACE PROCEDURE emple_depart
AS
    CURSOR empleados IS SELECT d.department_name, COUNT(e.employee_id) AS num_empleados
        FROM departments d
        INNER JOIN employees e ON e.department_id = d.department_id
        GROUP BY d.department_name;

    v_total_emple NUMBER;
BEGIN

    v_total_emple := 0;
    FOR i IN empleados LOOP
        dbms_output.put_line(i.department_name || ' tiene ' || i.num_empleados || ' empleados.' );
        v_total_emple := v_total_emple + i.num_empleados;
    END LOOP;
    dbms_output.put_line('LA EMPRESA TIENE ' || v_total_emple || ' empleados.');
    
END emple_depart;
/

BEGIN
    emple_depart;
END test;
/    
    
    
    