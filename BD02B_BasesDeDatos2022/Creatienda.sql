-- ***************************************************************************** --
-- ******************************************** EJERCICIO 01 - CREAR TIENDA **** --
-- ***************************************************************************** --

-- DROP TABLE Familia CASCADE CONSTRAINTS;
-- DROP TABLE Producto CASCADE CONSTRAINTS;
-- DROP TABLE Tienda CASCADE CONSTRAINTS;
-- DROP TABLE Stock CASCADE CONSTRAINTS;

-- DROP TABLE STOCK_TIENDAS CASCADE CONSTRAINTS;

/** Mediante el uso de sentencias DDL de SQL crea la tablas especificadas a continuación
aplicando las restricciones (constraints) indicadas. Siempre debemos de garantizar la
integridad referencial
**/

-- TABLA FAMILIA : Contiene las familias a las que pertenecen los productos.
CREATE TABLE Familia (
  Codfamilia NUMBER(3) PRIMARY KEY,
  Denofamilia VARCHAR2(50) UNIQUE NOT NULL
);
/*******************************************************************************
- Codfamilia es la clave primaria de la tabla, aloja un dato numérico de 3 dígitos
- Denofamilia almacena el nombre de la familia, es un campo alfanumerico de 50 caracteres,
no puede estar vacio ni puede haber dos familias con el mismo nombre
********************************************************************************/

-- TABLA PRODUCTO : contendrá información general sobre los productos que distribuye la empresa a las tiendas.
CREATE TABLE Producto (
   Codproducto NUMBER(5) PRIMARY KEY,
   Denoproducto VARCHAR2(20) NOT NULL,
   Descripcion VARCHAR2(100),
   PrecioBase NUMBER(6,2) NOT NULL,
   PorcReposicion NUMBER(3),
   UnidadesMinimas NUMBER(4) NOT NULL,
   -- Clave ajena, referencia a la tabla Familia, en su campo Codfamilia
   Codfamilia NUMBER(3) NOT NULL,
   
   -- Restricciones:
   CONSTRAINT PRO_PVP_CK CHECK (PrecioBase > 0),
   CONSTRAINT PRO_REP_CK CHECK (PorcReposicion > 0),
   CONSTRAINT PRO_UDS_CK CHECK (UnidadesMinimas > 0),
   CONSTRAINT PRO_CFA_FK FOREIGN KEY (Codfamilia) REFERENCES Familia(Codfamilia) ON DELETE SET NULL
);
/*******************************************************************************
- Codproducto es la clave primaria de la tabla, aloja un dato numérico de 5 dígitos
- Denoproducto almacena el nombre del producto, es un campo alfanumerico de 20
caracteres, no puede estar vacio.
- Descripcion en este campo se guarda la descripción del producto, como tipo de
dato es alfanumerico con un máximo de 100 caracteres.
- PrecioBase, es el precio base del producto, es un dato numérico de 6 enteros y
2 decimales, en total 8 digitos, siempre tiene que tener contenido mayor que 0 (cero).
- PorcReposicion, se usa para calcular el número de unidades a reponer cuando el
stock este en el umbral de mínimos. Es un dato numérico de 3 dígitos y tiene que
ser mayor que 0 (cero).
- UnidadesMinimas, almacena la cantidad de unidades de producto que debe haber en
el almacén como mínimo. se usa un dato numérico de 4 dígitos mayor que 0 (cero),
nunca puede estar vacio.
- Esta tabla se relaciona con la tabla FAMILIA mediante la PRIMARY KEY ( codfamilia )
de ésta y el campo Codfamilia de la tabla que se esta creando ( PRODUCTO )
********************************************************************************/

-- TABLA TIENDA : contendrá información básica sobre las tiendas que distribuyen los productos.
CREATE TABLE Tienda (
   Codtienda NUMBER(3) PRIMARY KEY,
   Denotienda VARCHAR2(20) NOT NULL,
   Telefono VARCHAR2(11),
   CodigoPostal VARCHAR2(5) NOT NULL,
   Provincia VARCHAR2(5) NOT NULL
);
/*******************************************************************************
- Codtienda almacena el código de cada tiendsa. Es la clave primari, dato numérico
de 3 dígito.
- Denotienda guarda el nombre de la tienda, en un dato alfanumérico de 20 caracteres,
no puede estar vacio.
- Telefono, campo donde se almacena el número de teléfono de la tienda, en un dato
alfanumérico de 11 caracteres.
- CodigoPostal guarda el código postal correspondiente a la dirección física de la
tienda. El tipo de dato de este campo es alfanumérico de 5 caracteres. No puede
estar vacio.
- Provincia, se almacena la provincia donde se ubica la tienda. Se utiliza un tipo
de dato alfanumérico, siempre debe tener contenido.
********************************************************************************/

-- TABLA STOCK : Contendrá para cada tienda el número de unidades disponibles de cada producto.
CREATE TABLE Stock (
   Codtienda NUMBER(3) NOT NULL,
   Codproducto NUMBER(5) NOT NULL,
   Unidades NUMBER(6) NOT NULL,
   
   -- Restricciones:
   CONSTRAINT STK_CTI_FK FOREIGN KEY (Codtienda) REFERENCES Tienda(Codtienda),
   CONSTRAINT STK_CPR_FK FOREIGN KEY (Codproducto) REFERENCES Producto(Codproducto),
   CONSTRAINT STK_UDS_CK CHECK (Unidades > 0),
   
   -- Clave primaria
   PRIMARY KEY (Codtienda,Codproducto)
);
/*******************************************************************************
Esta tabla relaciona las tablas TIENDA y PRODUCTO, a través de los campos Codtienda
y Codproducto.
La clave primaria, de esta tabla, está formada por la concatenación de los campos
Codtienda y Codproducto.
- Codtienda, es el código de la tienda, en un campo numérico de 3 dígitos que no
puede estar vacio (referencia a la clave primaria de la tabla TIENDA).
- Codproducto almacena los códigos de producto que tenga cada tienda, mediante un
campo numérico de 5 dígitos, que no puede estar vacio (referencia a la tabla PRODUCTO,
en su clave primaria).
- Unidades, indica el número de unidades de cada producto que tiene cada tienda.
Se usa un tipo de dato numérico de 6 dígitos, siempre debe de tener contenido,
mayor que 0 (cero).
********************************************************************************/