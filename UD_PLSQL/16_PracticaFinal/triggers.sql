CREATE OR REPLACE TRIGGER reg_facturas
AFTER INSERT OR UPDATE OR DELETE ON facturas
DECLARE
    operacion CHAR(1);
BEGIN
    IF INSERTING THEN operacion := 'I';
    END IF;
    IF UPDATING THEN operacion := 'U';
    END IF;
    IF DELETING THEN operacion := 'D';
    END IF;
    
    INSERT INTO control_log(cod_empleado, fecha, tabla_afectada, cod_operacion)
        VALUES(USER, SYSDATE, 'Facturas', operacion);
        
END reg_facturas;
/
CREATE OR REPLACE TRIGGER reg_lineas_facturas
AFTER INSERT OR UPDATE OR DELETE ON lineas_facturas
DECLARE
    operacion CHAR(1);
BEGIN
    IF INSERTING THEN operacion := 'I';
    END IF;
    IF UPDATING THEN operacion := 'U';
    END IF;
    IF DELETING THEN operacion := 'D';
    END IF;
    
    INSERT INTO control_log(cod_empleado, fecha, tabla_afectada, cod_operacion)
        VALUES(USER, SYSDATE, 'Lineas Facturas', operacion);
        
END reg_lineas_facturas;
/
