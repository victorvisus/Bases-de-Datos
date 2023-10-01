CREATE TABLE fabricantes (
    codigo INT PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL
);

CREATE TABLE articulos (
    codigo INT PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    precio NUMBER(6) NOT NULL,
    fabricante INT,
    
    CONSTRAINT PRO_FAB_FK FOREIGN KEY (fabricante) REFERENCES fabricantes(codigo) ON DELETE SET NULL
);

INSERT INTO fabricantes (codigo, nombre) VALUES (1,'software');
INSERT INTO fabricantes (codigo, nombre) VALUES (2,'hardware');
INSERT INTO fabricantes (codigo, nombre) VALUES (3,'desarrollo');
INSERT INTO fabricantes (codigo, nombre) VALUES (4,'analitica');

INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (1,'art01',25,1);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (2,'art02',55,3);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (3,'art03',125,2);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (4,'art04',63,4);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (5,'art05',12,1);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (6,'art06',256,3);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (7,'art07',633,4);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (8,'art08',203,1);
INSERT INTO articulos (codigo, nombre, precio, fabricante) VALUES (9,'art09',256,3);

--DELETE FROM articulos WHERE nombre = 'art01';

/** CONSULTAS ******************************************************************/

/** 1.1. Obtener los nombres de los productos de la tienda. **/
SELECT a.nombre FROM articulos a;

/** 1.2. Obtener los nombres y los precios de los productos de la tienda. **/
SELECT nombre, precio FROM articulos;

/** 1.3. Obtener el nombre de los productos cuyo precio sea menor o igual a 200. **/
SELECT nombre, precio FROM articulos WHERE precio <= 200;

/** 1.4. Obtener todos los datos de los artículos cuyo precio est´e entre los 60
y los 120 (ambas cantidades incluidas). **/
SELECT * FROM articulos WHERE precio BETWEEN 60 AND 120;

/** 1.5. Obtener el nombre y el precio en pesetas (es decir, el precio en euros
multiplicado por 166’386) **/
SELECT nombre, precio*166.386 AS precio_ptas FROM articulos;

/** 1.6. Seleccionar el precio medio de todos los productos. **/
SELECT AVG(precio) AS precio_medio FROM articulos;

/** 1.7. Obtener el precio medio de los artículos cuyo código de fabricante sea 2. **/
SELECT AVG(precio) AS precio_medio FROM articulos WHERE fabricante = 2;

/** 1.8. Obtener el numero de artículos cuyo precio sea mayor o igual a 180 ¤. **/
SELECT COUNT(*) FROM articulos WHERE precio >= 180;

/** 1.9. Obtener el nombre y precio de los artículos cuyo precio sea mayor o igual
a 180 y ordenarlos descendentemente por precio, y luego ascendentemente por nombre. **/
SELECT nombre, precio FROM articulos WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;

/** 1.10. Obtener un listado completo de artículos, incluyendo por cada articulo
los datos del articulo y de su fabricante. **/
SELECT a.codigo, a.nombre, a.precio, f.nombre AS Fabricante, f.codigo AS cod_fabricante
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo;

/** 1.11. Obtener un listado de artículos, incluyendo el nombre del artículo, su
precio, y el nombre de su fabricante. **/
SELECT a.nombre, a.precio, f.nombre AS Fabricante
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo;

/** 1.12. Obtener el precio medio de los productos de cada fabricante, mostrando
solo los códigos de fabricante. **/
SELECT f.codigo, AVG(a.precio)
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo
    GROUP BY f.codigo;

/** 1.13. Obtener el precio medio de los productos de cada fabricante, mostrando
el nombre del fabricante. **/
SELECT f.codigo, f.nombre, AVG(a.precio)
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo
    GROUP BY f.codigo, f.nombre;

/** 1.14. Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio
medio sea mayor o igual a 150. **/
SELECT f.codigo, f.nombre, AVG(a.precio) AS precio_medio
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo
    GROUP BY f.codigo, f.nombre
        HAVING AVG(a.precio) >= 150;
    
/** 1.15. Obtener el nombre y precio del artículo m´as barato. **/
SELECT nombre, precio FROM articulos WHERE precio = ( 
    SELECT MIN(precio) FROM articulos);

/** 1.16. Obtener una lista con el nombre y precio de los artículos m´as caros de
cada proveedor (incluyendo el nombre del proveedor). **/
SELECT a.nombre, a.precio, f.nombre AS proveedor
    FROM articulos a, fabricantes f
    WHERE a.fabricante = f.codigo
    AND a.precio = (
        SELECT MAX(a2.precio)
            FROM articulos a2
            WHERE a.fabricante = f.codigo
            );


/** 1.17. A˜nadir un nuevo producto: Altavoces de 70 ¤ (del fabricante 2) **/
INSERT INTO articulos (codigo,nombre,precio,fabricante) VALUES (10, 'Altavoces',70,2);

/** 1.18. Cambiar el nombre del producto 8 a ’Impresora Laser’ **/
UPDATE articulos SET nombre = 'Impresora Laser' WHERE codigo = 8;

/** 1.19. Aplicar un descuento del 10 % (multiplicar el precio por 0’9) a todos 
los productos. **/
UPDATE articulos SET precio = precio * 0.9;

/** 1.20. Aplicar un descuento de 10 ¤ a todos los productos cuyo precio sea mayor
o igual a 120 **/
UPDATE articulos SET precio = precio * 0.9 WHERE  precio >= 120;