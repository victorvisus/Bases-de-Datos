-- UPDATE
DECLARE
    T test.c1%TYPE;
BEGIN
    T := 10;
    UPDATE test SET C2='CCCCC' WHERE c1 = T;
    COMMIT;
END;
/