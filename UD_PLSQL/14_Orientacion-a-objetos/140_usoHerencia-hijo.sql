--OBJETO HIJO
CREATE OR REPLACE TYPE comestibles UNDER producto(
    caducidad DATE,
    
    MEMBER FUNCTION ver_caducidad RETURN VARCHAR2,
    
     --Sobreescribir una funcion del padre
     OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY comestibles AS

    MEMBER FUNCTION ver_caducidad RETURN VARCHAR2 AS
    BEGIN
        return caducidad;
    END ver_caducidad;
    
    OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER AS
    BEGIN
        return precio + 10;
    END;
END;
/

DECLARE
    v1 comestibles := comestibles(900, 'tornillos', 20, sysdate());
BEGIN
    dbms_output.put_line(v1.ver_precio());
    dbms_output.put_line(v1.ver_precio(10));
    dbms_output.put_line(v1.ver_caducidad());

END;