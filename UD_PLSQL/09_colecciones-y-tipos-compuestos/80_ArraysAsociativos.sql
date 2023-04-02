--Colecciones - Arrays Asociativos
/**
Se diferencia en que el RECORD solo almacena una fila, en cambio una coleccion
almacena objetos del mismo tipo, son más parecidos a los arrays en lenguaje de
programación.
Tenemos tres tipos de colecciones:
- Arrays asociativos
- Nested tables
- VArrays
**/

/**
ARRAYS ASOCIATIVOS o INDEX BY tables
-- Son colecciones PL/SQL con dos columnas
    - Clave primaria de tipo entero (PLS_INTEGER) o cadena (STRING - VARCHAR2)
    - Valores: un tipo que puede ser escalar (variable simple), o RECORD

-- Sintaxis
    TYPE nombreArray IS TABLE OF
        columna datos
        INDEX BY PLS_INTEGER | BINARY_INTEGER | VARCHAR2(x);
        
    nombreVariable nombreArray
    
    -Ejemplo:
        TYPE departamentos IS TABLE OF
            departments.department_name%TYPE
            INDEX BY PLS_INTEGER;
        
        depts departamentos;
        
-- Acceso al Array
    - Para acceder se usa:
        nombreArray(x); donde x es la posición a la que queremos acceder.
    - Si es de un tipo completo:
        nombreArray(x).nombreCampo;

-- Métodos de los arrays
    - EXIST(N)  : Detectar si existe un elemento
    - COUNT     : Número de elementos que contiene
    - FIRST     : Devuelve el índice más pequeño
    - LAST      : Devuelve el índice más alto
    - PRIOR(N)  : Devuelve el índice anterior a N
    - NEXT(N)   : Devuelve el índice posterior a N
    - DELETE    : Borra todo
    - DELETE(N) : Borra el índice N
    - DELETE(M,N) : Borra de los índices M a N
**/

DECLARE
    --Tipo SIMPLE
    TYPE departamentos IS TABLE OF
        departments.department_name%TYPE
        INDEX BY PLS_INTEGER;

    --Tipo COMPUESTO
    TYPE empleados IS TABLE OF
        employees%ROWTYPE
        INDEX BY PLS_INTEGER;
        
    depts departamentos;
    empls empleados;

BEGIN
    -- Tipo SIMPLE
    depts(1) := 'informatica';
    depts(2) := 'rrhh';
    
    dbms_output.put_line(depts(1));
    dbms_output.put_line(depts(2));
    
    -- Tipo COMPUESTO
    SELECT * INTO empls(1) FROM employees WHERE employee_id = 100;
    
    dbms_output.put_line(empls(1).first_name);
END;
/



