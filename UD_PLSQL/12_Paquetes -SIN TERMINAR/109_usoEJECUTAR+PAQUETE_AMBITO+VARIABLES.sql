SET SERVEROUTPUT ON
BEGIN
    pack1.v1 := pack1.v1 + 10;
    pack1.v2 := 'test';
    
    dbms_output.put_line(pack1.v1);
    dbms_output.put_line(pack1.v2);

END;