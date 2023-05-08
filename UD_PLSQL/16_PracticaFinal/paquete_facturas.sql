-- Práctica final PL/SQL ---------------------------------------------------

/*******************************************************************************
3.1. PAQUETE FACTURAS

    PROCEDIMIENTOS
    • ALTA_FACTURA (COD_FACTURA, FECHA,DESCRIPCIÓN).
        o Debe dar de alta una factura con los valores indicados en los parámetros
        o Debe comprobar que no se duplica
    • BAJA_FACTURA (cod_factura).
        o Debe borrar la factura indicada en el parámetros
        o Debe borrar también las líneas de facturas asociadas en la tabla
        LINEAS_FACTURA.
    • MOD_DESCRI(COD_FACTURA, DESCRIPCION).
        o Debe modificar la descripción de la factura que tenga el código del 
        parámetro con la nueva descripción
    • MOD_FECHA (COD_FACTURA,FECHA).
        o Debe modificar la fecha  de la factura que tenga el código del parámetro
        con la nueva fecha
    FUNCIONES
    • NUM_FACTURAS(FECHA_INICIO,FECHA_FIN).
        o Devuelve el número de facturas que hay entre esas fechas
    • TOTAL_FACTURA(COD_FACTURA.)
        o Devuelve el total de la factura con ese código. Debe hacer el sumatorio
        de “pvp*unidades” de las líneas de esa factura en la tabla LINEAS_FACTURA
********************************************************************************/

CREATE OR REPLACE PACKAGE gest_facturas AS
    PROCEDURE alta_factura(
        cod NUMBER,
        fecha_fra DATE,
        descripcion_fra VARCHAR2
    );
    PROCEDURE baja_factura(cod NUMBER);
    PROCEDURE mod_descri(
        cod NUMBER,
        decripcion_new VARCHAR2
    );
    PROCEDURE mod_fecha(cod NUMBER , fecha_new DATE);
    
    FUNCTION num_facturas(fecha_ini DATE, fecha_fin DATE) RETURN NUMBER;
    FUNCTION total_factura(cod NUMBER) RETURN NUMBER;
    
END gest_facturas;
/

CREATE OR REPLACE PACKAGE BODY gest_facturas AS
    error_fra EXCEPTION;
    
-- Método privado para gestión de errores
    FUNCTION reg_errores(cod NUMBER) RETURN BOOLEAN AS
        --control BOOLEAN;
        num_fra NUMBER;
    BEGIN
        SELECT COUNT(*) INTO num_fra FROM facturas WHERE facturas.cod_factura = cod;
        
        IF num_fra = 0 THEN RETURN FALSE;
        ELSE RETURN TRUE;
        END IF;
    END reg_errores;
        
-- Procedimientos
    PROCEDURE alta_factura(
        cod NUMBER,
        fecha_fra DATE,
        descripcion_fra VARCHAR2) AS

    BEGIN

        IF reg_errores(cod) = FALSE THEN
            INSERT INTO facturas VALUES(cod,fecha_fra,descripcion_fra);
            dbms_output.put_line('Fra. con código ' || cod || ' insertada correctamente');
        ELSE
            RAISE error_fra;
        END IF;
        
    EXCEPTION
        WHEN error_fra THEN
            dbms_output.put_line('La factura indicado con el código ' || cod || ' ya existe');
            INSERT INTO control_log VALUES(USER,SYSDATE,'Facturas','E');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END alta_factura;


/*
BAJA_FACTURA (cod_factura).
    - Debe borrar la factura indicada en el parámetros
    - Debe borrar también las líneas de facturas asociadas en la tabla LINEAS_FACTURA.
*/
    PROCEDURE baja_factura(cod NUMBER) AS
        
    BEGIN
        IF reg_errores(cod) = FALSE THEN RAISE error_fra;
        END IF;
        
        --Debe borrar la factura indicada en el parámetros
        DELETE FROM facturas WHERE facturas.cod_factura = cod;
        dbms_output.put_line('Fra. eliminada');
    
        --Debe borrar también las líneas de facturas asociadas en la tabla LINEAS_FACTURA
        DELETE FROM lineas_facturas WHERE lineas_facturas.cod_factura = cod;
        dbms_output.put_line('Detalle Fra. eliminado');
        
    EXCEPTION
        WHEN error_fra THEN
            dbms_output.put_line('La factura indicado con el código ' || cod || ' no existe');
            INSERT INTO control_log VALUES(USER,SYSDATE,'Facturas','E');
            
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('La factura, con el código ' || cod || ' no tiene lineas de factura');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
            
    END baja_factura;

/*
MOD_DESCRI(COD_FACTURA, DESCRIPCION).
    - Debe modificar la descripción de la factura que tenga el código del parámetro con la nueva descripción
*/
    PROCEDURE mod_descri(
        cod NUMBER,
        decripcion_new VARCHAR2) AS
    BEGIN
        --control := reg_errores(cod);

        IF reg_errores(cod) = FALSE THEN RAISE error_fra;
        END IF;
        
        UPDATE facturas SET descripcion = decripcion_new WHERE cod_factura = cod;
        dbms_output.put_line('Descripción de la fra. ' || cod || ' modificada');
        
    EXCEPTION
        WHEN error_fra THEN
            dbms_output.put_line('La factura indicado con el código ' || cod || ' no existe');
            INSERT INTO control_log VALUES(USER,SYSDATE,'Facturas','E');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END mod_descri;
    
/*
MOD_FECHA (COD_FACTURA,FECHA).
    - Debe modificar la fecha de la factura que tenga el código del parámetro con la nueva fecha
*/
    PROCEDURE mod_fecha(
        cod NUMBER,
        fecha_new DATE) AS
    BEGIN
        IF reg_errores(cod) = FALSE THEN RAISE error_fra;
        END IF;
        
        UPDATE facturas SET fecha = fecha_new WHERE cod_factura = cod;
        dbms_output.put_line('Fecha de la fra. ' || cod || ' modificada');
        
    EXCEPTION
        WHEN error_fra THEN
            dbms_output.put_line('La factura indicado con el código ' || cod || ' no existe');
            INSERT INTO control_log VALUES(USER,SYSDATE,'Facturas','E');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END mod_fecha;

-- Funciones

/*
NUM_FACTURAS(FECHA_INICIO,FECHA_FIN).
    - Devuelve el número de facturas que hay entre esas fechas
*/
    FUNCTION num_facturas(fecha_ini DATE, fecha_fin DATE) RETURN NUMBER AS
        n_facturas NUMBER;
    BEGIN
        SELECT COUNT(*) INTO n_facturas FROM facturas WHERE fecha BETWEEN fecha_ini AND fecha_fin;
        RETURN n_facturas;
    END num_facturas;

/*
TOTAL_FACTURA(COD_FACTURA.)
    - Devuelve el total de la factura con ese código. Debe hacer el sumatorio de
    “pvp*unidades” de las líneas de esa factura en la tabla LINEAS_FACTURA
*/
    FUNCTION total_factura(cod NUMBER) RETURN NUMBER AS
        total_fra NUMBER;
        
        datos_factura lineas_facturas%ROWTYPE;
    BEGIN
        SELECT * INTO datos_factura FROM lineas_facturas WHERE cod_factura = cod;
        total_fra := datos_factura.pvp * datos_factura.unidades;
        
        RETURN total_fra;
    END total_factura;
    
END gest_facturas;
/
