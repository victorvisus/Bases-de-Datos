-- Exceptions personalizadas
DECLARE
    --Creo el objeto Exception
    reg_max EXCEPTION;
    
    --Variables para Exception OTHERS
    code_exc NUMBER;
    message_exc VARCHAR2(100);
    
    --Creo dos variables para guardar los datos
    regn NUMBER;
    regt VARCHAR2(200);

    
BEGIN
    regn := 990;
    regt := 'Asia';
        
    /* Vamos a impedir que se pueda añadir un REGION_ID superior a 100 */
    IF regn > 100 THEN
        RAISE reg_max;
        /* RAISE es una clausula que se utiloza dentro de las excepciones de usuario
        Hasta ahora hemos estado usando las Exceptions de Oracle, pero cuando una
        Exception es personalizada el Oracle no sabe cuando dispararla, mediante
        un IF o una estructura de control, se lo indicamos con RAISE, diciendole 
        que Exception tiene que disparar, se ira a la zona EXCEPTIONS, buscará
        la Exception indicada y hara lo que tenga que hacer */
    ELSE
        INSERT INTO regions values (regn,regt);
        dbms_output.put_line('La región se ha insertado correctamente.');
    END IF;

EXCEPTION
    WHEN reg_max THEN
        dbms_output.put_line('La región no puede ser mayor a 100.');
       
    WHEN OTHERS THEN
        code_exc := SQLCODE;
        message_exc := SQLERRM;
        
        dbms_output.put_line('Error desconocido, más info:');
        dbms_output.put_line('Cód. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/