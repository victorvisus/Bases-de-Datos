-- Triggers

/*
Un trigger se puede utilizar para multiples cosas.
Se dispara cuando se dá algun determinado evento en la Base de Datos
Pueden ser: 
- DML, permite gestionar INSERT, UPDATE y DELETE
- DDL, permite controlar distintas opceraciones sobre objetos CREATE, DROP
- DATABASE, gestiona operaciones concretas sobre la BBDD, LOGON, SHUTDOWN, etc.
*/

/* TRIGGERS DML ----------------------------------------------------------------
TIPOS                             EVENTOS                         FILAS AFECTADAS

BEFORE,                           INSERT                    STATEMENT, solo se dispara una vez
- Se dispara antes de la          UPDATE                    P.ej. para contrrolar que la operación 
operación.                        DELETE                    afectada/realizada es correcta.
- Muy util para operaciones
de control, p.ej. Si la orden                               ROW, se dispara por cada fila afectada
DELETE no es correcta se puede                              p.ej. para controlar cada fila
rechazar con este tipo de
trigger

AFTER,
- Despues de la operación
Vale para operaciones de
auditoria, de logs, 4etc.

INSTEAD OF
- Para determinadas vistas, que 
sean complejas y que no 
permitan modificaciones con 
INSERT, UPDATE o DELETE

En un mismo Trigger se pueden mezclar de varios tipos.
*/