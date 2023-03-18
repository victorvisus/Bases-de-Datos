-- DELETE
DECLARE
    t test.c1%TYPE;
BEGIN
    t := 20;
    DELETE FROM test WHERE c1 = t;
    COMMIT;
END;
/