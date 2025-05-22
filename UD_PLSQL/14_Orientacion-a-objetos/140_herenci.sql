create or replace type comestibles under producto(
caducidad date,
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2
);
/


create or replace type body comestibles as 
MEMBER FUNCTION ver_caducidad RETURN VARCHAR2 as
begin
return caducidad;
end;
end;
/

declare
 v1 comestibles:=comestibles(900,'tornillos',20,sysdate());
begin
 dbms_output.put_line(v1.ver_precio());
 dbms_output.put_line(v1.ver_precio(10));
 dbms_output.put_line(v1.ver_caducidad);
 
 end;
 /