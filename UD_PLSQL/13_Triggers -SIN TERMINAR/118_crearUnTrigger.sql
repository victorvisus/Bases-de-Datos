-- Crear un Trigger
/*
Vamos a suponer que quiero controlar que cuando se haga un INSERT en la tabla 
REGIONS, voy a Guardar en la Table LOG_TABLE el registro de la operación y el 
usuario que ha realizado la operación.
*/
/*
CREATE TABLE log_table(
    LOG_COLUMN VARCHAR2(200),
    USER_NAME VARCHAR2(200)
);
*/

CREATE OR REPLACE TRIGGER ins_empl
AFTER INSERT ON regions
BEGIN
    INSERT INTO log_table VALUES('Inserción en la tabla REGIONS', USER);
END;
/