insert into Departamento (DepNo, Nombre) values (10,'Dirección');
insert into Departamento (DepNo, Nombre) values (20,'Administración');
insert into Departamento (DepNo, Nombre) values (30,'Programación');
insert into Departamento (DepNo, Nombre) values (40,'Análisis');
insert into Departamento (DepNo, Nombre) values (50,'Diseño');

insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (10001,'José','Sánchez Fernández',1365.84,20);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (20001,'Ana','Gil Tornero',1654.23,30);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (20002,'Miguel','Jiménez Galán',1580.94,30);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (10002,'Julia','Pérez González',1159.87,20);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (50001,'Marta','Casas Hernández',1865.25,10);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (30001,'Pedro','Martín San Gil',1624.35,40);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (30002,'Yolanda','Álbarez Simón',1640.32,40);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (40001,'Pablo','Camacho Partida',1598.32,50);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (40002,'Patricia','Gómez Hernaiz',1594.65,50);
insert into Empleado (EmpNo,Nombre,Apellidos,SalarioBase,DepNo)values (20003,'Antonio','Martínez Tambor',1235.21,30);


insert into Proyecto (ProyNo,Nombre,Duracion) values (10,'Cines',254);
insert into Proyecto (ProyNo,Nombre,DURACION) values (20,'Facturación',125);
insert into Proyecto (ProyNo,Nombre,DURACION) values (30,'Juego',342);
insert into Proyecto (ProyNo,Nombre,DURACION) values (40,'Granja',456);
-- insert into Proyecto (ProyNo,Nombre,DURACION) values (50,'test',200);
select * from PROYECTO;

insert into Participa(EmpNo,ProyNo,fecha) values (20001,30,'15/06/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (20001,10,'15/05/2017');
insert into Participa(EmpNo,ProyNo,fecha) values (20002,40,'12/08/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (20003,30,'20/07/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (20003,40,'15/07/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (30001,10,'07/05/2017');
insert into Participa(EmpNo,ProyNo,fecha) values (30001,40,'20/06/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (30002,30,'07/04/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (30002,20,'15/09/2018');
insert into Participa(EmpNo,ProyNo,fecha) values (40001,30,'10/05/2018');

select * from EMPLEADO;

/* Asignamos a dos empleados a dos proyectos más para que existan empleados que cumplan los
   requisitos del ejercicio 5
   5. Mostrar los datos de los empleados que participan en más de dos proyectos.  Consulta SQL (1 pts)

 */
insert into Participa(EmpNo,ProyNo,fecha) values (20001,20,'15/05/2017');
insert into Participa(EmpNo,ProyNo,fecha) values (20003,10,'15/07/2018');

-- Borramos los datos para no modificar los originales
delete from PARTICIPA where EMPNO = 20003 and PROYNO = 10;
delete from PARTICIPA where EMPNO = 20001 and PROYNO = 20;
