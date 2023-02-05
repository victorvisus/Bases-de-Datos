/**
1. Práctica adicional Variables y Constantes
Queremos calcular el impuesto de un producto
- El impuesto será del 21%. Le debemos poner en una constante
- Creamos una variable de tipo number (5,2) para poner el precio del producto
- Creamos otra variable para el resultado. Le decimos que es del mismo tipo (type)
que la anterior
- Hacemos el cálculo y visualizamos el resultado.
**/

SET SERVEROUTPUT ON;

DECLARE
    iva CONSTANT NUMBER := 21;
    precio NUMBER(5,2);
    res precio%TYPE;

BEGIN

    precio := 87.5;
    res := (precio * (iva / 100)) + precio;
    
    DBMS_OUTPUT.PUT_LINE(res);


END;