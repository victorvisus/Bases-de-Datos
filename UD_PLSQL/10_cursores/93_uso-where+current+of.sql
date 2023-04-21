-- UPDATES Y DELETES con WHERE CURRENT OF
/**
Se pueden modificar los datos de un cursor "al vuelo"
**/
DECLARE
    CURSOR cur_empl IS SELECT * FROM employees FOR UPDATE; --Con esto bloqueamos los datos en la BBDD, nadie podrá modificarlos
    empl employees%ROWTYPE;
    
BEGIN
    OPEN cur_empl; --abrimos el cursor
    
    LOOP --creamos un bucle para recorrerlo
        FETCH cur_empl INTO empl; --cargamos los datos en una variable tipo %ROWTYPE
        EXIT WHEN cur_empl%NOTFOUND;
        IF empl.commission_pct IS NOT NULL THEN --Comprobamos si el campo comm no es nulo
            UPDATE employees SET salary = salary * 1.10 WHERE CURRENT OF cur_empl;
            --con WHERE CURRENT OF... se le dice que actualice la fila donde me encuentro en este momento.
       ELSE
            UPDATE employees SET salary = salary * 1.10 WHERE CURRENT OF cur_empl;
        END IF;
    END LOOP;
    
    CLOSE cur_empl;
END;
/