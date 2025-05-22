
-- Pr�cticas Bucles

/*******************************************************************************
1. Pr�ctica 1 ------------------------------------------------------------------
� Vamos a crear la tabla de multiplicar del 1 al 10, con los tres tipos de bucles:
LOOP, WHILE y FOR
********************************************************************************/

----------------------------------------------------------------    LOOP    ----
DECLARE
    x  NUMBER := 1;
    y  NUMBER := 1;
    /** "X" y "Y" son dos variables num�ricas que se declaran en las l�neas siguientes.
    El valor de "X" se usar� como el multiplicando, mientras que "Z" se usar� como
    el multiplicador.**/
BEGIN
    << parent >>
    /** Luego, en el bucle "LOOP" (que se ejecutar� indefinidamente hasta que se
    encuentre una instrucci�n de salida), se verifica si el valor de "X" es igual
    a 11. Si es as�, se sale del bucle utilizando la instrucci�n "EXIT". **/ LOOP
        EXIT parent WHEN x = 11;
        dbms_output.put_line('Tabla de multiplicar de ' || x);
        << child >>
        /** Despu�s, hay otro bucle "LOOP" anidado dentro del primer bucle "LOOP".
        Este bucle se ejecutar� indefinidamente hasta que se encuentre una instrucci�n
        de salida. Dentro de este bucle, se verifica si el valor de "Z" es igual
        a 11. Si es as�, se sale del bucle utilizando la instrucci�n "EXIT".**/ LOOP
            EXIT child WHEN y = 11;
            dbms_output.put_line(x || ' x ' || y || ' = ' || x * y);
            
            /** La l�nea "y:=y+1;" incrementa el valor de "y" en 1 en cada iteraci�n
            del bucle interno.**/
            y := y + 1;
        END LOOP child;
        /** Despu�s de salir del bucle interno, la l�nea "y:=0;" restablece el
        valor de "y" a 0. **/
                y := 0;
        /** La l�nea "X:=X+1;" incrementa el valor de "X" en 1 en cada iteraci�n
        del bucle externo. **/
                x := x + 1;
    END LOOP parent;
END;
/

---------------------------------------------------------------    WHILE    ----
DECLARE
    x     NUMBER;
    y     NUMBER;
    r     NUMBER;
BEGIN
    x := 1;
    y := 1;
    dbms_output.put_line('Tabla de multiplicar de ' || x);
    WHILE x <= 10 LOOP
        WHILE y <= 10 LOOP
            r := x * y;
            dbms_output.put_line(x || ' x ' || y || ' = ' || r);
            y := y + 1;
        END LOOP;
        y := 1;
        x := x + 1;
    END LOOP;
END;
/
-----------------------------------------------------------------    FOR    ----
DECLARE
    r     NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line('Tabla de multiplicar de ' || i);
        
        FOR z IN 1..10 LOOP
        r := i * z;
            dbms_output.put_line(i || ' x ' || z || ' = ' || r);
        END LOOP;
    END LOOP;
END;
/

/*******************************************************************************
2. Pr�ctica 2 ------------------------------------------------------------------
� Crear una variable llamada TEXTO de tipo VARCHAR2(100).
� Poner alguna frase
� Mediante un bucle, escribir la frase al rev�s, Usamos el bucle WHILE
********************************************************************************/

--LENGTH(cad): devuelve el n�mero de caracteres de cad
--SUBSTR(cad, m[,n]): Devuelve la subcadena de cad que abarca desde m hasta el numero de caracteres dados por n.

DECLARE
    texto VARCHAR(100) := 'buenos dias';
    x NUMBER := LENGTH(texto);
    -- Variable tipo VARCHAR2. Esta variable se utilizar� para almacenar la cadena de texto invertida.
    res VARCHAR2(100);
BEGIN
    WHILE x > 0 LOOP
        res := res || SUBSTR(texto, x, 1);
        /* se concatena cada car�cter de la cadena de texto almacenada en la variable
        "texto" a la variable "res" en orden inverso utilizando la funci�n SUBSTR.
        La funci�n SUBSTR se utiliza para obtener una subcadena de una cadena de
        texto y se especifica la posici�n de inicio (en este caso, "x") y la longitud
        de la subcadena (en este caso, 1 car�cter).
        */
        x := x - 1;
        /* se decrementa el valor de "x" en 1 para procesar el siguiente car�cter
        de la cadena de texto.
        */
    END LOOP;
    dbms_output.put_line(res);
END;
/


/*******************************************************************************
3. Pr�ctica 3 ------------------------------------------------------------------
� Usando la pr�ctica anterior, si en el texto aparece el car�cter "x" debe salir
del bucle. Es igual en may�sculas o min�sculas.
� Debemos usar la cl�usula EXIT.
********************************************************************************/
--EXIT WHEN x = 5;

DECLARE
    texto VARCHAR(100) := 'buenos dias exit';
    x NUMBER := LENGTH(texto);
    -- Variable tipo VARCHAR2. Esta variable se utilizar� para almacenar la cadena de texto invertida.
    res VARCHAR2(100);
    
    -- Variable tipo CHAR. Se utiliza para almacenar la letra que corresponda de la cadena
    car CHAR(1);
BEGIN
    WHILE x > 0 LOOP
        
        car := SUBSTR(texto, x, 1);
        res := res || car;
        x := x - 1;

        EXIT WHEN LOWER(car) = 'x';
    END LOOP;
    dbms_output.put_line(res);
END;
/

/*******************************************************************************
4. Pr�ctica 4 ------------------------------------------------------------------
� Debemos crear una variable llamada NOMBRE
� Debemos pintar tantos asteriscos como letras tenga el nombre. Usamos un bucle FOR
� Por ejemplo Alberto ? ******* � por ejemplo Pedro ? *****
********************************************************************************/
DECLARE
    nombre VARCHAR2(100);
    asteriscos VARCHAR(100);
    x PLS_INTEGER; --para poner el m�x. al loop
BEGIN
    nombre := 'Victor';
    x := LENGTH(nombre);
    --dbms_output.put_line(nombre || '; tiene una longiud de ' || x);
    FOR i IN 1..x LOOP
        --Concatena un asterisco por "cada vuelta" a la variable asteriscos
        asteriscos := asteriscos || '*';
    END LOOP;
    dbms_output.put_line(nombre || ' ? ' || asteriscos);
END;
/
/*******************************************************************************
5. Pr�ctica 5 ------------------------------------------------------------------
� Creamos dos variables num�ricas, "inicio y fin"
� Las inicializamos con alg�n valor:
� Debemos sacar los n�meros que sean m�ltiplos de 4 de ese rango
********************************************************************************/
DECLARE
    ini PLS_INTEGER;
    fin PLS_INTEGER;
    
    res NUMBER;
BEGIN
    ini := 0;
    fin := 20;
    FOR i IN ini..fin LOOP
        res := MOD(i,4);
        IF res = 0
            THEN dbms_output.put_line('******************' || i || ' es m�ltiplo de 4');
--            ELSE dbms_output.put_line(i || ' NO es m�ltiplo de 4, su resto es ' || res);
        END IF;
    END LOOP;
END;
/