-- Pr�ctica de COLECCIONES y RECORDS

/*******************************************************************************
� Creamos un TYPE RECORD que tenga las siguientes columnas
    NAME VARCHAR2(100), SAL EMPLOYEES.SALARY%TYPE, COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);
� Creamos un TYPE TABLE basado en el RECORD anterior
� Mediante un bucle cargamos en la colecci�n los empleados. El campo NAME debe
contener FIRST_NAME y LAST_NAME concatenado.
� Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el 
v�deo usamos el EMPLOYEE_ID que va de 100 a 206
� A partir de este momento y ya con la colecci�n cargada, hacemos las siguientes
operaciones, usando m�todos de la colecci�n.
    � Visualizamos toda la colecci�n
    � Visualizamos el primer empleado
    � Visualizamos el �ltimo empleado
    � Visualizamos el n�mero de empleados
    � Borramos los empleados que ganan menos de 7000 y visualizamos de nuevo la colecci�n
    � Volvemos a visualizar el n�mero de empleados para ver cuantos se han borrado
    
    -- M�todos de los arrays
    - EXIST(N)  : Detectar si existe un elemento
    - COUNT     : N�mero de elementos que contiene
    - FIRST     : Devuelve el �ndice m�s peque�o
    - LAST      : Devuelve el �ndice m�s alto
    - PRIOR(N)  : Devuelve el �ndice anterior a N
    - NEXT(N)   : Devuelve el �ndice posterior a N
    - DELETE    : Borra todo
    - DELETE(N) : Borra el �ndice N
    - DELETE(M,N) : Borra de los �ndices M a N

*******************************************************************************/

DECLARE
    --Creo el objeto TYPE RECORD
    TYPE empleado_record IS RECORD (
        name VARCHAR2(100),
        sal employees.salary%TYPE,
        cod_dept employees.department_id%TYPE
    );
    
    --Creo el objeto TYPE TABLE
    TYPE empleado_table IS TABLE OF
        empleado_record
    INDEX BY PLS_INTEGER;

    --Declaro la variable
    empl empleado_table;
    
    numFilas PLS_INTEGER;
    
    firstId PLS_INTEGER;
    lastId PLS_INTEGER;
BEGIN
/* Hay que cargar las filas en el Array ( Objeto IS TABLE OF ),
Uso un FOR pero necesito saber la iteraci�n MAX y MIN
- Mediante un SELECT couento las filas que contiene la tabla employees y lo guardo 
en la variable numFilas.
Mejor para usar los ID, saco el ID mayor
- Para saber el comienzo del loop, y para usar i como ID del empleado, hago una 
consulta para saber cual es el ID menor que existe en la tabla, y lo guardo en la
variable firstID
*/
    SELECT MIN(employee_id) INTO firstId FROM employees;
--    dbms_output.put_line('Primer ID: ' || firstId);
    SELECT MAX(employee_id) INTO lastId FROM employees;
--    dbms_output.put_line('Primer ID: ' || lastId);
    
    FOR i IN firstId..lastId LOOP
        SELECT
            e.first_name || ' ' || e.last_name, e.salary, e.department_id INTO empl(i)
        FROM employees e
        WHERE e.employee_id = i; -- NO TE OLVIDES DEL WHERE, si no devuelve todas las filas en una sola consulta
    END LOOP;


-- Visualizamos toda la colecci�n ----------------------------------------------
    dbms_output.put_line('');
    dbms_output.put_line('-- Visualizamos toda la colecci�n -----------------');
    FOR i IN empl.FIRST..empl.LAST LOOP
        dbms_output.put_line('Nombre: ' || empl(i).name || ' - Salario: ' || empl(i).sal || ' - Dpto: ' || empl(i).cod_dept);
    END LOOP;

-- Visualizamos el primer empleado ---------------------------------------------
    dbms_output.put_line('');
    dbms_output.put_line('-- Visualizamos el primer empleado - ' || empl.FIRST ||'  ----------------');
    dbms_output.put_line('Nombre: ' || empl(empl.FIRST).name || ' - Salario: ' || empl(empl.FIRST).sal || ' - Dpto: ' || empl(empl.FIRST).cod_dept);
     
-- Visualizamos el �ltimo empleado ---------------------------------------------
    dbms_output.put_line('');
    dbms_output.put_line('-- Visualizamos el �ltimo empleado - ' || empl.LAST ||'  ----------------');
    dbms_output.put_line('Nombre: ' || empl(empl.LAST).name || ' - Salario: ' || empl(empl.LAST).sal || ' - Dpto: ' || empl(empl.LAST).cod_dept);
    
-- Visualizamos el n�mero de empleados -----------------------------------------
    dbms_output.put_line('');
    dbms_output.put_line('-- Visualizamos el n�mero de empleados -----------------');
    dbms_output.put_line('N�mero de empleados: ' || empl.COUNT);
    
-- Borramos los empleados que ganan menos de 7000 y visualizamos de nuevo la colecci�n
    dbms_output.put_line('');
    dbms_output.put_line('-- Borramos los empleados que ganan menos de 7000');
    dbms_output.put_line('y visualizamos de nuevo la colecci�n -------------------');
    FOR i IN empl.FIRST..empl.LAST LOOP
        IF empl(i).sal < 7000 THEN
            empl.DELETE(i);
        ELSE
            dbms_output.put_line('Nombre: ' || empl(i).name || ' - Salario: ' || empl(i).sal || ' - Dpto: ' || empl(i).cod_dept);
        END IF;
    END LOOP;

-- Volvemos a visualizar el n�mero de empleados para ver cuantos se han borrado
    dbms_output.put_line('');
    dbms_output.put_line('-- Volvemos a visualizar el n�mero de empleados -----------------');
    dbms_output.put_line('Han quedado empleados: ' || empl.COUNT);    
END;
/