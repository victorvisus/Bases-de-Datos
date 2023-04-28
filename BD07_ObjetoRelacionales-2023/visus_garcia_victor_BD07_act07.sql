-- TAREA 7 - BASES DE DATOS --  Actividad 7 ------------------------------------

/*******************************************************************************
7.	Obtener, de la tabla TablaComerciales, el Comercial que tiene el código 100,
asignándoselo a una variable unComercial
********************************************************************************/
DECLARE
    unComercial INTEGER;
    
    empl_comercial REF comercial;
BEGIN
    unComercial := 100;
    SELECT REF(c) INTO empl_comercial FROM comerciales c WHERE codigo = unComercial;

    unComercial := 101;

END;
/

SELECT * FROM comerciales WHERE codigo = 100;
/*******************************************************************************
8.	Modifica el código del Comercial guardado en esa variable unComercial asignando
el valor 101, y su zona debe ser la segunda que se había creado anteriormente.
Inserta ese Comercial en la tabla TablaComerciales  
********************************************************************************/