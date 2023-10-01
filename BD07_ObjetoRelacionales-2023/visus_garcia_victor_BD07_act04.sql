-- TAREA 7 - BASES DE DATOS --  Actividad 4 ------------------------------------

/*******************************************************************************
 4.	Crea un tabla Tabla Responsables de objetos  Responsable. Inserta en dicha
 tabla dos objetos Responsable.
    .	codigo:  5
    .	dni: 51083099F
    .	nombre: ELENA
    .	apellidos:  POSTA LLANOS
    .	sexo: F
    .	fecha_nac: 31/03/1975
    .	tipo: N
    .	antiguedad: 4

	El segundo objeto "Responsable" debes crearlo usando el método constructor 
    que has realizado anteriormente. Debes usar los siguientes datos:
    .	codigo: 6
    .	nombre: JAVIER
    .	apellidos: JARAMILLO HERNANDEZ
    .	tipo: C
********************************************************************************/
--ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

CREATE TABLE TablaResponsables OF responsable;

INSERT INTO TablaResponsables VALUES( responsable(5, '51083099F', 'Elena', 'Posta Llanos', 'F', '31/03/1975', 'N', 4) );
INSERT INTO TablaResponsables VALUES( responsable(6, 'Javier', 'Jaramillo', 'Herrnandez', 'C') );

--SELECT * FROM TablaResponsables ;



