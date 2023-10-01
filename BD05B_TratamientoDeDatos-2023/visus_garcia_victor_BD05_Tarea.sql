--2. 
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad) 
    VALUES (2, 'NEREA', 'FABRE BERDUN', '51083099F', 'TECNOLOGIA', '31/03/1975',4);
INSERT INTO profesorado (codigo, nombre, apellidos, especialidad, fecha_nac)
    VALUES (3, 'JAVIER', 'JIMENEZ HERNANDO', 'LENGUA', '04/05/1969');
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad)
    VALUES (4, 'BELEN', 'FERNANDEZ MARTINEZ', '19964324W', 'INGLES', '22/06/1973',2);
INSERT INTO profesorado (codigo, nombre, apellidos, especialidad, fecha_nac, antiguedad)
    VALUES (5, 'JAVIER', 'ANERO PAYAN', 'INFORMATICA', '31/05/1985',12);

--4.
--UPDATE nombre_tabla SET nombre_campo = valor [, nombre_ campo = valor] [ WHERE condición ];
UPDATE profesorado SET fecha_nac = '22/06/1974', antiguedad = 4
    WHERE UPPER(nombre) = 'BELEN';

SELECT * FROM profesorado WHERE UPPER(nombre) = 'BELEN';

--5.
SELECT * FROM profesorado;

SELECT nombre, COALESCE(antiguedad,0) FROM profesorado;
UPDATE profesorado SET antiguedad = (COALESCE(antiguedad,0) + 3);

--7.
DELETE FROM alumnado WHERE cod_curso = 3;

--8.
INSERT INTO alumnado (nombre, apellidos, sexo, fecha_nac)
    SELECT nombre, apellidos, sexo, fecha_nac FROM alumnado_nuevo;

--9
UPDATE cursos SET max_alumn = (
    SELECT COUNT(codigo) FROM alumnado WHERE cod_curso = 2
) WHERE codigo = 2;

--10
DELETE FROM alumnado WHERE cod_curso IN (
  SELECT c.codigo FROM cursos c, profesorado p
  WHERE c.cod_profe = p.codigo AND p.nombre = 'NURIA'
);