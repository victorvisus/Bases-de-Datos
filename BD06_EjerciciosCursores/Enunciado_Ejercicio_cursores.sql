
/* CREACION DE PROCEDIMIENTOS QUE USAN cursores */

/*******************************************************************************
1) Desarrollar un procedimiento que visualice el apellido y la fecha de alta de 
todos los empleados ordenados por apellido.
********************************************************************************/
CREATE OR REPLACE PROCEDURE ver_emple
IS
    CURSOR C1 IS SELECT apellido, fecha_alt FROM EMPLE ORDER BY apellido ASC;
    --CURSOR C1 IS SELECT * FROM EMPLE;
BEGIN
        dbms_output.put_line('Procedimiento con Cursor Declarado ---------------');

    FOR i IN C1 LOOP
        dbms_output.put_line('Apellido: ' || i.apellido || ' - ' || 'Fecha de alta: ' || i.fecha_alt);
    END LOOP;
END ver_emple;
/

EXECUTE ver_emple;
/

-- Op. Sin Declarar un Cursos --------------------------------------------------
CREATE OR REPLACE PROCEDURE ver_emple_op2
IS

BEGIN
    dbms_output.put_line('Procedimiento sin Cursor Declarado ---------------');
    
    FOR i IN ( 
        SELECT apellido, fecha_alt FROM EMPLE ORDER BY apellido ASC
        ) LOOP
        dbms_output.put_line('Apellido: ' || i.apellido || ' - ' || 'Fecha de alta: ' || i.fecha_alt);
    END LOOP;
END ver_emple_op2;
/

EXECUTE ver_emple_op2;
/

/*******************************************************************************
2) Codificar un procedimiento que muestre el nombre de cada departamento y el 
n�mero de empleados que tiene.
********************************************************************************/
CREATE OR REPLACE PROCEDURE ver_emple_depart
AS
    CURSOR cur_depart IS
        SELECT d.dnombre, COUNT(e.emp_no) AS num_empl FROM depart d
            INNER JOIN emple e on e.dept_no = d.dept_no
            GROUP BY d.dnombre;
            
BEGIN
    FOR i IN cur_depart LOOP
        dbms_output.put_line('Nom. Dpto.: ' || i.dnombre || ' - ' || 'No. Empleados: ' || i.num_empl);
    END LOOP;
    
END ver_emple_depart;
/

EXECUTE ver_emple_depart;
/


/*******************************************************************************
3) Escribir un procedimiento que reciba una cadena y visualice el apellido y el 
n�mero de empleado de todos los empleados cuyo apellido contenga la cadena especificada.
Al finalizar visualizar el n�mero de empleados mostrados.
********************************************************************************/
CREATE OR REPLACE PROCEDURE ver_emple_apell(cadena VARCHAR2)
AS
    CURSOR empl_cur(cadena VARCHAR2) IS
        SELECT * FROM emple e WHERE apellido LIKE '%'||cadena||'%';
    empleados emple%ROWTYPE;
BEGIN
/*
    FOR i IN empl_cur(cadena) LOOP
          dbms_output.put_line(i.emp_no || ' ' || i.apellido);
    END LOOP;
*/
    OPEN empl_cur(cadena);
    LOOP
        FETCH empl_cur INTO empleados;
        EXIT WHEN empl_cur%NOTFOUND;
          dbms_output.put_line(empleados.emp_no || ' ' || empleados.apellido);
    END LOOP;
    
    dbms_output.put_line('He encontrado ' || empl_cur%ROWCOUNT || ' empleados');
    CLOSE empl_cur;

END ver_emple_apell;
/

EXECUTE ver_emple_apell('SAN');
/

/*******************************************************************************
4) Escribir un programa que visualice el apellido y el salario de los cinco 
empleados que tienen el salario m�s alto.
********************************************************************************/
CREATE OR REPLACE PROCEDURE emp_5maxsal
AS
    CURSOR sal IS
        SELECT apellido, salario FROM emple ORDER BY salario DESC;
        --Ordena la consulta por salario descendiente para leer los 5 primeros puestos del cursor
    empleados sal%ROWTYPE;
    i NUMBER;

BEGIN
    dbms_output.put_line('Con bucle WHILE --------------------------------------');
    OPEN sal;
    i := 1;
    FETCH sal INTO empleados;
    WHILE sal%FOUND AND i <= 5 LOOP
        dbms_output.put_line(empleados.apellido || ' ' || empleados.salario);
        FETCH sal INTO empleados;
        i:=i+1;
    END LOOP;
    dbms_output.put_line('He encontrado ' || sal%ROWCOUNT || ' empleados con WHILE');
    CLOSE sal;
-- -------------------------------------------------------------------------- --
    dbms_output.put_line('Con bucle LOOP ---------------------------------------');
    OPEN sal;
    i := 1;
    LOOP
        FETCH sal INTO empleados;
        EXIT WHEN i > 5;
        
        dbms_output.put_line(empleados.apellido || ' ' || empleados.salario);
        i := i+1;
    END LOOP;
    
    dbms_output.put_line('He encontrado ' || sal%ROWCOUNT || ' empleados con FOR');
    CLOSE sal;
    
END emp_5maxsal;
/

EXECUTE emp_5maxsal;
/
/*******************************************************************************
5) Codificar un programa que visualice los dos empleados que ganan menos de cada
oficio.
********************************************************************************/
SELECT oficio, apellido, salario FROM emple
        ORDER BY oficio, salario ASC;
/
CREATE OR REPLACE PROCEDURE emp_2minsal
AS
    CURSOR sal IS
        SELECT oficio, apellido, salario FROM emple
        ORDER BY oficio, salario ASC;
    empleados sal%ROWTYPE;
    
    oficio_ant sal.oficio%TYPE;
    i INTEGER;
BEGIN
    dbms_output.put_line('Ejercicio 5');
    
    

END emp_2minsal;
/

SELECT oficio, apellido, salario FROM emple
    ORDER BY oficio, salario ASC;

/******************************************************************************* 
6) Escribir un programa que muestre, en formato similar a las rupturas de control o secuencia vistas en SQL*plus los siguientes datos:
- Para cada empleado: apellido y salario.
- Para cada departamento: Número de empleados y suma de los salarios del departamento.
- Al final del listado: Número total de empleados y suma de todos los salarios.
CREATE OR REPLACE PROCEDURE listar_emple
AS

END listar_emple;

7) Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nombre del departamento y la localidad.
El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
Se incluirá gestión de posibles errores.

CREATE OR REPLACE PROCEDURE insertar_depart(nombre_dep VARCHAR2, loc VARCHAR2)
AS

END insertar_depart;

 
8) Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores.
CREATE OR REPLACE PROCEDURE alta_emp( num emple.emp_no%TYPE, ape emple.apellido%TYPE, ofi emple.oficio%TYPE,
jef emple.dir%TYPE, fec emple.fecha_alt%TYPE, sal emple.salario%TYPE, com emple.comision%TYPE DEFAULT NULL, dep emple.dept_no%TYPE)
AS

END alta_emp;

	  	
9) Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o 
el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).
CREATE OR REPLACE PROCEDURE subida_sal1(num_depar emple.dept_no%TYPE,importe NUMBER,porcentaje NUMBER)
AS

END subida_sal1;
 

10) Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. 
La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar 
que la transacción no se quede a medias, y se gestionarán los posibles errores.

CREATE OR REPLACE PROCEDURE subida_50pct
AS

END subida_50pct;
