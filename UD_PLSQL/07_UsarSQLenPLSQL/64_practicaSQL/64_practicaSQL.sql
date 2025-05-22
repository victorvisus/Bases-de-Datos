-- Práctica INSERT, UPDATE, DELETE


/*******************************************************************************
1. PRÁCTICA 1 ------------------------------------------------------------------
Crear un bloque que inserte un nuevo departamento en la tabla DEPARTMENTS.
Para saber el DEPARTMENT_ID que debemos asignar al nuevo departamento primero 
debemos averiguar el valor mayor que hay en la tabla DEPARTMENTS y sumarle uno
para la nueva clave.
• Location_id debe ser 1000
• Manager_id debe ser 100
• Department_name debe ser “INFORMATICA”
• NOTA: en PL/SQL debemos usar COMMIT y ROLLBACK de la misma forma que lo hacemos
en SQL. Por tanto, para validar definitivamente un cambio debemos usar COMMIT.
********************************************************************************/
DECLARE
    dpto_id  departments.department_id%TYPE;
    last_id  departments.department_id%TYPE;
    flag     BOOLEAN := false;
BEGIN
    SELECT
        MAX(departments.department_id)
    INTO last_id
    FROM departments;

    dpto_id := last_id + 1;
    INSERT INTO departments ( department_id, location_id, manager_id, department_name
        ) VALUES ( dpto_id, 1000, 100, 'INFORMATICA 2' );

-- Comprobamos que el nuevo registro existe
    SELECT
        MAX(departments.department_id)
    INTO last_id
    FROM departments;
    
    
    IF last_id = dpto_id
    THEN dbms_output.put_line('Registro insertado con éxito');
    ELSE  dbms_output.put_line('Ha ocurrido un error al insertar el nuevo registro');
    END IF;
END;
/



/*******************************************************************************
2. PRÁCTICA 2 ------------------------------------------------------------------
Crear un bloque PL/SQL que modifique la LOCATION_ID del nuevo departamento a 1700.
En este caso usemos el COMMIT dentro del bloque PL/SQL.
********************************************************************************/

/*******************************************************************************
3. PRÁCTICA 3 ------------------------------------------------------------------
Por último, hacer otro bloque PL/SQL que elimine ese departamento nuevo.
********************************************************************************/