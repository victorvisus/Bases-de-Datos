-- Excepcions con SQL
DECLARE
    reg regions%ROWTYPE; --Creo un rowtype
    reg_control regions.region_id%TYPE; --Creo una variable de control 
    
    --Variables para Exception OTHERS
    code_exc NUMBER;
    message_exc VARCHAR2(100);
BEGIN
    reg.region_id := 100;
    reg.region_name := 'Africa';
    
    /* Esta haciendo un punto de control, SI la fila ya existe te doy un ERROR y
    SI NO existe se dispara la Exception donde se hace el proceso.
    
    Me va a buscar si el ID indicado existe dentro de la tabla, y guarda el 
    resultado en reg_control, si exite, si no existe salta la Exception, es en
    ese momento cuando hace el INSERT */
    SELECT region_id INTO reg_control FROM regions
        WHERE region_id = reg.region_id;
    
    dbms_output.put_line('La Región ya existe. Ningún dato añadido');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        /* La fila no existe y se hace el insert */
        INSERT INTO regions VALUES (reg.region_id, reg.region_name);
        COMMIT;
        
        dbms_output.put_line('Región insertada correctamente');
    WHEN OTHERS THEN
        code_exc := SQLCODE;
        message_exc := SQLERRM;
        
        dbms_output.put_line('El registro no se ha podido añadir, más info:');
        dbms_output.put_line('Cód. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/