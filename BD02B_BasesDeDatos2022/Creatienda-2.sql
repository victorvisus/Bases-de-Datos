/*
DROP TABLE Familia CASCADE CONSTRAINTS;
DROP TABLE Producto CASCADE CONSTRAINTS;
DROP TABLE Tienda CASCADE CONSTRAINTS;
DROP TABLE Stock CASCADE CONSTRAINTS;
*/

-- TABLA FAMILIA
CREATE TABLE familia (
    codfamilia NUMBER(3) PRIMARY KEY,
    nomfamilia VARCHAR2(50) UNIQUE NOT NULL
);

-- TABLA PRODUCTO
CREATE TABLE producto (
    codproducto NUMBER(5) PRIMARY KEY,
    nomproducto VARCHAR2(20) NOT NULL,
    descripcion VARCHAR2(100),
    preciobase NUMBER(8,2) NOT NULL,
    porcreposicion NUMBER(3),
    unidadesminimo NUMBER(4) NOT NULL,
    codfamilia NUMBER(3) NOT NULL,
    
    CONSTRAINT pro_pvp_CK CHECK(preciobase > 0),
    CONSTRAINT pro_porc_CK CHECK(porcreposicion > 0),
    CONSTRAINT pro_udmin_CK CHECK(unidadesminimo > 0),
    
    CONSTRAINT pro_fam_FK FOREIGN KEY (codfamilia) REFERENCES familia(codfamilia) ON DELETE SET NULL
);

-- TABLA TIENDA
CREATE TABLE tienda (
    codtienda NUMBER(3) PRIMARY KEY,
    nomtienda VARCHAR2(20) NOT NULL,
    telefono VARCHAR2(11),
    codigopostal VARCHAR2(5) NOT NULL,
    provincia VARCHAR2(5) NOT NULL
);

-- TABLA STOCK
CREATE TABLE stock (
    codtienda NUMBER(3) NOT NULL,
    codproducto NUMBER(5) NOT NULL,
    unidades NUMBER(6) NOT NULL,
    
    CONSTRAINT stc_uds_CK CHECK (unidades >= 0),
    
    CONSTRAINT stc_cod_PK PRIMARY KEY (codtienda,codproducto),
    
    CONSTRAINT stc_tienda_FK FOREIGN KEY (codtienda) REFERENCES tienda(codtienda),
    CONSTRAINT stc_produc_FK FOREIGN KEY (codproducto) REFERENCES producto(codproducto)
);