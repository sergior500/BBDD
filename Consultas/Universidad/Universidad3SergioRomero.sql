--1 Cuantos costes básicos hay.
SELECT  SUM(COSTEBASICO)
FROM ASIGNATURA;

SELECT COUNT(COSTEBASICO) 
FROM ASIGNATURA;

--2 Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.
SELECT COUNT(*),TITULACION.NOMBRE
FROM ASIGNATURA, TITULACION
WHERE ASIGNATURA.IDTITULACION  = TITULACION.IDTITULACION
GROUP BY TITULACION.NOMBRE;

--3 Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.

SELECT SUM(a.COSTEBASICO), t.NOMBRE 
FROM TITULACION t , ASIGNATURA a 
WHERE a.IDTITULACION  = t.IDTITULACION 
GROUP BY t.NOMBRE ;

--4 Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura fuera incrementado en un 7%. 
SELECT SUM(a.COSTEBASICO)*1.07, t.NOMBRE 
FROM TITULACION t , ASIGNATURA a 
WHERE a.IDTITULACION  = t.IDTITULACION 
AND t.NOMBRE  = 'Matematicas'
GROUP BY t.NOMBRE ;

--5 Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura.
SELECT COUNT(IDALUMNO), IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
GROUP BY IDASIGNATURA;

--6 Igual que el anterior pero mostrANDo el nombre de la asignatura.
SELECT COUNT(IDALUMNO), a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY a.NOMBRE;

/*7 Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar por el total de todas las asignaturas en las que está matriculada.
Recuerda que el precio de la matrícula tiene un incremento de un 10% por cada año en el que esté matriculado.*/
SELECT p.NOMBRE , SUM(a2.COSTEBASICO) SUM(a2.CUATRIMESTRE)
FROM ALUMNO_ASIGNATURA aa ,ALUMNO a ,ASIGNATURA a2 ,PERSONA p 
WHERE aa.IDALUMNO = a.IDALUMNO 
AND a.DNI = p.DNI 
AND aa.IDASIGNATURA = a2.IDASIGNATURA
GROUP BY p.NOMBRE 

/*8. Coste medio de las asignaturas de cada titulación, para aquellas titulaciones en el que el coste total
de la 1ª matrícula sea mayor que 60 euros. */
SELECT idtitulacion
FROM asignatura
GROUP BY idtitulacion
HAVING AVG(costebasico) > 60;

--9. Nombre de las titulaciones  que tengan más de tres alumnos.
SELECT t.nombre
FROM titulacion t, asignatura a, alumno_asignatura aa
WHERE t.idtitulacion=a.idtitulacion 
AND a.idasignatura=aa.idasignatura
GROUP BY t.nombre
HAVING COUNT(aa.idalumno) > 3;

--10. Nombre de cada ciudad junto con el número de personas que viven en ella.
SELECT ciudad, COUNT(dni) num_personas
FROM persona
GROUP BY ciudad;

--11. Nombre de cada profesor junto con el número de asignaturas que imparte.
SELECT persona.nombre, COUNT(asignatura.nombre) num_asignaturas
FROM persona, profesor, asignatura
WHERE persona.dni=profesor.dni 
AND profesor.idprofesor=asignatura.idprofesor
GROUP BY persona.nombre;

/*12. Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que 
tengan dos o más de 2 alumnos.*/
SELECT persona.nombre, COUNT(alumno_asignatura.idalumno) cantidad_alumno
FROM persona, profesor, asignatura, alumno_asignatura
WHERE persona.dni=profesor.dni 
AND profesor.idprofesor=asignatura.idprofesor 
AND asignatura.idasignatura=alumno_asignatura.idasignatura
GROUP BY persona.nombre
HAVING COUNT(alumno_asignatura.idalumno) >= 2;

--13. Obtener el máximo de las SUMas de los costesbásicos de cada cuatrimestre
SELECT cuatrimestre, SUM(costebasico)
FROM asignatura
GROUP BY cuatrimestre;

--14. Suma del coste de las asignaturas
SELECT SUM(costebasico)
FROM asignatura;

--15. ¿Cuántas asignaturas hay?
SELECT COUNT(DISTINCT nombre) total_asignaturas
FROM asignatura;

--16. Coste de la asignatura más cara y de la más barata
SELECT MIN(costebasico) asig_barata, MAX(costebasico) asig_cara
FROM asignatura;

--17. ¿Cuántas posibilidades de créditos de asignatura hay?
SELECT COUNT(DISTINCT creditos) posibilidades
FROM asignatura;

--18. ¿Cuántos cursos hay?
SELECT COUNT(DISTINCT curso) num_cursos
FROM asignatura;

--19. ¿Cuántas ciudades hay?
SELECT COUNT(DISTINCT ciudad) cant_ciudades
FROM persona;

--20. Nombre y número de horas de todas las asignaturas.
SELECT nombre, creditos*10 horas
FROM asignatura;

--21. Mostrar las asignaturas que no pertenecen a ninguna titulación.
SELECT *
FROM asignatura
WHERE idtitulacion IS NULL OR idtitulacion LIKE '';

/*22. Listado del nombre completo de las personas, sus teléfonos y sus direcciones, llamANDo a la columna del nombre 
"NombreCompleto" y a la de direcciones "Direccion".*/
SELECT nombre || ' ' || apellido || ' ' || telefono Nombre_Completo, ciudad || ' ' || direccioncalle || ' ' || direccionnum AS Direccion
FROM persona;

--23. Cual es el día siguiente al día en que nacieron las personas de la B.D.
SELECT dni, fecha_nacimiento, fecha_nacimiento+1 dia_siguiente
FROM persona;

--24. Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
SELECT ROUND((TRUNC(SYSDATE) - TRUNC(fecha_nacimiento))/365,1) AS difference
FROM persona;

/*25. Listado de personas mayores de 25 años ordenadas por apellidos y nombre, esta consulta tiene que valor 
para cualquier momento*/
SELECT *
FROM persona
WHERE ROUND((TRUNC(SYSDATE) - TRUNC(fecha_nacimiento))/365) > 25;

--26. Nombres completos de los profesores que además son alumnos
SELECT p.nombre || ' ' || p.apellido nombre
FROM persona p, profesor, persona pa, alumno
WHERE p.dni=profesor.dni 
AND profesor.dni=pa.dni 
AND pa.dni=alumno.dni;

--27. Suma de los créditos de las asignaturas de la titulación de Matemáticas
SELECT SUM(creditos) SUMa_creditos
FROM asignatura, titulacion
WHERE asignatura.idtitulacion=titulacion.idtitulacion 
AND titulacion.nombre LIKE 'Matematicas';

--28. Número de asignaturas de la titulación de Matemáticas
SELECT COUNT(asignatura.nombre) num_asignaturas
FROM asignatura, titulacion
WHERE asignatura.idtitulacion=titulacion.idtitulacion 
AND titulacion.nombre LIKE 'Matematicas';

--29. ¿Cuánto paga cada alumno por su matrícula?
SELECT persona.nombre, persona.apellido, SUM(asignatura.costebasico)
FROM persona, alumno, alumno_asignatura, asignatura
WHERE persona.dni=alumno.dni 
AND alumno.idalumno=alumno_asignatura.idalumno 
AND alumno_asignatura.idasignatura=asignatura.idasignatura
GROUP BY persona.nombre, persona.apellido;

--30. ¿Cuántos alumnos hay matriculados en cada asignatura?
SELECT asignatura.nombre, COUNT(alumno_asignatura.idalumno) num_alumnos
FROM asignatura, alumno_asignatura
WHERE asignatura.idasignatura=alumno_asignatura.idasignatura
GROUP BY asignatura.nombre; 





