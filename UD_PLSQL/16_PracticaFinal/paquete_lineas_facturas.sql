/*******************************************************************************
3.2. PAQUETE LINEA_FACTURAS

    PROCEDIMIENTOS
    • ALTA_LINEA (COD_FACTURA, COD_PRODUCTO, UNIDADES, FECHA)
        o Procedimiento para insertar una línea de Factura
        o Debe comprobar que existe ya la factura antes de insertar el registro.
        o También debemos comprobar que existe el producto en la tabla de PRODUCTOS.
        o El PVP debemos seleccionarlo de la tabla PRODUCTOS
    • BAJA_LINEA (cod_factura, COD_PRODUCTO
        o Damos de baja la línea con esa clave primaria)
    • MOD_PRODUCTO(COD_FACTURA,COD_PRODUCTO,PARAMETRO)
        o Se trata de 2 métodos sobrecargados, es decir el segundo parámetro debe
        admitir los siguientes valores:
            ? MOD_PRODUCTO(COD_FACTURA,COD_PRODUCTO, UNIDADES)
            ? MOD_PRODUCTO(COD_FACTURA,COD_PRODUCTO, FECHA)
        o Por tanto, debe modificar o bien unidades si se le pasa un NUMBER o bien 
        la fecha si se le pasa un DATE
    FUNCIONES
    • NUM_LINEAS(COD_FACTURA)
        o Devuelve el número de líneas de la factura
********************************************************************************/
CREATE OR REPLACE PACKAGE gest_lineas_facturas AS
    PROCEDURE alta_linea(
        cod_factura NUMBER,
        cod_producto NUMBER,
        unidades NUMBER,
        fecha DATE
    );
    PROCEDURE baja_linea(cod_producto NUMBER);
    PROCEDURE mod_producto(
        cod_factura NUMBER,
        cod_producto NUMBER,
        unidades NUMBER
    );
    PROCEDURE mod_producto(
        cod_factura NUMBER,
        cod_producto NUMBER,
        fecha DATE
    );
    
    FUNCTION num_lineas(cod_factura NUMBER) RETURN NUMBER;
    
END gest_lineas_facturas;