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
CREATE TABLE comerciales OF comercial;
/
-- Acceder a columnas tipo VARRAY
SELECT * FROM areas_comerciales;
-- Operador TABLE devuelve la información con cada uno de los valores que tiene el VARRAY
SELECT nombre_area, t2.*
FROM areas_comerciales, TABLE(areas_comerciales.zonas) t2;
-- Muestra en una fila para cada uno de los valores del VARRAY
/
DECLARE
    TYPE zonas_lista1 IS VARRAY(10) OF zonas;
    zonas_comerc zonas_lista1 := zonas_lista1();
    
    comerc1 comercial;
    comerc2 comercial;
    
    
BEGIN



--    INSERT INTO comerciales VALUES (
--        comercial(100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', zonas(1,'Zona 1',refResp,'06834') )
--    );
----    INSERT INTO comerciales VALUES (
----        comercial(100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', listaZonas1(1) )
----    );
--    INSERT INTO comerciales VALUES (
--        comercial(102, '6932288V', 'ANASTASIA', 'GOMES PEREZ', 'F', '28/11/1984', listaZonas1(2) )
--    );
    
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END;
/


