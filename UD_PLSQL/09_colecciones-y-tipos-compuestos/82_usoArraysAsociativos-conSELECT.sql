-- SELECTs multiples con arrays asociativos
-- Como manejar más de una fila con Array asociativos
/* Para esto es mejor hacerlo con Cursores, con el Array se carga la memoria, son
más adecuados para guardar pequeña cantidad de filas */

SET SERVEROUTPUT ON;

DECLARE
    --Declaramos un objeto TYPE Array Asociativo
    TYPE departamentos IS TABLE OF
        departments%ROWTYPE
    INDEX BY PLS_INTEGER;
    
    --Creamos el objeto
    depts departamentos;

BEGIN
    --Hacemos un bucle del 1 al 10 y mediante un SELECT lo almacena en el Array
    FOR i IN 1..10 LOOP
        SELECT * INTO depts(i) FROM departments WHERE department_id = i * 10; --Ponemos * 10 ya que el id del dpto, va cada 10
    END LOOP;
    
    --Mediante un FOR imprime todas las posiciones del Array, desde FIRST hasta LAST
    FOR i IN depts.FIRST..depts.LAST LOOP
        dbms_output.put_line(depts(i).department_name);
    END LOOP;
END;
/