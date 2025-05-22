CREATE OR REPLACE PACKAGE regiones
IS
    PROCEDURE alta_region(cod NUMBER, region VARCHAR2);
    PROCEDURE baja_region(cod NUMBER);
    PROCEDURE mod_region(cod NUMBER, new_name VARCHAR2);
    
    
END regiones;
/

CREATE OR REPLACE PACKAGE BODY regiones
IS
-- Métodos privados
    FUNCTION existe_region(cod NUMBER) RETURN BOOLEAN
    AS
        control BOOLEAN;
        regiones NUMBER;
    BEGIN
        SELECT COUNT(*) INTO regiones FROM regions WHERE region_id = cod;
        
        IF regiones = 0 THEN
            control := FALSE;
        ELSE
            control := TRUE;
        END IF;
        
        RETURN control;
    END existe_region;

-- Métodos públicos
    PROCEDURE alta_region(cod NUMBER, region VARCHAR2)
    AS
        region_existe EXCEPTION;
    BEGIN
        IF existe_region(cod) = TRUE THEN
            RAISE region_existe;
        ELSE
            INSERT INTO regions(region_id, region_name) VALUES(cod, region);
            dbms_output.put_line('Nueva región insertada con éxito: cód. ' || cod || ' - Nombre: ' || region);
        END IF;
        
    EXCEPTION
        WHEN region_existe THEN
            dbms_output.put_line('La region con código ' || cod || ' ya existe');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END alta_region;

    PROCEDURE baja_region(cod NUMBER) 
    AS
        region_existe EXCEPTION;
        region_no_existe EXCEPTION;
    BEGIN
        IF existe_region(cod) = TRUE THEN
            RAISE region_existe;
        ELSE
            RAISE region_no_existe; 
        END IF;
        
    EXCEPTION
        WHEN region_existe THEN
            DELETE FROM regions WHERE region_id = cod;
            dbms_output.put_line('La region con código ' || cod || ' ha sido eliminado');
            
        WHEN region_no_existe THEN
            dbms_output.put_line('La region con código ' || cod || ' no esta registrada');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END baja_region;
    
    PROCEDURE mod_region(cod NUMBER, new_name VARCHAR2)
    AS
        region_existe EXCEPTION;
        region_no_existe EXCEPTION;
    BEGIN
        IF existe_region(cod) = TRUE THEN
            RAISE region_existe;
        ELSE
            RAISE region_no_existe; 
        END IF;
        
    EXCEPTION
        WHEN region_existe THEN
            UPDATE regions SET region_name = new_name WHERE region_id = cod;
            dbms_output.put_line('La region con código ' || cod || ' ha sido modificado');
            
        WHEN region_no_existe THEN
            dbms_output.put_line('La region con código ' || cod || ' no esta registrada');
            
        WHEN OTHERS THEN
            dbms_output.put_line('Cód. de error ' || SQLCODE);
            dbms_output.put_line('Mensaje de error ' || SQLERRM);
    END mod_region;
    

END regiones;
/
SET SERVEROUT ON
DECLARE
    cod regions.region_id%TYPE;
    region regions.region_name%TYPE;
BEGIN
    regiones.alta_region(700, 'nueva_region');
    regiones.alta_region(10, 'nueva_region_error');
    
    regiones.baja_region(10);
END testeo;
/
select * FROM regions;