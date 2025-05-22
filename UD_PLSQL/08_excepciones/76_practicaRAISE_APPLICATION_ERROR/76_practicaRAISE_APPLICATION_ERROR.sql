-- Práctica con RAISE_APPLICATION_ERROR

/*******************************************************************************
1. PRÁCTICA 1 ------------------------------------------------------------------
Modificar la practica anterior para disparar un error con RAISE_APPLICATION en 
vez de con PUT_LINE.
a. Esto permite que la aplicación pueda capturar y gestionar el error que devuelve
el PL/SQL
*******************************************************************************/
DECLARE
    --control_regiones EXCEPTION;
    
    reg_id regions.region_id%TYPE;
    reg_nom regions.region_name%TYPE;
BEGIN

    reg_id := 250;
    reg_nom := 'Oceania';
    
    IF reg_id > 200 THEN
        --RAISE control_regiones;
        RAISE_APPLICATION_ERROR(-20532, 'Codigo no permitido. Debe ser inferior a 200');
    ELSE
        INSERT INTO regions VALUES (reg_id,reg_nom);
        dbms_output.put_line('Región insertada');
    END IF;
/*    
EXCEPTION
    WHEN control_regiones THEN
        dbms_output.put_line('Codigo no permitido. Debe ser inferior a 200');*/
END;
/