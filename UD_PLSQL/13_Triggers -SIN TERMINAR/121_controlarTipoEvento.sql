-- Controlar el Tipo de Evento
CREATE OR REPLACE TRIGGER TR1_REGION
BEFORE INSERT OR UPDATE OR DELETE
-- el OF region_name hace que el UPDATE solo se lanza si se ve afectada esa columna
ON REGIONS 
BEGIN

/* Existen unas tablas muy sencillas de utilizar, para controlar la operación:
 - INSERTING
 - UPDATING
 - DELETING
*/
    /* Vamos a guardar en la tabla LOG_TABLE no solo el usuario, si no tambien la
    operación que ha realizado */
    IF INSERTING THEN
        INSERT INTO log_table VALUES('Insercción', USER);
    END IF;
    
    IF UPDATING('REGION_NAME') THEN
        INSERT INTO log_table VALUES('Modificacion Nombre', USER);
    END IF;
    IF UPDATING('REGION_ID') THEN
        INSERT INTO log_table VALUES('Modificacion ID', USER);
    END IF;
    
    IF DELETING THEN
        INSERT INTO log_table VALUES('Eliminacion', USER);
    END IF;

/*
    -- Que solo el usuario HR pueda insertar filas en una tabla
    IF USER <> 'HR' THEN
        RAISE_APPLICATION_ERROR(-20000, 'Solo HR puede trabajar en la tabla REGIONS');
    END IF;
*/
END;
