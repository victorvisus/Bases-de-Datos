--Ver un procedimiento

-- USER_OBJECTS : contiene todos mis objetos, tablas, vistas, etc.. ------------
SELECT * FROM user_objects WHERE object_type = 'PROCEDURE';
-- En la columna STATUS, podemos ver si el procedimiento esta bien compilado

SELECT object_type, COUNT(*) FROM user_objects
    GROUP BY object_type;
--La anterior query no indica el numero de objetos que tenemos

-- Como ver el cód. fuente
/* El nombre siempre se guarda en Mayusculas */
SELECT * FROM user_source WHERE name = 'PRO1';

SELECT text FROM user_source WHERE name = 'PRO1';