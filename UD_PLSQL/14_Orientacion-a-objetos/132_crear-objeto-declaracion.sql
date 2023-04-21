create or replace TYPE PRODUCTO  AS OBJECT (

--Atributos
codigo number,
nombre varchar2(100),
precio number,

--Métodos
MEMBER FUNCTION ver_producto RETURN VARCHAR2 ,
MEMBER FUNCTION ver_precio  RETURN NUMBER,
MEMBER PROCEDURE cambiar_precio(pvp number)
);