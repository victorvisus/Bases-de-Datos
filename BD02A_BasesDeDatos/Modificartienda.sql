-- ***************************************************************************** --
-- **************************************** EJERCICIO 02 - MODIFICAR TIENDA **** --
-- ***************************************************************************** --

-- *************************************************** A) Modificar TABLAS. **** --
-- **** Añadir a la tabla STOCK **** --

-- Una columna de tipo fecha llamada FechaUltimaEntrada que por defecto tome el valor de la fecha actual.
ALTER TABLE Stock ADD (FechaUltimaEntrada DATE DEFAULT SYSDATE);
DESCRIBE Stock;

/* --COMPROBACIONES
DELETE FROM stock WHERE codtienda = 301 AND codproducto = 20002;
INSERT INTO stock (codtienda, codproducto, unidades) VALUES (301,20002,526);

UPDATE stock SET FechaUltimaEntrada = SYSDATE;
*/

-- Una columna llamada Beneficio que contendrá el tipo de porcentaje de beneficio que esa tienda aplica en ese producto. Se debe controlar que el valor que almacene sea 1,2, 3, 4 o 5.
ALTER TABLE Stock ADD (
    Beneficio NUMBER(1),
    CONSTRAINT STK_BEN_CK CHECK (Beneficio > 1 AND Beneficio < 5)
);
DESCRIBE Stock;
/* --COMPROBACIONES
-- ALTER TABLE stock DROP COLUMN Beneficio;
-- ALTER TABLE stock DISABLE CONSTRAINT STK_BEN_CK;
-- ALTER TABLE stock DROP CONSTRAINT STK_BEN_CK;

DELETE FROM stock WHERE codtienda = 301 AND codproducto = 20002;
INSERT INTO stock (codtienda, codproducto, unidades, beneficio) VALUES (301,20002,526,3);
*/

-- **** En la tabla PRODUCTO **** --

-- Eliminar de la tabla producto la columna Descripción.
ALTER TABLE producto DROP COLUMN Descripcion;
DESCRIBE producto;

-- Añadir una columna llamada perecedero que únicamente acepte los valores: S o N.
ALTER TABLE Producto ADD (
    Perecedero VARCHAR2(1),
    CONSTRAINT PRO_PER_CK CHECK (Perecedero = 'S' OR Perecedero = 'N')
);
DESCRIBE producto;

/* --COMPROBACIONES
INSERT INTO Producto (Codproducto,Denoproducto,PrecioBase,PorcReposicion,UnidadesMinimas,Codfamilia,Perecedero)
    VALUES (20004, 'ProdEjemplo04',756.98,5,10,102,'S');
*/

-- Modificar el tamaño de la columna Denoproducto a 50.
ALTER TABLE Producto MODIFY (Denoproducto VARCHAR2(50));
DESCRIBE producto;

-- **** En la tabla FAMILIA **** --

-- Añadir una columna llamada IVA, que represente el porcentaje de IVA y únicamente pueda contener los valores 21,10,ó 4.
ALTER TABLE Familia ADD (
    IVA NUMBER(2),
    CONSTRAINT FAM_IVA_CK CHECK (IVA = 21 OR IVA = 10 OR IVA = 4)
);
DESCRIBE Familia;

/* --COMPROBACIONES
INSERT INTO familia VALUES(103,'FamComprobar03',10);
*/

-- **** En la tabla TIENDA **** --

-- La empresa desea restringir el número de tiendas con las que trabaja, de forma que no pueda haber más de una tienda en una misma zona (la zona se identifica por el código postal). Definir mediante DDL las restricciones necesarias para que se cumpla en el campo correspondiente..
ALTER TABLE Tienda ADD CONSTRAINT TIE_CPO_UN UNIQUE (CodigoPostal);

/* --COMPROBACIONES
INSERT INTO tienda VALUES(303,'Tienda Comp 03','976856945','50003','ZGZ');
*/

-- *************************** B) Renombra la tabla STOCK por PROD_TIENDAS. **** --
ALTER TABLE Stock RENAME TO Prod_tiendas;

-- ************** C) Elimina la tabla FAMILIA y su contenido si lo tuviera. **** --
-- TRUNCATE TABLE Familia; ERROR Clave primaria la usa como clave ajena en la tabla Producto
DROP TABLE Familia CASCADE CONSTRAINTS PURGE;

-- **** D) Crea un usuario llamado C##INVITADO siguiendo los pasos vistos anteriormente y asignale todos los privilegios sobre la tabla PRODUCTO. **** --
CREATE USER INVITADO IDENTIFIED BY invitado
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO INVITADO;

GRANT ALL PRIVILEGES ON Producto TO INVITADO;

--SELECT * FROM USER_SYS_PRIVS; 
SELECT * FROM USER_TAB_PRIVS;
--SELECT * FROM USER_ROLE_PRIVS;

-- **** E) Retira los permisos de modificar la estructura de la tabla y borrar contenido de la tabla PRODUCTO al usuario anterior. * --
REVOKE DELETE ON Producto FROM INVITADO;
REVOKE ALTER ON Producto FROM INVITADO;













