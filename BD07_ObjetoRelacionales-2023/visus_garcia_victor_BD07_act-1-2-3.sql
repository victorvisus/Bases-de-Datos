/*
DROP TABLE comerciales;
DROP TABLE areas_comerciales;
DROP TYPE ListaZonas;
DROP TABLE responsables;

DROP TYPE comercial;
DROP TYPE zonas;
DROP TYPE responsable;
DROP TYPE personal;
*/

-- TAREA 7 - BASES DE DATOS -- Actividades 1, 2 y 3 - Crear Objetos ------------

/*******************************************************************************
 Actividad 1.	Crea el tipo de objetos "Personal" con los siguientes atributos:
********************************************************************************/

/* -----------------------------------------------------------------------------
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
    fecha_nac DATE

) NOT FINAL;

/* -----------------------------------------------------------------------------
1.B.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Responsable" 
con los siguientes atributos:
     .	tipo  CHAR ,
     .	antiguedad INTEGER 
*/
CREATE OR REPLACE TYPE responsable UNDER personal(
    tipo  CHAR,
    antiguedad INTEGER,
    
    --Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable"...
    CONSTRUCTOR FUNCTION responsable(
        r_codigo INTEGER, r_nombre VARCHAR2, r_ape_uno VARCHAR2, r_ape_dos VARCHAR2, r_tipo CHAR
    ) RETURN SELF AS RESULT,
    
    --Actividad 3.	Crea un método getNombreCompleto para el tipo de objetos Responsable... 
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2
);

/* -----------------------------------------------------------------------------
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

    --Actividad 9 - Método MAP
    MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2
);

/* -----------------------------------------------------------------------------
1.D.-	Crea, como tipo heredado de "Personal", el tipo de objeto "Comercial" 
con los siguientes atributos:
     .	zonaComercial Zonas
*/
CREATE OR REPLACE TYPE comercial UNDER personal(
    zonaComercial zonas
);


/*******************************************************************************
Actividad 2.	Crea un método constructor para el tipo de objetos "Responsable",
en el que se indiquen como parámetros el código, nombre, primer apellido, segundo
apellido y tipo. Este método debe asignar al atributo apellidos los datos de 
primer apellido y segundo apellido que se han pasado como parámetros, uniéndolos
con un espacio entre ellos.
********************************************************************************/
CREATE OR REPLACE TYPE BODY responsable AS
 
    CONSTRUCTOR FUNCTION responsable(
        r_codigo INTEGER, r_nombre VARCHAR2, r_ape_uno VARCHAR2, r_ape_dos VARCHAR2, r_tipo CHAR
    ) RETURN SELF AS RESULT IS
    
    p_apellidos VARCHAR2(30) := r_ape_uno || ' ' || r_ape_dos;
    
    BEGIN
        SELF.codigo := r_codigo;
        SELF.nombre := r_nombre;
        SELF.apellidos := p_apellidos;
        SELF.tipo := r_tipo;
        RETURN;
    END;

/*******************************************************************************
3.	Crea un método getNombreCompleto para el tipo de objetos Responsable que 
permita obtener su nombre completo con el formato apellidos nombre.
********************************************************************************/
    MEMBER FUNCTION getNombreCompleto RETURN VARCHAR2 IS
    BEGIN
        RETURN apellidos || ', ' || nombre;
    END getNombreCompleto;
 END;
 

/*******************************************************************************
 9.	Crea un método MAP ordenarZonas para el tipo Zonas. Este método debe retornar
 el nombre completo del Responsable al que hace referencia cada zona.
 Para obtener el nombre debes utilizar el método getNombreCompleto que se ha 
 creado anteriormente
 *******************************************************************************/
 CREATE OR REPLACE TYPE BODY zonas AS
 
    MAP MEMBER FUNCTION ordenarZonas RETURN VARCHAR2 IS
    respon responsable;
    BEGIN
        SELECT DEREF(refRespon) INTO respon FROM DUAL;
        RETURN respon.getNombreCompleto();
    END ordenarZonas;
 
 END;
 
 
