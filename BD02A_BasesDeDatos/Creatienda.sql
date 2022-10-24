/*
Eliminar Tablas:

DROP TABLE nombre_tabla;
- Añadir CASCADE CONSTRAINTS después del nombre de la tabla para que, si la tabla
tiene FOREIGN KEYS - que impiden su eliminación -, la elimine sin problemas
*/

-- DROP TABLE Familia CASCADE CONSTRAINTS;
-- DROP TABLE Producto CASCADE CONSTRAINTS;
-- DROP TABLE Tienda CASCADE CONSTRAINTS;
-- DROP TABLE Stock CASCADE CONSTRAINTS;


-- ***************************************************************************** --
-- ******************************************** EJERCICIO 01 - CREAR TIENDA **** --
-- ***************************************************************************** --

-- TABLA FAMILIA: Contiene las familias a las que pertenecen los productos, como por ejemplo ordenadores, impresoras,etc.
CREATE TABLE Familia (
  Codfamilia NUMBER(3) PRIMARY KEY,
  Denofamilia VARCHAR2(50) UNIQUE NOT NULL
);

-- TABLA PRODUCTO => contendrá información general sobre los productos que distribuye la empresa a las tiendas.
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

-- TABLA TIENDA=> contendrá información básica sobre las tiendas que distribuyen los productos.
CREATE TABLE Tienda (
   Codtienda NUMBER(3) PRIMARY KEY,
   Denotienda VARCHAR2(20) NOT NULL,
   Telefono VARCHAR2(11),
   CodigoPostal VARCHAR2(5) NOT NULL,
   Provincia VARCHAR2(5) NOT NULL
);

-- TABLA STOCK => Contendrá para cada tienda el número de unidades disponibles de cada producto.
/* La clave primaria está formada por la concatenación de los campos Codtienda y Codproducto. */
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


/*********************************** AÑADO DATOS DE EJEMPLO PARA COMPROBAR *****/

-- familia(Codfamilia,Denofamilia)
INSERT INTO familia VALUES (101,'FamEjemplo01');
INSERT INTO familia VALUES (102,'FamEjemplo02');

SELECT * FROM familia;

-- DELETE FROM familia WHERE codfamilia = 002;

-- Producto(Codproducto,Denoproducto,Descripcion,PrecioBase,PorcReposicion,UnidadesMinimas,Codfamilia)
INSERT INTO producto VALUES (20001, 'ProdEjemplo01',null,256,3,10,101);
INSERT INTO producto VALUES (20002, 'ProdEjemplo02',null,10.6,3,2,101);
INSERT INTO producto VALUES (20003, 'ProdEjemplo03',null,230.65,5,10,102);

SELECT * FROM producto;

-- Tienda(Codtienda,Denotienda,Telefono,CodigoPostal,Provincia)
INSERT INTO tienda VALUES (301,'Tienda Ejemplo 01',null,'50001','ZGZ');
INSERT INTO tienda VALUES (302,'Tienda Ejemplo 02',null,'28090','MAD');

SELECT * FROM tienda;

-- Stock(Codtienda,Codproducto,Unidades)
INSERT INTO stock VALUES (301,20001,20);
INSERT INTO stock VALUES (301,20002,300);
INSERT INTO stock VALUES (301,20003,1326);
INSERT INTO stock VALUES (302,20001,659);
INSERT INTO stock VALUES (302,20002,56);
INSERT INTO stock VALUES (302,20003,25);

SELECT * FROM stock;





