set serveroutput on
DECLARE
  A NUMBER;
  B NUMBER;
begin
  A:=120;
  B:=59;
  
  calc_tax(A,B);
end;
/