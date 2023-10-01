SET SERVEROUTPUT ON
/*
    +   -> Suma                                 **  -> Exponenciación
    %   -> Indicador de atributo                <>  -> Distinto
    .   -> Selector                             ¡=  -> Distinto
    /   -> Division                             <=  -> Menor o igual
    (  -> Delimitaddor de lista                 >=  -> Mayor o igual
    )  -> Delimitaddor de lista                 ..  -> Rango
    :   -> Variable host                        ||  -> Concatenación
    ,   -> Separador de elementos               <<  -> Delimitador de etiquetas
    *   -> Producto                             >>  -> Delimitador de etiquetas
    "   -> Delimitador de id acotado            --  -> Comentario de línea
    =   -> Igual relacional                     /*  -> Comentario de bloque
    <   -> Menor                                :=  -> Asignación     
    >   -> Mayor                                =>  -> Selector nombre de parámetro
    @   -> Indicador de acceso remoto
    ;   -> Terminador de sentencias
    -   -> Resta/Negación
*/

-- SENTENCIA IF ----------------------------------------------------------------
DECLARE
    a integer:=10;
    b integer:=17;
BEGIN
    IF (a > b) THEN
      dbms_output.put_line(a || ' es mayor');
    ELSIF (a < b) THEN
        dbms_output.put_line(a || ' es menor');
    ELSE
      dbms_output.put_line(b || ' es mayor o iguales');
    END IF;
END sentencia_if;
/

-- SENTENCIA CASE --------------------------------------------------------------
DECLARE
    nota INTEGER:=8; -- Se podría especificar nota INTEGER:=&nota
BEGIN
    CASE
        WHEN nota in (1,2) THEN
            DBMS_OUTPUT.PUT_LINE('Muy deficiente');
        WHEN nota in (3,4) THEN
            DBMS_OUTPUT.PUT_LINE('Insuficiente');
        WHEN nota = 5 THEN
            DBMS_OUTPUT.PUT_LINE('Suficiente');
        WHEN nota = 6 THEN
            DBMS_OUTPUT.PUT_LINE('Bien');
        WHEN nota in(7,8) THEN
            DBMS_OUTPUT.PUT_LINE('Notable');
        WHEN nota in (9,10) THEN
            DBMS_OUTPUT.PUT_LINE('Sobresaliente');
      ELSE
            DBMS_OUTPUT.PUT_LINE('Error, no es una nota');
    END CASE;

END sentencia_case;
/

-- Bucle LOOP ------------------------------------------------------------------
DECLARE
  a integer :=1;
BEGIN
    LOOP
        dbms_output.put_line(a);
        EXIT WHEN a>9;
        a:=a+1;
    END LOOP;
END bucle_loop;
/

-- Bucle WHILE -----------------------------------------------------------------
DECLARE
    a integer :=1;
BEGIN
    WHILE a<10 LOOP 
        dbms_output.put_line(a);  
        a:=a+1;
    END LOOP;
END bucle_while;
/

-- Bucle FOR -------------------------------------------------------------------
DECLARE
    a NUMBER;
BEGIN
    FOR a IN 1..10 LOOP -- ascendente de uno en uno
      dbms_output.put_line(a);
    END LOOP;
    
    FOR a IN REVERSE 1..10 LOOP -- descendente de uno en uno
      dbms_output.put_line(a);
    END LOOP;
END bucle_for;
/

-- EXCEPCIONES - ERRORES -------------------------------------------------------
SET SERVEROUT ON
DECLARE
    supervisor agentes%ROWTYPE;
    empl emple%ROWTYPE;
    categoria NUMBER := 11;
    
    categoria_erronea EXCEPTION;
    
    mi_excep EXCEPTION; --Se crea un Objeto tipo EXCEPTION
    PRAGMA exception_init ( mi_excep, -937 );
    --PRAGMA Es una orden al compilador, lo que esta haciendo es asociar mi objeto EXCEPTION con el cod. de error -937
    
    code NUMBER;
    message VARCHAR2(100);
BEGIN
    SELECT * INTO supervisor FROM agentes WHERE categoria = 2 AND oficina = 3;
    
    IF categoria<0 OR categoria>3 AND categoria < 10 THEN
        RAISE categoria_erronea;
    ELSIF categoria > 10 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La ID no puede ser mayor de 10, se supende el proceso.');
    END IF;
    
    SELECT * INTO empl FROM emple;
    dbms_output.put_line(empl.salario);
     
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Mensaje o bloque de códgio si salta NO_DATA_FOUND');
    WHEN categoria_erronea THEN
        dbms_output.put_line('Mensaje o bloque de códgio si salta categoria_erronea');
    WHEN mi_excep THEN
        dbms_output.put_line('Función de grupo incorrecta');
    
    WHEN OTHERS THEN
        dbms_output.put_line('Cód. de error ' || SQLCODE);
        dbms_output.put_line('Mensaje de error ' || SQLERRM);
        dbms_output.put_line('Mensaje o bloque de códgio si salta otro error no desconocido, capturando el código y mensaje del error');
END errores_exception;
/


-- CURSORES --------------------------------------------------------------------
DECLARE

    CURSOR C1 IS SELECT * FROM REGIONS;
    V1 regions%ROWTYPE;
BEGIN
    OPEN C1;
    --Leer una fila y guardarla
    FETCH C1 INTO V1;
    dbms_output.put_line(V1.region_name);
    CLOSE C1;
    
    --Recorrer el cursor con LOOP
    OPEN C1;
    LOOP
        FETCH C1 INTO V1;
        EXIT WHEN C1%NOTFOUND;
        dbms_output.put_line(V1.region_name);
    END LOOP;
    CLOSE C1;
    
    --Recorrer cursor con FOR
    dbms_output.put_line('Bucle FOR ---------------------------------');
    FOR i IN C1 LOOP
        dbms_output.put_line(i.region_name);
    END LOOP;

END ej_cursor;
/


-- PROCEDIMIENTO ---------------------------------------------------------------
CREATE OR REPLACE PROCEDURE crear_depart (
    v_num_dept depart.dept_no%TYPE,
    v_dnombre depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
    v_loc depart.loc%TYPE DEFAULT 'PROVISIONAL')
IS
    --ZONA PARA ESTABLECER VARIABLES
BEGIN
    INSERT INTO depart
    VALUES (v_num_dept, v_dnombre, v_loc);
END crear_depart;
/


-- TRIGGER ---------------------------------------------------------------------

-- Tipos ------------------------------
-- BEFORE : antes de la operación
-- AFTER : después
-- INSTEAD OF :

-- Eventos sobre los que actuan -------
-- INSERT
-- UPDATE
-- DELATE

-- Filas afectadas --------------------
-- Statement : solo se dispara una vez, por ejemplo en un DELETE masivo
-- ROW : se dispara por cada fila

-- Trigger de tipo STATEMENT ---------------------------------------------------
CREATE OR REPLACE TRIGGER trigger_after
AFTER INSERT ON regions
BEGIN
    INSERT INTO log_table VALUES('Insercción en la tabla REGIONS', USER);
END trigger_after;
/
-- Trigger que afesta la actualización de una determinada columna --------------
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


-- Paquetes --------------------------------------------------------------------
CREATE OR REPLACE PACKAGE nombre_paquete
IS
    PROCEDURE nombre_procedimiento(var1 NUMBER, var2 VARCHAR2);
    FUNCTION nombre_funcion(f_var1 NUMBER, f_var2 VARCHAR2) RETURN VARCHAR2;
    
END nombre_paquete;
/

CREATE OR REPLACE PACKAGE BODY nombre_paquete
IS
    --Metodo privado:
    FUNCTION funcion_privada(var1 NUMBER) RETURN NUMBER
    AS
        x NUMBER;
    BEGIN
        x := var1 + 10;
        RETURN x;
    END funcion_privada;
    
    PROCEDURE nombre_procedimiento(var1 NUMBER, var2 VARCHAR2)
    AS
    BEGIN
        dbms_output.put_line('nombre_procedimiento() param 1: ' || var1);
        dbms_output.put_line('nombre_procedimiento() param 1 usando metodo privado: ' || funcion_privada(var1));
        dbms_output.put_line('nombre_procedimiento() param 2: ' || var2);
        
    END nombre_procedimiento;
    
    FUNCTION nombre_funcion(f_var1 NUMBER, f_var2 VARCHAR2) RETURN VARCHAR2
    AS
        resultado VARCHAR2(200);
    BEGIN
        resultado := 'nombre_funcion() param 1 usando metodo privado: ' || funcion_privada(f_var1) || '- El número enviado fué' || f_var1 || ' y el texto ' || f_var2;
            
        RETURN resultado;
    END nombre_funcion;
END nombre_paquete;
/
SET SERVEROUTPUT ON
DECLARE
    v1_proc NUMBER;
    v2_proc VARCHAR2(100);
    v1_func NUMBER;
    v2_func VARCHAR2(100);
    
    return_funcion VARCHAR2(200);
BEGIN
    v1_proc := 5;
    v2_proc := 'Test enviado a proc';
    v1_func := 12;
    v2_func := 'Test enviado a funcion';
    
    nombre_paquete.nombre_procedimiento(v1_proc, v2_proc);
    
    return_funcion := nombre_paquete.nombre_funcion(v1_func, v2_func);
    dbms_output.put_line(return_funcion);
END testeo;
/


-- Objetos ---------------------------------------------------------------------
CREATE OR REPLACE TYPE nombre_obj AS OBJECT(
    atributo1 NUMBER,
    atributo2 VARCHAR2(30),
    
    --Método
    MEMBER FUNCTION nombre_funcion RETURN VARCHAR
    
) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY nombre_obj AS
    
    MEMBER FUNCTION nombre_funcion RETURN VARCHAR IS
    BEGIN
        RETURN SELF.atributo2;
    END nombre_funcion;
    
END;
/

--Objeto padre no instanciable, del que no se pueden crear instancias del mismo
CREATE OR REPLACE TYPE obj_padre AS OBJECT(
    attr1 NUMBER,
    attr2 VARCHAR2(30),
    
    MEMBER FUNCTION funcion1(param1 NUMBER) RETURN BOOLEAN
    
) NOT FINAL NOT INSTANTIABLE;
/

-- Herencia
CREATE OR REPLACE TYPE nombre_obj_hijo UNDER nombre_obj (
    atributo_hijo1 VARCHAR2(30),
    
    --Constructor
    CONSTRUCTOR FUNCTION nombre_obj_hijo(
        atributo1 NUMBER, atributo2 VARCHAR2, atributo_hijo1 VARCHAR2
    ) RETURN SELF AS RESULT
);
/
CREATE OR REPLACE TYPE BODY nombre_obj_hijo AS

    CONSTRUCTOR FUNCTION nombre_obj_hijo(
        atributo1 NUMBER, atributo2 VARCHAR2, atributo_hijo1 VARCHAR2
    ) RETURN SELF AS RESULT IS
    
    BEGIN
        SELF.atributo1 := atributo1;
        SELF.atributo2 := atributo2;
        SELF.atributo_hijo1 := atributo_hijo1;
        RETURN;
    END;
END;
/

-- Map
CREATE OR REPLACE TYPE objeto2 AS OBJECT(
    refObjt REF nombre_obj,
    attr1 NUMBER,

    -- Map
    MAP MEMBER FUNCTION ordenar RETURN NUMBER
);
/
CREATE OR REPLACE TYPE BODY objeto2 AS

    MAP MEMBER FUNCTION ordenar RETURN NUMBER IS
    obj nombre_obj;
    BEGIN
        SELECT DEREF(refObjt) INTO obj FROM DUAL;
        RETURN obj.nombre_funcion();
    END ordenar;
END;
/

--Crear Objetos
DECLARE
    objetoTipo1 nombre_obj;
    objetoTipo2 nombre_obj_hijo;
    objetoTipo3 objeto2;
BEGIN
    objetoTipo1 := nombre_obj(20, 'nombreObjeto');
    objetoTipo2 := nombre_obj_hijo(30, 'nombreObjeto', 'es hijo');
    objetoTipo3 := objeto2(objetoTipo1, 30);
END;
/

--Tabla de Objetos
CREATE TABLE tablaObjetos OF nombre_obj;
INSERT INTO tablaObjetos VALUES(nombre_obj(10, 'atributo2'));
INSERT INTO tablaObjetos VALUES(nombre_obj(13, 'nombre_atributo2'));
SELECT * FROM tablaobjetos;
/

-- Referencia a Objetos
DECLARE
    refObj REF nombre_obj;
    objetoTipo3 objeto2;
BEGIN
    SELECT REF(o) INTO refObj FROM tablaobjetos o WHERE o.atributo1 = 10;
    objetoTipo3 := objeto2(refObj, 34);
    dbms_output.put_line(objetoTipo3.attr1);
END;
/


--VARRAY -----------------------------------------------------------------------

--Crear VARRAY
CREATE OR REPLACE TYPE listaObjetos IS VARRAY(10) OF objeto2;
/
--Crear tabla VARRAY
CREATE TABLE tablaVarray (
    cod NUMBER,
    objetos listaObjetos
);
/
DECLARE
    refObj1 REF nombre_obj;
    refObj2 REF nombre_obj;
    objetoTipo3 objeto2;
    objetoTipo4 objeto2;
    varrayObj listaObjetos;
    
BEGIN
    varrayObj := listaObjetos();
    
    SELECT REF(o) INTO refObj1 FROM tablaobjetos o WHERE o.atributo1 = 10;
    objetotipo3 := objeto2(refObj1, 36);
    varrayObj.EXTEND();
    varrayObj(1) := objetotipo3;
    
    SELECT REF(o) INTO refObj2 FROM tablaobjetos o WHERE o.atributo1 = 10;
    objetotipo4 := objeto2(refObj2, 36);
    varrayObj.EXTEND();
    varrayObj(2) := objetotipo4;
    
--    INSERT INTO tablavarray VALUES(1, varrayObj(1));
--    INSERT INTO tablavarray VALUES(2, varrayObj(2));
    
    INSERT INTO tablavarray VALUES(1, varrayObj);
END;
/
SELECT * FROM tablavarray;





