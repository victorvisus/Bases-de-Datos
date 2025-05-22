-- DISCO DURO DE REOR

--4. Mostrar los numeros del 1 al 100 con WHILE --------------------------------
declare
    i number(8) := 1;
begin
    dbms_output.put_line('Bucle WHILE');
    while (i <= 10) loop
        dbms_output.put_line(i);
        i := i +1;
    end loop;
end;
/
--5. Mostrar los numeros del 1 al 100 con FOR ----------------------------------
begin
    dbms_output.put_line('Bucle FOR');
    for i in 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/
begin
    dbms_output.put_line('Bucle FOR REVERSE');
    for i in reverse 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/
--6. Mostrar los numeros del 1 al 100 con LOOP ---------------------------------
declare
    i number(8) := 1;
begin
    dbms_output.put_line('Bucle LOOP');
    loop
        dbms_output.put_line(i);
        exit when i = 10; --Depende donde se ponga sera verdadero o falso
        i := i +1;
    end loop;
end;
/