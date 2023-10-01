/*
A) Modificar la estructura de tablas creadas en el ejercicio anterior siguiendo las indicaciones. Las instrucciones que dan soluci�n a los ejercicios se incluir�n enun script llamado
ModificaTienda.sql.
Cada uno de ellos, como en el ejercicio anterior, ir� precedido de un comentario con el enunciado.
*/

-- A�adir a la tabla STOCK -----------------------------------------------------
/* Una columna de tipo fecha llamada FechaUltimaEntrada que por defecto tome el 
valor de la fecha actual.*/
ALTER TABLE stock ADD (fechaultimaentrada DATE DEFAULT SYSDATE);

/* Una columna llamada Beneficio que contendr� el tipo de porcentaje de beneficio
que esa tienda aplica en ese producto. Se debe controlar que el valorque almacene
sea 1,2, 3, 4 o 5. */
ALTER TABLE stock ADD (
    beneficio NUMBER(1) CHECK (beneficio >=1 AND beneficio <= 5)
);
ALTER TABLE stock ADD (
    beneficio NUMBER(1) CHECK (beneficio BETWEEN 1 AND 5)
);

ALTER TABLE Stock ADD (
    Beneficio NUMBER(1),
    CONSTRAINT STK_BEN_CK CHECK (Beneficio >= 1 AND Beneficio <= 5)
);

-- En la tabla PRODUCTO --------------------------------------------------------
/* Eliminar de la tabla producto la columna Descripci�n. */
ALTER TABLE producto DROP (descripcion);
ALTER TABLE producto DROP COLUMN Descripcion;

/* A�adir una columna llamada perecedero que �nicamente acepte los valores:
S o N. */
ALTER TABLE producto ADD (
    perecedero CHAR CHECK (perecedero = 'S' OR perecedero = 'N')
);
/* Modificar el tama�o de la columna Nomproducto a 50. */
ALTER TABLE Producto MODIFY (nomproducto VARCHAR2(50));

-- En la tabla FAMILIA ---------------------------------------------------------
/* A�adir una columna llamada IVA, que represente el porcentaje de IVA y �nicamente
pueda contener los valores 21,10,� 4. */
ALTER TABLE familia ADD (
    iva NUMBER(2)
    CHECK (iva = 21 OR iva = 10 OR iva = 4)
);

-- En la tabla tienda ----------------------------------------------------------
/* La empresa desea restringir el n�mero de tiendas con las que trabaja, de forma
que no pueda haber m�s de una tienda en una misma zona (la zona seidentifica por
el c�digo postal). Definir mediante DDL las restricciones necesarias para que se 
cumpla en el campo correspondiente. */
ALTER TABLE tienda MODIFY (codigopostal UNIQUE);
ALTER TABLE Tienda ADD CONSTRAINT TIE_CPO_UN UNIQUE (CodigoPostal);

-- B) Renombra la tabla STOCK por STOCK_TIENDAS. -------------------------------
ALTER TABLE Stock RENAME TO Stock_tiendas;