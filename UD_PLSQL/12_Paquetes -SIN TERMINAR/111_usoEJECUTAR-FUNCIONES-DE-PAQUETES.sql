SET SERVEROUTPUT ON
DECLARE
    v1 VARCHAR2(100);
BEGIN
    v1 := pack1.convert('aaaa', 'U');
    
    dbms_output.put_line(v1);
END;
/

-- Las funciones dentro de un paquete se pueden usar en las sentencias SQL
SELECT
    first_name, pack1.convert(first_name, 'U')
FROM
    employees;