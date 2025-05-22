DECLARE
    sales  NUMBER := 20000;
    bonus  NUMBER := 0;
BEGIN
    IF sales > 50000 THEN
        bonus := 1500;
    ELSIF sales > 35000 THEN
        bonus := 500;
    ELSIF
        sales < 20001
        AND sales > 10000
    THEN
        bonus := 250;
    ELSE
        bonus := 100;
    END IF;

    dbms_output.put_line('Sales = '
                         || sales
                         || ', bonus = '
                         || bonus
                         || '.');

END;