-- VER LOS PROCEDIMIENTOS
SELECT * FROM USER_OBJECTS
  WHERE OBJECT_TYPE='PROCEDURE';

-- VER LOS OBJETOS DEL USUARIO
SELECT OBJECT_TYPE,COUNT(*) FROM USER_OBJECTS
  GROUP BY OBJECT_TYPE;
  
-- VER COD. DE UN OBJETO
SELECT * FROM USER_SOURCE
WHERE NAME='P1';

-- VER EL TEXTO DEL COD. DE UN OBJETO
SELECT TEXT FROM USER_SOURCE
WHERE NAME='P1';