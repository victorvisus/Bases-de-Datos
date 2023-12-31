/**
https://josejuansanchez.org/bd/ejercicios-consultas-sql/index.html

**/

/* ------------------------------------------------------------ CREAR TABLAS -- */
/*
GENERATED BY DEFAULT ON NULL AS IDENTITY -> Es el AUTO_INCREMENT
IDENTITY Las columnas se introdujeron en Oracle 12c, lo que permite una funcionalidad
de incremento autom�tico simple en las versiones modernas de Oracle.

El uso de la IDENTITYcolumna es funcionalmente similar al de otros sistemas de
bases de datos. Recreando nuestro booksesquema de tabla anterior en Oracle 12c
moderno o superior, simplemente usar�amos la siguiente definici�n de columna.
*/

CREATE TABLE fabricante (
  codigo NUMBER(10) GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo NUMBER(10) GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio NUMBER(7,2) NOT NULL,
  codigo_fabricante NUMBER(10) NOT NULL,
  CONSTRAINT PRO_CFA_FK FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo) ON DELETE SET NULL
);

/* -------------------------------------------------------- INSERTAR VALORES -- */
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Port�til Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Port�til Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/* --------------------------------------------------------------- CONSULTAS -- */

-- Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

-- Lista el nombre de los productos, el precio en euros y el precio en d�lares estadounidenses (USD).
SELECT nombre, precio AS PVP_euros, precio*1.1414136 AS PVP_dolares FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a may�scula.
SELECT UPPER(nombre), precio FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- convirtiendo los nombres a min�scula.
SELECT LOWER(nombre), precio FROM producto;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna
-- obtenga en may�sculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre, UPPER(SUBSTR(nombre, 1, 2)) FROM fabricante;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- redondeando el valor del precio.
SELECT nombre, ROUND(precio, 0) FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto,
-- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, TRUNC(precio) FROM producto;

-- Lista el c�digo de los fabricantes que tienen productos en la tabla producto.
SELECT f.codigo FROM fabricante f, producto p WHERE p.codigo_fabricante = f.codigo;

-- Lista el c�digo de los fabricantes que tienen productos en la tabla producto,
-- eliminando los c�digos que aparecen repetidos.
SELECT f.codigo FROM fabricante f, producto p WHERE p.codigo_fabricante = f.codigo GROUP BY f.codigo;
SELECT DISTINCT f.codigo FROM fabricante f, producto p WHERE p.codigo_fabricante = f.codigo;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de
-- forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante WHERE ROWNUM <= 5;

-- Lista el nombre y el precio del producto m�s barato.
-- (Utilice solamente las cl�usulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto WHERE precio = (SELECT MIN(precio) FROM producto);

-- Lista el nombre y el precio del producto m�s caro. (Utilice solamente las cl�usulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto WHERE precio = (SELECT MAX(precio) FROM producto);

-- Lista el nombre de todos los productos del fabricante cuyo c�digo de fabricante es igual a 2.
SELECT p.nombre FROM producto p WHERE p.codigo_fabricante = 2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120�.
SELECT nombre, precio FROM producto WHERE precio <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400�.
SELECT nombre, precio FROM producto WHERE precio >= 400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400�.
SELECT nombre, precio FROM producto WHERE precio < 400;

-- Lista todos los productos que tengan un precio entre 80� y 300�. Sin utilizar el operador BETWEEN.
SELECT nombre, precio FROM producto WHERE precio >= 80 AND precio <= 300;

-- Lista todos los productos que tengan un precio entre 60� y 200�. Utilizando el operador BETWEEN.
SELECT nombre, precio FROM producto WHERE precio BETWEEN 60 AND 200;

-- Lista todos los productos que tengan un precio mayor que 200� y que el c�digo de fabricante sea igual a 6.
SELECT nombre, precio, codigo_fabricante FROM producto WHERE precio > 200 AND codigo_fabricante = 6;

-- Lista todos los productos donde el c�digo de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT * FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

-- Lista todos los productos donde el c�digo de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN(1,3,5);

-- Lista el nombre y el precio de los productos en c�ntimos (Habr� que multiplicar
-- por 100 el valor del precio). Cree un alias para la columna que contiene el
-- precio que se llame c�ntimos.
SELECT nombre, precio*100 AS centimos FROM producto;

-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre FROM fabricante WHERE nombre  LIKE('S%');

-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante WHERE nombre  LIKE('%e');

-- Lista los nombres de los fabricantes cuyo nombre contenga el car�cter w.
SELECT nombre FROM fabricante WHERE nombre  LIKE('%w%');

-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4;

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena
-- Port�til en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE('%Port�til%');

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena
-- Monitor en el nombre y tienen un precio inferior a 215 �.
SELECT nombre FROM producto WHERE nombre LIKE('%Monitor%') AND precio < 215;

-- Lista el nombre y el precio de todos los productos que tengan un precio mayor
-- o igual a 180�. Ordene el resultado en primer lugar por el precio (en orden
-- descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;


-- Consultas multitabla (Composici�n interna) ----------------------------------

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante
-- de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo;

-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante 
-- de todos los productos de la base de datos. Ordene el resultado por el nombre
-- del fabricante, por orden alfab�tico.
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo ORDER BY f.nombre ASC;

-- Devuelve una lista con el c�digo del producto, nombre del producto, c�digo del
-- fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo, p.nombre, p.precio, f.codigo , f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto m�s barato.
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo 
  AND precio = (
  SELECT MIN(precio) FROM producto
  )
  ORDER BY f.nombre ASC;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto m�s caro.
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo 
  AND precio = (
  SELECT MAX(precio) FROM producto
  )
  ORDER BY f.nombre ASC;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre, p.precio, f.nombre FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo 
  WHERE f.nombre = 'Lenovo';

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un
-- precio mayor que 200�.
SELECT p.nombre, p.precio, f.nombre FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo 
  WHERE f.nombre = 'Crucial' AND p.precio > 200;
  
-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT p.nombre, f.nombre AS Fabricante FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo
  WHERE f.nombre IN('Asus', 'Hewlett-Packard', 'Seagate');

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, f.nombre AS Fabricante FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo
  WHERE f.nombre LIKE('%e');

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre
-- de fabricante contenga el car�cter w en su nombre.
SELECT p.nombre, f.nombre AS Fabricante FROM producto p
  INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
  WHERE f.nombre LIKE('%w%');

-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante,
-- de todos los productos que tengan un precio mayor o igual a 180�. Ordene el 
-- resultado en primer lugar por el precio (en orden descendente) y en segundo 
-- lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre AS Fabricante FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo
  WHERE p.precio >= 180
  ORDER BY p.precio DESC, p.nombre ASC;

-- Devuelve un listado con el c�digo y el nombre de fabricante, solamente de aquellos
-- fabricantes que tienen productos asociados en la base de datos.
SELECT f.codigo, f.nombre AS Fabricante FROM producto p
  JOIN fabricante f ON p.codigo_fabricante = f.codigo
  WHERE f.codigo IN(p.codigo_fabricante);
  
-- Obtener el precio medio de los productos de cada fabricante, mostrando solo los
-- c�digos del fabricante
SELECT AVG(p.precio), p.codigo_fabricante FROM producto p GROUP BY p.codigo_fabricante;

-- Obtener el precio medio de los productos de cada fabricante, mostrando solo el
-- nombre del fabricante
SELECT AVG(p.precio), f.nombre FROM producto p
  INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
  GROUP BY f.nombre;

-- Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio
-- seas mayor o igual a 150�
SELECT AVG(p.precio), f.nombre FROM fabricante f
  INNER JOIN producto p ON p.codigo_fabricante = f.codigo
  GROUP BY f.nombre
  HAVING AVG(p.precio) >= 150;
  
-- Obtener una lista con el nombre y precio de los art�culos m�s caros de cada
-- producto (incluyendo el nombre del proveedor)
SELECT p.nombre, p.precio, f.nombre AS Fabricante FROM producto p
  INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
  AND p.precio = (
    SELECT MAX(p1.precio) FROM producto p1 WHERE p1.codigo_fabricante = f.codigo);