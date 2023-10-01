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
CREATE TABLE comerciales OF comercial;
/

DECLARE
    --Instancio un VARRAY para almacenar las zonas creadas con los datos extraídos de la tabla areas_comerciales
    TYPE listaZonas1 IS VARRAY(10) OF zonas;
    zonas_comerc listaZonas1 := listaZonas1();
    area1 zonas;
    area2 zonas;
    
    --Instancio dos objetos 'responsable' para guardar la referencia a los responsables de las zonas comerciales
    refRespZona1 REF responsable;
    refRespZona2 REF responsable;
    
    --Instancio dos objetos comercial
    comerc1 comercial;
    comerc2 comercial;

    --Creo un CURSOR para guardar los datos de las zonas almacenadas en el VARRAY em la tabla 'areas_comerciales'
    CURSOR areas IS SELECT t2.codigo, t2.nombre, t2.codigopostal FROM areas_comerciales, TABLE(areas_comerciales.zonas) t2;
    --Creo un RECORD para guardar los datos de las zoans
    TYPE datos_area IS RECORD (
        codigo INTEGER,
        nombre VARCHAR2(20),
        codigoPostal CHAR(5)
    );
    --Creo dos variables del RECORD creado
    datos_area1 datos_area;
    datos_area2 datos_area;
BEGIN
    --Referencio a los dos responsables guardados en su tabla, y los almaceno en los objeto responsable
    SELECT REF(r) INTO refRespZona1 FROM responsables r WHERE r.codigo = 6;
    SELECT REF(r) INTO refRespZona2 FROM responsables r WHERE r.dni = '51083099F';
    
    --Abro y recorro el cursor almacenando los datos extraídos en los RECORD 'datos_area1 y 2' creados
    OPEN areas;
    FETCH areas INTO datos_area1;
    dbms_output.put_line('Código área: ' || datos_area1.codigo);
    dbms_output.put_line('Código nombre: ' || datos_area1.nombre);
    dbms_output.put_line('Código codigoPostal: ' || datos_area1.codigoPostal);
    --Creo el objeto zonas 'area1' con los datos extraídos
    area1 := NEW zonas(datos_area1.codigo, datos_area1.nombre, refRespZona1, datos_area1.codigoPostal);
    
    FETCH areas INTO datos_area2;
    dbms_output.put_line('Código área: ' || datos_area2.codigo);
    dbms_output.put_line('Código nombre: ' || datos_area2.nombre);
    dbms_output.put_line('Código codigoPostal: ' || datos_area2.codigoPostal);
    --Creo el objeto zonas 'area2' con los datos extraídos
    area2 := NEW zonas(datos_area2.codigo, datos_area2.nombre, refRespZona2, datos_area2.codigoPostal);
    
    CLOSE areas;
    
    --Aumento en 2 posiciones el VARRAY para guardar en el los dos objetos 'area' creados
    zonas_comerc.EXTEND(2);
    zonas_comerc(1) := area1;
    zonas_comerc(2) := area2;

    --Inserto en la tabla comerciales los dos comerciales, creandolos a la vez que se insertan
    INSERT INTO comerciales VALUES (
        comercial(100, '23401092Z', 'MARCOS', 'SUAREZ LOPEZ', 'M', '30/3/1990', zonas_comerc(1) )
    );
    INSERT INTO comerciales VALUES (
        comercial(102, '6932288V', 'ANASTASIA', 'GOMES PEREZ', 'F', '28/11/1984', zonas_comerc(2) )
    );
    
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('Error: El responsable no existe');
    
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error, abortando ejecución.');
    
END;
/


