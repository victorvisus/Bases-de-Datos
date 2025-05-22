
-- Prácticas Bucles

/*******************************************************************************
1. Práctica 1 ------------------------------------------------------------------
• Vamos a crear la tabla de multiplicar del 1 al 10, con los tres tipos de bucles:
LOOP, WHILE y FOR
********************************************************************************/

----------------------------------------------------------------    LOOP    ----
DECLARE
    x  NUMBER := 1;
    y  NUMBER := 1;
    /** "X" y "Y" son dos variables numéricas que se declaran en las líneas siguientes.
    El valor de "X" se usará como el multiplicando, mientras que "Z" se usará como
    el multiplicador.**/
BEGIN
    << parent >>
    /** Luego, en el bucle "LOOP" (que se ejecutará indefinidamente hasta que se
    encuentre una instrucción de salida), se verifica si el valor de "X" es igual
    a 11. Si es así, se sale del bucle utilizando la instrucción "EXIT". **/ LOOP
        EXIT parent WHEN x = 11;
        dbms_output.put_line('Tabla de multiplicar de ' || x);
        << child >>
        /** Después, hay otro bucle "LOOP" anidado dentro del primer bucle "LOOP".
        Este bucle se ejecutará indefinidamente hasta que se encuentre una instrucción
        de salida. Dentro de este bucle, se verifica si el valor de "Z" es igual
        a 11. Si es así, se sale del bucle utilizando la instrucción "EXIT".**/ LOOP
            EXIT child WHEN y = 11;
            dbms_output.put_line(x || ' x ' || y || ' = ' || x * y);
            
            /** La línea "y:=y+1;" incrementa el valor de "y" en 1 en cada iteración
            del bucle interno.**/
            y := y + 1;
        END LOOP child;
        /** Después de salir del bucle interno, la línea "y:=0;" restablece el
        valor de "y" a 0. **/
                y := 0;
        /** La línea "X:=X+1;" incrementa el valor de "X" en 1 en cada iteración
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
2. Práctica 2 ------------------------------------------------------------------
• Crear una variable llamada TEXTO de tipo VARCHAR2(100).
• Poner alguna frase
• Mediante un bucle, escribir la frase al revés, Usamos el bucle WHILE
********************************************************************************/

--LENGTH(cad): devuelve el número de caracteres de cad
--SUBSTR(cad, m[,n]): Devuelve la subcadena de cad que abarca desde m hasta el numero de caracteres dados por n.

DECLARE
    texto VARCHAR(100) := 'buenos dias';
    x NUMBER := LENGTH(texto);
    -- Variable tipo VARCHAR2. Esta variable se utilizará para almacenar la cadena de texto invertida.
    res VARCHAR2(100);
BEGIN
    WHILE x > 0 LOOP
        res := res || SUBSTR(texto, x, 1);
        /* se concatena cada carácter de la cadena de texto almacenada en la variable
        "texto" a la variable "res" en orden inverso utilizando la función SUBSTR.
        La función SUBSTR se utiliza para obtener una subcadena de una cadena de
        texto y se especifica la posición de inicio (en este caso, "x") y la longitud
        de la subcadena (en este caso, 1 carácter).
        */
        x := x - 1;
        /* se decrementa el valor de "x" en 1 para procesar el siguiente carácter
        de la cadena de texto.
        */
    END LOOP;
    dbms_output.put_line(res);
END;
/


/*******************************************************************************
3. Práctica 3 ------------------------------------------------------------------
• Usando la práctica anterior, si en el texto aparece el carácter "x" debe salir
del bucle. Es igual en mayúsculas o minúsculas.
• Debemos usar la cláusula EXIT.
********************************************************************************/
--EXIT WHEN x = 5;

DECLARE
    texto VARCHAR(100) := 'buenos dias exit';
    x NUMBER := LENGTH(texto);
    -- Variable tipo VARCHAR2. Esta variable se utilizará para almacenar la cadena de texto invertida.
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
4. Práctica 4 ------------------------------------------------------------------
• Debemos crear una variable llamada NOMBRE
• Debemos pintar tantos asteriscos como letras tenga el nombre. Usamos un bucle FOR
• Por ejemplo Alberto ? ******* ó por ejemplo Pedro ? *****
********************************************************************************/
DECLARE
    nombre VARCHAR2(100);
    asteriscos VARCHAR(100);
    x PLS_INTEGER; --para poner el máx. al loop
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
5. Práctica 5 ------------------------------------------------------------------
• Creamos dos variables numéricas, "inicio y fin"
• Las inicializamos con algún valor:
• Debemos sacar los números que sean múltiplos de 4 de ese rango
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
            THEN dbms_output.put_line('******************' || i || ' es múltiplo de 4');
--            ELSE dbms_output.put_line(i || ' NO es múltiplo de 4, su resto es ' || res);
        END IF;
    END LOOP;
END;
/