/*1 Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para 
las asignaturas del mismo coste mostrar por orden alfabético de nombre de asignatura.*/

SELECT DISTINCT COSTEBASICO,NOMBRE 
FROM ASIGNATURA a
ORDER BY COSTEBASICO DESC, nombre ASC;

--2 Mostrar el nombre y los apellidos de los profesores.

SELECT nombre, apellido 
FROM PERSONA p ,PROFESOR p2  
WHERE p.DNI =p2.DNI;

--3 Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla.

SELECT a.NOMBRE 
FROM ASIGNATURA a ,PROFESOR p2 ,PERSONA p 
WHERE p.DNI = p2.DNI 
AND p2.IDPROFESOR = a.IDPROFESOR 
AND p.CIUDAD ='Sevilla';

--4 Mostrar el nombre y los apellidos de los alumnos.

SELECT p.NOMBRE,p.APELLIDO 
FROM PERSONA p,ALUMNO a
WHERE p.DNI = a.dni;

--5 Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla.

SELECT p.NOMBRE,p.APELLIDO,p.DNI  
FROM PERSONA p,ALUMNO a
WHERE p.DNI = a.dni 
AND p.CIUDAD = 'Sevilla'; 

--6 Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial".

SELECT p.DNI ,p.NOMBRE ,p.APELLIDO  
FROM PERSONA p , ALUMNO a, ALUMNO_ASIGNATURA aa,ASIGNATURA a2 
WHERE p.DNI =a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA =a2.IDASIGNATURA 
AND a2.NOMBRE ='Seguridad Vial';

/*7 Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI
20202020A. Un alumno está matriculado en una titulación si está matriculado en una
asignatura de la titulación.*/

SELECT DISTINCT a2.IDTITULACION  
FROM ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA a2
WHERE a.IDALUMNO =aa.IDALUMNO 
AND aa.IDASIGNATURA = a2.IDASIGNATURA 
AND a.DNI LIKE '20202020A';

--8 Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.

SELECT a2.NOMBRE 
FROM PERSONA p , ALUMNO a, ALUMNO_ASIGNATURA aa,ASIGNATURA a2 
WHERE p.DNI =a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA =a2.IDASIGNATURA 
AND p.NOMBRE LIKE 'Rosa' 
AND p.APELLIDO LIKE 'Garcia';

--9 Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz.

SELECT a2.DNI  
FROM PERSONA p,PROFESOR p2,ASIGNATURA a,ALUMNO_ASIGNATURA aa,ALUMNO a2
WHERE p.DNI =p2.DNI 
AND p2.IDPROFESOR =a.IDPROFESOR 
AND a.IDASIGNATURA =aa.IDASIGNATURA 
AND aa.IDALUMNO =a2.IDALUMNO 
AND p.NOMBRE LIKE 'Jorge' AND p.APELLIDO LIKE 'Saenz';

--10 Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 

SELECT a2.DNI,p3.NOMBRE,p3.APELLIDO  
FROM PERSONA p,PROFESOR p2,ASIGNATURA a,ALUMNO_ASIGNATURA aa,ALUMNO a2, PERSONA p3
WHERE p.DNI =p2.DNI 
AND p2.IDPROFESOR =a.IDPROFESOR 
AND a.IDASIGNATURA =aa.IDASIGNATURA 
AND aa.IDALUMNO =a2.IDALUMNO 
AND a2.DNI  =p3.DNI 
AND p.NOMBRE LIKE 'Jorge' AND p.APELLIDO LIKE 'Saenz';

--11 Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 

SELECT t.NOMBRE 
FROM TITULACION t,ASIGNATURA a
WHERE t.IDTITULACION = a.IDTITULACION 
AND a.CREDITOS >=4;

--12 Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 

SELECT a.NOMBRE ,a.CREDITOS,t.NOMBRE  
FROM ASIGNATURA a, TITULACION t 
WHERE a.IDTITULACION =t.IDTITULACION 
AND a.CUATRIMESTRE =1; 

--13 Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas

SELECT a.NOMBRE,a.COSTEBASICO ,p.NOMBRE 
FROM ASIGNATURA a,ALUMNO_ASIGNATURA aa ,ALUMNO a2 ,PERSONA p
WHERE a.IDASIGNATURA =aa.IDASIGNATURA 
AND aa.IDALUMNO =a2.IDALUMNO 
AND a2.DNI =p.DNI 
AND a.CREDITOS >4.5;

--14 Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos

SELECT p.NOMBRE 
FROM PERSONA p,PROFESOR p2, ASIGNATURA a
WHERE p.DNI =p2.DNI 
AND p2.IDPROFESOR = a.IDPROFESOR 
AND a.COSTEBASICO BETWEEN 25 AND 35;

--15 Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.

SELECT p.NOMBRE  
FROM PERSONA p,ALUMNO a , ALUMNO_ASIGNATURA aa
WHERE p.DNI =a.DNI 
AND a.IDALUMNO =aa.IDALUMNO 
AND (aa.IDASIGNATURA = '150212' OR aa.IDASIGNATURA = '130113' 
OR (aa.IDASIGNATURA = '150212' AND aa.IDASIGNATURA = '130113'));

--16 Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.

SELECT a.NOMBRE,t.NOMBRE  
FROM ASIGNATURA a, TITULACION t
WHERE a.IDTITULACION = t.IDTITULACION 
AND a.CUATRIMESTRE =2 
AND a.CREDITOS !=6;

--17 Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.

SELECT DISTINCT  a.NOMBRE ,a.CREDITOS *10 AS numero_horas,a2.DNI 
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa, ALUMNO a2 
WHERE a.IDASIGNATURA =aa.IDASIGNATURA 
AND aa.IDALUMNO =a2.IDALUMNO; 

--18 Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura

SELECT p.NOMBRE 
FROM PERSONA p, ALUMNO a , ALUMNO_ASIGNATURA aa
WHERE p.DNI =a.DNI 
AND a.IDALUMNO =aa.IDALUMNO 
AND p.VARON =0 
AND p.CIUDAD LIKE 'Sevilla';

--19 Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.

SELECT nombre 
FROM ASIGNATURA a 
WHERE CURSO =1 AND UPPER(IDPROFESOR) = 'P101';

--20 Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.

SELECT p.NOMBRE  
FROM PERSONA p ,ALUMNO a,ALUMNO_ASIGNATURA aa
WHERE p.DNI =a.DNI 
AND a.IDALUMNO =aa.IDALUMNO 
AND aa.NUMEROMATRICULA >=3;