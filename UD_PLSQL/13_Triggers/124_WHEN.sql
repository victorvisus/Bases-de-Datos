-- WHEN

/* Se usa cuando se quiere que el trigger se dispare baja alguna circunstancia */
CREATE OR REPLACE TRIGGER TR1_REGION
    BEFORE INSERT OR UPDATE OR DELETE
    ON REGIONS
    FOR EACH ROW
    WHEN (NEW.REGION_ID > 1000) --Solo se dispara cuando el NUEVO ID de la region sea myaro que 1000

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
