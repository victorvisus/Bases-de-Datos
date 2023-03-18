-- Práctica SELECT INTO
-- Realiza los siguientes ejemplos. Usa %ROWTYPE y %TYPE

/*******************************************************************************
1. PRÁCTICA 1 ------------------------------------------------------------------
• Crear un bloque PL/SQL que devuelva al salario máximo del departamento 100 y 
lo deje en una variable denominada salario_maximo y la visualice
********************************************************************************/
DECLARE
    salario_maximo employees.salary%TYPE;
BEGIN
    SELECT
        MAX(salary)
    INTO salario_maximo
    FROM employees
    WHERE department_id = 100;

    dbms_output.put_line(salario_maximo);
END;
/
-- SOLUCION --------------------------------------------------------------------
DECLARE
    salario_maximo employees.salary%TYPE;
BEGIN
    SELECT
        MAX(salary)
    INTO salario_maximo
    FROM employees
    WHERE department_id = 100;

    dbms_output.put_line('el salario máximo de ese departamento es:' || salario_maximo);
END;
/
/*******************************************************************************
2. PRÁCTICA2 ------------------------------------------------------------------
• Visualizar el tipo de trabajo del empleado número 100
********************************************************************************/
DECLARE
    puesto  jobs.job_title%TYPE;
    nombre  employees.first_name%TYPE;
BEGIN
    SELECT
        j.job_title, e.first_name
    INTO puesto, nombre
    FROM jobs j
        INNER JOIN employees e ON j.job_id = e.job_id
    WHERE e.employee_id = 100;

    dbms_output.put_line(nombre || ' es ' || puesto);
END;
/
-- SOLUCION --------------------------------------------------------------------
DECLARE
    tipo_trabajo employees.job_id%TYPE;
BEGIN
    SELECT
        job_id
    INTO tipo_trabajo
    FROM employees
    WHERE employee_id = 100;

    dbms_output.put_line('El tipo de trabajo del empleado 100 es:' || tipo_trabajo);
END;
/
/*******************************************************************************
3. PRÁCTICA 3 ------------------------------------------------------------------
• Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por ejemplo 10.
• Visualizar el nombre de ese departamento y el número de empleados que tiene,
poniendo. Crear dos variables para albergar los valores. 
********************************************************************************/
DECLARE
    dpto       employees.department_id%TYPE := 10;
    nombre     departments.department_name%TYPE;
    num_emple  NUMBER;
BEGIN
    SELECT
        d.department_name, COUNT(e.employee_id)
    INTO nombre, num_emple
    FROM departments d
        INNER JOIN employees e ON e.department_id = d.department_id
    WHERE e.department_id = dpto
    GROUP BY d.department_name;

    dbms_output.put_line('Nombre del dpto: ' || nombre);
    dbms_output.put_line('Tiene: ' || num_emple || ' empleados');
END;
/
-- SOLUCION --------------------------------------------------------------------
DECLARE
    cod_departamento  departments.department_id%TYPE := 10;
    nom_departamento  departments.department_name%TYPE;
    num_emple         NUMBER;
BEGIN
--RECUPERAR EL NOMBRE DEL DEPARTAMENTO
    SELECT
        department_name
    INTO nom_departamento
    FROM departments
    WHERE department_id = cod_departamento;
--RECUPERAR EL NÚMERO DE EMLEADOS DEL DEPARTAMENTO
    SELECT
        COUNT(*)
    INTO num_emple
    FROM employees
    WHERE department_id = cod_departamento;

    dbms_output.put_line('EL DEPARTAMENTO ' || nom_departamento || ' TIENE ' || num_emple || ' EMPLEADOS');

END;
/
/*******************************************************************************
4. PRÁCTICA 4 ------------------------------------------------------------------
• Mediante dos consultas recuperar el salario máximo y el salario mínimo de la
empresa e indicar su diferencia
********************************************************************************/
DECLARE
    salario_maximo  employees.salary%TYPE;
    salario_min     employees.salary%TYPE;
    dif             NUMBER(8, 2);
BEGIN
    SELECT
        MAX(employees.salary), MIN(employees.salary)
    INTO salario_maximo, salario_min
    FROM employees;

    dbms_output.put_line('Salario máx: ' || salario_maximo);
    dbms_output.put_line('Salario máx: ' || salario_min);
    
    dif := salario_maximo - salario_min;
    dbms_output.put_line('la diferencia es: ' || dif);
END;
/
-- SOLUCION --------------------------------------------------------------------
DECLARE
    maximo      NUMBER;
    minimo      NUMBER;
    diferencia  NUMBER;
BEGIN
    SELECT
        MAX(salary), MIN(salary)
    INTO maximo, minimo
    FROM employees;

    dbms_output.put_line('EL SALARIO MÁXIMO ES:' || maximo);
    dbms_output.put_line('EL SALARIO MÍNIMO ES:' || minimo);
    diferencia := maximo - minimo;
    dbms_output.put_line('LA DIFERENCIA ES:' || diferencia);
END;
/