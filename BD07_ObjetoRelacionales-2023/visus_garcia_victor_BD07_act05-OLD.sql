-- TAREA 7 - BASES DE DATOS --  Actividad 5 ------------------------------------

/*******************************************************************************
5.	Crea una colecci�n VARRAY llamada ListaZonas en la que se puedan almacenar 
hasta 10 objetos Zonas.

Guarda en una instancia listaZonas1 de dicha lista, dos Zonas
     .	codigo: 1
     .	nombre: zona 1
     .	refResponsable: Referencia al responsable cuyo c�digo es 5
     .	codigo postal: 06834
     
     .	codigo: 2
     .	nombre: zona 2
     .	refResponsable: Referencia al responsable cuyo DNI es 51083099F.
     .	codigo postal: 28003
********************************************************************************/

--DROP TYPE ListaZonas;
DROP TABLE listazonas1;

-- CREO EL VARRAY
CREATE OR REPLACE TYPE ListaZonas IS VARRAY(10) OF zonas;
/
-- CREO LA INSTANCIA listaZonas1
CREATE TABLE listazonas1 OF zonas;
/
DECLARE
--    TYPE ListaZonas IS VARRAY(10) OF zonas;
    refResp REF responsable;
    
    zona1 zonas;
    zona2 zonas;
    
    listaZonas1 ListaZonas := ListaZonas();

BEGIN

    -- A�adir Zona 1 --
    SELECT REF(r) INTO refResp FROM responsables r WHERE r.codigo = 5;
    zona1 := NEW zonas(1,'Zona 1',refResp,'06834');
    listaZonas1.EXTEND();
    listaZonas1(1) := zona1;
    dbms_output.put_line('A�adida nueva zona: ' || listaZonas1(1).nombre);

    -- A�adir Zona 2 --
    SELECT REF(r) INTO refResp FROM responsables r WHERE r.dni = '51083099F';
    zona2 := NEW zonas(2,'Zona 2',refResp,'28003');
    listaZonas1.EXTEND();
    listaZonas1(2) := zona2;
    dbms_output.put_line('A�adida nueva zona: ' || listaZonas1(2).nombre);
    
    -- A�ADO EL VARRAY A LA TABLA listaZonas1 (no s� si es lo que pide el ejercicio)
    INSERT INTO listazonas1 VALUES(listazonas1(1));
    INSERT INTO listazonas1 VALUES(listazonas1(2));

EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecuci�n.');
    
END;
/