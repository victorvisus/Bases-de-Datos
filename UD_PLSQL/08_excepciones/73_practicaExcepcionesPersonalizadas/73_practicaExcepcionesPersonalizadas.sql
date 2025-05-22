-- Pr�ctica con EXCEPCIONES DE USUARIO

/*******************************************************************************
1. PR�CTICA 1 ------------------------------------------------------------------
Crear una Excepci�n personalizada denominada CONTROL_REGIONES.
� Debe dispararse cuando al insertar o modificar una regi�n queramos poner una 
clave superior a 200. Por ejemplo usando una variable con ese valor.
� En ese caso debe generar un texto indicando algo as� como �Codigo no permitido.
Debe ser inferior a 200�
� Recordemos que las excepciones personalizadas deben dispararse de forma manual
con el RAISE.
*******************************************************************************/
DECLARE
    control_regiones EXCEPTION;
    
    reg_id regions.region_id%TYPE;
    reg_nom regions.region_name%TYPE;
BEGIN

    reg_id := 150;
    reg_nom := 'Oceania';
    
    IF reg_id > 200 THEN
        RAISE control_regiones;
    ELSE
        INSERT INTO regions VALUES (reg_id,reg_nom);
        dbms_output.put_line('Regi�n insertada');
    END IF;

EXCEPTION
    WHEN control_regiones THEN
        dbms_output.put_line('Codigo no permitido. Debe ser inferior a 200');
END;
/