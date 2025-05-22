CREATE OR REPLACE FUNCTION CALC_TAX_F
    (EMPL IN EMPLOYEES.EMPLOYEE_ID%TYPE,
      T1 IN NUMBER)
RETURN NUMBER --Se indica el tipo de dato que devuelve
IS
  TAX NUMBER:=0;
  SAL NUMBER:=0;
BEGIN
   IF T1 <0 OR T1 > 60 THEN 
      RAISE_APPLICATION_ERROR(-20000,'EL PORCENTAJE DEBE ESTAR ENTRE 0 Y 60');
    END IF;
   SELECT SALARY INTO SAL FROM EMPLOYEES WHERE EMPLOYEE_ID=EMPL;
   --T1:=0;
   TAX:=SAL*T1/100;
   
   RETURN TAX; --Se le dice que variable va a devolver
   -- Hay que controlar los RETURN
EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_line('NO EXISTE EL EMPLEADO');
END;
/
/** Cuando se llama a la funcion hay que guardar su RETURN en algun sitio, una variable **/

-- Las funcionaes se pueden usar en SQL ----
SELECT first_name, salary FROM employees;

SELECT first_name, salary, calc_tax_f(employee_id, 18) FROM employees;

-- RESTRICCIONES: ---
--Solo se tienen parámetros de tipo IN
--La función tienen que estar en la base de datos
--Solo devuelve dato de tipo SQL o PL/SQL