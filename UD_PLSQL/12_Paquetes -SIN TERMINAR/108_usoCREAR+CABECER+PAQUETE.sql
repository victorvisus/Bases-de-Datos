CREATE OR REPLACE PACKAGE pack1
IS
    V1 NUMBER := 10;
    V2 VARCHAR2(100);

-- Cuando se habré un paquete ya no se cierra
-- las variables permanecen durante toda la sesión
END pack1;
/