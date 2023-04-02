SET SERVEROUTPUT ON;

DECLARE
    --Tipo SIMPLE
    TYPE departamentos IS TABLE OF
        departments.department_name%TYPE
        INDEX BY PLS_INTEGER;

    --Tipo COMPUESTO
    TYPE empleados IS TABLE OF
        employees%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    depts departamentos;
    empls empleados;

BEGIN
    -- Tipo SIMPLE
    depts(1) := 'informatica';
    depts(2) := 'rrhh';
    depts(55) := 'Prueba';
    
    dbms_output.put_line('Pos. 1: ' || depts(1));
    dbms_output.put_line('Pos. 2: ' || depts(2));
    dbms_output.put_line('Pos. LAST: ' || depts.LAST);
    dbms_output.put_line('Pos. FIRST: ' || depts.FIRST);
    
    IF depts.EXISTS(3) THEN
        dbms_output.put_line(depts(3));
    ELSE
        dbms_output.put_line('Ese valor no existe');
    END IF;
    
    -- Tipo COMPUESTO
    SELECT * INTO empls(1) FROM employees WHERE employee_id = 100;
    dbms_output.put_line(empls(1).first_name);
    
    SELECT * INTO empls(2) FROM employees WHERE employee_id = 110;
    dbms_output.put_line(empls(2).first_name);
END;
/
