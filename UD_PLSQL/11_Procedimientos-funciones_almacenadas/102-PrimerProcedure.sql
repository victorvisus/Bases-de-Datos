-- Si no existe lo crea y si existe lo reemplaza
CREATE OR REPLACE PROCEDURE P1
IS
  X NUMBER:=10;
BEGIN
  DBMS_OUTPUT.PUT_LINE(X);
END P1;

