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
    --Creo el objeto TYPE RECORD
    TYPE contador_record IS RECORD (
        tipo VARCHAR2(10),
        nomCat categorias.nombre%TYPE,
        numRows NUMBER(3),
        numArticulos NUMBER(3)
    );
    --Declaramos un objeto TYPE Array Asociativo
    TYPE contador IS TABLE OF
        contador_record
    INDEX BY PLS_INTEGER;
    --Creamos el Array
    informacionCategorias contador;

BEGIN
    -- Añado el num de filas que tiene en productos la categoria ORIGEN al Array
    informacionCategorias(1).tipo := 'origen';
    SELECT COUNT(*) INTO informacionCategorias(1).numRows FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    
    -- Añado el num de filas que tiene en productos la categoria DESTINO al Array
    informacionCategorias(2).tipo := 'destino';
    SELECT COUNT(*) INTO informacionCategorias(2).numRows FROM categorias WHERE cod_categoria = id_CategoriaDestino;

    CASE
        -- La Categoria Origen No existe ---------------------------------------
        WHEN informacionCategorias(1).numRows = 0 THEN
            RAISE_APPLICATION_ERROR(-20531, 'La Categoria Origen no existe');

        -- La Categoria Destino No existe --------------------------------------
        WHEN informacionCategorias(2).numRows = 0 THEN
            RAISE_APPLICATION_ERROR(-20532, 'La Categoria Destino no existe');
            
        -- Ambas categorias NO pueden ser iguales ------------------------------
        WHEN id_CategoriaOrigen = id_CategoriaDestino THEN
            RAISE_APPLICATION_ERROR(-20530, 'Las Categorias facilitadas son las mismas');

        ELSE
            -- Se realizan los cambios -----------------------------------------
                    
            -- Guardo el número de productos de Origen, para usarlo en el msg
            SELECT COUNT(*) INTO informacionCategorias(1).numArticulos FROM productos WHERE cod_categoria = id_CategoriaOrigen;
            -- Guardo el nombre de la Categoria Origen, para usarlo en el msg
            SELECT nombre INTO informacionCategorias(1).nomCat FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
            -- Guardo el nombre de la Categoria Destino, para usarlo en el msg
            SELECT nombre INTO informacionCategorias(2).nomCat FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    
            UPDATE productos SET cod_categoria = id_CategoriaDestino WHERE cod_categoria = id_CategoriaOrigen;
            
            dbms_output.put_line('Se han trasladado ' || informacionCategorias(1).numArticulos || ' ARTICULOS de la categoría ' || informacionCategorias(1).nomCat || ' a la categoría ' ||  informacionCategorias(2).nomCat);
    END CASE;

END CambiarCategoria;
/

/*
EXECUTE CambiarCategoria( 10, 53 );
/
*/