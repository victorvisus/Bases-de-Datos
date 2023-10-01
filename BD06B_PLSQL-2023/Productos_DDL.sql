CREATE TABLE categorias(
	cod_categoria number(10) PRIMARY Key,
	nombre varchar2(100),
	descripcion varchar2(500),
	activado number(3) 
);
CREATE TABLE productos(
	cod_producto number(10) PRIMARY Key,
	cod_categoria number(10),
	alta timestamp(0),
	nombre varchar2(100),
	descripcion varchar2(500),
	precio binary_double,
	precioOferta binary_double,
	activado number(3),
	peso binary_double,
	iva binary_double,
	CONSTRAINT fk_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria)
);

CREATE TABLE fotos(
	cod_foto number(10) PRIMARY Key,
	fecha timestamp(0),
	imagen varchar2(300),
	titulo varchar2(300),
	cod_producto number(10),
	CONSTRAINT fk_productos1 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);
CREATE TABLE videos(
	cod_video number(10) PRIMARY Key,
	fecha timestamp(0),
	video varchar2(300),
	titulo varchar2(300),
	cod_producto number(10),
	CONSTRAINT fk_productos2 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);