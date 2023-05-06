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
-- CREO LA TABLA comerciales, INDICADA EN LA ACTIVIDAD 6
CREATE TABLE comerciales OF comercial;
/
--SELECT REF(r) FROM responsables r WHERE r.codigo = 6;
--/
DECLARE
    --Instancio los objetos que referencian a 'responsable'
    refRespZona1 REF responsable;
    refRespZona2 REF responsable;
    --Instancio los objetos 'zonas'
    zona1 zonas;
    zona2 zonas;
    --Instancio el VARRAY
    listaZonas1 ListaZonas;
    
    --Variable Actividad 7
    unComercial comercial;
BEGIN

-- Creo Zona 1 --
    -- Referencio a la tabla responsables y guardo en la variable refRespZona1 el responsable correspondiente
    SELECT REF(r) INTO refRespZona1 FROM responsables r WHERE r.codigo = 6;
    -- Instancio el objeto zonas: zona1
    zona1 := NEW zonas(1,'Zona 1',refRespZona1,'06834');

-- Creo Zona 2 --
    -- Referencio a la tabla responsables y guardo en la variable refRespZona2 el responsable correspondiente
    SELECT REF(r) INTO refRespZona2 FROM responsables r WHERE r.dni = '51083099F';
    -- Instancio el objeto zonas: zona2
    zona2 := NEW zonas(2,'Zona 2',refRespZona2,'28003');

-- Inicializao el VARRAY y Añado las zonas --
    listaZonas1 := ListaZonas(zona1, zona2);

-- AÑADO EL VARRAY A LA TABLA areas_comerciales (no sé si es lo que pide el ejercicio, pero así lo entiendo yo)
    INSERT INTO areas_comerciales VALUES(1, 'listazonas1', listazonas1);


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

    INSERT INTO comerciales VALUES (
        comercial(100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', listaZonas1(1) )
    );
    INSERT INTO comerciales VALUES (
        comercial(102, '6932288V', 'ANASTASIA', 'GOMES PEREZ', 'F', '28/11/1984', listaZonas1(2) )
    );

/*******************************************************************************
7.	Obtener, de la tabla TablaComerciales, el Comercial que tiene el código 100,
asignándoselo a una variable unComercial
********************************************************************************/
    SELECT VALUE(c) INTO unComercial FROM comerciales c WHERE c.CODIGO = 100;

/*******************************************************************************
8.	Modifica el código del Comercial guardado en esa variable unComercial asignando
el valor 101, y su zona debe ser la segunda que se había creado anteriormente.
Inserta ese Comercial en la tabla TablaComerciales  
********************************************************************************/
    unComercial.codigo := 101;
    unComercial.zonacomercial := listazonas1(2);
    
    INSERT INTO comerciales VALUES(unComercial);


EXCEPTION
    --Habia creado esta Exception para controlar la innexistencia del responsable con DNI 51083099F
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END;
/

SELECT * FROM areas_comerciales;
SELECT * FROM comerciales;
SELECT nombre_area, t2.* FROM areas_comerciales, TABLE(areas_comerciales.zonas) t2;
--DROP TYPE ListaZonas;
--DROP TYPE zonaslista;
--DROP TABLE areas_comerciales;
--DROP TABLE zonas_tab;
--DROP TABLE comerciales;