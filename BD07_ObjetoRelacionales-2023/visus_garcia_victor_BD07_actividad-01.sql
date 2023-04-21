-- TAREA 7 - BASES DE DATOS
/*******************************************************************************
 Actividad 1.	Crea el tipo de objetos "Personal" con los siguientes atributos:
 ********************************************************************************/

/*
1.A.-	Crea el tipo de objetos "Personal" con los siguientes atributos:
 .	codigo INTEGER,
 .	dni VARCHAR2(10),
 .	nombre VARCHAR2(30),
 .	apellidos VARCHAR2(30),
 .	sexo VARCHAR2(1),
 .	fecha_nac DATE
*/
CREATE OR REPLACE TYPE persona AS OBJECT(
    --Atributos
    codigo INTEGER,
    dni VARCHAR2(10),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    sexo VARCHAR2(1),
    fecha_nac DATE
);
/

/*
1.B.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Responsable" con los siguientes atributos:
 .	tipo  CHAR ,
 .	antiguedad INTEGER 
*/

/*
1.C.-	Crea el tipo de objeto "Zonas" con los siguientes atributos:
 .	codigo INTEGER, 
 .	nombre VARCHAR2(20), 
 .	refRespon REF Responsable, 
 .	codigoPostal CHAR(5),
*/
CREATE OR REPLACE TYPE zonas AS OBJECT(
    --Atributos
    codigo INTEGER,
    nombre VARCHAR2(20),
    refRespon REF Responsable,
    codigoPostal CHAR(5)
);
/

/*
1.D.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Comercial" con los siguientes atributos:
 .	zonaComercial Zonas
*/