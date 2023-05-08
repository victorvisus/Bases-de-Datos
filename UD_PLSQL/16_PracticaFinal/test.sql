SET SERVEROUT ON
DECLARE
BEGIN
/*
    gest_facturas.alta_factura(20, '05-03-2022', 'Esta es la descripción');
    gest_facturas.alta_factura(21, '10-04-2022', 'Esta es la descripción');
    gest_facturas.alta_factura(22, '25-04-2022', 'Esta es la descripción');
*/

    gest_facturas.baja_factura(21);
    gest_facturas.baja_factura(22);

    --gest_facturas.baja_factura(10);
    
/*
    gest_facturas.mod_descri(21, 'nueva descripción');
    gest_facturas.mod_fecha(20, '25-02-2022');
  */  
    --dbms_output.put_line('Existen ' || gest_facturas.num_facturas('01/02/2022','15/02/2022') || ' facturas');
END;
/
DELETE FROM facturas WHERE cod_factura = 20;
SELECT * FROM facturas;
SELECT * FROM lineas_facturas;
SELECT * FROM control_log;
SELECT COUNT(cod_factura) FROM facturas WHERE cod_factura = 20;

select * from productos;
