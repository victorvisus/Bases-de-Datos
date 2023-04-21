/*******************************************************************************
3- Crear un cursor con parámetros que pasando el número de departamento visualice
el número de empleados de ese departamento
********************************************************************************/
CREATE OR REPLACE PROCEDURE jefes_dpto(dpt_id IN departments.department_id%TYPE)
AS
    CURSOR num_empl_dpto(num_dpto departments.department_id%TYPE) IS
        SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS num_empl FROM employees e
            INNER JOIN departments d ON d.department_id = e.department_id
            GROUP BY d.department_id, d.department_name
            HAVING d.department_id = num_dpto;

BEGIN
    FOR i IN num_empl_dpto(dpt_id) LOOP
        dbms_output.put_line('ID dpto: ' || i.department_id);
        dbms_output.put_line('Nombre: ' || i.department_name);
        dbms_output.put_line('Num. Empleados: ' || i.num_empl);
    END LOOP;

END jefes_dpto;
/
EXECUTE jefes_dpto(600);
/

/************************************************* SOLUCIÓN DEL PROFESOR    ****/
SET SERVEROUTPUT ON
DECLARE
    CODIGO DEPARTMENTS.DEPARTMENT_ID%TYPE;
    CURSOR C1(COD DEPARTMENTS.DEPARTMENT_ID%TYPE ) IS SELECT COUNT(*) FROM employees
        WHERE DEPARTMENT_ID=COD;
    NUM_EMPLE NUMBER;
BEGIN
    CODIGO:=10;
    OPEN C1(CODIGO);
    FETCH C1 INTO NUM_EMPLE;
        DBMS_OUTPUT.PUT_LINE('numero de empleados de ' ||codigo||' es '||num_emple);
end;