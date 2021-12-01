-- ******************************************************************************** --
-- *************** EJERCICIO 1: Creacion de bases de datos y estructuras de tablas. --
-- ******************************************************************************** --


-- *************************************************************** TABLE Profesores --

CREATE TABLE Profesores (
    -- 3.5 Dos profesores no pueden llamarse igual. -- Solo aplico UNIQUE al campo nombre
	nombre VARCHAR2(20) CONSTRAINT prof_nom_UNN UNIQUE NOT NULL,
	apellido_1 VARCHAR2(20) CONSTRAINT prof_ap1__NN NOT NULL,
	apellido_2 VARCHAR2(20),
    -- 3.7 Se debe poder diferenciar las tuplas de la tabla PROFESORES por el NIF. - PRIMARY KEY
	nif_prof CHAR(9) CONSTRAINT prof_nif_PK PRIMARY KEY,
	direccion VARCHAR2(50),
	titulacion VARCHAR2(30),
    -- 3.3 Para cada profesor el atributo Salario no puede estar vacío. - NOT NULL
	salario_mes NUMBER(4,2) CONSTRAINT prof_sal_NN NOT NULL
    
    -- CORRECCIÓN - restriccion 5 no implementada correctamente (no sólo el nombre, también debe incluir los apellidos)
    /*
    CONSTRAINT PKA_Nombre UNIQUE (NombreProfesor, Apellido1Profesor,Apellido2Profesor)
    */
);
-- Modifico el tamaño del tipo de dato porque con el introducido al crear la tabla me indicaba que el valor a añadir en el campo salario_mes es mayor que la precisión especificada --
ALTER TABLE Profesores MODIFY (salario_mes NUMBER(8));


-- Inserto valores a los campos y poder comprobar reglas
INSERT INTO Profesores VALUES (
	'Luis', 'Soler', 'Peres', '23426356H', 'su calle 23', 'Matemáticas', 900
);
INSERT INTO Profesores VALUES (
	'Miguel', 'García', 'Lopez', '17568952L', 'calle del pino 33', 'Musica', 1500.97
);


-- ******************************************************************* TABLE Cursos --

CREATE TABLE Cursos (
    -- 3.4 Dos cursos no pueden llamarse de la misma forma - UNIQUE
	curso VARCHAR2(15) NOT NULL CONSTRAINT cur_nom_UN UNIQUE,
    -- 3.6 Se debe poder diferenciar las tuplas de la tabla CURSOS por el Código del Curso. - PRIMARY KEY
	id_curso NUMBER(3) CONSTRAINT cur_idcurs_PK PRIMARY KEY,
	nif_prof CHAR(9),
	num_max_alumnos NUMBER(2),
	fecha_ini DATE,
	fecha_fin DATE,
    -- 3.2 En un curso, el número de horas es un dato obligatorio, es obligatorio que contenga información. - NOT NULL
	num_horas NUMBER(4) NOT NULL,
    -- 3.10 Se debe cumplir la regla de integridad referencial.
	CONSTRAINT cur_prof_FK FOREIGN KEY (nif_prof) REFERENCES Profesores ON DELETE SET NULL
);

-- La fecha de fin del curso siempre tiene que ser mayor que la fecha de inicio del mismo.
ALTER TABLE Cursos ADD CONSTRAINT cur_fin_val CHECK (fecha_fin>fecha_ini);
ALTER TABLE Cursos MODIFY (nif_prof NOT NULL);


-- Inserto valores a los campos y poder comprobar reglas
INSERT INTO Cursos VALUES (
    'Solfeo', 1, '17568952L', 10, '01/12/2020', '30/12/2020', 60
);


-- ****************************************************************** TABLE Alumnos --

CREATE TABLE Alumnos (	
	nombre VARCHAR2(20) CONSTRAINT alu_nom_NN NOT NULL,
	apellido_1 VARCHAR2(20) CONSTRAINT alu_ap1_NN NOT NULL,
	apellido_2 VARCHAR2(20),
    -- 3.7 Se debe poder diferenciar las tuplas de la tabla ALUMNOS por el NIF. - PRIMARY KEY
	nif_alum CHAR(9) CONSTRAINT alu_nif_PK PRIMARY KEY,
	direccion VARCHAR2(50),
	sexo VARCHAR2(1) CONSTRAINT alu_sex_NN NOT NULL,
	fecha_nac DATE,
    -- 3.1 Un alumno/a debe matricularse en un curso antes de que se le pueda dar de alta. - NOT NULL
	id_curso NUMBER(3) NOT NULL,
    -- 3.10 Se debe cumplir la regla de integridad referencial.
    CONSTRAINT alu_idcurs_FK FOREIGN KEY (id_curso) REFERENCES Cursos ON DELETE CASCADE
    /* CORRECCIÓN: - restricción 10: Error en la sintaxis de definicion de la Integridad Refrencial.
    Cuando una clave ajena referencia a una Tabla, debe hacerlo a la tabla y al campo de la tabla al que se va a referenciar,
    no sólo a la tabla(en tu caso coinciden y no hay problema, pero no es lo correcto). Lo mismo cuando defines su comportamiento,
    habitualmente se define el comportamiento para actualización y eliminación.
    */
    -- CursoMatriculado CHAR(3) CONSTRAINT FK_AluCur REFERENCES Cursos(CodigoCurso) ON UPDATE CASCADE ON DELETE CASCADE;
);

-- 3.9 El dominio del atributo sexo es M (mujer) y H (hombre).
ALTER TABLE Alumnos ADD CONSTRAINT alu_sex_VAL CHECK (sexo IN ('M','H'));


-- Inserto valores a los campos y poder comprobar reglas
INSERT INTO Alumnos (nombre, apellido_1, nif_alum, sexo, id_curso) VALUES (
    'Miguel', 'Barrero', '23654874J', 'H', 1
);


-- ******************************************************************************** --
-- **************************** EJERCICIO 2: Modificacion de estructuras existentes --
-- ******************************************************************************** --


-- ***** 1. Crear un nuevo atributo para los alumnos, llamado Edad de tipo numérico --
ALTER TABLE Alumnos ADD (
    edad NUMBER(2)
);


-- ***** 2. Modificar el campo edad (creado anteriormente) para que sólo pueda tener *
-- valor comprendido entre 16 y 50 años ******************************************* --
ALTER TABLE Alumnos ADD CONSTRAINT alu_ed_CH CHECK (edad BETWEEN 16 AND 50);


-- **** 3. Modificar el campo Número de horas del CURSO de manera que solo pueda *****
-- haber cursos con 20, 28 o 100 horas ******************************************** --

-- Antes de hacer la nueva restricción tengo que modificar el valor del campo num_horas insertado anteriormente de 60 a 100.--
UPDATE Cursos SET num_horas=100 WHERE curso='Solfeo';
-- y ahora puedo aplicar la restricción.
ALTER TABLE Cursos ADD CONSTRAINT cur_hor_val CHECK (num_horas IN (20, 28, 100));


-- ** 4. No podemos añadir un curso si su número máximo de alumnos es inferior a 11 --

-- Antes de hacer la nueva restricción tengo que modificar el valor del campo num_max_alumnos insertado anteriormente de 10 a 15 (por ejemplo).--
UPDATE Cursos SET num_max_alumnos=15 WHERE curso='Solfeo';
-- y ahora puedo aplicar la restricción.
ALTER TABLE Cursos ADD CONSTRAINT cur_nam_val CHECK (num_max_alumnos>=11);


-- **** 5. Eliminar la restricción que controla los valores que puede tomar el  ******
-- atributo Sexo ****************************************************************** --
ALTER TABLE Alumnos DISABLE CONSTRAINT alu_sex_VAL;
-- Compruebo que esta deshabilitada la restricción
UPDATE Alumnos SET sexo='L' WHERE nombre='Miguel';


-- **** 6. Eliminar la columna Salario de la tabla PROFESORES ********************* --
ALTER TABLE Profesores DROP CONSTRAINT prof_sal_NN;
ALTER TABLE Profesores DROP COLUMN salario_mes;


-- **** 7. Cambiar la clave primaria de la tabla PROFESORES por Nombre y Apellidos  --

-- Elimino la relación con la TABLA Cursos
ALTER TABLE Cursos DISABLE CONSTRAINT cur_prof_FK;
ALTER TABLE Cursos DROP CONSTRAINT cur_prof_FK;

-- Desactivo la Restricción de la PRIMARY KEY de la tabla Profesores
ALTER TABLE Profesores DISABLE CONSTRAINT prof_nif_PK;
ALTER TABLE Profesores DROP CONSTRAINT prof_nif_PK;

-- Aunque supuestamente no es necesario, pongo la restricción NOT NUL al atributo apellido_2
ALTER TABLE Profesores MODIFY (apellido_2 NOT NULL);
-- Añado una nueva restricción a la tabla en la que indico que tiene que hacer una clave compuesta con los campos indicados
ALTER TABLE Profesores ADD CONSTRAINT prof_PK PRIMARY KEY (nombre, apellido_1, apellido_2);


-- CORRECCIÓN: - restriccion 7: No es necesario hacer el disable de las restricciones. Faltaría volver a crear la restricción de integridad referencial que has eliminado.

/*7.Cambiar la clave primaria de la tabla PROFESORES por Nombre y Apellidos*/
/*
ALTER TABLE Cursos DROP CONSTRAINT FK_CurPro;
ALTER TABLE Profesores DROP CONSTRAINT PK_Prof CASCADE;
ALTER TABLE Profesores DROP CONSTRAINT PKA_Nombre;
ALTER TABLE Profesores ADD CONSTRAINT PK_Prof PRIMARY KEY(NombreProfesor, Apellido1Profesor,Apellido2Profesor); 
ALTER TABLE Profesores ADD CONSTRAINT PKA_Prof UNIQUE (NIFProfesor), ADD CONSTRAINT NIFProfesor NOT NULL;  
ALTER TABLE Curso ADD CONSTRAINT FK_CurPro FOREIGN KEY (NIFProfesorCurso) REFERENCES Profesores (NIFProfesor); 
*/

-- **** 8. Renombrar la tabla PROFESORES por TUTORES ****************************** --
RENAME Profesores TO Tutores;


-- **** 9. Eliminar la tabla ALUMNOS. ********************************************* --
DROP TABLE Alumnos;


-- **** 10. Crear un usuario con tu nombre y clave BD02 y dale todos los ********** --
-- privilegios sobre la tabla Tutores. ******************************************** --
CREATE USER victor IDENTIFIED BY BD02
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE temp
QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO victor;

GRANT ALL PRIVILEGES ON Tutores TO victor;

-- GRANT SELECT, INSERT, UPDATE, DELETE ON Tutores TO victor;


-- **** 11. Al usuario anterior quitarle los permisos para modificar o actualizar * --
-- la tabla Tutores *************************************************************** --
REVOKE UPDATE ON Tutores FROM victor;

-- CORRECCIÓN: - restriccion 11: el revoke es de alter además de update.

/*11.Al usuario anterior quitarle los permisos para modificar o actualizar la tabla Tutores*/

/*
ALTER USER nombre_user IDENTIFIED BY BD02;
REVOKE ALTER ON Tutores FROM nombre_user;
*/