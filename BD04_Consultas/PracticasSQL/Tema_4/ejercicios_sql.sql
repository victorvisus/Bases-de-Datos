4.12. Prácticas Propuestas
Práctica 4.7: Consultas simples con la BBDD jardinería

1. Sacar la ciudad y el teléfono de las oficinas de Estados Unidos.

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

5. Sacar el número de clientes que tiene la empresa.

	SELECT count(*) AS numClientes
	FROM clientes


6. Sacar el nombre de los clientes españoles.

	SELECT nombreCliente, Pais
	FROM clientes
	WHERE Pais = 'Spain' OR Pais = 'EspaÃ±a';
	
	SELECT nombreCliente, Pais
	FROM clientes
	WHERE Pais = 'Spain' || Pais = 'EspaÃ±a';


7. Sacar cuántos clientes tiene cada país.

	SELECT Pais, count(CodigoCliente) AS NumClientes
	FROM clientes
	GROUP BY Pais;


8. Sacar cuántos clientes tiene la ciudad de Madrid.

	SELECT Ciudad, count(CodigoCliente) AS NumClientes
	FROM clientes
	WHERE Ciudad = 'Madrid'
	GROUP BY Ciudad;
	
	SELECT Ciudad, count(CodigoCliente) AS NumClientes
	FROM clientes
	WHERE Ciudad = 'Madrid';


9. Sacar cuántos clientes tienen las ciudades que empiezan por M.

	SELECT count(CodigoCliente) AS CiudadesEmpiezanM
	FROM clientes
	WHERE Ciudad LIKE 'M%';


10. Sacar el código de empleado y el número de clientes al que atiende cada representante de ventas.
	
	SELECT CodigoEmpleadoRepVentas AS CodigoEmpleado, Count(CodigoCliente) AS NumeroClientes
	FROM clientes
	GROUP BY CodigoEmpleadoRepVentas;


11. Sacar el número de clientes que no tiene asignado representante de ventas.

	SELECT count(CodigoCliente) AS NumClientesSinRepresentante
	FROM clientes
	WHERE CodigoEmpleadoRepVentas IS NULL;
	

12. Sacar cuál fue el primer y último pago que hizo algún cliente.

	SELECT CodigoCliente, MIN(FechaPedido) AS PrimerPago, MAX(FechaPedido) AS UltimoPago
	FROM pedidos;
	
	SELECT CodigoCliente, MIN(FechaPedido) AS PrimerPago, MAX(FechaPedido) AS UltimoPago
	FROM pedidos
	GROUP BY CodigoCliente;
	
	
13. Sacar el código de cliente de aquellos clientes que hicieron pagos en 2008.

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
	
	
15. Sacar el número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos que no han sido entregados a tiempo.

	SELECT CodigoPedido, FechaEsperada, FechaEntrega
	FROM pedidos
	WHERE FechaEntrega > FechaEsperada;

16. Sacar cuántos productos existen en cada línea de pedido.
	
	SELECT CodigoPedido, CodigoProducto, NumeroLinea, Cantidad
	FROM detallepedidos;

	
16.1 Sacar cuántos productos distintos, y totales existen en cada pedido.

	SELECT CodigoPedido, COUNT(CodigoProducto) AS NumProductosDistintos, SUM(Cantidad) AS NumProductosTotales
	FROM detallepedidos
	GROUP BY CodigoPedido;
	
	
17. Sacar un listado de los 20 códigos de productos más pedidos ordenado por cantidad pedida. (pista: Usar el filtro LIMIT de MySQL o el filtro rownum de Oracle)

	SELECT CodigoProducto, SUM(Cantidad)
	FROM detallepedidos
	GROUP BY CodigoProducto
	ORDER BY SUM(Cantidad) DESC
	LIMIT 20;
	
	
18. Sacar el número de pedido, código de cliente, fecha requerida y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha requerida. (pista: Usar la función addDate de MySQL o el operador + de Oracle).

	SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega
	FROM pedidos
	WHERE DATE_ADD(FechaEntrega,INTERVAL 2 DAY) <= FechaEsperada;
	

	SELECT CodigoPedido, CodigoCliente, FechaEsperada, FechaEntrega, DATEDIFF(FechaEsperada,FechaEntrega)
	FROM pedidos
	WHERE DATEDIFF(FechaEsperada,FechaEntrega) <= 2;
	
	
19. Sacar la facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. NOTA: La base imponible se calcula sumando el coste del producto por el número de unidades vendidas. El IVA, es el 18% de la base imponible, y el total, la suma de los dos campos anteriores.

	SELECT SUM(Cantidad*PrecioUnidad) AS BaseImponible,SUM(Cantidad*PrecioUnidad)*0.18 AS IVA18,SUM(Cantidad*PrecioUnidad)+SUM(Cantidad*PrecioUnidad)*0.18 AS TotalFacturado
	FROM detallepedidos;
	

20. Sacar la misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por FR.

	SELECT CodigoProducto, SUM(Cantidad*PrecioUnidad) AS BaseImponible, SUM(Cantidad*PrecioUnidad)*0.18 AS IVA18, SUM(Cantidad*PrecioUnidad)+SUM(Cantidad*PrecioUnidad)*0.18 AS TotalFacturado
	FROM detallepedidos
	GROUP BY CodigoProducto
	HAVING CodigoProducto LIKE "FR%";

Práctica 4.8: Subconsultas con la BBDD jardinería

1. Obtener el nombre del producto más caro.

	SELECT nombre
	FROM productos
	WHERE PrecioVenta = (SELECT MAX(PrecioVenta)
						FROM productos);

						
2. Obtener el nombre del producto del que más unidades se hayan vendido en un mismo pedido.

	SELECT nombre
	FROM productos
	WHERE codigoProducto = (SELECT codigoProducto
							FROM detallepedidos
							WHERE Cantidad = (SELECT MAX(Cantidad)
											  FROM detallepedidos));
						
	
3. Obtener los clientes cuya línea de crédito sea mayor que los pagos que haya realizado.

	SELECT CodigoCliente, NombreCliente, LimiteCredito, SUM(Cantidad*PrecioUnidad) TotalGastado
	FROM clientes 
		NATURAL JOIN pedidos 
		NATURAL JOIN detallepedidos
	GROUP BY CodigoCliente
	HAVING LimiteCredito > TotalGastado;
	

4. Sacar el producto que más unidades tiene en stock y el que menos unidades tiene en stock.


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

							
Práctica 4.9: Consultas multitabla con la BBDD jardinería

1. Sacar el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

	SELECT NombreCliente, CodigoEmpleado, oficinas.Ciudad
	FROM Clientes
		INNER JOIN empleados ON Clientes.CodigoEmpleadoRepVentas = empleados.CodigoEmpleado
		INNER JOIN oficinas ON empleados.CodigoOficina = oficinas.CodigoOficina

		
2. Sacar la misma información que en la pregunta anterior pero solo los clientes que no hayan hecho pagos(pedidos). 
	
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
	
	
Práctica 4.10: Consultas variadas con la BBDD jardinería

1. Sacar un listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.

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
	
	
5. Sacar un listado de clientes donde aparezca el nombre de su comercial y la ciudad donde está su oficina.

	SELECT clientes.nombreCliente, empleados.nombre, oficinas.Ciudad
	FROM oficinas 
		NATURAL JOIN empleados 
		INNER JOIN clientes ON empleados.CodigoEmpleado = clientes.CodigoEmpleadoRepVentas;

		
6. Sacar el nombre, apellidos, oficina y cargo de aquellos que no sean representantes de ventas.

	SELECT Nombre, Apellido1, Apellido2, CodigoOficina, Puesto
	FROM empleados
	WHERE Puesto <> "Representante Ventas";
	
	
7. Sacar cuántos empleados tiene cada oficina, mostrando el nombre de la ciudad donde está la oficina.

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
		
	
9. Sacar el nombre, apellido, oficina (ciudad) y cargo del empleado que no represente a ningún cliente.

10. Sacar la media de unidades en stock de los productos agrupados por gama.

11. Sacar los clientes que residan en la misma ciudad donde hay un a oficina, indicando dónde está la oficina.

12. Sacar los clientes que residan en ciudades donde no hay oficinas ordenado por la ciudad donde residen.

13. Sacar el número de clientes que tiene asignado cada representante de ventas.

14. Sacar cuál fue el cliente que hizo el pago con mayor cuantía y el que hizo el pago con menor cuantía.

15. Sacar un listado con el precio total de cada pedido.

16. Sacar los clientes que hayan hecho pedidos en el 2008 por una cuantía superior a 2000 euros.

17. Sacar cuántos pedidos tiene cada cliente en cada estado.

18. Sacar los clientes que han pedido más de 200 unidades de cualquier producto.



Práctica 4.11: Más consultas variadas

1. Equipo y ciudad de los jugadores españoles de la NBA.

2. Equipos que comiencen por H y terminen en S.

3. Puntos por partido de 'Pau Gasol' en toda su carrera.

4. Equipos que hay en la conferencia oeste ('west').

5. Jugadores de Arizona que pesen más de 100 kilos y midan más de 1.82m (6 pies).

6. Puntos por partido de los jugadores de los 'cavaliers'.

7. Jugadores cuya tercera letra de su nombre sea la v.

8. Número de jugadores que tiene cada equipo de la conferencia oeste 'West'.

9. Número de jugadores Argentinos en la NBA.

10. Máxima media de puntos de 'Lebron James' en su carrera.

11. Asistencias por partido de 'J ase Calderon' en la temporada '07/ 08'.

12. Puntos por partido de 'Lebron James' en las temporadas del 03/04 al 05/06.

13. Número de jugadores que tiene cada equipo de la conferencia este 'East'.

14. Tapones por partido de los jugadores de los 'Blazers'.

15. Media de rebotes de los jugadores de la conferencia Este 'East' .

16. Rebotes por partido de los jugadores de los equipos de Los Angeles.

17. Número de jugadores que tiene cada equipo de la división NorthWest.

18. Número de jugadores de España y Francia en la NBA.

19. Número de pivots 'C ' que tiene cada equipo.

20. ¿Cuánto mide el pívot más alto de la nba?

21. ¿Cuánto pesa (en libras y en kilos) el pívot más alto de la NBA?

22. Número de jugadores que empiezan por 'Y'.

23. Jugadores que no metieron ningún punto en alguna temporada.

24. Número total de jugadores de cada división.

25. Peso medio en kilos y en libras de los jugadores de los 'Raptors'.

26. Mostrar un listado de jugadores con el formato Nombre(Equipo) en una sola columna.

27. Puntuación más baja de un partido de la NBA.

28. Primeros 10 jugadores por orden alfabético.

29. Temporada con más puntos por partido de 'Kobe Bryant'.

30. Número de bases 'G' que tiene cada equipo de la conferencia este 'East'.

31. Número de equipos que tiene cada conferencia.

32. Nombre de las divisiones de la conferencia Este.

33. Máximo reboteador de los 'Suns'.

34. Máximo anotador de la toda base de datos en una temporada.

35. Sacar cuántas letras tiene el nombre de cada jugador de los 'grizzlies' (Usar función LENGTH).

36. ¿Cuántas letras tiene el equipo con nombre más largo de la NBA (Ciudad y Nombre)?



Práctica 4.12: Consultas con tablas derivadas

1. Sacar el importe medio de los pedidos de la BBDD jardineria.

2. Sacar un listado con el número de partidos ganados por los equipos de la NBA.

3. Sacar la media de partidos ganados por los equipos del oeste.

4. ¿Cuál es el pedido más caro del empleado que más clientes tiene?