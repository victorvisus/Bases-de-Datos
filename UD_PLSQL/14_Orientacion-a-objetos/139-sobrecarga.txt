set serveroutput on
declare
 v1 producto:=producto(900,'tornillos',20);
begin
 dbms_output.put_line(v1.ver_precio());
 dbms_output.put_line(v1.ver_precio(10));
 end;
 /