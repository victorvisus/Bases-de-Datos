-- �mbito de la EXCEPTIONS
/*
Las variables que se encuientran en un Bloque anidado son variables LOCALES a ese
bloque, en el que se pueden leer tambi�n las variables del bloque Padre, que son 
GLOBALES.
Las Exceptions funcionan igual
*/
DECLARE
    --Variables para Exception OTHERS
    code_exc     NUMBER;
    message_exc  VARCHAR2(100);
    
    --Creo dos variables para guardar los datos
    regn         NUMBER;
    regt         VARCHAR2(200);
BEGIN
    regn := 990;
    regt := 'Asia';
    
    -- BLOQUE HIJO --
    DECLARE
        --Creo el objeto Exception
        reg_max EXCEPTION; --Solo se lee en el bloque Hijo
    BEGIN
        IF regn > 100 THEN
            RAISE reg_max;
        ELSE
            INSERT INTO regions VALUES (regn,regt);
            dbms_output.put_line('La regi�n se ha insertado correctamente.');
        END IF;
    EXCEPTION
        WHEN reg_max THEN
            dbms_output.put_line('La regi�n no puede ser mayor a 100.');
    END;
    -- FIN BLOQUE HIJO --
EXCEPTION
    WHEN OTHERS THEN
        code_exc := sqlcode;
        message_exc := sqlerrm;
        dbms_output.put_line('Error desconocido, m�s info:');
        dbms_output.put_line('C�d. de error ' || code_exc);
        dbms_output.put_line('Mensaje de error ' || message_exc);
END;
/