-- Seleccionar el precio medio de todos los productos

-- Seleccionar el precio medio de todos los productos cuyo código de fabricante sea 2
select avg(precio) from producto;
-- Ottener el número de articulos cuyo precio sea mayor o igual 180
select count(codigo) from producto where precio >= 180;
select codigo from producto where precio >= 180;

-- Obtener el nombre, precio de los productos cuyo precio sea >= 180 y ordenalos ppor precio desc y por nombre asc
select nombre, precio from producto where precio >= 180 order by precio desc, nombre asc;

-- Obtener un listado completo de los articulos, incluyendo por cada uno los datos del articulo y del fabricante
select p.nombre, p.precio, f.nombre as Fabricante from producto p, fabricante f where p.codigo = f.codigo;
select p.nombre, p.precio, f.nombre as Fabricante from producto p inner join fabricante f on p.codigo = f.codigo;

-- Obtener el precio medio de los productos de cada fabricante, mostrando solo los códigos de fabricante
select avg(p.precio) as PVP_Medio, f.nombre from producto p inner join fabricante f on p.codigo = f.codigo
group by f.nombre;

-- Obtener los nombres de los fabricantes cuyo precio medio sea mayor o igual a 150.
select f.nombre, avg(p.precio) from fabricante f inner join producto p on p.codigo_fabricante = f.codigo
group by f.nombre having avg(p.precio) >= 150;

-- Obtener el nombre y el precio del producto más barato
select nombre, precio from producto where precio = (select min(precio) from producto);

-- Obtener una lista con el nombre y el precio de los articulos más caros de cada proveedor, incluyendo el nombre del proveedor
select p.nombre, p.precio, f.nombre from producto p inner join fabricante f on p.codigo = f.codigo
and p.precio = (select max(p.precio) from producto p where p.codigo_fabricante = f.codigo);

-- Añadir un nuevo producto: altavoces 70€ al fabricante 2
insert into producto(codigo, nombre, precio, codigo_fabricante) values (300, 'altavoces', 70, 2);

-- Cambiar el nombre del producto 8 a Impresora laser
UPDATE producto set nombre = 'Impresora Laser' where codigo = 8;

-- Aplicar un descuento del 10% (multiplicar por 0,9) a todos los productos
update producto set precio = precio*0.9;

-- aplicar un descuento de 10€ a todos los productos cuyo precio sea mayor o igual a 120
update producto set precio = precio-10 where precio >= 120;

-- ------------------------------------------------------------------ EMPLEADOS --
Create table departamentos(
  codigo int primary key,
  nombre varchar2(100) not null,
  presupuesto int
);
Create table empleados(
  dni varchar2(8) primary key,
  nombre varchar2(100) not null,
  apellidos varchar2(255) not null,
  departamento int not null,
  constraint fk_emp_dto foreign key (departamento) references departamentos(codigo)
);