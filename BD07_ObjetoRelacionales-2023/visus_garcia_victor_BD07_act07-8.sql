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
    
END;

/*
SELECT * FROM tablaComerciales;
SELECT c.codigo, c.zonacomercial.nombre FROM tablaComerciales c;
SELECT * FROM areas_comerciales;
SELECT nombre_area, t2.* FROM areas_comerciales, TABLE(areas_comerciales.zonas) t2;
*/