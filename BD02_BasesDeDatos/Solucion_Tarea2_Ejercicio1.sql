CREATE TABLE PROFESORES ( 
NIFProfesor CHAR(9) CONSTRAINT PK_Prof PRIMARY KEY, 
NombreProfesor NVARCHAR2(25), 
Apellido1Profesor NVARCHAR2(25),
Apellido2Profesor NVARCHAR2(25),
DireccionProfesor NVARCHAR2(30),
Titulacion NVARCHAR2(30),
Salario NUMBER (7,2) NOT NULL, 
CONSTRAINT PKA_Nombre UNIQUE (NombreProfesor, Apellido1Profesor,Apellido2Profesor)
);
/*TABLA PROFESORES (1�): Orden por restricciones de integridad referencial.*/
/*PRIMARY KEY: restricci�n 7: diferenciar tuplas de PROFESORES por NIF*/
/*NOT NULL: restricci�n 3: salario no puede estar vacio*/
/*UNIQUE: restricci�n 5: dos profesores no pueden llamarse de la misma forma*/


CREATE TABLE CURSOS (
CodigoCurso CHAR(3) CONSTRAINT PK_Curso PRIMARY KEY,
NombreCurso NVARCHAR2(30) UNIQUE,
NIFProfesorCurso CHAR(9),
MaxAlumnosRecomendado INT, 
FInicio DATE,
FFinal DATE,
HorasTotales NUMBER (3,2) NOT NULL,
CONSTRAINT CHK_ff_fi CHECK (FFinal > FInicio), 
CONSTRAINT FK_CurPro FOREIGN KEY (NIFProfesorCurso) REFERENCES Profesores(NIFProfesor) ON UPDATE CASCADE ON DELETE CASCADE
); 
/*TABLA CURSOS en segundo lugar por la restricci�n 10: cumplir con la regla de integridad referencial*/
/*PRIMARY KEY: restricci�n 6: diferenciar tuplas de CURSOS por C�digo del Curso*/
/*UNIQUE: restricci�n 4: dos cursos no pueden llamarse igual*/
/*NOT NULL: restricci�n 2:las horas son un dato obligatorio*/
/*CHECK: restricci�n 8: fecha de fin debe ser mayor que la de inicio*/
/*FOREIGN KEY por la restricci�n 10: cumplir con la integridad referencial*/


CREATE TABLE ALUMNOS (
NIFAlumno CHAR(9) CONSTRAINT PK_Alumno PRIMARY KEY,
NombreAlumno NVARCHAR2(25),
Apellido1Alumno NVARCHAR2(25),
Apellido2Alumno NVARCHAR2(25),
DireccionAlumno NVARCHAR2(30),
Sexo CHAR(1),
FNacimiento DATE,
CursoMatriculado CHAR(3) CONSTRAINT FK_AluCur REFERENCES Cursos(CodigoCurso) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT CHK_AluSex CHECK (Sexo in('M','H'))
); 
/*PRIMARY KEY: restricci�n 7: diferenciar tuplas de ALUMNOS por NIF*/
/*FOREIGN KEY: restricci�n 10: integridad referencial*/
/*CHECK: restricci�n 9: el dominio del atributo sexo es M (mujer) y H (hombre)*/
