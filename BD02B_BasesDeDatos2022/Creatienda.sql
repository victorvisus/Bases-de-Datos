-- ***************************************************************************** --
-- ******************************************** EJERCICIO 01 - CREAR TIENDA **** --
-- ***************************************************************************** --

-- DROP TABLE Familia CASCADE CONSTRAINTS;
-- DROP TABLE Producto CASCADE CONSTRAINTS;
-- DROP TABLE Tienda CASCADE CONSTRAINTS;
-- DROP TABLE Stock CASCADE CONSTRAINTS;

-- DROP TABLE STOCK_TIENDAS CASCADE CONSTRAINTS;

/** Mediante el uso de sentencias DDL de SQL crea la tablas especificadas a continuaci�n
aplicando las restricciones (constraints) indicadas. Siempre debemos de garantizar la
integridad referencial
**/

-- TABLA FAMILIA : Contiene las familias a las que pertenecen los productos.
CREATE TABLE Familia (
  Codfamilia NUMBER(3) PRIMARY KEY,
  Denofamilia VARCHAR2(50) UNIQUE NOT NULL
);
/*******************************************************************************
- Codfamilia es la clave primaria de la tabla, aloja un dato num�rico de 3 d�gitos
- Denofamilia almacena el nombre de la familia, es un campo alfanumerico de 50 caracteres,
no puede estar vacio ni puede haber dos familias con el mismo nombre
********************************************************************************/

-- TABLA PRODUCTO : contendr� informaci�n general sobre los productos que distribuye la empresa a las tiendas.
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
- Codproducto es la clave primaria de la tabla, aloja un dato num�rico de 5 d�gitos
- Denoproducto almacena el nombre del producto, es un campo alfanumerico de 20
caracteres, no puede estar vacio.
- Descripcion en este campo se guarda la descripci�n del producto, como tipo de
dato es alfanumerico con un m�ximo de 100 caracteres.
- PrecioBase, es el precio base del producto, es un dato num�rico de 6 enteros y
2 decimales, en total 8 digitos, siempre tiene que tener contenido mayor que 0 (cero).
- PorcReposicion, se usa para calcular el n�mero de unidades a reponer cuando el
stock este en el umbral de m�nimos. Es un dato num�rico de 3 d�gitos y tiene que
ser mayor que 0 (cero).
- UnidadesMinimas, almacena la cantidad de unidades de producto que debe haber en
el almac�n como m�nimo. se usa un dato num�rico de 4 d�gitos mayor que 0 (cero),
nunca puede estar vacio.
- Esta tabla se relaciona con la tabla FAMILIA mediante la PRIMARY KEY ( codfamilia )
de �sta y el campo Codfamilia de la tabla que se esta creando ( PRODUCTO )
********************************************************************************/

-- TABLA TIENDA : contendr� informaci�n b�sica sobre las tiendas que distribuyen los productos.
CREATE TABLE Tienda (
   Codtienda NUMBER(3) PRIMARY KEY,
   Denotienda VARCHAR2(20) NOT NULL,
   Telefono VARCHAR2(11),
   CodigoPostal VARCHAR2(5) NOT NULL,
   Provincia VARCHAR2(5) NOT NULL
);
/*******************************************************************************
- Codtienda almacena el c�digo de cada tiendsa. Es la clave primari, dato num�rico
de 3 d�gito.
- Denotienda guarda el nombre de la tienda, en un dato alfanum�rico de 20 caracteres,
no puede estar vacio.
- Telefono, campo donde se almacena el n�mero de tel�fono de la tienda, en un dato
alfanum�rico de 11 caracteres.
- CodigoPostal guarda el c�digo postal correspondiente a la direcci�n f�sica de la
tienda. El tipo de dato de este campo es alfanum�rico de 5 caracteres. No puede
estar vacio.
- Provincia, se almacena la provincia donde se ubica la tienda. Se utiliza un tipo
de dato alfanum�rico, siempre debe tener contenido.
********************************************************************************/

-- TABLA STOCK : Contendr� para cada tienda el n�mero de unidades disponibles de cada producto.
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
Esta tabla relaciona las tablas TIENDA y PRODUCTO, a trav�s de los campos Codtienda
y Codproducto.
La clave primaria, de esta tabla, est� formada por la concatenaci�n de los campos
Codtienda y Codproducto.
- Codtienda, es el c�digo de la tienda, en un campo num�rico de 3 d�gitos que no
puede estar vacio (referencia a la clave primaria de la tabla TIENDA).
- Codproducto almacena los c�digos de producto que tenga cada tienda, mediante un
campo num�rico de 5 d�gitos, que no puede estar vacio (referencia a la tabla PRODUCTO,
en su clave primaria).
- Unidades, indica el n�mero de unidades de cada producto que tiene cada tienda.
Se usa un tipo de dato num�rico de 6 d�gitos, siempre debe de tener contenido,
mayor que 0 (cero).
********************************************************************************/