-- Práctica final PL/SQL 12c ---------------------------------------------------

/*******************************************************************************
1. Objetivos
• Esta práctica pretende hacer un repaso de los componentes más importantes de
PL/SQL: procedimintos, funciones, paquetes y triggers.
********************************************************************************/

/*******************************************************************************
2. Crear las tablas y datos necesarios

• Vamos a crear cuatro tablas. Podemos ejecutar el script “creación_ddl.sql” que
se encuentra en los recursos del capítulo o bien podéis copiarlo y pegarlo de este
documento
    - FACTURAS
    - LINEAS_FACTURA
    - LOG_CONTROL
    - PRODUCTOS

• Las columnas de cada tabla con la siguientes:
    FACTURAS
        COD_FACTURA NUMBER
        FECHA DATE
        DESCRIPCIÓN VARCHAR2(100)
        
        Clave primaria: COD_FACTURA
        
    LINEAS_FACTURAS
        COD_PRODUCTO NUMBER
        COD_FACTURA NUMBER
        PVP NUMBER
        UNIDADES NUMBER
        FECHA DATE
        
        Clave Primaria: COD_FACTURA+COD_PRODUCTO
        Referencia a la tabla FACTURAS y a la tabla PRODUCTOS

    PRODUCTOS
        COD_PRODUCTO NUMBER
        NOMBRE_PRODUCTO VARCHAR2(100)
        PVP NUMBER
        TOTAL_VENDIDO NUMBER
        Clave primaria: COD_PRODUCTO

    CONTROL_LOG
        COD_EMPLEADO NUMBER
        FECHA DATE
        TABLA_AFECTADA VARCHAR2(50)
        COD_OPERACÍON CHAR(1)
        La columna COD_OPERACION debe valer:(I, U, D ? INSERT, UPDATE ,DELETE)
********************************************************************************/
CREATE TABLE facturas(
    cod_factura NUMBER,
    fecha DATE,
    descripcion VARCHAR2(100)
);
CREATE TABLE lineas_facturas(
    cod_producto NUMBER,
    cod_factura NUMBER,
    pvp NUMBER,
    unidades NUMBER,
    fecha DATE
);
CREATE TABLE productos(
    cod_producto NUMBER,
    nombre_producto VARCHAR2(100),
    pvp NUMBER,
    total_vendido NUMBER
);
CREATE TABLE control_log(
    cod_empleado VARCHAR2(30),
    fecha DATE,
    tabla_afectada VARCHAR2(50),
    cod_operacion CHAR(1)
);

ALTER TABLE facturas ADD CONSTRAINT fr_cod_pk PRIMARY KEY (cod_factura);
ALTER TABLE lineas_facturas MODIFY(
    cod_producto NOT NULL,
    cod_factura NOT NULL
);
ALTER TABLE lineas_facturas ADD CONSTRAINT lf_cod_pk PRIMARY KEY (cod_factura, cod_producto);
ALTER TABLE productos ADD CONSTRAINT pr_cod_pk PRIMARY KEY (cod_producto);
ALTER TABLE control_log ADD CONSTRAINT cl_ope_ch CHECK(cod_operacion = 'I' OR cod_operacion = 'U' OR cod_operacion = 'D' OR cod_operacion = 'E');

ALTER TABLE lineas_facturas ADD CONSTRAINT lf_fra_fk FOREIGN KEY (cod_factura) REFERENCES facturas(cod_factura);
ALTER TABLE lineas_facturas ADD CONSTRAINT lf_pro_fk FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto);

ALTER TABLE productos DROP COLUMN total_vendido;
ALTER TABLE productos ADD (
    total_vendidos NUMBER
);

Insert into PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('1','TORNILLO','1',null);
Insert into PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('2','TUERCA','5',null);
Insert into PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('3','ARANDELA','4',null);
Insert into PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('4','MARTILLO','40',null);
Insert into PRODUCTOS (COD_PRODUCTO,NOMBRE_PRODUCTO,PVP,TOTAL_VENDIDOS) values ('5','CLAVO','1',null);