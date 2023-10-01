4.12. Pr�cticas Propuestas
Pr�ctica 4.7: Consultas simples con la BBDD jardiner�a

1. Sacar la ciudad y el tel�fono de las oficinas de Estados Unidos.

	SELECT Ciudad, Telefono
	FROM oficinas
	WHERE Pais='EEUU';


2. Sacar el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.

	SELECT Nombre, Apellido1, Apellido2, Email
	FROM empleados
	WHERE CodigoJefe =	(SELECT CodigoEmpleado
						FROM empleados
						WHERE nombre = 'Alberto' AND apellido1='Soria');	


	SELECT emp.Nombre, emp.Apellido1, emp.Apellido2, emp.Email
	FROM empleados emp INNER JOIN empleados jefe ON emp.CodigoJefe = jefe.CodigoEmpleado
	WHERE jefe.nombre = 'Alberto' AND jefe.apellido1='Soria';


3. Sacar el cargo, nombre, apellidos y email del jefe de la empresa.

	SELECT Puesto, Nombre, Apellido1, Apellido2, Email
	FROM empleados
	WHERE CodigoJefe IS NULL


4. Sacar el nombre, apellidos y cargo de aquellos que no sean representantes de ventas.

	SELECT Nombre, Apellido1, Apellido2, Puesto
	FROM empleados
	WHERE Puesto <> 'Representante Ventas';
	
	SELECT Nombre, Apellido1, Apellido2, Puesto
	FROM empleados
	WHERE NOT(Puesto = 'Representante Ventas');

	SELECT Nombre, Apellido1, Apellido2, Puesto
	FROM empleados
	WHERE Puesto != 'Representante Ventas';

5. Sacar el n�mero de clientes que tiene la empresa.

	SELECT count(*) AS numClientes
	FROM clientes


6. Sacar el nombre de los clientes espa�oles.

	SELECT nombreCliente, Pais
	FROM clientes
	WHERE Pais = 'Spain' OR Pais = 'España';
	
	SELECT nombreCliente, Pais
	FROM clientes
	WHERE Pais = 'Spain' || Pais = 'España';


7. Sacar cu�ntos clientes tiene cada pa�s.

	SELECT Pais, count(CodigoCliente) AS NumClientes
	FROM clientes
	GROUP BY Pais;


8. Sacar cu�ntos clientes tiene la ciudad de Madrid.

	SELECT Ciudad, count(CodigoCliente) AS NumClientes
	FROM clientes
	WHERE Ciudad = 'Madrid'
	GROUP BY Ciudad;
	
	SELECT Ciudad, count(CodigoCliente) AS NumClientes
	FROM clientes
	WHERE Ciudad = 'Madrid';


9. Sacar cu�ntos clientes tienen las ciudades que empiezan por M.

	SELECT count(CodigoCliente) AS CiudadesEmpiezanM
	FROM clientes
	WHERE Ciudad LIKE 'M%';


10. Sacar el c�digo de empleado y el n�mero de clientes al que atiende cada representante de ventas.
	
	SELECT CodigoEmpleadoRepVentas AS CodigoEmpleado, Count(CodigoCliente) AS NumeroClientes
	FROM clientes
	GROUP BY CodigoEmpleadoRepVentas;


11. Sacar el n�mero de clientes que no tiene asignado representante de ventas.

	SELECT count(CodigoCliente) AS NumClientesSinRepresentante
	FROM clientes
	WHERE CodigoEmpleadoRepVentas IS NULL;
	

12. Sacar cu�l fue el primer y �ltimo pago que hizo alg�n cliente.

	SELECT CodigoCliente, MIN(FechaPedido) AS PrimerPago, MAX(FechaPedido) AS UltimoPago
	FROM pedidos;
	
	SELECT CodigoCliente, MIN(FechaPedido) AS PrimerPago, MAX(FechaPedido) AS UltimoPago
	FROM pedidos
	GROUP BY CodigoCliente;
	
	
13. Sacar el c�digo de cliente de aquellos clientes que hicieron pagos en 2008.

	SELECT CodigoCliente
	FROM pedidos
	WHERE FechaPedido LIKE '2008%'
	GROUP BY CodigoCliente;
	
	SELECT CodigoCliente
	FROM pedidos
	WHERE YEAR(FechaPedido) = '2008'
	GROUP BY CodigoCliente;
	
	
14. Sacar los distintos estados por los que puede pasar un pedido.
	
	SELECT Estado
	FROM pedidos
	GROUP BY Estado;
	
	
15. Sacar el n�mero de pedido, c�digo de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregados a tiempo.

	SELECT CodigoPedido, FechaEsperada, FechaEntrega
	FROM pedidos
	WHERE FechaEntrega > FechaEsperada;

16. Sacar cu�ntos productos existen en cada l�nea de pedido.
	
	SELECT CodigoPedido, CodigoProducto, NumeroLinea, Cantidad
	FROM detallepedidos;

	
16.1 Sacar cu�ntos productos distintos, y totales existen en cada pedido.

	SELECT CodigoPedido, COUNT(CodigoProducto) AS NumProductosDistintos, SUM(Cantidad) AS NumProductosTotales
	FROM detallepedidos
	GROUP BY CodigoPedido;
	
	
17. Sacar un listado de los 20 c�digos de productos m�s pedidos ordenado por cantidad pedida. (pista: Usar el filtro LIMIT de MySQL o el filtro rownum de Oracle)

	SELECT CodigoProducto, SUM(Cantidad)
	FROM detallepedidos
	GROUP BY CodigoProducto
	ORDER BY SUM(Cantidad) DESC
	LIMIT 20;
	
	
18. Sacar el n�mero de pedido, c�digo de cliente, fecha requerida y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos d�as antes de la fecha requerida. (pista: Usar la funci�n addDate de MySQL o el operador + de Oracle).

	SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega
	FROM pedidos
	WHERE DATE_ADD(FechaEntrega,INTERVAL 2 DAY) <= FechaEsperada;
	

	SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega, DATEDIFF(FechaEsperada,FechaEntrega)
	FROM pedidos
	WHERE DATEDIFF(FechaEsperada,FechaEntrega) <= 2;
	
	
19. Sacar la facturaci�n que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. NOTA: La base imponible se calcula sumando el coste del producto por el n�mero de unidades vendidas. El IVA, es el 18% de la base imponible, y el total, la suma de los dos campos anteriores.

	SELECT SUM(Cantidad*PrecioUnidad) AS BaseImponible,SUM(Cantidad*PrecioUnidad)*0.18 AS IVA18,SUM(Cantidad*PrecioUnidad)+SUM(Cantidad*PrecioUnidad)*0.18 AS TotalFacturado
	FROM detallepedidos;
	

20. Sacar la misma informaci�n que en la pregunta anterior, pero agrupada por c�digo de producto filtrada por los c�digos que empiecen por FR.

	SELECT CodigoProducto, SUM(Cantidad*PrecioUnidad) AS BaseImponible, SUM(Cantidad*PrecioUnidad)*0.18 AS IVA18, SUM(Cantidad*PrecioUnidad)+SUM(Cantidad*PrecioUnidad)*0.18 AS TotalFacturado
	FROM detallepedidos
	GROUP BY CodigoProducto
	HAVING CodigoProducto LIKE "FR%";

Pr�ctica 4.8: Subconsultas con la BBDD jardiner�a

1. Obtener el nombre del producto m�s caro.

	SELECT nombre
	FROM productos
	WHERE PrecioVenta = (SELECT MAX(PrecioVenta)
						FROM productos);

						
2. Obtener el nombre del producto del que m�s unidades se hayan vendido en un mismo pedido.

	SELECT nombre
	FROM productos
	WHERE codigoProducto = (SELECT codigoProducto
							FROM detallepedidos
							WHERE Cantidad = (SELECT MAX(Cantidad)
											  FROM detallepedidos));
						
	
3. Obtener los clientes cuya l�nea de cr�dito sea mayor que los pagos que haya realizado.

	SELECT CodigoCliente, NombreCliente, LimiteCredito, SUM(Cantidad*PrecioUnidad) TotalGastado
	FROM clientes 
		NATURAL JOIN pedidos 
		NATURAL JOIN detallepedidos
	GROUP BY CodigoCliente
	HAVING LimiteCredito > TotalGastado;
	

4. Sacar el producto que m�s unidades tiene en stock y el que menos unidades tiene en stock.


	SELECT CodigoProducto, Nombre, CantidadEnStock
	FROM productos
	WHERE CantidadEnStock = (SELECT MIN(CantidadEnStock)
							FROM productos)
		OR CantidadEnStock = (SELECT MAX(CantidadEnStock)
							FROM productos);

							
	SELECT CodigoProducto, Nombre, CantidadEnStock
	FROM productos
	WHERE CantidadEnStock = (SELECT MIN(CantidadEnStock)
							FROM productos)
	UNION
	SELECT CodigoProducto, Nombre, CantidadEnStock
	FROM productos
	WHERE CantidadEnStock = (SELECT MAX(CantidadEnStock)
							FROM productos);

							
Pr�ctica 4.9: Consultas multitabla con la BBDD jardiner�a

1. Sacar el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

	SELECT NombreCliente, CodigoEmpleado, oficinas.Ciudad
	FROM Clientes
		INNER JOIN empleados ON Clientes.CodigoEmpleadoRepVentas = empleados.CodigoEmpleado
		INNER JOIN oficinas ON empleados.CodigoOficina = oficinas.CodigoOficina

		
2. Sacar la misma informaci�n que en la pregunta anterior pero solo los clientes que no hayan hecho pagos(pedidos). 
	
	SELECT NombreCliente, CodigoEmpleado, oficinas.Ciudad
	FROM Clientes
		INNER JOIN empleados ON Clientes.CodigoEmpleadoRepVentas = empleados.CodigoEmpleado
		INNER JOIN oficinas ON empleados.CodigoOficina = oficinas.CodigoOficina
	WHERE clientes.CodigoCliente NOT IN (SELECT CodigoCliente
										 FROM pedidos
										 GROUP BY CodigoCliente);
	
	SELECT NombreCliente, CodigoEmpleado, oficinas.Ciudad
	FROM Clientes
		INNER JOIN empleados ON clientes.CodigoEmpleadoRepVentas = empleados.CodigoEmpleado
		INNER JOIN oficinas ON empleados.CodigoOficina = oficinas.CodigoOficina
		LEFT JOIN pedidos ON clientes.CodigoCliente = pedidos.CodigoCliente
	WHERE pedidos.CodigoCliente IS NULL;
	
	
3. Obtener un listado con el nombre de los empleados junto con el nombre de sus jefes.
	
	SELECT temp.Nombre AS empleado, tjefe.Nombre AS jefe
	FROM empleados AS temp
		INNER JOIN empleados AS tjefe ON temp.CodigoJefe = tjefe.CodigoEmpleado;
		
	SELECT temp.Nombre AS empleado, tjefe.Nombre AS jefe
	FROM empleados AS temp
		LEFT JOIN empleados AS tjefe ON temp.CodigoJefe = tjefe.CodigoEmpleado;
		
		
4. Obtener el nombre de los clientes a los que no se les ha entregado a tiempo un pedido (FechaEntrega> FechaEsperada).

	SELECT NombreCliente, COUNT(CodigoCliente) AS pedidosRetrasados
	FROM clientes NATURAL JOIN pedidos
	WHERE (FechaEntrega > FechaEsperada)
	GROUP BY CodigoCliente;
	
	
Pr�ctica 4.10: Consultas variadas con la BBDD jardiner�a

1. Sacar un listado de clientes indicando el nombre del cliente y cu�ntos pedidos ha realizado.

	SELECT NombreCliente, COUNT(CodigoCliente) AS NumPedidos
	FROM clientes NATURAL JOIN pedidos
	GROUP BY CodigoCliente;
	
	SELECT NombreCliente, COUNT(pedidos.CodigoCliente) AS NumPedidos, clientes.CodigoCliente, pedidos.CodigoCliente
	FROM clientes LEFT JOIN pedidos ON clientes.CodigoCliente = pedidos.CodigoCliente
	GROUP BY clientes.CodigoCliente;
	
	
2. Sacar un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
	
	SELECT NombreCliente, SUM(Cantidad*PrecioUnidad) AS CantPagada
	FROM clientes 
		NATURAL JOIN pedidos
		NATURAL JOIN detallepedidos
	GROUP BY clientes.CodigoCliente;
	
	SELECT NombreCliente, IFNULL(SUM(Cantidad*PrecioUnidad),0) AS CantPagada
	FROM clientes 
		LEFT JOIN pedidos ON clientes.CodigoCliente = pedidos.CodigoCliente
		LEFT JOIN detallepedidos ON pedidos.CodigoPedido = detallepedidos.CodigoPedido
	GROUP BY clientes.CodigoCliente;
	
	
3. Sacar el nombre de los clientes que hayan hecho pedidos en 2008.
	
	SELECT NombreCliente
	FROM clientes NATURAL JOIN pedidos
	WHERE YEAR(FechaPedido) = '2008'
	GROUP BY CodigoCliente;
	
	SELECT NombreCliente
	FROM clientes
	WHERE CodigoCliente IN (SELECT CodigoCliente
							FROM pedidos
							WHERE YEAR(FechaPedido) = '2008'
							GROUP BY CodigoCliente);
	
	
4. Listar el nombre del cliente y el nombre y apellido de sus representantes de aquellos clientes que no hayan realizado pagos.
	
	SELECT clientes.nombreCliente, empleados.nombre, empleados.apellido1
	FROM empleados 
		INNER JOIN clientes ON empleados.CodigoEmpleado = clientes.CodigoEmpleadoRepVentas
		LEFT JOIN pedidos ON clientes.CodigoCliente = pedidos.CodigoCliente
	WHERE pedidos.CodigoPedido IS NULL;
	
	SELECT clientes.nombreCliente, empleados.nombre, empleados.apellido1
	FROM empleados 
		INNER JOIN clientes ON empleados.CodigoEmpleado = clientes.CodigoEmpleadoRepVentas
	WHERE CodigoCliente NOT IN (SELECT CodigoCliente
								FROM pedidos
								GROUP BY CodigoCliente);
	
	
5. Sacar un listado de clientes donde aparezca el nombre de su comercial y la ciudad donde est� su oficina.

	SELECT clientes.nombreCliente, empleados.nombre, oficinas.Ciudad
	FROM oficinas 
		NATURAL JOIN empleados 
		INNER JOIN clientes ON empleados.CodigoEmpleado = clientes.CodigoEmpleadoRepVentas;

		
6. Sacar el nombre, apellidos, oficina y cargo de aquellos que no sean representantes de ventas.

	SELECT Nombre, Apellido1, Apellido2, CodigoOficina, Puesto
	FROM empleados
	WHERE Puesto <> "Representante Ventas";
	
	
7. Sacar cu�ntos empleados tiene cada oficina, mostrando el nombre de la ciudad donde est� la oficina.

	SELECT COUNT(*) AS NumEmpleados, CodigoOficina, Ciudad
	FROM oficinas NATURAL JOIN empleados
	GROUP BY CodigoOficina;
	
	
8. Sacar un listado con el nombre de los empleados, y el nombre de sus respectivos jefes.

	SELECT temp.Nombre AS empleado, tjefe.Nombre AS jefe
	FROM empleados AS temp
		INNER JOIN empleados AS tjefe ON temp.CodigoJefe = tjefe.CodigoEmpleado;
		
	SELECT temp.Nombre AS empleado, tjefe.Nombre AS jefe
	FROM empleados AS temp
		LEFT JOIN empleados AS tjefe ON temp.CodigoJefe = tjefe.CodigoEmpleado;
		
	
9. Sacar el nombre, apellido, oficina (ciudad) y cargo del empleado que no represente a ning�n cliente.

10. Sacar la media de unidades en stock de los productos agrupados por gama.

11. Sacar los clientes que residan en la misma ciudad donde hay un a oficina, indicando d�nde est� la oficina.

12. Sacar los clientes que residan en ciudades donde no hay oficinas ordenado por la ciudad donde residen.

13. Sacar el n�mero de clientes que tiene asignado cada representante de ventas.

14. Sacar cu�l fue el cliente que hizo el pago con mayor cuant�a y el que hizo el pago con menor cuant�a.

15. Sacar un listado con el precio total de cada pedido.

16. Sacar los clientes que hayan hecho pedidos en el 2008 por una cuant�a superior a 2000 euros.

17. Sacar cu�ntos pedidos tiene cada cliente en cada estado.

18. Sacar los clientes que han pedido m�s de 200 unidades de cualquier producto.



Pr�ctica 4.11: M�s consultas variadas

1. Equipo y ciudad de los jugadores espa�oles de la NBA.

2. Equipos que comiencen por H y terminen en S.

3. Puntos por partido de 'Pau Gasol' en toda su carrera.

4. Equipos que hay en la conferencia oeste ('west').

5. Jugadores de Arizona que pesen m�s de 100 kilos y midan m�s de 1.82m (6 pies).

6. Puntos por partido de los jugadores de los 'cavaliers'.

7. Jugadores cuya tercera letra de su nombre sea la v.

8. N�mero de jugadores que tiene cada equipo de la conferencia oeste 'West'.

9. N�mero de jugadores Argentinos en la NBA.

10. M�xima media de puntos de 'Lebron James' en su carrera.

11. Asistencias por partido de 'J ase Calderon' en la temporada '07/ 08'.

12. Puntos por partido de 'Lebron James' en las temporadas del 03/04 al 05/06.

13. N�mero de jugadores que tiene cada equipo de la conferencia este 'East'.

14. Tapones por partido de los jugadores de los 'Blazers'.

15. Media de rebotes de los jugadores de la conferencia Este 'East' .

16. Rebotes por partido de los jugadores de los equipos de Los Angeles.

17. N�mero de jugadores que tiene cada equipo de la divisi�n NorthWest.

18. N�mero de jugadores de Espa�a y Francia en la NBA.

19. N�mero de pivots 'C ' que tiene cada equipo.

20. �Cu�nto mide el p�vot m�s alto de la nba?

21. �Cu�nto pesa (en libras y en kilos) el p�vot m�s alto de la NBA?

22. N�mero de jugadores que empiezan por 'Y'.

23. Jugadores que no metieron ning�n punto en alguna temporada.

24. N�mero total de jugadores de cada divisi�n.

25. Peso medio en kilos y en libras de los jugadores de los 'Raptors'.

26. Mostrar un listado de jugadores con el formato Nombre(Equipo) en una sola columna.

27. Puntuaci�n m�s baja de un partido de la NBA.

28. Primeros 10 jugadores por orden alfab�tico.

29. Temporada con m�s puntos por partido de 'Kobe Bryant'.

30. N�mero de bases 'G' que tiene cada equipo de la conferencia este 'East'.

31. N�mero de equipos que tiene cada conferencia.

32. Nombre de las divisiones de la conferencia Este.

33. M�ximo reboteador de los 'Suns'.

34. M�ximo anotador de la toda base de datos en una temporada.

35. Sacar cu�ntas letras tiene el nombre de cada jugador de los 'grizzlies' (Usar funci�n LENGTH).

36. �Cu�ntas letras tiene el equipo con nombre m�s largo de la NBA (Ciudad y Nombre)?



Pr�ctica 4.12: Consultas con tablas derivadas

1. Sacar el importe medio de los pedidos de la BBDD jardineria.

2. Sacar un listado con el n�mero de partidos ganados por los equipos de la NBA.

3. Sacar la media de partidos ganados por los equipos del oeste.

4. �Cu�l es el pedido m�s caro del empleado que m�s clientes tiene?