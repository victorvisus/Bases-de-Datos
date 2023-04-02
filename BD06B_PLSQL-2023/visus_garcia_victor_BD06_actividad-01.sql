-- Tarea 6 -- 1º DAM Bases de Datos --------------------------------------------

/*******************************************************************************
1. Actividad 1 -----------------------------------------------------------------
Crear un procedimiento que permita cambiar todos los artículos de una categoría 
determinada (categoría origen) a otra categoría (categoría destino).

    -	El procedimiento tendrá la siguiente cabecera:
    CambiarCategoria( id_CategoriaOrigen, id_CategoriaDestino ), donde cada uno 
    de los argumentos corresponde a un identificador de categoría. Cambiará la 
    columna Identificador de categoría de todos los artículos, de la tabla ARTICULOS,
    que pertenecen a la categoría con código id_CategoriaOrigen por el código
    id_CategoriaDestino
    
    -	Previo a realizar el cambio se deberá de comprobar que ambas categorías 
    existen y que no son iguales.
    
    -	Para la comprobación de la existencia de las categorías se puede utilizar
    un cursor variable, o contar el número de filas y en caso de que no exista, 
    se mostrará el mensaje correspondiente mediante una excepción del tipo
    RAISE_APPLICATION_ERROR. También se mostrará un mensaje en caso de que ambos
    argumentos tengan el mismo valor.         
    
    -	Si se realizEl procedimiento mostrará el mensaje "Se han trasladado XXX 
    ARTICULOS de la categoría XXXXXX a la categoría ZZZZZZ" donde XXX es el número
    de artículos que se han cambiado de categoría, XXXXXX es el nombre de la 
    categoría origen y ZZZZZZ es el nombre de la categoría destino.

*******************************************************************************/

/* Pasos:
1º Crear la cabecera del procedimiento, CREATE OR REPLACE PROCEDURE nombvre(parametro, parametro)
2º Declarar las variables necesarias ( ir haciendolo conforme sea necesario )
    No se usa el bloque DECLARE
3º Controlar los requerimientos y lanzar las excepciones necesarias
    - ERROR 1 : Las dos categorias, pasadas por argumentos, son iguales.
    - ERROR 2 : La categoria Origen no existe.
    - ERROR 3 : La Categoria Destino no existe.
4º Mostrar mensaje de ejecuciónb satisfactoria

--------------------------------------------------------------- ANOTACIONES ----
- OJO - LAS TABLAS NO CONTIENE DATOS, no se ha facilitado ninguno en la tarea --
- OJO - La tabla ARTICULOS, indicada en el enunciado NO EXISTE, entiendo que se
refiere a la tabla PRODUCTOS ---------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE CambiarCategoria(
    id_CategoriaOrigen categorias.cod_categoria%TYPE,
    id_CategoriaDestino categorias.cod_categoria%TYPE)
AS

    numFilas NUMBER(10); --La uso para almacenar el número de filas, si existen

    -- Almacena los Nombres de las Categorias
    nombreCategoriaOrigen categorias.nombre%TYPE;
    nombreCategoriaDestino categorias.nombre%TYPE;
    -- Num. articulos movidos
    numArticulos NUMBER(10);

BEGIN
    
    -- La Categoria Origen No existe
    SELECT COUNT(*) INTO numFilas FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    IF numFilas = 0 THEN
        RAISE_APPLICATION_ERROR(-20531, 'La Categoria Origen no existe');    
    END IF;
    
    -- La Categoria Destino No existe
    SELECT COUNT(*) INTO numFilas FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    IF numFilas = 0 THEN
        RAISE_APPLICATION_ERROR(-20532, 'La Categoria Destino no existe');    
    END IF;
    
    -- Ambas categorias NO pueden ser iguales
    IF id_CategoriaOrigen = id_CategoriaDestino THEN
        RAISE_APPLICATION_ERROR(-20530, 'Las Categorias facilitadas son las mismas');
    END IF;    

/*
    -- Comprueba que haya productos en la categoria indicada.
    SELECT COUNT(*) INTO numArticulos FROM productos WHERE cod_categoria = id_CategoriaOrigen;
    IF numArticulos = 0 THEN
        RAISE_APPLICATION_ERROR(-20533, 'No existen productos que mover');
    END IF;
*/

    --Guardo los nombres de las categorias, pasadas por parametros
    SELECT nombre INTO nombreCategoriaOrigen FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    SELECT nombre INTO nombreCategoriaDestino FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    --Guardo el número de productos a modificar
    SELECT COUNT(*) INTO numArticulos FROM productos WHERE cod_categoria = id_CategoriaOrigen;
    
    -- Se realizan los cambios
    UPDATE productos SET cod_categoria = id_CategoriaDestino WHERE cod_categoria = id_CategoriaOrigen;
    dbms_output.put_line('Se han trasladado ' || numArticulos || ' ARTICULOS de la categoría ' || nombreCategoriaOrigen || ' a la categoría ' ||  nombreCategoriaDestino);

END;
/



/**
INSERT INTO categorias VALUES(10, 'Herramienta manual', 'Herramienta para uso manual', 000);
INSERT INTO categorias VALUES(23, 'Herramienta de taller', 'Herramienta para uso en taller', 010);
INSERT INTO categorias VALUES(53, 'Maquinaria de taller', 'Maquinaria fija en algun lugar de tu talle', 002);
INSERT INTO categorias VALUES(65, 'Herramienta electrica de mano', 'Herramienta a bateria o enchufada a la red eléctrica', 100);

INSERT INTO productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva) VALUES(0123456789,10,'Martillo','Sirve para golpear',15,10,1,1,4);
INSERT INTO productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva) VALUES(1234567890,23,'Disco de corte','Sirve hacer cortes en tableros',150,100,1,27,10);
INSERT INTO productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva) VALUES(2345678901,53,'Mesa de corte','Sirve hacer cortes en tableros',250,NULL,1,2,21);
INSERT INTO productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva) VALUES(3456789012,65,'Clavadora a baterias','Sirve para clavar',89,NULL,1,3,21);
**/