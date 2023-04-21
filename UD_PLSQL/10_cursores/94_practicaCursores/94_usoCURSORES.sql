/*******************************************************************************
1. Hacer un programa que tenga un cursor que vaya visualizando los salarios de
los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar un
RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede ver.
********************************************************************************/
CREATE OR REPLACE PROCEDURE sal_emp
AS
    CURSOR empl IS SELECT first_name, last_name, salary FROM employees;
    emplista empl%ROWTYPE;

    nombre_empl VARCHAR2(100);
BEGIN
    OPEN empl;
    
    LOOP
        FETCH empl INTO emplista;
        EXIT WHEN empl%NOTFOUND;

        nombre_empl := emplista.first_name || ' ' || emplista.last_name;
        dbms_output.put_line('empleado actual: ' || nombre_empl);
        
        IF nombre_empl = 'Steven King' THEN
            RAISE_APPLICATION_ERROR(-20500, 'El jefe no es un empleado');
        ELSE
            dbms_output.put_line('Nombre: ' || nombre_empl);
            dbms_output.put_line('Salario: ' || emplista.salary);            
        END IF;
    END LOOP;
    
    CLOSE empl;
END sal_emp;
/
EXECUTE sal_emp;
/