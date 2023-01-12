-- BD04 - CONSULTAS A RESOLVER CON LA SOLUCION DE CADA UNA DE ELLAS --

1.-  Obtener los nombres y salarios de los empleados que cobran más de 985 euros y tienen una comisión es superior al 5% de su salario.
select nombre,ape1,salario from empleado where salario > 1000 and comision > salario * 0.05;

2.- Obtener el código de empleado, código de departamento, nombre y sueldo total en pesetas de aquellos empleados cuyo sueldo total (salario más comisión) supera los 1800 euros. Presentarlos ordenados por código de departamento y dentro de éstos por orden alfabético.
select coddpto,codemple,nombre,ape1,(salario+nvl(comision,0))*166.386
from empleado where salario+nvl(comision,0)>1800
order by coddpto,nombre,ape1;

3.-  Obtener un listado con los nombres, y apellidos de los empleados y sus años de antigüedad en la empresa, ordenado por años de antigüedad siendo los que más años llevan los primeros que deban aparecer.
SELECT nombre,ape1,ape2, (sysdate-fechaingreso)/365.20 as "Antigüedad" from empleado order by 4 desc;

4.- Obtener el nombre de los empleados que trabajan en un departamento con presupuesto superior a 50.000 euros pero menor de 60000 euros. Hay que usar predicado cuantificado
select ape1,nombre from empleado where coddpto= some(select coddpto from dpto where presupuesto>50000 and presupuesto<60000);

5.- Obtener en orden alfabético los nombres de empleado cuyo salario es inferior al mínimo de los empleados del departamento 1.
select nombre,ape1,salario from empleado where salario < (select min(salario) from empleado where coddpto=1)

6.- Obtener los nombre de empleados que trabajan en el departamento del cuál es jefe el empleado con código 1.
select nombre,ape1 from empleado where coddpto = some (select coddpto from dpto where codemplejefe=1)

7.- Obtener los nombres de los empleados cuyo primer apellido empiece por las letras p, q, r, s.
select nombre,ape1 from empleado where substr(ape1,1,1) between 'P' and 'S';

8.- Obtener los nombres de los empleados que viven en ciudades en las que hay algún centro de trabajo
select ape1, nombre from empleado where upper(localidad) in (select upper(localidad) from centro);

9.- Obtener en orden alfabético los salarios y nombres de los empleados cuyo salario sea superior al 60% del máximo salario de la empresa.
select salario,nombre from empleado where salario >(select max(salario) * 0.6 from empleado) order by nombre;

10.-  Obtener el nombre y apellidos del empleado que más salario cobra
select nombre,ape1,ape2, salario from empleado where salario=(select MAX(salario) from empleado)

11.- Obtener las localidades y número de empleados de aquellas en las que viven más de 3 empleados
select localidad,count(*) from empleado group by localidad having count(*) > 3 order by 2;

12.- Obtener los nombres de todos los centros y los departamentos que se ubican en cada uno,así como aquellos centros que no tienen departamentos.
select tc.direccion,td.denominacion from centro tc left join dpto td on tc.codcentro=td.codcentro order by 1,2;

13.- Obtener el nombre del departamento de más alto nivel, es decir, aquel que no depende de ningún otro.
select denominacion from dpto where coddptodepende is null;
  
14.- Obtener al departamento que más empleados tiene
select denominacion from dpto,empleado where empleado.coddpto=dpto.coddpto group by dpto.coddpto,denominacion having count(empleado.codemple)>=all(select count(codemple) from empleado group by coddpto);

15.- Obtener todos los departamentos existentes en la empresa y los empleados (si los tiene) que pertenecen a él.
select denominacion,nombre,ape1,ape2 from dpto td left join empleado te on td.coddpto=te.coddpto order by 1;

16.- Obtener un listado ordenado alfabéticamente donde aparezcan los nombres de los empleados y a continuación el literal "tiene comision" si la tieneo o "no tiene comisión" si no la tiene.
Select nombre, ape1,ape2, 'tiene comision' as Comision from empleado where comision is not null
UNION
Select nombre, ape1,ape2, 'no tiene comision' as Comision from empleado where comision is null order by 4,2;

O bien con la función decode

Select nombre, ape1,ape2, decode(nvl(comision,0),0,'tiene comision','no tiene comision') as Comision from empleado;

17.- Obtener un listado de las localidades en las que hay centros y no vive ningún empleado ordenado alfabéticamente.
select upper(tc.localidad) from centro tc minus select upper(te.localidad) from empleado te order by 1;

También podría hacerse con not in: 
select upper(c.localidad) from centro c WHERE UPPER(c.localidad) NOT IN (SELECT UPPER(e.localidad) from empleado e) order by c.localidad;

18.- Obtener a los nombres, apellidos de los empleados que no son jefes de departamento.
select nombre,ape1,ape2 from empleado where codemple not in (select codemplejefe from dpto);

19.-  Esta cuestión puntúa doble. Se desea dar una gratificación por navidades en función de la antigüedad en la empresa siguiendo estas pautas:
	Si lleva entre 1 y 5 años, se le dará 100 euros
	Si lleva entre 6 y 10 años, se le dará 50 euros por año
	Si lleva entre 11 y 20 años, se le dará 70 euros por año
	Si lleva más de 21 años, se le dará 100 euros por año

select nombre,ape1,ape2, 100 as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 1 and 5
union
select nombre,ape1,ape2, 50*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 6 and 10
union
select nombre,ape1,ape2, 70*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365) between 11 and 20
union
select nombre,ape1,ape2, 100*((sysdate-fechaingreso)/365) as Gratificacion from empleado where trunc((sysdate-fechaingreso)/365)> 21;


