
/* TAREA 6.1 */ 
CREATE OR REPLACE PROCEDURE CambiarCategoria( id_CategoriaOrigen categorias.cod_categoria%TYPE, id_CategoriaDestino categorias.cod_categoria%TYPE  )
IS
    existe, contador NUMBER;
    origen, destino categorias.nombre%TYPE;
BEGIN

    IF id_CategoriaOrigen = id_CategoriaDestino THEN
        RAISE_APPLICATION_ERROR(-20001, 'Las categorias han de ser diferentes');
    END IF;
	
	SELECT COUNT(*) INTO existe FROM categorias WHERE cod_categoria = id_CategoriaDestino;
    IF existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La categoria DESTINO '||  id_CategoriaDestino||' no existe'); 
    END IF;
	
    SELECT COUNT(*) INTO existe FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
    IF existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'La categoria ORIGEN '||  id_CategoriaOrigen||' no existe'); 
    END IF;

    SELECT COUNT(*) INTO contador FROM productos WHERE cod_categoria = id_CategoriaOrigen;
	IF contador>0 THEN
		SELECT nombre INTO origen FROM categorias WHERE cod_categoria = id_CategoriaOrigen;
		SELECT nombre INTO destino FROM categorias WHERE cod_categoria = id_CategoriaDestino;
		UPDATE productos SET cod_categoria = id_CategoriaDestino WHERE cod_categoria = id_CategoriaOrigen;
		DBMS_OUTPUT.PUT_LINE('Se han cambiado ' || contador || ' PRODUCTOS de la categoría ' || origen || ' a la categoría ' || destino);
    ELSE 
		DBMS_OUTPUT.PUT_LINE('NO se han cambiado PRODUCTOS de la categoría ' || origen || ' a la categoría ' || destino);
	END IF;
    COMMIT;
END;
/


/* TAREA 6.2 */ 
CREATE OR REPLACE TRIGGER validaciones AFTER INSERT OR UPDATE ON PRODUCTOS
FOR EACH ROW
BEGIN
      IF (LENGTH(:new.cod_producto)>10) THEN
        RAISE_APPLICATION_ERROR(-20004,'La longitud del codigo deber menor de 10 digitos');
      END IF;
      IF ( :new.iva NOT IN (4,10,21) ) THEN
        RAISE_APPLICATION_ERROR(-20005,'El IVA de los productos tiene que ser 4, 10 o 21'); 
      END IF;
      IF ( :new.preciooferta IS NULL and :new.preciooferta >= :new.precio ) THEN
        RAISE_APPLICATION_ERROR(-20006,'El precio de la oferta ha de ser inferior al precio normal del producto');
      END IF;
      IF ( :new.cod_categoria > 50 AND (:new.preciooferta IS NOT NULL OR :new.preciooferta <> 0 OR :new.iva <> 21 ) THEN 
          RAISE_APPLICATION_ERROR(-20007,'El producto no puede tener precio de oferta y su iva ha de ser del 21');
      END IF;
      IF ( :new.cod_categoria <= 50 and ( :new.iva NOT IN (4,10) OR :new.peso >= 30 ) THEN 
          RAISE_APPLICATION_ERROR(-20008,'Los productos de categoria menor o igual a 50, han de tener IVA del 4 o 10 un peso inferior a 30');
      END IF;
      IF ( :new.cod_categoria IS NULL or :new.precio IS NULL) THEN 
        RAISE_APPLICATION_ERROR(-20009,'La categoria y el precio de los productos es obligatorio');
      END IF;
END;
