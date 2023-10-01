/**
1 . Nombre y apellidos de los usuarios con crédito entre 200 y 400 ordenado por
crédito descendente.
**/
SELECT nombre, apellidos, credito
    FROM usuario
    WHERE credito BETWEEN 200 AND 400
    ORDER BY credito DESC;
/**
2. ¿Cuántos usuarios son mujeres?
**/
SELECT COUNT(*) FROM usuario WHERE sexo = 'M';
--SELECT * FROM usuario;

--Solucion
SELECT COUNT(SEXO)
FROM USUARIO
WHERE SEXO='M';
/**
3. Nombre y apellidos de los usuarios que tiene correo en Hotmail ordenado por 
apellido y nombre.
**/
SELECT nombre, apellidos, correo FROM usuario 
    WHERE LOWER(correo) LIKE('%hotmail%')
    ORDER BY 2, 1;

--Solucion
SELECT NOMBRE, APELLIDOS
FROM USUARIO
WHERE CORREO LIKE '%@hotmail.%'
ORDER BY 2,1;
/**
4. Suma del crédito de los usuarios de la provincia de Barcelona.
**/
SELECT provincia, SUM(credito) FROM usuario GROUP BY provincia HAVING LOWER(provincia) = 'barcelona';

--Solucion
SELECT SUM(CREDITO)
FROM USUARIO
WHERE PROVINCIA LIKE 'BARCELONA';

/**
5. Nombre, apellidos y fecha de nacimiento del usuario de mas edad.
**/
--Cogiendo la fecha más antigüa
SELECT nombre, apellidos, f_nacimiento FROM usuario
    WHERE f_nacimiento = (
        SELECT MIN(f_nacimiento) FROM usuario
    );

--Calculando la edad desde la fecha de nacimiento hasta la fecha del sistema
SELECT nombre || ' ' || apellidos AS Usuario, TRUNC(MONTHS_BETWEEN(SYSDATE,f_nacimiento)/12, 0) || ' ' || 'años' AS Edad
    FROM usuario
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE,f_nacimiento)/12, 0) = (
        SELECT MAX(TRUNC(MONTHS_BETWEEN(SYSDATE,f_nacimiento)/12, 0)) FROM usuario
    );

--Solucion
SELECT NOMBRE, APELLIDOS, f_nacimiento
FROM USUARIO
WHERE f_nacimiento <= ALL (SELECT f_nacimiento
FROM USUARIO);

/**
6. Listado con la suma del crédito de los usuarios de cada una de las provincias
ordenado por provincia.
**/
SELECT provincia, SUM(credito) FROM usuario GROUP BY provincia ORDER BY provincia;

--Solucion
SELECT PROVINCIA, SUM(CREDITO)
FROM USUARIO
GROUP BY PROVINCIA
ORDER BY 1;

/**
7. Provincias en las que la suma del crédito de los usuarios es menos de 200.
**/
SELECT provincia, SUM(credito) FROM usuario GROUP BY provincia HAVING SUM(credito) < 200;

--Solucion
SELECT PROVINCIA, SUM(CREDITO)
FROM USUARIO
GROUP BY PROVINCIA
HAVING SUM(CREDITO) < 200;

/**
8. ¿Cuál es la provincia en la que la suma de crédito de los usuarios es la mayor de todas?
**/
SELECT provincia, SUM(credito) FROM usuario
    GROUP BY provincia 
    HAVING SUM(credito) = (
        SELECT MAX(SUM(credito)) FROM usuario GROUP BY provincia
        );

--Solucion
SELECT PROVINCIA, SUM(CREDITO)
FROM USUARIO
GROUP BY PROVINCIA
HAVING SUM(CREDITO) >= ALL (SELECT SUM(CREDITO)
FROM USUARIO
GROUP BY PROVINCIA);

/**
9. Nombre y apellidos del usuario que ha creado cada una de las partidas indicando
de qué juego son.
**/
SELECT u.nombre || ' ' || u.apellidos AS "Creador", p.nombre AS "Nombre Partida", j.nombre AS "Juego" FROM usuario u
    JOIN partida p ON p.cod_creador_partida = u.login
    JOIN juego j ON p.cod_juego = j.codigo; 

--Solucion
SELECT U.NOMBRE, U.APELLIDOS, J.NOMBRE
FROM PARTIDA P INNER JOIN USUARIO U
ON (p.cod_creador_partida=U.LOGIN)
INNER JOIN JUEGO J
ON (P.COD_JUEGO=J.CODIGO);

/**
10. Juegos de los que no hay partida comenzada.
**/
--La consulta que he realizado muestra las partidas que estan finalizada, NO las que indica el enunciado
SELECT j.nombre, p.estado FROM juego j
    INNER JOIN partida p ON p.cod_juego = j.codigo
    WHERE p.estado = 0;

--Solucion
SELECT NOMBRE
FROM JUEGOS
WHERE CODIGO NOT IN (SELECT J.CODIGO
FROM JUEGOS J,PARTIDAS P
WHERE J.CODIGO=P.COD_JUEGO);

/**
11. Listado de juegos de los que hay partida en funcionamiento.
**/
SELECT j.nombre, p.estado FROM juego j
    INNER JOIN partida p ON p.cod_juego = j.codigo
    WHERE p.estado = 1;

--Solucion
SELECT DISTINCT (J.NOMBRE)
FROM JUEGOS J INNER JOIN PARTIDAS P
ON J.CODIGO = P.COD_JUEGO;
/**
12. Listado de nombre y apellidos de usuario y número de partidas en las que está jugando ordenador de mayor a menor.
**/
SELECT u.nombre, u.apellidos, COUNT(un.codigo_partida) FROM usuario u
    INNER JOIN unen un ON un.codigo_usuario = u.login
    GROUP BY u.nombre, u.apellidos
    ORDER BY 3 DESC;

--Solucion
SELECT U.NOMBRE, U.APELLIDOS, COUNT(*)
FROM USUARIOS U INNER JOIN UNEN N
ON U.LOGIN=N.CODIGO_USUARIO
GROUP BY U.NOMBRE, U.APELLIDOS
ORDER BY 3 DESC;