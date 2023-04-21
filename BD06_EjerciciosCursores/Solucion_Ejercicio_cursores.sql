
1) Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.

CREATE OR REPLACE PROCEDURE ver_emple
AS
CURSOR c_emple IS
SELECT APELLIDO, FECHA_ALT
FROM EMPLE
ORDER BY APELLIDO;
v_apellido VARCHAR2(10);
v_fecha DATE;
BEGIN
OPEN c_emple;
FETCH c_emple into v_apellido, v_fecha;
WHILE c_emple%FOUND LOOP
DBMS_OUTPUT.PUT_LINE( v_apellido||' * '||v_fecha);
FETCH c_emple into v_apellido,v_fecha;
END LOOP;
CLOSE c_emple;
END ver_emple;

2) Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.

CREATE OR REPLACE PROCEDURE ver_emple_depart
AS
CURSOR c_emple IS
SELECT dnombre, COUNT(emp_no)
FROM emple e, depart d
WHERE d.dept_no = e.dept_no(+)
GROUP BY dnombre;
v_dnombre depart.dnombre%TYPE;
v_num_emple BINARY_INTEGER;
BEGIN
OPEN c_emple;
FETCH c_emple into v_dnombre, v_num_emple;
WHILE c_emple%FOUND LOOP
DBMS_OUTPUT.PUT_LINE(v_dnombre||' * '||v_num_emple);
FETCH c_emple into v_dnombre,v_num_emple;
END LOOP;
CLOSE c_emple;
END ver_emple_depart;

3) Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.

CREATE OR REPLACE PROCEDURE ver_emple_apell(
cadena VARCHAR2)
AS
cad VARCHAR2(10);
CURSOR c_emple IS
SELECT apellido, emp_no FROM emple
WHERE apellido LIKE cad;
vr_emple c_emple%ROWTYPE;
BEGIN
cad :='%'||cadena||'%';
OPEN c_emple;
FETCH c_emple INTO vr_emple;
WHILE (c_emple%FOUND) LOOP
DBMS_OUTPUT.PUT_LINE(vr_emple.emp_no||' * '
||vr_emple.apellido);
FETCH c_emple INTO vr_emple;
END LOOP;
DBMS_OUTPUT.PUT_LINE('NUMERO DE EMPLEADOS: '
|| c_emple%ROWCOUNT);
CLOSE c_emple;
END ver_emple_apell;

4) Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.

CREATE OR REPLACE PROCEDURE emp_5maxsal
AS
CURSOR c_emp IS
    SELECT apellido, salario FROM emple ORDER BY salario DESC;

    vr_emp c_emp%ROWTYPE;
    i NUMBER;

BEGIN
    i:=1;
    OPEN c_emp;
    FETCH c_emp INTO vr_emp;
    WHILE c_emp%FOUND AND i<=5 LOOP
        DBMS_OUTPUT.PUT_LINE(vr_emp.apellido ||' * '|| vr_emp.salario);
        FETCH c_emp INTO vr_emp;
        i:=I+1;
    END LOOP;
    CLOSE c_emp;
END emp_5maxsal;

	  	
5) Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.
CREATE OR REPLACE PROCEDURE emp_2minsal
AS
    CURSOR c_emp IS
        SELECT apellido, oficio, salario FROM emple
        ORDER BY oficio, salario;
    vr_emp c_emp%ROWTYPE;
    oficio_ant EMPLE.OFICIO%TYPE;
    i NUMBER;
BEGIN
    OPEN c_emp;
    oficio_ant:='*';

    FETCH c_emp INTO vr_emp;
    WHILE c_emp%FOUND LOOP
        IF oficio_ant <> vr_emp.oficio THEN
            oficio_ant := vr_emp.oficio;
            i := 1;
        END IF;

        IF i <= 2 THEN
            DBMS_OUTPUT.PUT_LINE(vr_emp.oficio||' * ' ||vr_emp.apellido||' * ' ||vr_emp.salario);
        END IF;

        FETCH c_emp INTO vr_emp;
        i:=I+1;
    END LOOP;
    
    CLOSE c_emp;
END emp_2minsal;

 

6) Escribir un programa que muestre, en formato similar a las rupturas de control o secuencia vistas en SQL*plus los siguientes datos:
- Para cada empleado: apellido y salario.
- Para cada departamento: Número de empleados y suma de los salarios del departamento.
- Al final del listado: Número total de empleados y suma de todos los salarios.
CREATE OR REPLACE PROCEDURE listar_emple
AS
CURSOR c1 IS
SELECT apellido, salario, dept_no FROM emple
ORDER BY dept_no, apellido;
vr_emp c1%ROWTYPE;
dep_ant EMPLE.DEPT_NO%TYPE;
cont_emple NUMBER(4) DEFAULT 0;
sum_sal NUMBER(9) DEFAULT 0;
tot_emple NUMBER(4) DEFAULT 0;
tot_sal NUMBER(10) DEFAULT 0;
BEGIN
OPEN c1;
FETCH c1 INTO vr_emp;
IF c1%FOUND THEN
dep_ant := vr_emp.dept_no;
END IF;
WHILE c1%FOUND LOOP

/* Comprobación nuevo departamento y resumen */
IF dep_ant <> vr_emp.dept_no THEN
DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || dep_ant ||
' NUM. EMPLEADOS: '||cont_emple ||
' SUM. SALARIOS: '||sum_sal);
dep_ant := vr_emp.dept_no;
tot_emple := tot_emple + cont_emple;
tot_sal:= tot_sal + sum_sal;
cont_emple:=0;
sum_sal:=0;
END IF;

/* Líneas de detalle */
DBMS_OUTPUT.PUT_LINE(RPAD(vr_emp.apellido,10)|| ' * '
||LPAD(TO_CHAR(vr_emp.salario,'9,999,999'),12));

/* Incrementar y acumular */
cont_emple := cont_emple + 1;
sum_sal:=sum_sal + vr_emp.salario;

FETCH c1 INTO vr_emp;
END LOOP;
CLOSE c1;

IF cont_emple > 0 THEN

/* Escribir datos del último departamento */
DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || dep_ant ||
' NUM EMPLEADOS: '|| cont_emple ||
' SUM. SALARIOS: '||sum_sal);
dep_ant := vr_emp.dept_no;
tot_emple := tot_emple + cont_emple;
tot_sal:= tot_sal + sum_sal;
cont_emple:=0;
sum_sal:=0;

/* Escribir totales informe */
DBMS_OUTPUT.PUT_LINE(' ****** NUMERO TOTAL EMPLEADOS: '
||tot_emple ||
' TOTAL SALARIOS: '|| tot_sal);
END IF;
END listar_emple;

/* Nota: este procedimiento puede escribirse de forma que la visualización de los resultados resulte mas clara incluyendo líneas de separación, cabeceras de columnas, etcétera. Por razones didácticas no se han incluido estos elementos ya que pueden distraer y dificultar la comprensión del código. */

7) Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nombre del departamento y la localidad.
El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
Se incluirá gestión de posibles errores.

CREATE OR REPLACE PROCEDURE insertar_depart(
nombre_dep VARCHAR2,
loc VARCHAR2)
AS
CURSOR c_dep IS SELECT dnombre
FROM depart WHERE dnombre = nombre_dep;
v_dummy DEPART.DNOMBRE%TYPE DEFAULT NULL;
v_ulti_num DEPART.DEPT_NO%TYPE;
nombre_duplicado EXCEPTION;
BEGIN
/* Comprobación de que el departamento no está duplicado */
OPEN c_dep;
FETCH c_dep INTO v_dummy;
CLOSE c_dep;
IF v_dummy IS NOT NULL THEN
RAISE nombre_duplicado;
END IF;

/* Captura del último número y cálculo del siguiente */
SELECT MAX(dept_no) INTO v_ulti_num FROM depart;

/* Inserción de la nueva fila */
INSERT INTO depart VALUES ((TRUNC(v_ulti_num, -1)+10)
, nombre_dep, loc);
EXCEPTION
WHEN nombre_duplicado THEN
DBMS_OUTPUT.PUT_LINE('Err. departamento duplicado');
RAISE;
WHEN OTHERS THEN
RAISE_APPLICATION_ERROR(-20005, 'Err. Operacion cancelada');
END insertar_depart;

 

8) Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores.

CREATE OR REPLACE PROCEDURE alta_emp(
num emple.emp_no%TYPE,
ape emple.apellido%TYPE,
ofi emple.oficio%TYPE,
jef emple.dir%TYPE,
fec emple.fecha_alt%TYPE,
sal emple.salario%TYPE,
com emple.comision%TYPE DEFAULT NULL,
dep emple.dept_no%TYPE)
AS
v_dummy_jef EMPLE.DIR%TYPE DEFAULT NULL;
v_dummy_dep DEPART.DEPT_NO%TYPE DEFAULT NULL;
BEGIN
/* Comprobación de que existe el departamento */
SELECT dept_no INTO v_dummy_dep
FROM depart WHERE dept_no = dep;

/* Comprobación de que existe el jefe del empleado */
SELECT emp_no INTO v_dummy_jef
FROM emple WHERE emp_no = jef;

/* Inserción de la fila */
INSERT INTO EMPLE VALUES
(num, ape, ofi, jef, fec, sal, com, dep);

EXCEPTION
WHEN NO_DATA_FOUND THEN
IF v_dummy_dep IS NULL THEN
RAISE_APPLICATION_ERROR(-20005,
'Err. Departamento inexistente');
ELSIF v_dummy_jef IS NULL THEN
RAISE_APPLICATION_ERROR(-20005,
'Err. No existe el jefe');
ELSE
RAISE_APPLICATION_ERROR(-20005,
'Err. Datos no encontrados(*)');
END IF;
WHEN DUP_VAL_ON_INDEX THEN
DBMS_OUTPUT.PUT_LINE
('Err.numero de empleado duplicado');
RAISE;
END alta_emp;

9) Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).

CREATE OR REPLACE PROCEDURE subida_sal1(
num_depar emple.dept_no%TYPE,
importe NUMBER,
porcentaje NUMBER)
AS
CURSOR c_sal IS SELECT salario,ROWID
FROM emple WHERE dept_no = num_depar;
vr_sal c_sal%ROWTYPE;
v_imp_pct NUMBER(10);
BEGIN
OPEN c_sal;
FETCH c_sal INTO vr_sal;
WHILE c_sal%FOUND LOOP

/* Guardar en v_imp_pct el importe mayor */
v_imp_pct :=
GREATEST((vr_sal.salario/100)*porcentaje,
v_imp_pct);

/* Actualizar */
UPDATE EMPLE SET SALARIO=SALARIO + v_imp_pct
WHERE ROWID = vr_sal.rowid;

FETCH c_sal INTO vr_sal;
END LOOP;
CLOSE c_sal;
EXCEPTION
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('Err. ninguna fila actualizada');
END subida_sal1;

 
10) Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores.
CREATE OR REPLACE PROCEDURE subida_50pct
AS
CURSOR c_ofi_sal IS
SELECT oficio, AVG(salario) salario FROM emple
GROUP BY oficio;
CURSOR c_emp_sal IS
SELECT oficio, salario FROM emple E1
WHERE salario <
(SELECT AVG(salario) FROM emple E2
WHERE E2.oficio = E1.oficio)
ORDER BY oficio, salario FOR UPDATE OF salario;

vr_ofi_sal c_ofi_sal%ROWTYPE;
vr_emp_sal c_emp_sal%ROWTYPE;
v_incremento emple.salario%TYPE;

BEGIN
COMMIT;
OPEN c_emp_sal;
FETCH c_emp_sal INTO vr_emp_sal;
OPEN c_ofi_sal;
FETCH c_ofi_sal INTO vr_ofi_sal;
WHILE c_ofi_sal%FOUND AND c_emp_sal%FOUND LOOP

/* calcular incremento */
v_incremento :=
(vr_ofi_sal.salario - vr_emp_sal.salario) / 2;

/* actualizar */
UPDATE emple SET salario = salario + v_incremento
WHERE CURRENT OF c_emp_sal;

/* siguiente empleado */
FETCH c_emp_sal INTO vr_emp_sal;

/* comprobar si es otro oficio */
IF c_ofi_sal%FOUND and
vr_ofi_sal.oficio <> vr_emp_sal.oficio THEN
FETCH c_ofi_sal INTO vr_ofi_sal;
END IF;
END LOOP;
CLOSE c_emp_sal;
CLOSE c_ofi_sal;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK WORK;
RAISE;
END subida_50pct;