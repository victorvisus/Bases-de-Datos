--Comando RAISE_APPLICATION_ERROR
-- Exceptions personalizadas
DECLARE
    --Variables para Exception OTHERS
    code_exc NUMBER;
    message_exc VARCHAR2(100);
    
    --Creo dos variables para guardar los datos
    regn NUMBER;
    regt VARCHAR2(200);
    
BEGIN
    regn := 101;
    regt := 'Asia';
        
    IF regn > 100 THEN
        -- EL CODIGO DEBE ESTAR ENTRE -20000 y -20999
        RAISE_APPLICATION_ERROR(-20001, 'La ID no puede ser mayor de 100, se supende el proceso.');
        /* Es una funcion que permite devolver un error personalizado y cortar el
        programa
        Tiene 2 argumentos:
            - el primero es el cód. del error, el que nosotros queramos y que
            este entre -20000 y -20999.
            - el segundo el mensaje de error. */
    ELSE
        INSERT INTO regions values (regn,regt);
        dbms_output.put_line('La región se ha insertado correctamente.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        code_exc := SQLCODE;
        message_exc := SQLERRM;
        
        dbms_output.put_line('Error desconocido, más info:');
        dbms_output.put_line('Cód. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/