
/*******************************************************************************
********************************************************************************/
-- COMPROBACIONES ------------------------------------------------------------

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
--CREATE SEQUENCE cod_pers;

SET SERVEROUTPUT ON;

DECLARE
    --Declaro objeto "personal"
    p1 personal;
    --Declaro objeto "responsable"
    r1 responsable;
    r2 responsable;
    --Declaro objeto "comercial"
--    c1 comercial;
    --Declaro objeto "zonas"
--    z1 zonas;

BEGIN
    --Instancio objeto p1
    p1 := NEW personal(1, '25639659Y', 'Federico', 'Lopez Vazques', 'H', '20/02/1975');
--    
    r1 := NEW responsable(2, 'Jesús', 'Sariñena', 'Arriaga', 'X');
    r2 := NEW responsable(3, '76859263H', 'Silvia', 'Ape2 Ape2', 'M', '11/11/1911', 'N', 4);
    
    
--    c1 := comercial();
--    z1 := zonas();

    dbms_output.put_line('p1 Personal = ' || p1.getDatos);
    dbms_output.put_line('r1 Responsable const propio = ' || r1.getDatos);
    dbms_output.put_line('r2 Responsable const heredado = ' || r2.getDatos);

END;
/
SELECT * FROM USER_TYPES;