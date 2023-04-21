-- Bucle FOR con subquerys

-- DECLARE
--    CURSOR C1 IS SELECT * FROM REGIONS;
BEGIN
    FOR i IN ( SELECT * FROM REGIONS ) LOOP --Con esto abrimos un cursor directamente
        dbms_output.put_line(i.region_name);
    END LOOP;
    /* Con FOR no es necesario realizar los comandos del cursor, ni el open, ni close, ni fetch*/
END;
/