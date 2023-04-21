-- Trigger Tipo ROW
/*
- Se disparan por cada fila que se ve ejecutada, antes o despues, ya sea BEFORE o AFTER
- Podemos acceder a los datos de cada fila, y controlarlo dependiendo del dato
Se accede a ellos mediante :old y :new

            :new            :old
INSERT      NULL            Valor del INSERT
UPDATE      Valor anterior  Valor nuevo
DELETE      Valor anterior  NULL
*/

-- Controlar el Tipo de Evento
CREATE OR REPLACE TRIGGER TR1_REGION
    BEFORE INSERT OR UPDATE OR DELETE
    ON REGIONS
    FOR EACH ROW

BEGIN

    IF INSERTING THEN
        :NEW.REGION_NAME := UPPER(:NEW.REGION_NAME);
        INSERT INTO log_table VALUES('Insercción', USER);
    END IF;
    
    IF UPDATING('REGION_NAME') THEN
        :NEW.REGION_NAME := UPPER(:NEW.REGION_NAME);
        INSERT INTO log_table VALUES('Modificacion Nombre', USER);
    END IF;
    IF UPDATING('REGION_ID') THEN
        INSERT INTO log_table VALUES('Modificacion ID', USER);
    END IF;
    
    IF DELETING THEN
        INSERT INTO log_table VALUES('Eliminacion', USER);
    END IF;

END;
