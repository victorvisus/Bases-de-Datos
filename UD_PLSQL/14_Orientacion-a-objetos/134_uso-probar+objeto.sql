--UTILIZACION DE OBJETOS
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
    --declaro el objeto
    v1 producto;
BEGIN
    --instancio/creo el objeto
    v1 := producto(100,'manzanas',10);
    
    --Ejecuto el método "ver_precio"
    dbms_output.put_line(v1.ver_precio());
    dbms_output.put_line(v1.ver_producto());
    
    v1.cambiar_precio(20);
    dbms_output.put_line('nuevo precio: ' || v1.ver_precio());
    
    v1.mayus();
    dbms_output.put_line(v1.ver_producto());
    
    v1.nombre := 'pera';
    dbms_output.put_line(v1.ver_producto());
    --Esto se puedo porque el atributo nombre es público
END;
/