-- Trabajar con OBJETOS
/**
Oracle no es una base de datos orientada a Objetas, pero a lo largo del tiempo
ha ido incorporanto funcionalidades para trabajar con estas caracteristica.
Oracle no es de forma nativa una base de datos orientada a Obetos

- Un Objeto se crea a través de una Clase (Plantilla) que define sus características
- A través de la clase (Plantilla) podré instanciar varios objetos
- Una clase tiene atributos y métodos (funciones) que estan integradas dentro del propio objeto
- Tienen muchas similitudes con los paquetes.
- Tiene caracteristicas como el polimorfismo, herencia, encapsulación, etc...
- Las funciones/metodos, pueden ser de tipo MEMBER, STATIC, CONSTRUCTOR
- Lo ideal es que tenga setter y getters, para poder cambiar y coger atributos del objeto

Un objeto tiene una cabecera y un body
- En la cabecera se declaran las variable y las funciones
- En el body
**/

--Se declara el objeto, con la cabecera
CREATE OR REPLACE TYPE empleado AS OBJECT(
    --Atributos
    nombre VARCHAR2(100),
    apellidos VARCHAR2(100),
    edad NUMBER,
    
    --Métodos
    MEMBER FUNCTION ver_nombre RETURN VARCHAR2,
    MEMBER FUNCTION ver_edad RETURN NUMBER
);
--Creamos el BODY
CREATE OR REPLACE TYPE BODY empleado AS

    MEMBER FUNCTION ver_nombre RETURN VARCHAR2
    IS
    BEGIN
        RETURN nombre;
    END ver_nombre;
    
    MEMBER FUNCTION ver_edad RETURN VARCHAR2
    IS
    BEGIN
        RETURN edad;
    END ver_edad;
END;
/

/**
Como puedo utilizar esto:
- Como columna de una tabla
- Con PL/SQL puro
**/
SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;
DECLARE
    --Se crea una instancia del objeto, con su constructor (como en JAVA)
    v1 empleado := empleado('pepe','rodriguez',89);
BEGIN
    --Para llamar a las propiedades o a sus metodos se hace con punto+nombre_metodo
    dbms_output.put_line(v1.ver_nombre());
END;
/