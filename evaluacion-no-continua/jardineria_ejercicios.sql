/* bloque 0 instrucciones DDL*/
1. Utilizando lenguaje SQL-DDL, escribir las instrucciones que permiten crear el esquema dado sobre un SGBD Oracle.

/* bloque 1 instrucciones DML */
1. Escribir las instrucciones SQL que permiten dar de alta datos de ejemplo en todas las tablas de la base de datos

/* bloque 2 - creaci�n de las estructuras que permiten implementar los mecanismos de control siguientes */
1. Al dar de alta un pedido la fecha de este no puede ser mayor que la fecha actual, adem�s de que un pedido solo puede servirse (estado=servido) si el pedido est� pagado 
2. No puedo dar de alta l�neas de pedido (detallepedidos) con cantidad menor que 1 o el preciounidad en blanco
3. El numero de linea de un pedido no se puede repetir nunca para el mismo pedido.

/* bloque 3 consultas SQL */ 
1. Consulta que muestra los datos de los clientes que nunca han realizado un pedido.
2. Consulta que muestra el importe total de los pedidos realizados por cada cliente, ordenado por nombre de cliente.
3. Consulta que muestre los datos de los clientes que tienen pedidos sin servir (estado=servido).
4. Listado de las gamas de productos junto con el numero de productos asignado a cada gama de producto.
5. Listado de oficinas que tienen clientes que nunca han comprado productos de la gama 'conifera'

/* bloque 4 programaci�n PL/SQL - Implementar las estructuras que se piden a continuaci�n*/ 
1. Mostrar toda la informacion de un pedido dado su codigo (fechaEsperada, fechaEntrega, fechapedido, estado, comentarios)
2. Realizar una funci�n que me devuelva la suma de pagos que ha realizado. Pasa el codigo por parametro.
3. Realizar un m�todo o procedimiento que muestre el total en euros de un pedido, pasale el codigo por parametro.
4. Mostrar el nombre de un cliente dado su codigo. Controla en caso de que no se encuentre, mostrando un mensaje por ejemplo.
5. Realizar una funci�n que me devuelva la suma de pagos que ha realizado. Pasa el codigo por parametro. Controla en caso de que no se encuentre, en ese caso devuelve un -1.
6. Realizar una funci�n que devuelva el total en euros de un pedido, pasale el codigo por parametro. Controla en caso de que no se encuentre, en ese caso devuelve un 0. Pasale otro parametro, si supera ese limite, lanzaremos una excepcion propia y devolveremos un 0.
7. Crear un cursor que muestre todos los clientes que no hayan hecho pagos. Hazlo con un for.
