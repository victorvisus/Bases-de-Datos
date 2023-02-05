-- AMBITO DE LA VARIABLES

/**
- Variables Globales: son las declaradas en el bloque padre, a la que puede acceder el hijo

- Variables Locales: variables declaradas en el bloque hijo, tienen preponderancia
sobre las del bloque padre, si sellaman igual.
A estas no puede acceder el código que haya en el bloque padre.
**/

SET SERVEROUTPUT ON

DECLARE
    x  NUMBER := 20; --GLOBAL
            z  NUMBER := 30;
BEGIN
    dbms_output.put_line('x global := ' || x);
    DECLARE
        x  NUMBER := 10; --LOCAL
                        y  NUMBER := 200; --LOCAL, no se puede acceder desde el Padre
            BEGIN
        dbms_output.put_line('x local := ' || x);
        dbms_output.put_line('z := ' || z);
    END;

END;

/**
Las variables del padre puede ser usadas por el hijo, pero las del hijo no pueden ser usadas por el padre
Las variables de hijo se buscan en el propio hijo, y si no las encuentra las busca en el padre.
**/