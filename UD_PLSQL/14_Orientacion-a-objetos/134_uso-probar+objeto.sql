--UTILIZACION DE OBJETOS
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
    --declaro el objeto
    v1 producto;
    
    CURSOR c_lista IS SELECT * FROM auditoria;
    v_lista auditoria%ROWTYPE;
BEGIN
    --instancio/creo el objeto
    v1 := producto('manzanas');
    
    --Ejecuto el método "ver_precio"
    dbms_output.put_line('Cod. ' || v1.ver_codigo());
    dbms_output.put_line('Precio ' || v1.ver_precio());
    dbms_output.put_line('Nombre ' || v1.ver_producto());
    
    v1.cambiar_precio(20);
    dbms_output.put_line('nuevo precio: ' || v1.ver_precio());
    
    v1.mayus();
    dbms_output.put_line(v1.ver_producto());
    
    v1.nombre := 'pera';
    dbms_output.put_line(v1.ver_producto());
    --Esto se puedo porque el atributo nombre es público
    
    --Probamos el método static
    --v1.auditoria();
    -- no se puede usar poniendo el nombre de la instancia del objeto producto, hay que usar la clase
    producto.auditoria();
    
--    FOR i IN (SELECT * FROM auditoria) LOOP
--        dbms_output.put_line(i.usuario || ' ' || i.fecha);
--    END LOOP;
    
    OPEN c_lista;
    LOOP
        FETCH c_lista INTO v_lista;
        EXIT WHEN c_lista%NOTFOUND;
        dbms_output.put_line(v_lista.usuario || ' ' || v_lista.fecha);
    END LOOP;
END;
/

DROP SEQUENCE seq1;
CREATE SEQUENCE seq1;