--1. C�digo y nombre de todos los departamentos.
SELECT codigo, nombre FROM departamentos;

--2. N�mero de cuenta y nombre de los empleados cuya retenci�n es mayor o igual que 10.
SELECT cuenta, nombre FROM empleados WHERE retencion >= 10;

--3. Nombre de los empleados que tienen m�s de 2 hijos.
SELECT nombre FROM empleados WHERE hijos > 2;

--4. C�digo y n�mero de cuenta de los empleados cuyo nombre empieze por 'A' o por 'J'.
SELECT nombre, codigo, cuenta FROM empleados WHERE nombre LIKE('A%') OR nombre LIKE('J%');

--5. Nombre del primer y �ltimo empleado en t�rminos alfab�ticos.
/* MIN y MAX() --> Devuelve el valor m�nimo o el m�ximo de la expresi�n entre par�ntesis
*/
SELECT MIN(nombre), MAX(nombre) FROM empleados ORDER BY nombre ASC;

--6. N�mero de hijos y n�mero de empleados agrupados por hijos, mostrando s�lo los grupos cuyo n�mero de empleados sea mayor que 1.
/* COUNT() --> Cuenta el n�mero de valores/datos que tiene una columna,
    por defecto no cuenta los valores nulos, hay que indicarselo con ALL
*/
SELECT hijos, COUNT(ALL nombre) FROM empleados GROUP BY hijos;

--7. N�mero de hijos, retenci�n m�xima, m�nima y media de los empleados agrupados por hijos.
/* AVG() --> Calcula la media de los valores indicados o expresi�n
*/
SELECT hijos, MAX(retencion), MIN(retencion), AVG(retencion) AS retencion_media
    FROM empleados
    GROUP BY hijos;

--8. Nombre del empleado y nombre del departamento en el que han trabajado empleados que no tienen hijos.
/* Multitabla:
    Indicamos (SELECT) las columnas que queremos que se muestren, diferenciando 
    las columnas de una tabla de otra indicando: tabla.columna
    Le decimos (WHERE) con que tablas vamos a trabajar y la relaci�n que existe 
    entre ellas, si hay m�s de una relaci�n la a�adimos con AND y despu�s los filtros.
*/
SELECT Empleados.nombre, Departamentos.nombre
    FROM Empleados, Trabajan, Departamentos
    WHERE (Empleados.codigo = Trabajan.cod_emp)
    AND (Departamentos.codigo = Trabajan.cod_dep)
    AND Empleados.hijos = 0;

--9. Nombre del empleado, mes y ejercicio de sus justificantes de n�mina para los empleados que han trabajado en el departamento de Ventas.
SELECT Empleados.nombre, Just_nominas.mes, Just_nominas.ejercicio
    FROM Empleados, Just_nominas, Trabajan, Departamentos
    WHERE (Empleados.codigo = Just_nominas.cod_emp)
    AND ((Empleados.codigo = Trabajan.cod_emp) AND (Departamentos.codigo = Trabajan.cod_dep))
    AND (trabajan.cod_dep = 1);

--10. Nombre de los empleados que han ganado m�s de 2000 � en el a�o 2006.
/* JOIN es otra manera de unir tablas: con FROM le indicamos la primera tabla y
    despu�s con JOIN indicamos una segunda tabla y le indicamos la relaci�n
    mediante ON tabla2.columna = tabla1.columna
*/
/* Con GROUP BY le decimos como queremos que agrupe los registros, con que columnas,
    con la clausula HAVING le aplicamos un filtro al agrupamiento
*/
SELECT Empleados.Nombre, SUM(Just_Nominas.Ingreso) AS Total_Ingreso_2006
    FROM Empleados
    JOIN Just_Nominas ON Just_Nominas.cod_emp = Empleados.codigo
    WHERE Just_nominas.ejercicio = 2006
    GROUP BY Empleados.nombre HAVING SUM(Just_Nominas.ingreso) > 2000;
    
SELECT Empleados.Nombre, SUM(Just_Nominas.Ingreso) AS Total_Ingreso_2006
    FROM Empleados, Just_nominas
    WHERE Just_Nominas.cod_emp = Empleados.codigo
    AND Just_nominas.ejercicio = 2006
    GROUP BY Empleados.nombre HAVING SUM(Just_Nominas.ingreso) > 2000;

--11. N�mero de empleados cuyo n�mero de hijos es superior a la media de hijos de los empleados.
/* Subconsultas: Pueden ir en la clausula WHERE, HAVING o FROM y entre par�ntesis (),
    es una consulta dentro de otra
*/
SELECT COUNT(nombre)
    FROM Empleados
    WHERE hijos > (
        SELECT AVG(hijos) FROM Empleados
    );

--12. Nombre de los empleados que m�s hijos tienen o que menos hijos tienen.
/* ANY --> Compara con CUALQUIERA de los datos de una lista o subconsulta,
la instrucci�n ser� cierta si ALGUNO de los datos coincide con la condici�n.
2000 > ANY(1000, 1500, 3000) --> OK
Se cumple alguno de Ellos
*/
/* ALL --> Compara los datos con la columna o subconsulta indicada y devuelve ok
si toda la comparaci�n es cierta.
2000 > ALL(1000, 1500, 3000) --> NO OK
Se tienen que cumplir TODOS
*/
SELECT nombre, hijos
    FROM Empleados
    WHERE hijos >= ALL (
        SELECT hijos FROM Empleados
    )
    OR hijos <= ALL (
        SELECT hijos FROM Empleados
    );

--13. Nombre de los empleados que no tienen justificante de n�minas.
/* IS NULL --> Comparar un nulo con otro nulo no tiene sentido, es la no existencia,
    por eso no tiene sentido usar operadores comparadores.
    Lo que hace es preguntar si algo es nulo
*/
SELECT E.nombre
    FROM Empleados E, Just_nominas J
    WHERE E.codigo = J.cod_emp
    AND J.ingreso IS NULL;

--14. Nombre y fecha de nacimiento con formato "1 de Enero de 2000" y etiquetada la columna como fecha, de todos los empleados.
/* TO_CHAR(arg, formato) --> convierte a una cadena de caracteres, el primer argumento
    es el dato a convertir y el segundo el formato con el que se quiere mostrar
*/
SELECT nombre, TO_CHAR(fnacimiento, 'DD" de" MONTH" de" YYYY') AS Nacimiento FROM Empleados;

--15. Nombre de los empleados, nombre de los departamentos en los que ha trabajado y funci�n en may�sculas que ha realizado en cada departamento.
SELECT Empleados.nombre, Departamentos.nombre, UPPER(Trabajan.funcion)
    FROM Empleados, Trabajan, Departamentos
    WHERE (Empleados.codigo = Trabajan.cod_emp) AND (Departamentos.codigo = Trabajan.cod_dep);
    
--16. Nombre, fecha de nacimiento y nombre del d�a de la semana de su fecha de nacimiento de todos los empleados.
SELECT nombre, TO_CHAR(fnacimiento, 'DD" de" MONTH" de" YYYY') AS Nacimiento, TO_CHAR(fnacimiento, 'DAY') AS D�a FROM Empleados;

--17. Nombre, edad y n�mero de hijos de los empleados que tienen menos de 40 a�os y tienen hijos.
/* TRUNC(m, n) --> Dice cuantos decimales queremos que aparezcan en un n�mero o 
    en el resultado de una operaci�n
*/
SELECT nombre, TRUNC(MONTHS_BETWEEN(SYSDATE,fnacimiento)/12, 0) AS Edad, hijos
    FROM Empleados
    WHERE hijos > 0
    AND MONTHS_BETWEEN(SYSDATE,fnacimiento)/12 < 40;
    
--18. Nombre, edad de los empleados y nombre del departamento de los empleados que han trabajado en m�s de un departamento.
/* Selecciona la columna nombre y el calculo de la edad de Empleados; tambien la
    columna nombre de Departamentos.
    Une las tablas relacionando los campos los c�digos de empleado y departamento
    con el correspondiente de la relaci�n Trabajan.
    Y filtra por la lista de valores que nos devuelve la subconsulta.

    Subnconsulta: Selecciona el c�digo de empleado de la Tabla/Relaci�n Trabajan,
    Agrupa por este c�digo, cuenta las veces que el mismo c�digo aparece en disintos
    c�digos de departamento y filtra por las que sean mayor de 1
*/
SELECT E.nombre, TRUNC(MONTHS_BETWEEN(SYSDATE, E.fnacimiento)/12, 0) AS Edad, D.nombre AS Departamento
    FROM Empleados E, Departamentos D, Trabajan T
    WHERE ((E.codigo = T.cod_emp) AND (D.codigo = T.cod_dep))
    AND T.cod_emp
    IN (
        SELECT cod_emp FROM Trabajan
        GROUP BY cod_emp HAVING COUNT(cod_dep)>1
    );

/* Pruebo ha hacer la asociaci�n de varias tablas con JOIN */
SELECT Empleados.nombre, TRUNC(MONTHS_BETWEEN(SYSDATE, Empleados.fnacimiento)/12, 0) AS Edad, Departamentos.nombre AS Departamento
    FROM Empleados
    JOIN Trabajan ON Trabajan.cod_emp = Empleados.codigo
    JOIN Departamentos ON Departamentos.codigo = Trabajan.cod_dep
    WHERE Trabajan.cod_emp
    IN (SELECT cod_emp FROM Trabajan GROUP BY cod_emp HAVING COUNT(cod_dep)>1);

--19. Nombre, edad y n�mero de cuenta de aquellos empleados cuya edad es m�ltiplo de 3.
/* MOD(m, n) -> calcula el resto*/
SELECT nombre, TRUNC(MONTHS_BETWEEN(SYSDATE, fnacimiento)/12) AS Edad, cuenta
    FROM Empleados
    WHERE MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, fnacimiento)/12), 3) = 0;
    
--20. Nombre e ingresos percibidos del empleado m�s joven y del m�s longevo.
/* En la secci�n de la clausula WHERE, lo que le estoy diciendo es que compare
    los datos del campo fnacimiento con todos (ALL) los datos de la lista que
    devuelve la subconsulta que saca los datos de fnacimiento de la tabla Empleados
    y devuelva la fecha menor, en la segunda parte del WHERE (OR) es el caso contrario.
    Con OR le digo que una u otra condici�n, para que asi me muestre los dos resultados.
*/
SELECT E.nombre, E.fnacimiento, SUM(J.ingreso) AS Ingresos
    FROM Empleados E
    JOIN Just_nominas J ON J.cod_emp = E.codigo
    WHERE E.fnacimiento <= ALL (SELECT fnacimiento FROM Empleados)
    OR E.fnacimiento >= ALL (SELECT fnacimiento FROM Empleados)
    GROUP BY E.nombre, E.fnacimiento;