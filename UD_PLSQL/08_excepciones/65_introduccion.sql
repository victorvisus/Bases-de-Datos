SET SERVEROUTPUT ON;

DECLARE
    empl employees%ROWTYPE;
BEGIN
    SELECT * INTO empl
    FROM employees
    WHERE employee_id = 1000; --Lanza una execpción "no data found" por no encontrar datos con estos criterios
    
    DBMS_OUTPUT.put_line(empl.first_name);
END;
/
