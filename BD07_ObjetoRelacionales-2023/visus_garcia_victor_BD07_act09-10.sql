-- TAREA 7 - BASES DE DATOS --  Actividad 10 ------------------------------------

/*******************************************************************************
9.	Crea un m�todo MAP ordenarZonas para el tipo Zonas. Este m�todo debe retornar
el nombre completo del Responsable al que hace referencia cada zona. Para obtener 
el nombre debes utilizar el m�todo getNombreCompleto que se ha creado anteriormente
********************************************************************************/
-- La Soluci�n a la Actividad 9 se encuentra en el script:
-- visus_garcia_victor_BD07_act-1-2-3.sql - linea 73 y 126

/*******************************************************************************
10.	Realiza una consulta de la tabla TablaComerciales ordenada por zonaComercial
para comprobar el funcionamiento del m�todo MAP.  
********************************************************************************/
SET SERVEROUTPUT ON;
SELECT * FROM TablaComerciales ORDER BY zonaComercial;