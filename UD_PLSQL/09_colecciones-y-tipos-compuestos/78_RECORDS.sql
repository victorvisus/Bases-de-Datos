--Objeto Tipo RECORD con INSERT y UPDATE
SET SERVEROUTPUT ON

DECLARE
    TYPE empleado IS RECORD (
        nombre   VARCHAR2(100),
        salario  NUMBER,
        fecha    employees.hire_date%TYPE,
        datos    employees%rowtype
    );
    /** Objeto TYPE RECORD, parecido a un ARRAY pero solo almacena una fila de datos,
    donde se almacenan distintos datos, también puede almacenar filas completas
    de los datos de una tabla (con %ROWTYPE)
    
    - Para acceder a los datos de este objeto es: nombreObjeto.nombreCampo
    - Para acceder a un campo de la fila de la tabla almacenada tenemos 3 niveles
    nombreObjeto.nombreCampo.nombreCampoFila
    **/ 
    emple1 empleado;
    emple2 empleado;

BEGIN
    SELECT * INTO emple1.datos
        FROM employees WHERE employee_id = 100;

    emple1.nombre := emple1.datos.first_name || ' ' || emple1.datos.last_name;
    emple1.salario := emple1.datos.salary * 0.8;
    emple1.fecha := emple1.datos.hire_date;
    
    dbms_output.put_line(emple1.nombre);
    dbms_output.put_line(emple1.salario);
    dbms_output.put_line(emple1.fecha);
    dbms_output.put_line(emple1.datos.first_name);
    
    emple2.nombre := 'Nombre emple2';
    dbms_output.put_line(emple2.nombre);
END;
/