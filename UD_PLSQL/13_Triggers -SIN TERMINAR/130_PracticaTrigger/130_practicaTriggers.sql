-- PRÁCTICA CON TRIGGERS -------------------------------------------------------

/*******************************************************************************
1. Crear un TRIGGER BEFORE DELETE sobre la tabla EMPLOYEES que impida borrar un 
registro si su JOB_ID es algo relacionado con CLERK
********************************************************************************/
CREATE OR REPLACE TRIGGER clerk_protect
BEFORE DELETE ON employees FOR EACH ROW

BEGIN
    IF :old.job_id LIKE('%CLERK') THEN
        RAISE_APPLICATION_ERROR(-20500, 'No esta permitida la eliminación de este registro');
    END IF;
END;
/
SELECT * FROM employees;
DELETE FROM employees WHERE employee_id = 133;
/


/*******************************************************************************
2. Crear una tabla denominada AUDITORIA con las siguientes columnas:
********************************************************************************/
CREATE TABLE auditoria (
    USUARIO VARCHAR(50),
    FECHA DATE,
    SALARIO_ANTIGUO NUMBER,
    SALARIO_NUEVO NUMBER
);
/
ALTER TABLE auditoria ADD (
    SALARIO_ANTIGUO NUMBER,
    SALARIO_NUEVO NUMBER);
/*******************************************************************************
3. Crear un TRIGGER BEFORE INSERT de tipo STATEMENT, de forma que cada vez que se 
haga un INSERT en la tabla REGIONS guarde una fila en la tabla AUDITORIA con el 
usuario y la fecha en la que se ha hecho el INSERT
********************************************************************************/
CREATE OR REPLACE TRIGGER log_ins_regions
BEFORE INSERT ON regions

BEGIN
    INSERT INTO auditoria(USUARIO, FECHA) VALUES(USER, SYSDATE);
END log_ins_regions;
/
SELECT * FROM auditoria;
INSERT INTO regions(region_id, region_name) VALUES(20, 'otra_region');
/


/*******************************************************************************
4. Realizar otro trigger BEFORE UPDATE de la columna SALARY de tipo EACH ROW.
• Si la modificación supone rebajar el salario el TRIGGER debe disparar un
RAISE_APPLICATION_FAILURE “no se puede bajar un salario”.
• Si el salario es mayor debemos dejar el salario antiguo y el salario nuevo en
la tabla AUDITORIA.
********************************************************************************/
CREATE OR REPLACE TRIGGER control_salario
BEFORE UPDATE OF salary ON employees FOR EACH ROW

BEGIN
    IF :new.salary < :old.salary THEN
        RAISE_APPLICATION_ERROR(-20501,'No se puede rebajar el salario a los empleados');
    ELSE
        INSERT INTO auditoria(usuario, fecha, salario_nuevo, salario_antiguo) VALUES(USER, SYSDATE, :new.salary, :old.salary);
    END IF;
END control_salario;
/
SELECT * FROM auditoria;
SELECT * FROM employees;
UPDATE employees SET salary = 27400 WHERE employee_id = 100;
/


/*******************************************************************************
5. Crear un TRIGGER BEFORE INSERT en la tabla DEPARTMENTS que al insertar un 
departamento compruebe que el código no esté repetido y luego que si el LOCATION_ID
es NULL le ponga 1700 y si el MANAGER_ID es NULL le ponga 200
********************************************************************************/
CREATE OR REPLACE TRIGGER control_dptos
BEFORE INSERT ON departments FOR EACH ROW

DECLARE
    --v_ctrl_location_id departments.location_id%TYPE;
    
    CURSOR c_ctrl_location_id IS SELECT d.location_id FROM departments d WHERE d.location_id = :new.location_id;
BEGIN
    --SELECT d.location_id INTO v_ctrl_location_id FROM departments d WHERE d.location_id = :new.location_id;
    

    IF :new.location_id IS NOT NULL THEN
    
        FOR i IN c_ctrl_location_id LOOP
            IF :new.location_id = i.location_id THEN
                RAISE_APPLICATION_ERROR(-20550, 'El location_id ya existe');
            END IF;
        END LOOP;
        
    ELSE
        :new.location_id := 1700;
    END IF;
    
    IF :new.manager_id IS NULL THEN
        :new.manager_id := 200;
    END IF;

END control_dptos;
/
select * from departments;
select * from locations;
INSERT INTO departments(department_id,department_name,location_id) VALUES(302, 'Nuevo Departamento 2', 3200);
SELECT d.location_id FROM departments d WHERE d.location_id = 1735;
/







