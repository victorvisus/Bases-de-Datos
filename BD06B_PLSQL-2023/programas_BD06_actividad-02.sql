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

/*	La longitud de la clave de un art�culo no puede ser superior a 10 d�gitos. */
DECLARE
    cod NUMBER(20);
BEGIN
dbms_output.put_line('antes');

    cod := 91234567890;
    dbms_output.put_line(cod);
    dbms_output.put_line(LENGTH(cod));
    
    IF LENGTH(cod) > 10 THEN
        RAISE_APPLICATION_ERROR(-20150, 'La longitud de la clave del producto no puede tener m�s de 10 d�gitos');
    ELSE
        INSERT INTO  productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva)
            VALUES(cod,10,'Atornillador','Sirve atornillar',25,20,1,1,10);
        dbms_output.put_line('Producto insertado correctamente');
    END IF;
END;
/

/*	El IVA de un art�culo debe tener valor 4, 10 o 21. No puede haber productos 
con IVA nulo o vac�o. */
DECLARE
    iva productos.iva%TYPE;
BEGIN
    iva := 21;
    
    IF iva NOT IN(4,10,21) THEN
        RAISE_APPLICATION_ERROR(-20151, 'El IVA debe ser 4, 10 o 21%');
    ELSE
        INSERT INTO  productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva)
            VALUES(365698,53,'Canteadora','Sirve cepillar la superficio de tablas y tableros',528,500,1,35,iva);
            
        dbms_output.put_line('Producto insertado correctamente');
    END IF;

END;
/

/*	El precioOferta de un art�culo, si lo tiene, ha de ser menor al precio 
normal del art�culo. */
DECLARE
    pvp productos.precio%TYPE;
    pvdto productos.preciooferta%TYPE;

BEGIN
    pvp := 180;
    pvdto := 150;
    
    IF pvdto IS NULL OR pvdto < pvp THEN
        INSERT INTO  productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva)
            VALUES(968579,23,'Cepilladora electrica','Sirve cepillar la superficio de tablas y tableros a mano',pvp,pvdto,1,1,21);            

        dbms_output.put_line('Producto insertado correctamente');
    ELSE
        RAISE_APPLICATION_ERROR(-20152, 'El precio de oferta debe ser menor que el PVP');
    END IF;
END;
/

/*	Si un art�culo tiene categor�a superior a 50 no puede tener precioOferta
y debe tener un IVA del 21. */
DECLARE
    cat productos.cod_categoria%TYPE;
    pvOferta productos.preciooferta%TYPE;
    iva productos.iva%TYPE;
    
    catNom categorias.nombre%TYPE;
BEGIN

    cat := 65;
    pvOferta := NULL;
    iva := 21;
    
    dbms_output.put_line('1');
    SELECT nombre INTO catNom FROM categorias WHERE cod_categoria = cat;
    dbms_output.put_line('2');
    IF cat > 50 THEN
    dbms_output.put_line('3');
        IF pvoferta IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20153, 'Los productos con categoria "' || catNom || '" no pueden estar en Oferta');
        ELSIF iva <> 21 THEN
            RAISE_APPLICATION_ERROR(-20154, 'Los productos con categoria "' || catNom || '" deben tener un IVA del 21%');
        ELSE
            INSERT INTO  productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva)
                VALUES(659423,cat,'Clavadora a pilas','Sirve clavar cosas',200,pvOferta,1,1,iva);            

            dbms_output.put_line('Producto insertado correctamente');
        END IF;
    END IF;
END;
/

/*	Si un art�culo tiene categor�a inferior o igual a 50 puede tener precioOferta,
puede tener un IVA del 4 o del 10 y su peso debe ser inferior a 30. */
DECLARE

BEGIN
    NULL;
END;
/





