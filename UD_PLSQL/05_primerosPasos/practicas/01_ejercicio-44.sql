/**
Pr�cticas funciones SQL en PL/SQL
1. Visualizar iniciales de un nombre
    - Crea un bloque PL/SQL con tres variables VARCHAR2:
        - Nombre
        - apellido1
        - apellido2
    - Debes visualizar las iniciales separadas por puntos.
    - Adem�s siempre en may�scula
    - Por ejemplo alberto p�rez Garc�a deber�a aparecer--> A.P.G
    
2. Averiguar el nombre del d�a que naciste, por ejemplo "Martes"
    - PISTA (Funci�n TO_CHAR)
**/

DECLARE
    nombre     VARCHAR2(50) := 'jes�s';
    apellido1  VARCHAR2(50) := 'mesias';
    apellido2  VARCHAR2(50) := 'rau';
    nac        DATE := '20/03/1978';
BEGIN
--1. Visualizar iniciales de un nombre
    -- Debes visualizar las iniciales separadas por puntos.
        dbms_output.put_line(substr(nombre, 1, 1)
                         || '.'
                         || substr(apellido2, 1, 1)
                         || '.'
                         || substr(apellido2, 1, 1));
    
    -- Adem�s siempre en may�scula
        dbms_output.put_line(upper(substr(nombre, 1, 1)
                               || '.'
                               || substr(apellido2, 1, 1)
                               || '.'
                               || substr(apellido2, 1, 1)));

--2. Averiguar el nombre del d�a que naciste, por ejemplo "Martes"
    
        dbms_output.put_line(TO_CHAR(nac, 'DAY'));
END;