-- TAREA 7 - BASES DE DATOS --  Actividad 7 ------------------------------------
SELECT * FROM comerciales;
/*******************************************************************************
7.	Obtener, de la tabla TablaComerciales, el Comercial que tiene el código 100,
asignándoselo a una variable unComercial
********************************************************************************/
DECLARE
    unComercial comercial;
    
    empl_comercial REF comercial;
BEGIN
    --SELECT REF(c) INTO empl_comercial FROM comerciales c WHERE codigo = unComercial;

    SELECT VALUE(c) INTO unComercial FROM comerciales c WHERE c.CODIGO = 100;
    
END;
/

