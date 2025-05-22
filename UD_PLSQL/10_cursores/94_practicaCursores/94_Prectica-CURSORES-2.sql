/*******************************************************************************
2- Vamos averiguar cuales son los JEFES (MANAGER_ID) de cada departamento.
En la tabla DEPARTMENTS figura el MANAGER_ID de cada departamento, que a su vez 
es también un empleado. Hacemos un bloque con dos cursores. (Esto se puede hacer 
fácilmente con una sola SELECT pero vamos a hacerlo de esta manera para probar
parámetros en cursores).
    o El primero de todos los empleados
    o El segundo de departamentos, buscando el MANAGER_ID con el parámetro que
    se le pasa.
    o Por cada fila del primero, abrimos el segundo cursor pasando el EMPLOYEE_ID
    o Si el empleado es MANAGER_ID en algún departamento debemos pintar el Nombre
    del departamento y el nombre del MANAGER_ID diciendo que es el jefe.
    o Si el empleado no es MANAGER de ningún departamento debemos poner
    “No es jefe de nada”
********************************************************************************/
CREATE OR REPLACE PROCEDURE jefes_dpto
AS
    CURSOR empl_cur IS SELECT * FROM employees;
    CURSOR manager_cur(cr_manager_id departments.manager_id%TYPE) IS SELECT * FROM departments WHERE manager_id = cr_manager_id;
    
    empleados empl_cur%ROWTYPE;
    departamentos manager_cur%ROWTYPE;
    jefe departments.manager_id%TYPE;
BEGIN
    --Por cada fila del primero, abrimos el segundo cursor pasando el EMPLOYEE_ID
    OPEN empl_cur;
    LOOP
        FETCH empl_cur INTO empleados;
        EXIT WHEN empl_cur%NOTFOUND;

        FOR i IN manager_cur(empleados.employee_id) LOOP
            -- Si el empleado es MANAGER_ID en algún departamento debemos pintar el Nombre del departamento y el nombre del MANAGER_ID diciendo que es el jefe.
            IF empleados.employee_id = i.manager_id THEN
                dbms_output.put_line(i.department_name || ' ' || ' tiene por jefe a ' || empleados.first_name || ' ' || empleados.last_name);
            -- o Si el empleado no es MANAGER de ningún departamento debemos poner “No es jefe de nada”
            ELSE
                dbms_output.put_line(empleados.first_name || ' ' || empleados.last_name || ' no es jefe de nada');
            END IF;
        END LOOP;

    END LOOP;
    CLOSE empl_cur;
    
    
    
END jefes_dpto;
/
EXECUTE jefes_dpto;
/

/************************************************* SOLUCIÓN DEL PROFESOR    ****/
SET SERVEROUTPUT ON
DECLARE
    DEPARTAMENTO DEPARTMENTS%ROWTYPE;
    jefe DEPARTMENTS.MANAGER_ID%TYPE;
    CURSOR C1 IS SELECT * FROM EMployees;
    CURSOR C2(j DEPARTMENTS.MANAGER_ID%TYPE) IS SELECT * FROM DEPARTMENTS WHERE MANAGER_ID=j;
    
begin

    for EMPLEADO in c1 loop
        open c2(EMPLEADO.employee_id) ;
        FETCH C2 into departamento;
        if c2%NOTFOUND then
            DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME ||' No es JEFE de NADA');
        ELSE
            DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME || 'ES JEFE DEL DEPARTAMENTO '|| DEPARTAMENTO.DEPARTMENT_NAME);
        END IF;
        CLOSE C2;
    END LOOP;
END;
/