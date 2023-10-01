-- ***************************************************************************** --
-- **************************************** EJERCICIO 02 - MODIFICAR TIENDA **** --
-- ***************************************************************************** --

-- A)  Modificar la estructura de tablas creadas en el ejercicio anterior.       --

-- A.1 A�adir a la tabla STOCK *************************************************
/*******************************************************************************
A�ade una columna de tipo fecha llamada FechaUltimaEntrada que por defecto tome
el valor de la fecha actual.
********************************************************************************/
ALTER TABLE Stock ADD (FechaUltimaEntrada DATE DEFAULT SYSDATE);
/*******************************************************************************
Una columna llamada Beneficio que contendr� el tipo de porcentaje de beneficio que
esa tienda aplica en ese producto. Se debe controlar que el valor que almacene sea
1,2, 3, 4 o 5.
********************************************************************************/
ALTER TABLE Stock ADD (
    Beneficio NUMBER(1),
    CONSTRAINT STK_BEN_CK CHECK (Beneficio > 1 AND Beneficio < 5)
);

-- A.2 En la tabla PRODUCTO ****************************************************
/*******************************************************************************
Eliminar de la tabla producto la columna Descripci�n.
********************************************************************************/
ALTER TABLE producto DROP COLUMN Descripcion;
/*******************************************************************************
A�adir una columna llamada perecedero que �nicamente acepte los valores: S o N.
********************************************************************************/
ALTER TABLE Producto ADD (
    Perecedero VARCHAR2(1),
    CONSTRAINT PRO_PER_CK CHECK (Perecedero = 'S' OR Perecedero = 'N')
);
/*******************************************************************************
Modificar el tama�o de la columna Nomproducto a 50.
********************************************************************************/
ALTER TABLE Producto MODIFY (Denoproducto VARCHAR2(50));

-- A.3 En la tabla FAMILIA *****************************************************
/*******************************************************************************
A�adir una columna llamada IVA, que represente el porcentaje de IVA y �nicamente
pueda contener los valores 21,10,� 4.
********************************************************************************/
ALTER TABLE Familia ADD (
    IVA NUMBER(2),
    CONSTRAINT FAM_IVA_CK CHECK (IVA = 21 OR IVA = 10 OR IVA = 4)
);

-- A.4 En la tabla tienda ******************************************************
/*******************************************************************************
La empresa desea restringir el n�mero de tiendas con las que trabaja, de forma
que no pueda haber m�s de una tienda en una misma zona (la zona se identifica por
el c�digo postal). Definir mediante DDL las restricciones necesarias para que se
cumpla en el campo correspondiente.
********************************************************************************/
ALTER TABLE Tienda ADD CONSTRAINT TIE_CPO_UN UNIQUE (CodigoPostal);


-- B) Renombra la tabla STOCK por STOCK_TIENDAS.                                 --
ALTER TABLE Stock RENAME TO Stock_tiendas;


-- C) Elimina la tabla FAMILIA y su contenido si lo tuviera.                     --
DROP TABLE Familia CASCADE CONSTRAINTS;


-- D) Crea un usuario llamado C##INVITADO                                        --
CREATE USER INVITADO IDENTIFIED BY invitado
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON USERS;
--  y asignale todos los privilegios sobre la tabla PRODUCTO.
GRANT ALL PRIVILEGES ON Producto TO INVITADO;


-- E) Retira los permisos de modificar la estructura de la tabla
REVOKE DELETE ON Producto FROM INVITADO;
--  y borrar contenido de la tabla PRODUCTO al usuario anterior.
REVOKE ALTER ON Producto FROM INVITADO;