--1 Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.--

SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.IDASIGNATURA NOT IN '150212' 
AND aa.IDASIGNATURA NOT IN '130113';

--2 Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". --
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS >(SELECT a2.CREDITOS FROM ASIGNATURA a2 
					WHERE a2.NOMBRE = 'Seguridad Vial');

--3 Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. --
SELECT aa.IDALUMNO  
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA ='150212'
AND aa.IDASIGNATURA ='130113';

--4 Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no en ambas a la vez. 
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA = '150212'
OR aa.IDASIGNATURA ='130113';

--5 Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el coste básico promedio por asignatura en esa titulación.

SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.IDTITULACION = '130110' AND a.COSTEBASICO > 
(SELECT AVG(NVL( a2.COSTEBASICO,0)) FROM ASIGNATURA a2 );



--6 Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa
WHERE aa.IDASIGNATURA NOT IN '150212' 
OR aa.IDASIGNATURA NOT IN '130113';

--7 Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA IN '150212'AND aa.IDASIGNATURA NOT IN '130113';

--8 Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS > (SELECT a2.CREDITOS FROM ASIGNATURA a2 WHERE a2.NOMBRE ='Seguridad Vial');

--9 Mostrar las personas que no son ni profesores ni alumnos.

SELECT p.NOMBRE 
FROM PERSONA p 
WHERE p.NOMBRE NOT IN (SELECT p2.NOMBRE
					FROM PERSONA p2, PROFESOR p3 
					WHERE p2.DNI = p3.DNI
					AND  p3.DNI = p2.DNI) AND p.NOMBRE NOT IN 
										(SELECT p.NOMBRE FROM PERSONA p, ALUMNO a 
										WHERE p.DNI=a.DNI 
										AND p.DNI=a.DNI);	

--10 Mostrar el nombre de las asignaturas que tengan más créditos. 
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS = (SELECT MAX(CREDITOS) FROM ASIGNATURA);
				
--11 Lista de asignaturas en las que no se ha matriculado nadie. 
SELECT a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa , ASIGNATURA a 
WHERE aa.NUMEROMATRICULA IS NULL;

--12 Ciudades en las que vive algún profesor y también algún alumno. 
SELECT p.CIUDAD 
FROM PERSONA p , PROFESOR p2 , ALUMNO a 
WHERE p.DNI = p2.DNI 
AND p.DNI = a.DNI;



