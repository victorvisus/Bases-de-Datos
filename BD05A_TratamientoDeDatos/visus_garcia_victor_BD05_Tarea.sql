/* He usado SQL Developer en vez de APEX, debido a que me ha sido imposible iniciar
sesión en esta aplicación, la instalación apartentemente la he realizado correctamente
, pero he sido incapaz de iniciar sesión con ninguno de los usuarios que tengo.
Como en el temario simplemente se hace mención a este entorno gráfico, sin que se
encuentre  ninguna explicación, ni guia sobre esta herramienta, he decidido usar
la aplicación que se usa en el temario, por no perder tiempo.
*/

/*  1. Inserta un registro nuevo en la tabla PROFESORADO utilizando la herramienta
gráfica Application Express que ofrece Oracle Database Express. Los datos deben 
ser los siguientes:
    Codigo: 1
    Nombre: NURIA
    Apellidos: ANERO GONZALEZ
    DNI: 58328033X
    Especialidad: MATEMATICAS
    Fecha_Nac: 22/02/1972
    Antiguedad: 9
Debes entregar una captura de pantalla de la ventana en la que estás introduciendo
los datos, justo antes de pulsar el botón para guardarlos.


SE ADJUNTA ARCHIVO PDF, con la información requerida: BD05_capturas-tarea.pdf
*/

/*  2. Inserta varios registros más en la tabla PROFESORADO utilizando sentencias SQL.
Los datos deben ser los siguientes:
    2   MARIA LUISA   FABRE BERDUN        51083099F   TECNOLOGIA   31/03/75   4
    3   JAVIER        JIMENEZ HERNANDO                LENGUA       04/05/69   10
    4   ESTEFANIA     FERNANDEZ MARTINEZ  19964324W   INGLES       22/06/73   5
    5   JOSE M.       ANERO PAYAN
    
    SE ADJUNTA ARCHIVO PDF, con el resultado: BD05_capturas-tarea.pdf
*/
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad)
  VALUES (2, 'MARIA LUISA', 'FABRE BERDUN', '51083099F', 'TECNOLOGIA', '31/03/1975', 4);
INSERT INTO profesorado (codigo, nombre, apellidos, especialidad, fecha_nac, antiguedad)
  VALUES (3, 'JAVIER', 'JIMENEZ HERNANDO', 'lengua', '04/05/1969', 10);
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad)
  VALUES (4, 'ESTEFANIA', 'FERNANDEZ MARTINEZ', '19964324W', 'INGLES', '22/06/1973', 5);
INSERT INTO profesorado (codigo, nombre, apellidos)
  VALUES (5, 'MARIA LUISA', 'FABRE BERDUN');

/*  3. Modifica los registros de la tabla CURSOS para asignar a cada curso un 
profesor o profesora. Utiliza para ello la herramienta gráfica, entregando con
la tarea una captura de pantalla de la pestaña Datos de esa tabla, donde se
aprecien todos los cambios que has realizado. El profesorado que debes asignar a
cada curso es:
    codigo  Cod_Profe
    1       4
    2       2
    3       2
    4       1
    5       1
    6       3
    
    SE ADJUNTA ARCHIVO PDF, con el resultado: BD05_capturas-tarea.pdf
*/

/*   4. Modifica el registro de la profesora "ESTEFANIA", usando sentencias SQL,
y cambia su fecha de nacimiento a "22/06/1974" y la antigüedad a 4. En la entrega
de la tarea debes copiar la sentencia que has utilizado.

SE ADJUNTA ARCHIVO PDF, con el resultado: BD05_capturas-tarea.pdf
*/
UPDATE profesorado SET fecha_nac = '22/06/1974', antiguedad = 4
    WHERE nombre = 'ESTEFANIA';

/*   5. Modifica las antigüedades de todos los profesores y profesoras incrementándolas
en 1 en todos los registros. Debes hacerlo usando un sola sentencia SQL que debes
copiar para la entrega de la tarea.

    SE ADJUNTA ARCHIVO PDF, con el resultado: BD05_capturas-tarea.pdf
*/
UPDATE profesorado SET antiguedad = antiguedad + 1;

/*    6. Elimina, de la tabla CURSOS, el registro del curso que tiene el código 6.
Debes realizar esta acción desde la herramienta gráfica. Debes entregar una captura
de pantalla de la ventana en la que vas a borrar el registro, justo antes de pulsar
el botón Aceptar para confirmar el borrado.

    SE ADJUNTA ARCHIVO PDF, con el resultado: BD05_capturas-tarea.pdf
*/

/*     7. Elimina, de la tabla ALUMNADO, aquellos registros asociados al curso
con código 3. Debes hacerlo usando un sola sentencia SQL que debes copiar para 
la entrega de la tarea.
*/
DELETE FROM alumnado WHERE cod_curso = 3;

SELECT * FROM alumnado WHERE cod_curso = 3;

/*     8. Inserta los registros de la tabla ALUMNADO_NUEVO en la tabla ALUMNADO.
Debes hacerlo usando un sola sentencia SQL que debes copiar para la entrega de la
tarea.
*/
INSERT INTO alumnado(nombre,apellidos,sexo,fecha_nac)
        SELECT
            nombre, apellidos, sexo, fecha_nac
            FROM alumnado_nuevo;

/*      9. En la tabla CURSOS, actualiza el campo Max_Alumn del registro del curso
con código 2, asignándole el valor correspondiente al número total de alumnos y
alumnas que hay en la tabla ALUMNADO y que tienen asignado ese mismo curso.
*/
UPDATE cursos SET Max_alumn = (
    SELECT COUNT(alumnado.codigo) FROM alumnado
        WHERE alumnado.cod_curso = 2)
    WHERE cursos.codigo = 2;

SELECT cursos.max_alumn FROM cursos WHERE cursos.codigo = 2;

/*       10. Elimina de la tabla ALUMNADO todos los registros asociados a los 
cursos que imparte la profesora cuyo nombre es "NURIA".
*/
DELETE FROM alumnado WHERE cod_curso IN (
  SELECT cur.codigo FROM cursos cur, profesorado prof
  WHERE cur.cod_profe = prof.codigo AND prof.nombre = 'NURIA'
  );