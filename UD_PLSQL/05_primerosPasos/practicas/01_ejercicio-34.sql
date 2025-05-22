SET SERVEROUTPUT ON

/** 2-Crear dos variables de tipo num�rico y visualizar su suma **/
DECLARE
    x  NUMBER := 2;
    y  NUMBER := 4;
BEGIN
    dbms_output.put_line(x + y);
END;

/** 3-Modificar el ejemplo anterior y ponemos null como valor de una de las
variables. �Qu� resultado arroja? Volvemos a ponerla un valor num�rico **/
DECLARE
    x  NUMBER := NULL;
    y  NUMBER := 4;
BEGIN
    dbms_output.put_line(x + y);
END;
-- No arroja resultado

/** 4-A�adir una constante al ejercicio. Sumamos las 2 variables y la constantes.
Intentar modificar la constante. �Es posible? **/
DECLARE
    x  NUMBER := 2;
    y  NUMBER := 4;
    z  CONSTANT NUMBER := 6;
BEGIN
    dbms_output.put_line(x + y + z);
END;
-- 12. y no, no es posible modificar la constante

/** 5-Crear un bloque an�nimo que tenga una variable de tipo VARCHAR2 con nuestro
nombre, otra num�rica con la edad y una tercera con la fecha de nacimiento.
Visualizarlas por separado y luego intentar concatenarlas. �es posible? **/
DECLARE
    nombre           VARCHAR2(20) := 'V�ctor';
    x                NUMBER := 44;
    fechanacimietno  DATE := sysdate;
BEGIN
    dbms_output.put_line(nombre);
    dbms_output.put_line(x);
    dbms_output.put_line(fechanacimietno);
    dbms_output.put_line(nombre
                         || ' '
                         || x
                         || ' '
                         || fechanacimietno);

END;