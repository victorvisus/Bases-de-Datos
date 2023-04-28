-- TAREA 7 - BASES DE DATOS --  Actividad 5 ------------------------------------

/*******************************************************************************
5.	Crea una colección VARRAY llamada ListaZonas en la que se puedan almacenar 
hasta 10 objetos Zonas.

Guarda en una instancia listaZonas1 de dicha lista, dos Zonas
     .	codigo: 1
     .	nombre: zona 1
     .	refResponsable: Referencia al responsable cuyo código es 5
     .	codigo postal: 06834
     
     .	codigo: 2
     .	nombre: zona 2
     .	refResponsable: Referencia al responsable cuyo DNI es 51083099F.
     .	codigo postal: 28003
********************************************************************************/

--DROP TYPE ListaZonas;
--DROP TYPE zonaslista;
--DROP TABLE areas_cemerciales;
--DROP TABLE zonas_tab;

-- CREO EL VARRAY
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
--    TYPE ListaZonas IS VARRAY(10) OF zonas;
    refRespZona1 REF responsable;
    refRespZona2 REF responsable;
    zona1 zonas;
    zona2 zonas;
    
    listaZonas1 ListaZonas;
BEGIN

    -- Creo Zona 1 --
    SELECT REF(r) INTO refRespZona1 FROM responsables r WHERE r.codigo = 5;
    zona1 := NEW zonas(1,'Zona 1',refRespZona1,'06834');
    -- Creo Zona 2 --
    SELECT REF(r) INTO refRespZona2 FROM responsables r WHERE r.dni = '51083099F';
    zona2 := NEW zonas(2,'Zona 2',refRespZona2,'28003');
    -- Añado las zonas al VARRAY --
    listaZonas1 := ListaZonas(zona1, zona2);
    
    -- AÑADO EL VARRAY A LA TABLA areas_comerciales (no sé si es lo que pide el ejercicio)
    INSERT INTO areas_comerciales VALUES(1, 'listazonas1', listazonas1);

EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END;
/