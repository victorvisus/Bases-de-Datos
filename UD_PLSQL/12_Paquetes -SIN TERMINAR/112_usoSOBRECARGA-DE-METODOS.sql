--SOBRECARGA DE METODOS

--Queremos una función que cuente los empleados, da igual si recibe el nombre o si recibe el codigo
CREATE OR REPLACE PACKAGE PACK2 AS 

    -- Sobrecarga de funciones  
    FUNCTION count_employees(cod NUMBER) RETURN NUMBER;
    FUNCTION count_employees(cod VARCHAR2) RETURN NUMBER;

END PACK2;
/

CREATE OR REPLACE PACKAGE BODY PACK2 AS

  FUNCTION count_employees(cod NUMBER) RETURN NUMBER AS
  x NUMBER;
  BEGIN
    SELECT COUNT(*) INTO x FROM employees WHERE department_id = cod;
    RETURN x;
  END count_employees;

  FUNCTION count_employees(cod VARCHAR2) RETURN NUMBER AS
  x number;
  BEGIN
    SELECT COUNT(*) INTO x FROM employees a, departments b
        WHERE department_name = 'cod'
        AND a.department_id = b.department_id;
    RETURN x;
  END count_employees;

END PACK2;
/
SET SERVEROUT ON
BEGIN
    dbms_output.put_line('usamos la funccion que recibe un number ' || pack2.count_employees('50'));
    dbms_output.put_line('usamos la funccion que recibe un varchar2 ' || pack2.count_employees('Marketing'));
END;