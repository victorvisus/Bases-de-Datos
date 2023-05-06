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