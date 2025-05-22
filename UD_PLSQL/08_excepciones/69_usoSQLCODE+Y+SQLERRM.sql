-- SQLCODE y SQLERRM
/*
Son dos funciones de PL/SQL para la gestión de excepciones, sobre todo cuando se usa WHEN OTHERS
Son para saber que error me ha lanzado

SQLCODE: devuelve el código del error
SQLERRM: devuelve el mensage del error
*/
DECLARE
    empl EMPLOYEES%ROWTYPE;
    code NUMBER;
    message VARCHAR2(100);
BEGIN
    SELECT * INTO empl FROM employees;
    dbms_output.put_line(empl.salary);
    
EXCEPTION

    WHEN OTHERS THEN
        dbms_output.put_line('Cód. de error ' || SQLCODE);
        dbms_output.put_line('Mensaje de error ' || SQLERRM);
        
        /*
        Con estas funciones podemos, por ejemplo, almacenar los errores en una tabla
        */
        --INSERT INTO errors VALUES (SQLCODE,SQLERRM); Esto no es válido, SQL no conoce estas funciones
        code := SQLCODE;
        message := SQLERRM;
        
        INSERT INTO errors VALUES (code, message);
        COMMIT;
END;
/