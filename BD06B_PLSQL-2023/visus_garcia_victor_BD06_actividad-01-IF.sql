-- Tarea 6 -- 1� DAM Bases de Datos --------------------------------------------

/*******************************************************************************
1. Actividad 1 -----------------------------------------------------------------
Crear un procedimiento que permita cambiar todos los art�culos de una categor�a 
determinada (categor�a origen) a otra categor�a (categor�a destino).

    -	El procedimiento tendr� la siguiente cabecera:
    CambiarCategoria( id_CategoriaOrigen, id_CategoriaDestino ), donde cada uno 
    de los argumentos corresponde a un identificador de categor�a. Cambiar� la 
    columna Identificador de categor�a de todos los art�culos, de la tabla ARTICULOS,
    que pertenecen a la categor�a con c�digo id_CategoriaOrigen por el c�digo
    id_CategoriaDestino
    
    -	Previo a realizar el cambio se deber� de comprobar que ambas categor�as 
    existen y que no son iguales.
    
    -	Para la comprobaci�n de la existencia de las categor�as se puede utilizar
    un cursor variable, o contar el n�mero de filas y en caso de que no exista, 
    se mostrar� el mensaje correspondiente mediante una excepci�n del tipo
    RAISE_APPLICATION_ERROR. Tambi�n se mostrar� un mensaje en caso de que ambos
    argumentos tengan el mismo valor.         
    
    -	Si se realizEl procedimiento mostrar� el mensaje "Se han trasladado XXX 
    ARTICULOS de la categor�a XXXXXX a la categor�a ZZZZZZ" donde XXX es el n�mero
    de art�culos que se han cambiado de categor�a, XXXXXX es el nombre de la 
    categor�a origen y ZZZZZZ es el nombre de la categor�a destino.

*******************************************************************************/

/* Pasos:
1� Crear la cabecera del procedimiento, CREATE OR REPLACE PROCEDURE nombvre(parametro, parametro)
2� Declarar las variables necesarias ( ir haciendolo conforme sea necesario )
    No se usa el bloque DECLARE
3� Controlar los requerimientos y lanzar las excepciones necesarias
    - ERROR 1 : Las dos categorias, pasadas por argumentos, son iguales.
    - ERROR 2 : La categoria Origen no existe.
    - ERROR 3 : La Categoria Destino no existe.
4� Mostrar mensaje de ejecuci�nb satisfactoria

--------------------------------------------------------------- ANOTACIONES ----
- OJO - LAS TABLAS NO CONTIENE DATOS, no se ha facilitado ninguno en la tarea --
- OJO - La tabla ARTICULOS, indicada en el enunciado NO EXISTE, entiendo que se
refiere a la tabla PRODUCTOS ---------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE CambiarCategoriaIF(
    id_CategoriaOrigen categorias.cod_categoria%TYPE,
    id_CategoriaDestino categorias.cod_categoria%TYPE)
AS
    numFilas NUMBER(10); --La uso para almacenar el n�mero de filas, si existen

    -- Almacena los Nombres de las Categorias
    nombreCategoriaOrigen categorias.nombre%TYPE;
    nombreCategoriaDestino categorias.nombre%TYPE;
    -- Num. articulos movidos
    numArticulos NUMBER(10);

BEGIN

    -- La Categoria Origen No existe -------------------------------------------
    SELECT COUNT(*) INTO numFilas FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    IF numFilas = 0 THEN
        RAISE_APPLICATION_ERROR(-20531, 'La Categoria Origen no existe');
    END IF;
    
    -- La Categoria Destino No existe ------------------------------------------
    SELECT COUNT(*) INTO numFilas FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    IF numFilas = 0 THEN
        RAISE_APPLICATION_ERROR(-20532, 'La Categoria Destino no existe');    
    END IF;
    
    -- Ambas categorias NO pueden ser iguales ----------------------------------
    IF id_CategoriaOrigen = id_CategoriaDestino THEN
        RAISE_APPLICATION_ERROR(-20530, 'Las Categorias facilitadas son las mismas');
    END IF;    

    --Guardo los nombres de las categorias, pasadas por parametros
    SELECT nombre INTO nombreCategoriaOrigen FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    SELECT nombre INTO nombreCategoriaDestino FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    --Guardo el n�mero de productos a modificar
    SELECT COUNT(*) INTO numArticulos FROM productos WHERE cod_categoria = id_CategoriaOrigen;
    
    -- Se realizan los cambios -------------------------------------------------
    UPDATE productos SET cod_categoria = id_CategoriaDestino WHERE cod_categoria = id_CategoriaOrigen;
    dbms_output.put_line('Se han trasladado ' || numArticulos || ' ARTICULOS de la categor�a ' || nombreCategoriaOrigen || ' a la categor�a ' ||  nombreCategoriaDestino);

END CambiarCategoriaIF;
/

/*
EXECUTE CambiarCategoriaIF( 53, 10 );
/
*/