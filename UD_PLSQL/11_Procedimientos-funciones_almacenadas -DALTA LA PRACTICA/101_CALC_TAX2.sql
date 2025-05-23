create or replace PROCEDURE CALC_TAX_OUT 
(EMPL IN EMPLOYEES.EMPLOYEE_ID%TYPE,
    T1 IN NUMBER,
    R1 OUT NUMBER)
IS
  --TAX NUMBER:=0; --Por recibir un tercer parametro OUT no es necesaria esta variable
  SAL NUMBER:=0;
BEGIN
   IF T1 <0 OR T1 > 60 THEN 
      RAISE_APPLICATION_ERROR(-20000,'EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 60');
    END IF;    
   SELECT SALARY INTO SAL FROM EMPLOYEES    WHERE EMPLOYEE_ID=EMPL;
   --T1:=0;
   R1:=SAL*T1/100; --Al guardarse en una variable almacvenada en memoria no es necesario el RETURN
   DBMS_OUTPUT.PUT_line('SALARY:'||SAL);
  -- DBMS_OUTPUT.PUT_line('TAX:'||TAX);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO EXISTE EL EMPLEADO');
END;
