-- Pr�ctica con EXCEPCIONES

/*******************************************************************************
1. PR�CTICA 1 ------------------------------------------------------------------
Crear una SELECT (no un cursor expl�cito) que devuelva el nombre de un empleado 
pas�ndole el EMPLOYEE_ID en el WHERE,
� Comprobar en primer lugar que funciona pasando un empleado existente
� Pasar un empleado inexistente y comprobar que genera un error
� Crear una zona de EXCEPTION controlando el NO_DATA_FOUND para que pinte un mensaje 
como �Empleado inexistente�
********************************************************************************/
DECLARE
    id_empl NUMBER;
    nom_empl VARCHAR2(20);

BEGIN

    id_empl := 1000;

    SELECT first_name INTO nom_empl FROM employees WHERE employee_id = id_empl;
    DBMS_OUTPUT.put_line('El nombre del empleado con ID ' || id_empl || ' es ' || nom_empl);

EXCEPTION
    WHEN no_data_found THEN
        --Le decimos que imprima un mensaje, en vez de su mensaje predecinido
        dbms_output.put_line('empleado inexistente');
    WHEN OTHERS THEN
        dbms_output.put_line('Error desconocido');

END;
/

/*******************************************************************************
2. PR�CTICA 2 ------------------------------------------------------------------
Modificar la SELECT para que devuelva m�s de un empleado, por ejemplo poniendo
EMPLOYEE_ID> 100. Debe generar un error. Controlar la excepci�n para que genere 
un mensaje como �Demasiados empleados en la consulta�
********************************************************************************/
DECLARE
    id_empl NUMBER;
    nom_empl VARCHAR2(20);

BEGIN

    id_empl := 10;

    SELECT first_name INTO nom_empl FROM employees WHERE employee_id > id_empl;
    DBMS_OUTPUT.put_line('El nombre del empleado con ID ' || id_empl || ' es ' || nom_empl);

EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('demasiados datos');
    WHEN no_data_found THEN
        --Le decimos que imprima un mensaje, en vez de su mensaje predecinido
        dbms_output.put_line('empleado inexistente');
    WHEN OTHERS THEN
        dbms_output.put_line('Error desconocido');

END;
/

/*******************************************************************************
3. PR�CTICA 3 ------------------------------------------------------------------
3- Modificar la consulta para que devuelva un error de divisi�n por CERO, por ejemplo,
vamos a devolver el salario en vez del nombre y lo dividimos por 0. En este caso,
en vez de controlar la excepci�n directamente, creamos una secci�n WHEN OTHERS y
pintamos el error con SQLCODE y SQLERRM
********************************************************************************/
DECLARE
    id_empl NUMBER;
    sal_empl VARCHAR2(20);

BEGIN

    id_empl := 100;

    SELECT (salary / 0) INTO sal_empl FROM employees WHERE employee_id = id_empl;
    DBMS_OUTPUT.put_line('El nombre del empleado con ID ' || id_empl || ' es ' || sal_empl);

EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('demasiados datos');
    WHEN no_data_found THEN
        --Le decimos que imprima un mensaje, en vez de su mensaje predecinido
        dbms_output.put_line('empleado inexistente');
    WHEN OTHERS THEN
        dbms_output.put_line('C�d. Error: ' || SQLCODE);
        dbms_output.put_line('Mensaje del Error: ' || SQLERRM);

END;
/

/*******************************************************************************
4. PR�CTICA 4 ------------------------------------------------------------------
El error -00001 es clave primaria duplicada.
a. Aunque ya existe una predefinida (DUP_VAL_ON_INDEX) vamos a crear una excepci�n
no -predefinida que haga lo mismo.
b. Vamos a usar la tabla REGIONS para hacerlo m�s f�cil
c. Usamos PRAGMA EXCEPTION_INIT y creamos una excepci�n denominada �duplicado�.
d. Cuando se genere ese error debemos pintar �Clave duplicada, intente otra�.
********************************************************************************/
DECLARE
    duplicado EXCEPTION;
    PRAGMA exception_init(duplicado, -00001);

    code NUMBER;
    message VARCHAR2(100);
    
    --reg REGIONS%ROWTYPE;
    id_reg NUMBER;
    nom_reg VARCHAR2(20);

BEGIN
    id_reg := 1;
    nom_reg := 'regionnueva';
    
    --SELECT * INTO reg FROM regions;
    INSERT INTO regions VALUES (id_reg, nom_reg);
    COMMIT;

EXCEPTION
    WHEN duplicado THEN
        dbms_output.put_line('Clave duplicada, intente otra');
        
    WHEN OTHERS THEN
        code := SQLCODE;
        msg_err := SQLERRM;
        
        dbms_output.put_line('C�d. de error ' || code);
        dbms_output.put_line('Mensaje de error ' || msg_err);   
END;
/