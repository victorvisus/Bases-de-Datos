
/* CREACION DE PROCEDIMIENTOS QUE USAN cursores */ .

1) Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
CREATE OR REPLACE PROCEDURE ver_emple
AS

END ver_emple;

2) Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.
CREATE OR REPLACE PROCEDURE ver_emple_depart
AS

END ver_emple_depart;

3) Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.
CREATE OR REPLACE PROCEDURE ver_emple_apell(cadena VARCHAR2)
AS

END ver_emple_apell;

4) Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
CREATE OR REPLACE PROCEDURE emp_5maxsal
AS

END emp_5maxsal;

	  	
5) Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.
CREATE OR REPLACE PROCEDURE emp_2minsal
AS

END emp_2minsal;

 
6) Escribir un programa que muestre, en formato similar a las rupturas de control o secuencia vistas en SQL*plus los siguientes datos:
- Para cada empleado: apellido y salario.
- Para cada departamento: Número de empleados y suma de los salarios del departamento.
- Al final del listado: Número total de empleados y suma de todos los salarios.
CREATE OR REPLACE PROCEDURE listar_emple
AS

END listar_emple;

7) Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
Se pasará al procedimiento el nombre del departamento y la localidad.
El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
Se incluirá gestión de posibles errores.

CREATE OR REPLACE PROCEDURE insertar_depart(nombre_dep VARCHAR2, loc VARCHAR2)
AS

END insertar_depart;

 
8) Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores.
CREATE OR REPLACE PROCEDURE alta_emp( num emple.emp_no%TYPE, ape emple.apellido%TYPE, ofi emple.oficio%TYPE,
jef emple.dir%TYPE, fec emple.fecha_alt%TYPE, sal emple.salario%TYPE, com emple.comision%TYPE DEFAULT NULL, dep emple.dept_no%TYPE)
AS

END alta_emp;

	  	
9) Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o 
el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).
CREATE OR REPLACE PROCEDURE subida_sal1(num_depar emple.dept_no%TYPE,importe NUMBER,porcentaje NUMBER)
AS

END subida_sal1;
 

10) Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. 
La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar 
que la transacción no se quede a medias, y se gestionarán los posibles errores.

CREATE OR REPLACE PROCEDURE subida_50pct
AS

END subida_50pct;
