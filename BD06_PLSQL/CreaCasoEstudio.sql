drop user agencia cascade;
create user agencia identified by agencia default tablespace users;
grant connect,resource,dba to agencia;
conn agencia/agencia

create table oficinas (
     identificador     number(6) not null primary key,
     nombre          varchar2(40) not null unique,
     domicilio     varchar2(40),
     localidad     varchar2(20),
     codigo_postal      varchar2(5)
);

create table familias (
     identificador     number(6) not null primary key,
     nombre          varchar2(40) not null unique,
     familia          number(6) references familias,
     oficina          number(6) references oficinas
);

create table agentes (
     identificador     number(6) not null primary key,
     nombre          varchar2(60) not null,
     usuario          varchar2(20) not null unique,
     clave          varchar2(20) not null,
     habilidad     number(1) not null,
     categoria     number(1) not null,
     familia          number(6) references familias,
     oficina          number(6) references oficinas
);

insert into oficinas values (1, 'Madrid', 'Gran vi�a, 37', 'Madrid', '28000');
insert into oficinas values (2, 'Granada', 'Camino Ronda, 50', 'Granada', '36000');
insert into oficinas values (3, 'Jaen', 'Gran Eje, 80', 'Jaen', '27000');

insert into familias values (11, 'Madrid-1', NULL, 1);
insert into familias values (111, 'Madrid-1.1', 11, NULL);
insert into familias values (112, 'Madrid-1.2', 11, NULL);
insert into familias values (1121, 'Madrid-1.2.1', 112, NULL);
insert into familias values (1122, 'Madrid-1.2.2', 112, NULL);
insert into familias values (1123, 'Madrid-1.2.3', 112, NULL);
insert into familias values (21, 'Granada-1', NULL, 2);
insert into familias values (211, 'Granada-1.1', 21, NULL);
insert into familias values (212, 'Granada-1.2', 21, NULL);
insert into familias values (213, 'Granada-1.3', 21, NULL);
insert into familias values (31, 'Jaen-1', NULL, 3);

insert into agentes values (31, 'Jose Ramon Jimenez Reyes', 'jrjr', 'sup31', 9, 2, NULL, 3);
insert into agentes values (311, 'Pedro Fernandez Arias', 'pfa', 'ag311', 5, 0, 31, NULL);
insert into agentes values (312, 'Vanesa Sanchez Rojo', 'vsr', 'ag312', 5, 0, 31, NULL);
insert into agentes values (313, 'Francisco Javier Garci�a Escobedo', 'fjge', 'ag313', 5, 0, 31, NULL);
insert into agentes values (314, 'Pilar Ramirez Perez', 'prp', 'ag314', 5, 0, 31, NULL);
insert into agentes values (315, 'Jose Luis Garci�a Marti�nez', 'jlgm', 'ag315', 5, 0, 31, NULL);
insert into agentes values (21, 'Sebastian Lopez Ojeda', 'slo', 'sup21', 9, 2, NULL, 2);
insert into agentes values (211, 'Diosdado Sanchez Hernandez', 'dsh', 'ag211', 8, 1, 21, NULL);
insert into agentes values (2111, 'Jose Juan Cano Pardo', 'jjcp', 'ag2111', 5, 0, 211, NULL);
insert into agentes values (2112, 'Flor Moncada Anion', 'ag2112', 'fma', 5, 0, 211, NULL);
insert into agentes values (2113, 'Juan Manuel Alcazar Donaire', 'jmad', 'ag2113', 5, 0, 211, NULL);
insert into agentes values (2121, 'Manuel Jesus Rubia Mateos', 'mjrm', 'ag2121', 5, 0, 212, NULL);
insert into agentes values (2122, 'Esther Lopez Delgado', 'eld', 'ag2122', 5, 0, 212, NULL);
insert into agentes values (2123, 'Francisco Javier Cabrerizo Membrilla', 'fjcm', 'ag2123', 5, 0, 212, NULL);
insert into agentes values (2124, 'Veronica Cabrerizo Menbrilla', 'vcm', 'ag2124', 5, 0, 212, NULL);
insert into agentes values (2125, 'Mari�a Jose Navascues Morales', 'mjnm', 'ag2125', 5, 0, 212, NULL);
insert into agentes values (2131, 'Isabel Cruz Granados', 'icg', 'ag2131', 5, 0, 213, NULL);
insert into agentes values (2132, 'Antonio Casado Fernandez', 'acf', 'ag2132', 5, 0, 213, NULL);
insert into agentes values (2133, 'Gabriel Callejon Garci�a', 'gcg', 'ag2133', 5, 0, 213, NULL);
insert into agentes values (2134, 'Enrique Cano Balsera', 'ecb', 'ag2134', 5, 0, 213, NULL);
insert into agentes values (11, 'Narciso Jaimez Toro', 'njt', 'sup11', 9, 2, NULL, 1);
insert into agentes values (111, 'Jesus Banios Sancho', 'jbs', 'ag111', 8, 1, 11, NULL);
insert into agentes values (1111, 'Salvador Romero Villegas', 'srv', 'ag1111', 7, 1, 111, NULL);
insert into agentes values (1112, 'Jose Javier Bermudez Hernandez', 'jjbh', 'ag1112', 7, 1, 111, NULL);
insert into agentes values (1113, 'Alfonso Bonillo Sierra', 'abs', 'ag1113', 7, 1, 111, NULL);
insert into agentes values (1121, 'Silvia Thomas Barros', 'stb', 'ag1121', 7, 1, 112, NULL);
insert into agentes values (11211, 'Ernesto Osoro Gorrotxategi', 'eog', 'ag11211', 5, 0, 1121, NULL);
insert into agentes values (11212, 'Guillermo Campos Guillen', 'gcag', 'ag11212', 5, 0, 1121, NULL);
insert into agentes values (11213, 'Antonio Fernandez Rui�z', 'afr', 'ag11213', 5, 0, 1121, NULL);
insert into agentes values (11214, 'Mari�a Luisa Lopez Caballero', 'mllc', 'ag11214', 5, 0, 1121, NULL);
insert into agentes values (11221, 'Virginia Morenas Rubio', 'vmr', 'ag11221', 5, 0, 1121, NULL);
insert into agentes values (11222, 'Rosario Castro Garci�a', 'rcg', 'ag11222', 5, 0, 1122, NULL);
insert into agentes values (11223, 'Antonio Alvarez Palomeque', 'aap', 'ag11223', 5, 0, 1122, NULL);
insert into agentes values (11224, 'David Marti�nez Marti�nez', 'dmm', 'ag11224', 5, 0, 1122, NULL);
insert into agentes values (11225, 'Juan Corral Gonzalez', 'jcg', 'ag11225', 5, 0, 1122, NULL);
insert into agentes values (11226, 'Eduardo Alfada Pereira', 'eap', 'ag11226', 5, 0, 1122, NULL);
insert into agentes values (11231, 'Cayetano Garci�a Herrera', 'cgh', 'ag11231', 5, 0, 1123, NULL);
insert into agentes values (11232, 'Jose Antonio Sieres Vega', 'jasv', 'ag11232', 5, 0, 1123, NULL);
insert into agentes values (11233, 'Juan Manuel Guzman Garci�a', 'jmgg', 'ag11233', 5, 0, 1123, NULL);

commit;