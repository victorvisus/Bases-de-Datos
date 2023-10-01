drop table Departamento;
drop table Participa;
drop table Empleado;
drop table Proyecto;

create table Departamento(
DepNo number(3) primary key,
Nombre Varchar2(20)
);

create table Empleado(
EmpNo number (5) primary key,
Nombre varchar2(15),
Apellidos varchar2(30),
SalarioBase number(6,2),
DepNo number(3) references Departamento (DepNo)
);

create table Proyecto(
ProyNo number(3) primary key,
Nombre varchar2(20),
Duracion number (6)
);

create table Participa(
EmpNo number(5),
ProyNo number(3),
 fecha Date,
CONSTRAINT participa_pk primary key (EmpNo,ProyNo),
CONSTRAINT EmpNo_fk foreign key (EmpNo) references Empleado(EmpNo) on delete cascade,
CONSTRAINT ProyNo_fk foreign key (ProyNo) references Proyecto(ProyNo) on delete cascade
);