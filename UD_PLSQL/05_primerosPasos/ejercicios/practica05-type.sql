-- %TYPE: nos permite crear una variable que sea del mismo tipo que otra.
/** Sirve para decir a una variable que es del mismo tipo de la columna de una
tabla, de la cual no se sabe exactamente que tipo tiene esa columna **/

DECLARE
    x NUMBER;
    z x%TYPE;
    -- Le estamos diciendo que la variable z es del mismo tipo que la variable x
    
    emple employees.salary%TYPE;
    -- Le estamos diciendo que la variable empleado es del mismo tipo del que tiene la columna salary de la tabla employees
BEGIN
    emple := 100;
END;