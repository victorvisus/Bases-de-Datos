-- 1. Mostrar los datos de los empleados que se adscribieron a algún proyecto en el año 2017. Consulta SQL (0.5 pts.)
select e.*, p.FECHA fechaProyecto
from EMPLEADO e
         join PARTICIPA p on e.EMPNO = p.EMPNO
where Extract(year from p.FECHA) = 2017;

--2.  Mostrar el número de empleados que tiene cada departamento. Consulta SQL (0.5 pto.)
select count(e.DEPNO) numero_empleados, e.DEPNO
from DEPARTAMENTO d
         join EMPLEADO e on d.DEPNO = e.DEPNO
group by e.DEPNO
order by numero_empleados;

--3.  Mostrar el número de departamentos que participan en cada proyecto. Consulta SQL (1 pto.)
select p.PROYNO, count(p.PROYNO) numero_departamentos
from PARTICIPA p
         join DEPARTAMENTO d on p.PROYNO = d.DEPNO
group by p.PROYNO
order by numero_departamentos;

--4. Mostrar la suma de salarios de los empleados por cada departamento. Consulta SQL (1 pto.)
select e.DEPNO, sum(e.SALARIOBASE) suma_salarios
from EMPLEADO e
         join DEPARTAMENTO d on e.DEPNO = d.DEPNO
group by e.DEPNO
order by e.DEPNO;

--5. Mostrar los datos de los empleados que participan en más de dos proyectos.  Consulta SQL (1 pts)
-- no salen datos porque solo hay empleados trabajando como máximo en dos proyectos
select (e.NOMBRE || ' ' || e.APELLIDOS) nombre_completo, e.EMPNO, e.SALARIOBASE, e.DEPNO
from EMPLEADO e
         join PARTICIPA p on e.EMPNO = p.EMPNO
group by e.SALARIOBASE, e.NOMBRE, e.APELLIDOS, e.EMPNO, e.SALARIOBASE, e.DEPNO
having count(*) > 2;

-- 6. Realizar un procedimiento que reciba el identificador de un departamento y muestre los datos de los empleados que
-- pertenecen a dicho departamento. procedimiento PL/SQL(1 pts.)
CREATE OR REPLACE PROCEDURE datos_empleado(
    v_departamento departamento.depno%TYPE
) AS

    CURSOR c_empleado IS
        SELECT e.*
        FROM empleado e
        WHERE e.depno = v_departamento;

BEGIN
    dbms_output.put_line('Nº Empleado        Nombre completo         Salario    Nº Dpto');
    FOR registro IN c_empleado
        LOOP
            dbms_output.put_line('  '
                || registro.empno
                || '         '
                || registro.nombre
                || ' '
                || registro.apellidos
                || '     '
                || registro.salariobase
                || '€      '
                || registro.depno);
        END LOOP;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('No existe ningún departamento con identificador ' || v_departamento);
END;
/

DECLARE
    v_departamento departamento.depno%TYPE := &codigo;
BEGIN
    datos_empleado(v_departamento);
END;
/

-- PARTE 3
--1. Mostrar los datos proyectos en los que participa el empleado con identificador 5. Consulta SQL (1 pts.)
-- No salen datos porque no hay ningún trabajador con identificador 5
select p.*
from PROYECTO pro
         join PARTICIPA p on pro.PROYNO = p.PROYNO
         join EMPLEADO e on p.EMPNO = e.EMPNO
where e.EMPNO = 5;

--2. Mostrar los datos del proyecto que tenga la mayor duración. Consulta SQL(1 ptos.)
select *
from PROYECTO p
where p.DURACION = (select max(p.DURACION) from PROYECTO p)
order by DURACION desc;

--3. Mostrar los empleados que no participan en ningún proyecto. Consulta SQL (1 pts.)
select e.EMPNO, (e.NOMBRE || ' ' || e.APELLIDOS) nombre_empleado, e.SALARIOBASE, e.DEPNO
from EMPLEADO e
         left join PARTICIPA p on e.EMPNO = p.EMPNO
where p.PROYNO is null
order by EMPNO;

--4. Realizar un disparador que compruebe en las inserciones y actualizaciones, la duración
-- de los proyectos y que si es negativa introduzca 0. Trigger (2 pts.)
CREATE OR REPLACE TRIGGER actualizar_duracion_proyecto
    BEFORE
        INSERT OR UPDATE
    ON PROYECTO
    FOR EACH ROW
DECLARE
    v_proyecto PROYECTO%rowtype;
BEGIN
    select * into v_proyecto from PROYECTO p where p.PROYNO = :new.proyno;
    if :new.duracion < 0 then
        raise_application_error(-20001, 'La duración del proyecto tiene que ser mayor que cero');
    end if;
END;
/