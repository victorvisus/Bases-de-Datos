-- Controlar varias operaciones al mismo tiempo
CREATE OR REPLACE TRIGGER TR1_REGION
BEFORE INSERT OR UPDATE OF region_name OR DELETE
-- el OF region_name hace que el UPDATE solo se lanza si se ve afectada esa columna
ON REGIONS 
BEGIN

    -- Que solo el usuario HR pueda insertar filas en una tabla
    IF USER <> 'HR' THEN
        RAISE_APPLICATION_ERROR(-20000, 'Solo HR puede trabajar en la tabla REGIONS');
    END IF;

END;
