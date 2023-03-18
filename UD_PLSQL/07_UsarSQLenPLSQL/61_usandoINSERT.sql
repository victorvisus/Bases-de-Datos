-- Use de INSERT

DECLARE
    col1 test.c1%TYPE;
BEGIN
    col1 := 20;
    INSERT INTO test (c1,c2) VALUES (col1, 'sdhn');
    -- Tienen que llevar un COMMIT o un ROLLBACK para que se guarden los datos en la BBDD
    COMMIT;
END;
/