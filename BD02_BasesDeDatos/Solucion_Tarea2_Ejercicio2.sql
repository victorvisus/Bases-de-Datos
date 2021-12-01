/*1.Crear un nuevo atributo para los alumnos, llamado Edad de tipo numerico*/
ALTER TABLE Alumnos ADD Edad NUMBER;

/*2.Modificar el campo edad para que solo pueda tener valor comprendido entre 16 y 50 a�os*/
ALTER TABLE Alumnos ADD CONSTRAINT CHK_AlumnoEdad CHECK (Edad >= 16 AND Edad <= 50);

/*3.Modificar el campo Numero de horas del CURSO de manera que solo pueda haber cursos con 20, 28 o 100 horas.*/
ALTER TABLE Cursos ADD CONSTRAINT CHK_CursoHoras CHECK HorasTotales IN('20','28','100');  

/*4.No podemos a�adir un curso si su Numero maximo de alumnos es inferior a 11*/
ALTER TABLE Cursos ADD CONSTRAINT CHK_CursoMaxAlumn CHECK MaxAlumnosRecomendado >= '11';

/*5.Eliminar la restriccion que controla los valores que puede tomar el atributo Sexo*/
ALTER TABLE Alumnos DROP CONSTRAINT CHK_AluSex; 

/*6.Eliminar la columna Salario de la tabla PROFESORES*/
ALTER TABLE Profesores DROP COLUMN Salario;

/*7.Cambiar la clave primaria de la tabla PROFESORES por Nombre y Apellidos*/
ALTER TABLE Cursos DROP CONSTRAINT FK_CurPro;
ALTER TABLE Profesores DROP CONSTRAINT PK_Prof CASCADE;
ALTER TABLE Profesores DROP CONSTRAINT PKA_Nombre;
ALTER TABLE Profesores ADD CONSTRAINT PK_Prof PRIMARY KEY(NombreProfesor, Apellido1Profesor,Apellido2Profesor); 
ALTER TABLE Profesores ADD CONSTRAINT PKA_Prof UNIQUE (NIFProfesor), ADD CONSTRAINT NIFProfesor NOT NULL;  
ALTER TABLE Curso ADD CONSTRAINT FK_CurPro FOREIGN KEY (NIFProfesorCurso) REFERENCES Profesores (NIFProfesor); 

/*8.Renombrar la tabla PROFESORES por TUTORES*/
RENAME Profesores TO Tutores

/*9.Eliminar la tabla ALUMNOS*/
DROP TABLE Alumnos;

/*10.Crear un usuario con tu nombre y clave BD02 y dale todos los privilegios sobre la tabla Tutores*/
CREATE USER nombre_user IDENTIFIED BY BD02;
GRANT all privileges ON Tutores TO nombre_user;

/*11.Al usuario anterior quitarle los permisos para modificar o actualizar la tabla Tutores*/
ALTER USER nombre_user IDENTIFIED BY BD02;
REVOKE ALTER ON Tutores FROM nombre_user;