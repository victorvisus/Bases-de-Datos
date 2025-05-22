--HERENCIA
/*
SE USA LA CLAUSULA    UNDER
PARA QUE SEA HEREDABLE, OL OBJETO O EL MÉTODO DEBE SER 'NOT FINAL'
*/
DROP TYPE PRODUCTO;
DROP TYPE COMESTIBLES;

--CABECERA ---------------------------------------------------------------------
create or replace TYPE PRODUCTO AS OBJECT (

    --Atributos
    codigo number,
    nombre varchar2(100),
    precio number,

    --Métodos
    MEMBER FUNCTION ver_producto RETURN VARCHAR2 ,
    MEMBER FUNCTION ver_precio RETURN NUMBER,
    MEMBER FUNCTION ver_precio(impuestos NUMBER) RETURN NUMBER,
    MEMBER FUNCTION ver_codigo RETURN NUMBER,
    MEMBER PROCEDURE cambiar_precio(precio number),

    MEMBER PROCEDURE mayus,
    
    --Vamos a meter en una tabla de auditoria, el usuario y la fecha en la que se ha lanzado el procedimiento
    STATIC PROCEDURE auditoria,
    
    --CREAR CONSTRUCTOR
    CONSTRUCTOR FUNCTION producto(n1 VARCHAR2) RETURN SELF AS RESULT
) NOT FINAL;
/

--CUERPO - BODY ----------------------------------------------------------------
create or replace TYPE body PRODUCTO  AS

    MEMBER FUNCTION ver_producto RETURN VARCHAR2 as 
    begin
        return codigo ||' '|| nombre||' '||precio;
    
    end ver_producto;
    
    MEMBER FUNCTION ver_precio  RETURN NUMBER as
    begin
      return precio;
    end ver_precio;
    
    MEMBER FUNCTION ver_precio(impuestos NUMBER) RETURN NUMBER AS
    BEGIN
        RETURN precio - precio*impuestos/100;
    END ver_precio;
    
    MEMBER FUNCTION ver_codigo RETURN NUMBER as
    BEGIN
        return codigo;
    END ver_codigo;
    
    MEMBER PROCEDURE cambiar_precio(precio number) as
    begin
      self.precio:=precio;
    end cambiar_precio;
    
    MEMBER PROCEDURE mayus AS
    BEGIN
        nombre := UPPER(nombre);
    END mayus;
    
    --Método STATIC declarado en la cabecera del OBJETO producto.
    --Hace que cuando se instacia un nuevo objeto de la clase producto se inserta un registro en la tabla auditoria
    STATIC PROCEDURE auditoria AS
    BEGIN
        INSERT INTO auditoria VALUES(USER, SYSDATE);
    END auditoria;

    --Método CONSTRUCTOR declarado en la cabecera del OBJETO producto
    --Permite instanciar un objeto de la clase producto pasandole unicamente el atributo nombre
    CONSTRUCTOR FUNCTION producto(n1 VARCHAR2) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.nombre := n1;
        SELF.precio := NULL;
        SELF.codigo := seq1.nextval;
        
        RETURN; --Tiene que devolver algo, devuelve el self, a si mismo
    END producto;
END;
/