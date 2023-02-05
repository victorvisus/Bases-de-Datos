-- EJERCICIO 4 -------------------------------------------------------------

-- Tabla TRABAJADOR
CREATE TABLE trabajador (
    id_t NUMBER(11) PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    tarifa DOUBLE NOT NULL,
    oficio VARCHAR(15) NOT NULL,
    id_sup NUMBER(11) NOT NULL,

    CONSTRAINT tra_sup_FK FOREIGN KEY (id_sup) REFERENCES trabajador(id_t)
);

-- Tabla EDIFICIO
CREATE TABLE edificio (
    id_e NUMBER(11) PRIMARY KEY,
    dir VARCHAR2(15) NOT NULL,
    tipo VARCHAR2(10) NOT NULL,
    nivel_calidad NUMBER(11) NOT NULL,
    categoria NUMBER(11) NOT NULL,

    CONSTRAINT edi_cal_CK CHECK (nivel_calidad BETWEEN 0 AND 10),
    CONSTRAINT edi_cat_CK CHECK (categoria > 0)
);

-- Tabla ASIGNACION
CREATE TABLE asignacion (
    id_t NUMBER(11),
    id_e NUMBER(11),
    fecha_inicio DATE,
    num_dias NUMBER(11) NOT NULL,

    CONSTRAINT asi_idt_FK FOREIGN KEY (id_t) REFERENCES trabajador(id_t),
    CONSTRAINT asi_ide_FK FOREIGN KEY (id_e) REFERENCES edificio(id_e),

    CONSTRAINT asi_id_PK PRIMARY KEY (id_t,id_e)
);
