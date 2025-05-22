-- Parametros
/**
- Parametro de tipo IN ---------------------------------------------------------
yo le mando desde el bloque PL al procedimiento un valor
    Los paramentros de tipo IN no pueden ser modificados dentro del procedimiento

- Tipo OUT ---------------------------------------------------------------------
el procedimiento me devuelve un valor, que se guarda en una variable
del bloque que llama al procedimiento
    Permite que pueda devolver un valor desde dentro del procedimiento.
    
    Le pasamos una variable, que se puede cambiar dentro del procedimiento, y 
    también se cambia dentro del PL desde el que es llamado el procedimiento

    1) En el programa Padre, se inicializa una variable que apunta a una direccion 
    de memoria
    2) El padre le manda, como parametro, la variable.
    3) Cuando se ejecuta el programa hijo (el procedimiento), éste modifica el valor
    de la dirección de memoria de la variable.

    En los parametros de tipo OUT no se envia ningún valor, unicamente sirven para
    apuntar a la misma direccion de memoria que la variable que se le envia desde
    el programa padre

- tipo IN/OUT ------------------------------------------------------------------
le paso un valor en el argumento y, al mismo tiempo, le puedo devolver un valor

    Sirve para enviar un valor, desde el programa padre, y, además, guarda el 
    resultado del procedimiento en esa variable
    Un procedimiento puede tener distintos parámetros IN/OUT


--------------------------------------------------------------------------------
Si no se indica lo contrario el tipo por defecto es IN
**/

