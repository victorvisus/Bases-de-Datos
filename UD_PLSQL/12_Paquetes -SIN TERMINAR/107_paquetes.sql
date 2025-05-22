-- PAQUETES
/**
En los paquetes se pueden almacenar otros objetos, como procedimientos, funciones, 
variables, cursores... organizandolos de una manera comun a todos los objetos
Es como una libreria, de otros lenguajes

Estan formados por:
- Package spec "Cabecera": especificacion del paquete
Aqui se declaran todas las variables p�blicas y todos los procedimientos p�blicos que vamos a construir
Aqui no hay c�digo, solo se realiza la declaraci�n del procedimiento

- Body:
Aqui van variable privadas, c�digo y el c�digo de los objetos que he declarado en la cabecera
Todo lo que se declare en la cabecera hay que crearlo en el cuerpo
Se puede tener variables y procedimientos privados.
TODO LO QUE NO ESTE DECLARADO EN LA CABECERA NO SE PUEDE ACCEDER DESDE FUERA DEL PAQUETE