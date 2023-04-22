
/*******************************************************************************
********************************************************************************/
-- COMPROBACIONES ------------------------------------------------------------

--ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
--CREATE SEQUENCE cod_pers;

SET SERVEROUTPUT ON;

DECLARE
    --Declaro objeto "personal"
    p1 personal;
    --Declaro objeto "responsable"
    r1 responsable;
    --Declaro objeto "comercial"
--    c1 comercial;
    --Declaro objeto "zonas"
--    z1 zonas;

BEGIN
    --Instacio objeto p1
    p1 := NEW personal(1, '25639659Y', 'Federico', 'Lopez Vazques', 'H', '20/02/1975');
    
    r1 := NEW responsable(2, 'Jesús', 'Sariñena', 'Arriaga', 'X');
    
--    c1 := comercial();
--    z1 := zonas();

    dbms_output.put_line('p1 Personal = ' || p1.getDatos);
    dbms_output.put_line('r1 Responsable const 1 = ' || r1.getDatos);
    --dbms_output.put_line('r2 Responsable const 2 = ' || r2.getDatos);

END;
/
SELECT * FROM USER_TYPES;