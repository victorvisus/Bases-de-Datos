-- CURSORES CON PARAMETROS
DECLARE
    CURSOR C1(SAL number) IS SELECT * FROM employees WHERE SALARY > SAL;
    empl EMPLOYEES%ROWTYPE;
BEGIN
    OPEN C1(20000);
    
    LOOP
        FETCH C1 INTO empl;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(empl.first_name || ' ' || empl.salary);
    END LOOP;
    dbms_output.put_line('He encontrado ' || c1%ROWCOUNT || ' empleados');
    CLOSE C1;
END;
/