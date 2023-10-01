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

--Creo la tabla 'coemrciales'
CREATE TABLE tablaComerciales OF comercial;


DECLARE
    listaZonas1 areas_comerciales.zonas%TYPE;
    
BEGIN
    SELECT zonas INTO listaZonas1 FROM areas_comerciales;
    --dbms_output.put_line('listaZonas1 pos. 1 nombre: ' || listaZonas1(1).nombre);
    --dbms_output.put_line('listaZonas1 pos. 2 nombre: ' || listaZonas1(2).nombre);

    --Inserto en la tabla comerciales los dos comerciales, creandolos a la vez que se insertan
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
    
END;
/


