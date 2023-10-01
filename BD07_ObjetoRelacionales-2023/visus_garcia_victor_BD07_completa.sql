SET SERVEROUTPUT ON;
/*
DROP TABLE tablaComerciales;
DROP TABLE areas_comerciales;
DROP TYPE ListaZonas;
DROP TABLE tablaResponsables;

DROP TYPE comercial;
DROP TYPE zonas;
DROP TYPE responsable;
DROP TYPE personal;
*/

--------------------------------------------------------------------------------
-- TAREA 7 - BASES DE DATOS -- Actividades 1, 2 y 3 - Crear Objetos ------------

/*******************************************************************************
 Actividad 1.	Crea el tipo de objetos "Personal" con los siguientes atributos:
********************************************************************************/

/* -----------------------------------------------------------------------------
1.A.-	Crea el tipo de objetos "Personal" con los siguientes atributos:
     .	codigo INTEGER,
     .	dni VARCHAR2(10),
     .	nombre VARCHAR2(30),
     .	apellidos VARCHAR2(30),
     .	sexo VARCHAR2(1),
     .	fecha_nac DATE
*/
CREATE OR REPLACE TYPE personal AS OBJECT(
    --Atributos
    codigo INTEGER,
    dni VARCHAR2(10),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    sexo VARCHAR2(1),
    fecha_nac DATE

) NOT FINAL;
/
/* -----------------------------------------------------------------------------
1.B.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Responsable" 
con los siguientes atributos:
     .	tipo  CHAR ,
     .	antiguedad INTEGER 
*/
CREATE OR REPLACE TYPE responsable UNDER personal(
    tipo  CHAR,
    antiguedad INTEGER,
    
    --Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable"...
    CONSTRUCTOR FUNCTION responsable(
        r_codigo INTEGER, r_nombre VARCHAR2, r_ape_uno VARCHAR2, r_ape_dos VARCHAR2, r_tipo CHAR
    ) RETURN SELF AS RESULT,
    
    --Actividad 3.	Crea un método getNombreCompleto para el tipo de objetos Responsable... 
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2
);
/
/* -----------------------------------------------------------------------------
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
    codigoPostal CHAR(5),

    --Actividad 9 - Método MAP
    MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2
);
/
/* -----------------------------------------------------------------------------
1.D.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Comercial" 
con los siguientes atributos:
     .	zonaComercial Zonas
*/
CREATE OR REPLACE TYPE comercial UNDER personal(
    zonaComercial zonas
);
/

/*******************************************************************************
Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable",
en el que se indiquen como parámetros el código, nombre, primer apellido, segundo
apellido y tipo. Este método debe asignar al atributo apellidos los datos de 
primer apellido y segundo apellido que se han pasado como parámetros, uniéndolos
con un espacio entre ellos.
********************************************************************************/
CREATE OR REPLACE TYPE BODY responsable AS
 
    CONSTRUCTOR FUNCTION responsable(
        r_codigo INTEGER, r_nombre VARCHAR2, r_ape_uno VARCHAR2, r_ape_dos VARCHAR2, r_tipo CHAR
    ) RETURN SELF AS RESULT IS
    
    p_apellidos VARCHAR2(30) := r_ape_uno || ' ' || r_ape_dos;
    
    BEGIN
        SELF.codigo := r_codigo;
        SELF.nombre := r_nombre;
        SELF.apellidos := p_apellidos;
        SELF.tipo := r_tipo;
        RETURN;
    END;

/*******************************************************************************
3.	Crea un método getNombreCompleto para el tipo de objetos Responsable que 
permita obtener su nombre completo con el formato apellidos nombre.
********************************************************************************/
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2 IS
    BEGIN
        RETURN apellidos || ', ' || nombre;
    END getNombreCompleto;
END;
/

/*******************************************************************************
9.	Crea un método MAP ordenarZonas para el tipo Zonas. Este método debe retornar
el nombre completo del Responsable al que hace referencia cada zona.

Para obtener el nombre debes utilizar el método getNombreCompleto que se ha 
creado anteriormente
 *******************************************************************************/
CREATE OR REPLACE TYPE BODY zonas AS
 
    MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2 IS
    respon responsable;
    BEGIN
        SELECT DEREF(refRespon) INTO respon FROM DUAL;
        RETURN respon.getNombreCompleto();
    END ordenarZonas;
 
END;
/


--------------------------------------------------------------------------------
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
CREATE TABLE TablaResponsables OF responsable;
/
INSERT INTO TablaResponsables VALUES( responsable(5, '51083099F', 'Elena', 'Posta Llanos', 'F', '31/03/1975', 'N', 4) );
INSERT INTO TablaResponsables VALUES( responsable(6, 'Javier', 'Jaramillo', 'Herrnandez', 'C') );
/


--------------------------------------------------------------------------------
-- TAREA 7 - BASES DE DATOS --  Actividad 5 ------------------------------------

/*******************************************************************************
5.	Crea una colección VARRAY llamada ListaZonas en la que se puedan almacenar 
hasta 10 objetos Zonas.

Guarda en una instancia listaZonas1 de dicha lista, dos Zonas
     .	codigo: 1
     .	nombre: zona 1
     .	refResponsable: Referencia al responsable cuyo código es 6
     .	codigo postal: 06834
     
     .	codigo: 2
     .	nombre: zona 2
     .	refResponsable: Referencia al responsable cuyo DNI es 51083099F.
     .	codigo postal: 28003
********************************************************************************/

-- CREO EL VARRAY de Objetos ZONAS
CREATE OR REPLACE TYPE ListaZonas IS VARRAY(10) OF zonas;
/
-- CREO LA TABLA para guardar el VARRAY listaZonas1
CREATE TABLE areas_comerciales (
    codigo NUMBER PRIMARY KEY,
    nombre_area VARCHAR2(100),
    zonas ListaZonas
);
/

DECLARE
    refRespZona1 REF responsable;
    refRespZona2 REF responsable;
    zona1 zonas;
    zona2 zonas;
    
    listaZonas1 ListaZonas;
BEGIN

-- Creo Zona 1 --
    -- Referencio a la tabla TablaResponsables  y guardo en la variable refRespZona1 el responsable correspondiente
    SELECT REF(r) INTO refRespZona1 FROM TablaResponsables  r WHERE r.codigo = 6;
    -- Instancio el objeto zonas: zona1
    zona1 := NEW zonas(1,'Zona 1',refRespZona1,'06834');

-- Creo Zona 2 --
    -- Referencio a la tabla TablaResponsables  y guardo en la variable refRespZona2 el responsable correspondiente
    SELECT REF(r) INTO refRespZona2 FROM TablaResponsables  r WHERE r.dni = '51083099F';
    -- Instancio el objeto zonas: zona2
    zona2 := NEW zonas(2,'Zona 2',refRespZona2,'28003');

-- Inicializao el VARRAY y Añado las zonas --
    listaZonas1 := ListaZonas(zona1, zona2);

-- AÑADO EL VARRAY A LA TABLA areas_comerciales (no sé si es lo que pide el ejercicio)
    INSERT INTO areas_comerciales VALUES(1, 'listazonas1', listazonas1);

EXCEPTION
    --Habia creado esta Exception para controlar la innexistencia del responsable con DNI 51083099F
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END actividad_05;
/


--------------------------------------------------------------------------------
-- TAREA 7 - BASES DE DATOS --  Actividad 6 ------------------------------------

/*******************************************************************************
6.	Crea una tabla TablaComerciales de objetos Comercial.

Inserta en dicha tabla las siguientes filas:
     .	codigo: 100
     .	dni: 23401092Z
     .	nombre: MARCOS
     .	apellidos: SUAREZ LOPEZ
     .	sexo: M
     .	fecha_nac: 30/3/1990
     .	zonacomercial: objeto creado anteriormente para la zona 1
    
     .	codigo: 102
     .	dni: 6932288V
     .	nombre: ANASTASIA
     .	apellidos:  GOMES PEREZ
     .	sexo: F
     .	fecha_nac: 28/11/1984
     .	zonacomercial: objeto que se encuentre en la segunda posición de "listaZonas1" 
     .		    (debe tomarse de la lista)
********************************************************************************/
--DROP TABLE comerciales;

--Creo la tabla 'tablaComerciales'
CREATE TABLE tablaComerciales OF comercial;
/

DECLARE
    listaZonas1 areas_comerciales.zonas%TYPE;
    
BEGIN
    SELECT zonas INTO listaZonas1 FROM areas_comerciales;
    --dbms_output.put_line('listaZonas1 pos. 1 nombre: ' || listaZonas1(1).nombre);
    --dbms_output.put_line('listaZonas1 pos. 2 nombre: ' || listaZonas1(2).nombre);

    --Inserto en la tabla tablaComerciales los dos comerciales, creandolos a la vez que se insertan
    INSERT INTO tablaComerciales VALUES (
        comercial(100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', listaZonas1(1) )
    );
    INSERT INTO tablaComerciales VALUES (
        comercial(102, '6932288V', 'ANASTASIA', 'GOMES PEREZ', 'F', '28/11/1984', listaZonas1(2) )
    );

EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END actividad_06;
/


--------------------------------------------------------------------------------
-- TAREA 7 - BASES DE DATOS --  Actividad 7 y 8 --------------------------------

/*******************************************************************************
7.	Obtener, de la tabla TablaComerciales, el Comercial que tiene el código 100,
asignándoselo a una variable unComercial
********************************************************************************/
DECLARE
    unComercial comercial;
    
    --listaZonas1 ListaZonas := ListaZonas();
    listaZonas1 areas_comerciales.zonas%TYPE;
BEGIN
    --Extraigo de la tabla 'comerciales' el registro con cód. 100 y lo guardo en la variable unComercial
    SELECT VALUE(c) INTO unComercial FROM tablaComerciales c WHERE c.CODIGO = 100;
    --dbms_output.put_line('Nombre del comercial "capturado": ' || unComercial.nombre);
    --dbms_output.put_line('Nombre de la zona del comercial "capturado": ' || unComercial.zonaComercial.nombre);
    
/*******************************************************************************
8.	Modifica el código del Comercial guardado en esa variable unComercial asignando
el valor 101, y su zona debe ser la segunda que se había creado anteriormente.
Inserta ese Comercial en la tabla TablaComerciales  
********************************************************************************/

    --Cambio el valor del atributo 'codigo' del comercial extraido de la table
    unComercial.codigo := 101;
    
    --Extraigo el VARRAY de la tabla 'areas_comerciales' y lo guardo en el VARRAY creado para el ejercicio
    SELECT zonas INTO listaZonas1 FROM areas_comerciales;
    --dbms_output.put_line('listaZonas1 pos. 1 nombre: ' || listaZonas1(1).nombre);
    --dbms_output.put_line('listaZonas1 pos. 2 nombre: ' || listaZonas1(2).nombre);
    
    --Establzco como valor del atributo 'zonazomercial' la segunda zona del VARRAY
    unComercial.zonacomercial := listaZonas1(2);
    --dbms_output.put_line('Nuevo Cod unComercial: ' || unComercial.codigo);
    --dbms_output.put_line('Nueva Zona unComercial_ ' || unComercial.zonacomercial.nombre);
    
    INSERT INTO tablaComerciales VALUES(unComercial);
    
END actividad_07y8;
/


--------------------------------------------------------------------------------
-- TAREA 7 - BASES DE DATOS --  Actividad 10 ------------------------------------

/*******************************************************************************
9.	Crea un método MAP ordenarZonas para el tipo Zonas. Este método debe retornar
el nombre completo del Responsable al que hace referencia cada zona. Para obtener 
el nombre debes utilizar el método getNombreCompleto que se ha creado anteriormente
********************************************************************************/
-- La Solución a la Actividad 9 se encuentra en la linea 56 y 130

/*******************************************************************************
10.	Realiza una consulta de la tabla TablaComerciales ordenada por zonaComercial
para comprobar el funcionamiento del método MAP.  
********************************************************************************/
SELECT * FROM TablaComerciales ORDER BY zonaComercial;
/

BEGIN
    dbms_output.put_line('La tarea se ha ejecutado correctamente');
END;
/
