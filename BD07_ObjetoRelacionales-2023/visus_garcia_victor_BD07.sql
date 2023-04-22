DROP TYPE comercial;
DROP TYPE zonas;
DROP TYPE responsable;
DROP TYPE personal;



-- TAREA 7 - BASES DE DATOS
/*******************************************************************************
 Actividad 1.	Crea el tipo de objetos "Personal" con los siguientes atributos:
 ********************************************************************************/

/*
1.A.-	Crea el tipo de objetos "Personal" con los siguientes atributos:
 .	codigo INTEGER,
 .	dni VARCHAR2(10),
 .	nombre VARCHAR2(30),
 .	apellidos VARCHAR2(30),
 .	sexo VARCHAR2(1),
 .	fecha_nac DATE
*/
CREATE OR REPLACE TYPE personal AS OBJECT(
    --Atributos
    codigo INTEGER,
    dni VARCHAR2(10),
    nombre VARCHAR2(30),
    apellidos VARCHAR2(30),
    sexo VARCHAR2(1),
    fecha_nac DATE,
    
    --Métodos
    MEMBER FUNCTION getDatos RETURN VARCHAR2
) NOT FINAL;
/
CREATE OR REPLACE TYPE BODY personal AS

    MEMBER FUNCTION getDatos RETURN VARCHAR2 AS
    BEGIN
        RETURN 'Datos del objeto: - ' ||
            'Código: ' || codigo || ' ' ||
            'DNI: ' || dni || ' ' ||
            'Nombre: ' || nombre || ' ' ||
            'Apellidos: ' || apellidos || ' ' ||
            'Sexo: ' || sexo || ' ' ||
            'Fecha de Nacimiento ' || fecha_nac;
    END getDatos;
END;
/
/*
1.B.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Responsable" con los siguientes atributos:
 .	tipo  CHAR ,
 .	antiguedad INTEGER 
*/
CREATE OR REPLACE TYPE responsable UNDER personal(
    tipo  CHAR,
    antiguedad INTEGER,
    
    --MÉTODOS:
    OVERRIDING MEMBER FUNCTION getDatos RETURN VARCHAR2,
    
    --Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable"...
    CONSTRUCTOR FUNCTION responsable(
        codigo INTEGER, nombre VARCHAR2, ape_uno VARCHAR2, ape_dos VARCHAR2, tipo CHAR
    ) RETURN SELF AS RESULT,
    
    --Actividad 3.	Crea un método getNombreCompleto para el tipo de objetos Responsable... 
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2
);
/
/*
1.C.-	Crea el tipo de objeto "Zonas" con los siguientes atributos:
 .	codigo INTEGER, 
 .	nombre VARCHAR2(20), 
 .	refRespon REF Responsable, 
 .	codigoPostal CHAR(5),
*/
CREATE OR REPLACE TYPE zonas AS OBJECT(
    --Atributos
    codigo INTEGER,
    nombre VARCHAR2(20),
    refRespon REF Responsable,
    codigoPostal CHAR(5),
    
    --Métodos
    MEMBER FUNCTION getDatos RETURN VARCHAR2
);
/

/*
1.D.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Comercial" con los siguientes atributos:
 .	zonaComercial Zonas
*/
CREATE OR REPLACE TYPE comercial UNDER personal(
    zonaComercial zonas
);
/

/*******************************************************************************
Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable",
en el que se indiquen como parámetros el código, nombre, primer apellido, segundo
apellido y tipo. Este método debe asignar al atributo apellidos los datos de 
primer apellido y segundo apellido que se han pasado como parámetros, uniéndolos
con un espacio entre ellos.
********************************************************************************/
CREATE OR REPLACE TYPE BODY responsable AS
 
    OVERRIDING MEMBER FUNCTION getDatos RETURN VARCHAR2 AS
    BEGIN
        RETURN 'Datos del objeto: - ' ||
            'Código: ' || codigo || ' ' ||
            'DNI: ' || dni || ' ' ||
            'Nombre: ' || nombre || ' ' ||
            'Apellidos: ' || apellidos || ' ' ||
            'Sexo: ' || sexo || ' ' ||
            'Fecha de Nacimiento ' || fecha_nac || ' ' ||
            'Tipo: ' || tipo || ' ' ||
            'Antigüedad ' || antiguedad;
    END getDatos;
    
    CONSTRUCTOR FUNCTION responsable(
        codigo INTEGER, nombre VARCHAR2, ape_uno VARCHAR2, ape_dos VARCHAR2, tipo CHAR
    ) RETURN SELF AS RESULT IS
    BEGIN
        SELF.codigo := codigo;
        SELF.nombre := nombre;
        SELF.apellidos := ape_uno || ' ' || ape_dos;
        SELF.tipo := tipo;
        
        RETURN;
    END;

    /******************************************************************************
    3.	Crea un método getNombreCompleto para el tipo de objetos Responsable que 
    permita obtener su nombre completo con el formato apellidos nombre.
    ******************************************************************************/
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2 IS
    BEGIN
        RETURN apellidos || ', ' || nombre;
    END getNombreCompleto;
 END;
 /
