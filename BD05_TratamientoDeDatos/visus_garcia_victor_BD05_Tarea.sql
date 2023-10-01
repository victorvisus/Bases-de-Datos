/*  1. Inserta un registro nuevo en la tabla PROFESORADO utilizando sentencias SQL.
Los datos deben ser los siguientes:
    Codigo: 1
    Nombre: NURIA
    Apellidos: ANERO GONZALEZ
    DNI: 58328033X
    Especialidad: MATEMATICAS
    Fecha_Nac: 22/02/1972
    Antiguedad: 9
*/

INSERT INTO profesorado (codigo,nombre,apellidos,dni,especialidad,fecha_nac,antiguedad)
    VALUES (1,'NURIA','ANERO GONZALEZ','58328033X','MATEMATICAS','22/02/1972',9);
    
/*  2. Inserta varios registros más en la tabla PROFESORADO utilizando sentencias SQL.
Los datos deben ser los siguientes:
    2   MARIA LUISA   FABRE BERDUN        51083099F   TECNOLOGIA   31/03/75   4
    3   JAVIER        JIMENEZ HERNANDO                LENGUA       04/05/69   10
    4   ESTEFANIA     FERNANDEZ MARTINEZ  19964324W   INGLES       22/06/73   5
    5   JOSE M.       ANERO PAYAN
    
CONSULTA: Haciendo el script de la siguiente manera, me da un error
"comando SQL no terminado correctamente", pero no veo donde esta el error.

    INSERT INTO profesorado (codigo,nombre,apellidos,dni,especialidad,fecha_nac,antiguedad) 
        VALUES
            (2,'MARIA LUISA','FABRE BERDUN','51083099F','TECNOLOGIA','31/03/75',4),
            (3,'JAVIER','JIMENEZ HERNANDO',null,'LENGUA','04/05/69',10),
            (4,'ESTEFANIA','FERNANDEZ MARTINEZ','19964324W','INGLES','22/06/73',5),
            (5,'JOSE M.','ANERO PAYAN',null,null,null,null);

*/
INSERT INTO profesorado (codigo,nombre,apellidos,dni,especialidad,fecha_nac,antiguedad) 
    VALUES (2,'MARIA LUISA','FABRE BERDUN','51083099F','TECNOLOGIA','31/03/75',4);
INSERT INTO profesorado (codigo,nombre,apellidos,especialidad,fecha_nac,antiguedad) 
    VALUES (3,'JAVIER','JIMENEZ HERNANDO','LENGUA','04/05/69',10);
INSERT INTO profesorado (codigo,nombre,apellidos,dni,especialidad,fecha_nac,antiguedad) 
    VALUES (4,'ESTEFANIA','FERNANDEZ MARTINEZ','19964324W','INGLES','22/06/73',5);
INSERT INTO profesorado (codigo,nombre,apellidos) 
    VALUES (5,'JOSE M.','ANERO PAYAN');
    
/*  3. Modifica los registros de la tabla CURSOS para asignar a cada curso un profesor
o profesora, usando sentencias SQL. Deberás entregas las sentencias ejecutadas y una
captura del resultado final donde se aprecien todos los cambios que has realizado.
El profesorado que debes asignar a cada curso es:
    codigo  Cod_Profe
    1       4
    2       2
    3       2
    4       1
    5       1
    6       3
UPDATE cursos SET cod_profe = 4 WHERE codigo = 1;
UPDATE cursos SET cod_profe = 2 WHERE codigo = 2;
UPDATE cursos SET cod_profe = 2 WHERE codigo = 3;
UPDATE cursos SET cod_profe = 1 WHERE codigo = 4;
UPDATE cursos SET cod_profe = 1 WHERE codigo = 5;
UPDATE cursos SET cod_profe = 3 WHERE codigo = 6;
*/

-- Usando un condicional
UPDATE cursos SET cod_profe =
    CASE codigo
        WHEN 1 THEN 4
        WHEN 2 THEN 2
        WHEN 3 THEN 2
        WHEN 4 THEN 1
        WHEN 5 THEN 1
        WHEN 6 THEN 3
END;
  
SELECT * FROM cursos;
-- SE ADJUNTA ARCHIVO IMAGEN CON LOS RESULTADOS DE LA TABLA

/* 4. Modifica el registro de la profesora "ESTEFANIA", usando sentencias SQL, y
cambia su fecha de nacimiento a "22/06/1974" y la antigüedad a 4. En la entrega 
de la tarea debes copiar la sentencia que has utilizado.
*/

UPDATE profesorado SET fecha_nac = '22/06/1974', antiguedad = 4
    WHERE nombre = 'ESTEFANIA';
    
/* 5. Modifica las antigüedades de todos los profesores y profesoras incrementándolas
en 1 en todos los registros. Debes hacerlo usando un sola sentencia SQL que debes
copiar para la entrega de la tarea.
*/
UPDATE profesorado SET antiguedad = antiguedad + 1;

/*  6. Elimina, de la tabla CURSOS, el registro del curso que tiene el código 6.
Debes realizar esta acción desde la herramienta gráfica. Debes entregar una captura
de pantalla de la ventana en la que vas a borrar el registro, justo antes de pulsar
el botón Aceptar para confirmar el borrado.
*/
-- SE ADJUNTA DOCUMENTO odt

/*  7. Elimina, de la tabla ALUMNADO, aquellos registros asociados al curso con código 3.
Debes hacerlo usando un sola sentencia SQL que debes copiar para la entrega de la tarea.
*/
DELETE FROM alumnado WHERE cod_curso = 3;

/*  8. Inserta los registros de la tabla ALUMNADO_NUEVO en la tabla ALUMNADO.
Debes hacerlo usando un sola sentencia SQL que debes copiar para la entrega de la tarea.
*/
INSERT INTO alumnado(nombre,apellidos,sexo,fecha_nac)
        SELECT
            nombre, apellidos, sexo, fecha_nac
            FROM alumnado_nuevo;
            
/* 9. En la tabla CURSOS, actualiza el campo Max_Alumn del registro del curso con
código 2, asignándole el valor correspondiente al número total de alumnos y alumnas
que hay en la tabla ALUMNADO y que tienen asignado ese mismo curso.
*/
UPDATE cursos SET Max_alumn = (
    SELECT COUNT(alumnado.codigo) FROM alumnado
        WHERE alumnado.cod_curso = 2)
    WHERE cursos.codigo = 2
;

/* 10. Elimina de la tabla ALUMNADO todos los registros asociados a los cursos que
imparte la profesora cuyo nombre es "NURIA".

relacionar profesorado.nombre = NURIA con su profesorado.codigo
y que sea el mismo que tiene en cursos.cod_profe

-- Consulta para mostrar los cursos de Alumnado correspondientes a NURIA
SELECT cur.codigo AS COD_CURSO, al.nombre
    FROM alumnado al, cursos cur, profesorado prof
    WHERE cur.cod_profe = prof.codigo AND prof.nombre = 'NURIA';
*/
DELETE FROM alumnado WHERE cod_curso IN (SELECT cur.codigo FROM cursos cur, profesorado prof
                        WHERE cur.cod_profe = prof.codigo AND prof.nombre = 'NURIA');
    

