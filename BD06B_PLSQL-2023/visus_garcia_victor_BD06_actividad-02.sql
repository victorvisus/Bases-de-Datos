-- Tarea 6 -- 1� DAM Bases de Datos --------------------------------------------

/*******************************************************************************
2. Actividad 2 -----------------------------------------------------------------
Queremos controlar algunas restricciones a la hora de trabajar con art�culos:

    -	La longitud de la clave de un art�culo no puede ser superior a 10 d�gitos.
    
    -	El IVA de un art�culo debe tener valor 4, 10 o 21. No puede haber productos 
    con IVA nulo o vac�o.
    
    -	El precioOferta de un art�culo, si lo tiene, ha de ser menor al precio 
    normal del art�culo.
    
    -	Si un art�culo tiene categor�a superior a 50 no puede tener precioOferta
    y debe tener un IVA del 21.
    
    -	Si un art�culo tiene categor�a inferior o igual a 50 puede tener 
    precioOferta, puede tener un IVA del 4 o del 10 y su peso debe ser inferior
    a 30.
    
    -	Todos los art�culos deben pertenecer a una categor�a y deben tener un 
    precio.

Se pide crear un disparador para asegurar estas restricciones. El disparador deber�
lanzar todos los errores que se puedan producir en su ejecuci�n mediante errores
que identifiquen con un mensaje adecuado por qu� se ha producido dicho error.

Algunas de las restricciones implementadas con el disparador se pueden incorporar 
a la definici�n del esquema de la tabla utilizando el Lenguaje de Definici�n de
Datos (Check,Unique,..).Identifica cu�les son y con qu� tipo de restricciones las
implementar�as.
*******************************************************************************/
CREATE OR REPLACE TRIGGER restriccionesProductos
    BEFORE INSERT OR UPDATE
    ON productos
    FOR EACH ROW
    
BEGIN

    /*	La longitud de la clave de un art�culo no puede ser superior a 10 d�gitos. */
    IF LENGTH(:new.cod_producto) > 10 THEN
        RAISE_APPLICATION_ERROR(-20150, 'La longitud de la clave del producto no puede tener m�s de 10 d�gitos');
    END IF;
    -- ESTE SE CONTROLA CON RESTRICCI�N DDL, es m�s ya esta controlado con el tipo
    -- de dato del atributo cod_categoria NUMBER(10,0) -------------------------

    /*	El IVA de un art�culo debe tener valor 4, 10 o 21. No puede haber 
    productos con IVA nulo o vac�o. */
    IF :new.iva NOT IN(4,10,21) THEN
        RAISE_APPLICATION_ERROR(-20151, 'El IVA debe ser 4, 10 o 21%');
    END IF;
    -- Se controla en DDL, con un CHECK (IVA = 21 OR IVA = 10 OR IVA = 4) ------

    /*	El precioOferta de un art�culo, si lo tiene, ha de ser menor al precio 
    normal del art�culo. */
    IF :new.precioOferta IS NOT NULL THEN
        IF :new.precio < :new.precioOferta THEN
            RAISE_APPLICATION_ERROR(-20152, 'El precio de oferta debe ser menor que el PVP');
        END IF;
    END IF;
    -- Se controla en DDL, con un CHECK (precioOferta < precio)
    
    /*	Si un art�culo tiene categor�a superior a 50 no puede tener precioOferta
    y debe tener un IVA del 21. */
    IF :new.cod_categoria > 50 THEN
        IF :new.precioOferta IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20153, 'Los productos con ID de categoria superior a 50 no pueden estar en Oferta');
        ELSIF :new.iva <> 21 THEN
            RAISE_APPLICATION_ERROR(-20154, 'Los productos con ID de categoria superior a 50 deben tener un IVA del 21%');
        END IF;
    END IF;
    -- NO se puede controlar con DDL -------------------------------------------
    
    /*	Si un art�culo tiene categor�a inferior o igual a 50 puede tener ( O NO )
    precioOferta, puede tener un IVA del 4 o del 10 ( NO DEL 21 ) y su peso debe
    ser inferior a 30. */
    IF (:new.cod_categoria <= 50) AND (:new.iva = 21) THEN
        RAISE_APPLICATION_ERROR(-20155, 'Los productos con ID de categoria inferior (o igual) a 50 NO pueden tener IVA del 21%');
    ELSIF (:new.cod_categoria <= 50) AND (:new.peso >= 30) THEN
        RAISE_APPLICATION_ERROR(-20156, 'Los productos con ID de categoria inferior (o igual) a 50 el peso debe ser inferior a 30Kg');
    END IF;
    -- NO se puede controlar con DDL -------------------------------------------

    /*	Todos los art�culos deben pertenecer a una categor�a y deben tener un 
    precio. */
    IF (:new.cod_categoria IS NULL) OR (:new.precio IS NULL) THEN
        RAISE_APPLICATION_ERROR(-20157, 'Todos los productos deben tener una Categor�a y un Precio');
    END IF;
    -- Se controla con DDL a�adiendo una restricci�n NOT NULL a los atributos correspondientes
END;
/
