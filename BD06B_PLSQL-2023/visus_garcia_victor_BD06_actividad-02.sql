-- Tarea 6 -- 1º DAM Bases de Datos --------------------------------------------

/*******************************************************************************
2. Actividad 2 -----------------------------------------------------------------
Queremos controlar algunas restricciones a la hora de trabajar con artículos:

    -	La longitud de la clave de un artículo no puede ser superior a 10 dígitos.
    
    -	El IVA de un artículo debe tener valor 4, 10 o 21. No puede haber productos 
    con IVA nulo o vacío.
    
    -	El precioOferta de un artículo, si lo tiene, ha de ser menor al precio 
    normal del artículo.
    
    -	Si un artículo tiene categoría superior a 50 no puede tener precioOferta
    y debe tener un IVA del 21.
    
    -	Si un artículo tiene categoría inferior o igual a 50 puede tener 
    precioOferta, puede tener un IVA del 4 o del 10 y su peso debe ser inferior
    a 30.
    
    -	Todos los artículos deben pertenecer a una categoría y deben tener un 
    precio.

Se pide crear un disparador para asegurar estas restricciones. El disparador deberá
lanzar todos los errores que se puedan producir en su ejecución mediante errores
que identifiquen con un mensaje adecuado por qué se ha producido dicho error.

Algunas de las restricciones implementadas con el disparador se pueden incorporar 
a la definición del esquema de la tabla utilizando el Lenguaje de Definición de
Datos (Check,Unique,..).Identifica cuáles son y con qué tipo de restricciones las
implementarías.
*******************************************************************************/
CREATE OR REPLACE TRIGGER restriccionesProductos
    BEFORE INSERT OR UPDATE
    ON productos
    FOR EACH ROW
    
BEGIN

    /*	La longitud de la clave de un artículo no puede ser superior a 10 dígitos. */
    IF LENGTH(:new.cod_producto) > 10 THEN
        RAISE_APPLICATION_ERROR(-20150, 'La longitud de la clave del producto no puede tener más de 10 dígitos');
    END IF;
    -- ESTE SE CONTROLA CON RESTRICCIÓN DDL, es más ya esta controlado con el tipo
    -- de dato del atributo cod_categoria NUMBER(10,0) -------------------------

    /*	El IVA de un artículo debe tener valor 4, 10 o 21. No puede haber 
    productos con IVA nulo o vacío. */
    IF :new.iva NOT IN(4,10,21) THEN
        RAISE_APPLICATION_ERROR(-20151, 'El IVA debe ser 4, 10 o 21%');
    END IF;
    -- Se controla en DDL, con un CHECK (IVA = 21 OR IVA = 10 OR IVA = 4) ------

    /*	El precioOferta de un artículo, si lo tiene, ha de ser menor al precio 
    normal del artículo. */
    IF :new.precioOferta IS NOT NULL THEN
        IF :new.precio < :new.precioOferta THEN
            RAISE_APPLICATION_ERROR(-20152, 'El precio de oferta debe ser menor que el PVP');
        END IF;
    END IF;
    -- Se controla en DDL, con un CHECK (precioOferta < precio)
    
    /*	Si un artículo tiene categoría superior a 50 no puede tener precioOferta
    y debe tener un IVA del 21. */
    IF :new.cod_categoria > 50 THEN
        IF :new.precioOferta IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20153, 'Los productos con ID de categoria superior a 50 no pueden estar en Oferta');
        ELSIF :new.iva <> 21 THEN
            RAISE_APPLICATION_ERROR(-20154, 'Los productos con ID de categoria superior a 50 deben tener un IVA del 21%');
        END IF;
    END IF;
    -- NO se puede controlar con DDL -------------------------------------------
    
    /*	Si un artículo tiene categoría inferior o igual a 50 puede tener ( O NO )
    precioOferta, puede tener un IVA del 4 o del 10 ( NO DEL 21 ) y su peso debe
    ser inferior a 30. */
    IF (:new.cod_categoria <= 50) AND (:new.iva = 21) THEN
        RAISE_APPLICATION_ERROR(-20155, 'Los productos con ID de categoria inferior (o igual) a 50 NO pueden tener IVA del 21%');
    ELSIF (:new.cod_categoria <= 50) AND (:new.peso >= 30) THEN
        RAISE_APPLICATION_ERROR(-20156, 'Los productos con ID de categoria inferior (o igual) a 50 el peso debe ser inferior a 30Kg');
    END IF;
    -- NO se puede controlar con DDL -------------------------------------------

    /*	Todos los artículos deben pertenecer a una categoría y deben tener un 
    precio. */
    IF (:new.cod_categoria IS NULL) OR (:new.precio IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20157, 'Todos los productos deben tener una Categoría y un Precio');
    END IF;
    -- Se controla con DDL añadiendo una restricción NOT NULL a los atributos correspondientes
END;
/
