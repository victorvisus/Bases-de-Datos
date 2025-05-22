-- VARRAYS
/*
- Son Arrays que empiezan en una posición y pueden tener hasta n posiciones, siendo n el número máximo de tamaño
- Se tiene acceso via posición, no hay clave-valor
- Contienen un elemento de un tipo
- Las posiciones se "llenan" de manera ordenada, son arrays densos
*/

TYPE nombre IS VARRAY (num_elementos) OF tipo

--se crea una variable
nombre nombre;

/*
- No se pueden borrar elementos, por ser arrays densos
- Se puede extender: puedo rellenar, por ejemplo 10 posiciones de un array de 200,
e ir llenando posiciones pero sin superar el tamaño del array
- Se pueden usar como columnas de una tabla
*/

SET SERVEROUTPUT ON;
DECLARE
    TYPE V1 IS VARRAY(50) OF VARCHAR2(100);
    
    --Primero hay que inicializar el varray, para ello se usa el constructor
    --Aqui le estamos dando contenido para 3 posiciones del VArray
    var1 V1 := V1('Adios', 'hola', 'tercero');
BEGIN
    dbms_output.put_line(var1(1));
    
    var1(1) := 'Hola';
    dbms_output.put_line(var1(1));
    
    dbms_output.put_line(var1(3));
    
    --Para añadir más valores/posiciones hay que extender el varray
    dbms_output.put_line('Núm posiciones ' || var1.COUNT());
    dbms_output.put_line('Limite ' || var1.LIMIT());
    
    var1.EXTEND();
    dbms_output.put_line('Núm posiciones después de EXTEND ' || var1.COUNT());
    
    --Argumento para poner a EXTEND el num. de elementos que quiero añadir
    var1.EXTEND(5);
    dbms_output.put_line('Núm posiciones después de EXTEND +5 ' || var1.COUNT());
END;
/