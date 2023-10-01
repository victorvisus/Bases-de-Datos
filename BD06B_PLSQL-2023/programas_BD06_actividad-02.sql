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

/*	La longitud de la clave de un artículo no puede ser superior a 10 dígitos. */
DECLARE
    cod NUMBER(20);
BEGIN
dbms_output.put_line('antes');

    cod := 91234567890;
    dbms_output.put_line(cod);
    dbms_output.put_line(LENGTH(cod));
    
    IF LENGTH(cod) > 10 THEN
        RAISE_APPLICATION_ERROR(-20150, 'La longitud de la clave del producto no puede tener más de 10 dígitos');
    ELSE
        INSERT INTO  productos(cod_producto,cod_categoria,nombre,descripcion,precio,preciooferta,activado,peso,iva)
            VALUES(cod,10,'Atornillador','Sirve atornillar',25,20,1,1,10);
        dbms_output.put_line('Producto insertado correctamente');
    END IF;
END;
/

/*	El IVA de un artículo debe tener valor 4, 10 o 21. No puede haber productos 
con IVA nulo o vacío. */
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

/*	El precioOferta de un artículo, si lo tiene, ha de ser menor al precio 
normal del artículo. */
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

/*	Si un artículo tiene categoría superior a 50 no puede tener precioOferta
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

/*	Si un artículo tiene categoría inferior o igual a 50 puede tener precioOferta,
puede tener un IVA del 4 o del 10 y su peso debe ser inferior a 30. */
DECLARE

BEGIN
    NULL;
END;
/





