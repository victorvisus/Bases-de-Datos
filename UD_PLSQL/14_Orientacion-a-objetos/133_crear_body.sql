create or replace TYPE body PRODUCTO  AS

    MEMBER FUNCTION ver_producto RETURN VARCHAR2 as 
    begin
        return nombre||' '||precio;
    
    end ver_producto;
    
    MEMBER FUNCTION ver_precio  RETURN NUMBER as
    begin
      return precio;
    end ver_precio;
    
    MEMBER PROCEDURE cambiar_precio(precio number) as
    begin
      self.precio:=precio;
    end cambiar_precio;
    
    MEMBER PROCEDURE mayus AS
    BEGIN
        nombre := UPPER(nombre);
    END mayus;
end;
/