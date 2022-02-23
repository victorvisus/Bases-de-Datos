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


SE ADJUNTA ARCHIVO PDF, con la información requerida: 

He tenido que usar el SQL Developer porque con el APEX me ha sido imposible, en 
el temario no aparece ninguna explicación sobre esta herramienta gráfica
*/


/*  2. Inserta varios registros más en la tabla PROFESORADO utilizando sentencias SQL.
Los datos deben ser los siguientes:
    2   MARIA LUISA   FABRE BERDUN        51083099F   TECNOLOGIA   31/03/75   4
    3   JAVIER        JIMENEZ HERNANDO                LENGUA       04/05/69   10
    4   ESTEFANIA     FERNANDEZ MARTINEZ  19964324W   INGLES       22/06/73   5
    5   JOSE M.       ANERO PAYAN
*/
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad)
  VALUES (2, 'MARIA LUISA', 'FABRE BERDUN', '51083099F', 'TECNOLOGIA', '31/03/1975', 4);
INSERT INTO profesorado (codigo, nombre, apellidos, especialidad, fecha_nac, antiguedad)
  VALUES (3, 'JAVIER', 'JIMENEZ HERNANDO', 'lengua', '04/05/1969', 10);
INSERT INTO profesorado (codigo, nombre, apellidos, dni, especialidad, fecha_nac, antiguedad)
  VALUES (4, 'ESTEFANIA', 'FERNANDEZ MARTINEZ', '19964324W', 'INGLES', '22/06/1973', 5);
INSERT INTO profesorado (codigo, nombre, apellidos)
  VALUES (5, 'MARIA LUISA', 'FABRE BERDUN');
  
  
  
