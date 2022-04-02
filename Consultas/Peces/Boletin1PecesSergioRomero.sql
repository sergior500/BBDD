/* 1. Nombre, apellido y teléfono de todos los afiliados que sean hombres 
 y que hayan nacido antes del 1 de enero de 1970*/

SELECT a.NOMBRE , a.APELLIDOS , a.TELF 
FROM AFILIADOS a 
WHERE a.NACIMIENTO < to_date('01/01/1970','DD/MM/YYYY');

/*2. Peso, talla  y nombre de todos los peces que se han pescado 
por con talla inferior o igual a 45. Los datos deben salir ordenados por el nombre del pez, 
y para el mismo pez por el peso (primero los más grandes) 
y para el mismo peso por la talla (primero los más grandes).*/

SELECT c.PEZ, c.TALLA, c.PESO  
FROM CAPTURASSOLOS c 
WHERE c.TALLA <= 45
UNION
SELECT c2.PEZ, c2.Talla, c2.Peso
FROM CAPTURASEVENTOS c2 
WHERE c2.TALLA <= 45;
ORDER BY PEZ ASC, PESO DESC, TALLA DESC;


/*3. Obtener los nombres y apellidos de los afiliados que o bien tienen la 
 licencia de pesca que comienzan con una A (mayúscula o minúscula), 
 o bien el teléfono empieza en 9 
 y la dirección comienza en Avda.*/

SELECT DISTINCT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a, PERMISOS p
WHERE a.FICHA = p.FICHA
AND lower(p.LICENCIA) LIKE 'a%'
OR (a.TELF LIKE '9%'
AND a.DIRECCION LIKE 'Avda.%');

--4. Lugares del cauce “Rio Genil” que en el campo de observaciones 
--no tengan valor.

SELECT l.LUGAR
FROM LUGARES l 
WHERE l.CAUCE LIKE 'Rio Genil' 
AND l.OBSERVACIONES IS NULL;

/*5. Mostrar el nombre y apellidos de cada afiliado, junto 
 * con la ficha de los afiliados que 
 lo han avalado alguna vez como primer avalador.*/

SELECT a.NOMBRE , a.APELLIDOS , a.FICHA 
FROM AFILIADOS a JOIN CAPTURASSOLOS c 
ON c.aval1 = a.FICHA 

/*6. Obtén los cauces y en qué lugar de ellos han encontrado tencas (tipo de pez) 
 cuando nuestros afiliados han ido a pescar solos, indicando 
 la comunidad a la que pertenece dicho lugar. 
 (no deben salir valores repetidos)*/

SELECT DISTINCT c2.CAUCE , l.LUGAR 
FROM CAPTURASSOLOS c , LUGARES l , CAUCES c2 
WHERE c.LUGAR = l.LUGAR 
AND l.CAUCE = c2.CAUCE;

/*7. Mostrar el nombre y apellido de los afiliados que han conseguido alguna copa. 
Los datos deben salir ordenador por la fecha del evento, 
mostrando primero los eventos más antiguos.*/

SELECT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a , PARTICIPACIONES p , EVENTOS e 
WHERE a.FICHA = p.FICHA 
AND p.EVENTO = e.EVENTO
AND p.TROFEO IS NOT NULL
ORDER BY e.FECHA_EVENTO ASC;


SELECT a.NOMBRE , a.APELLIDOS 
FROM AFILIADOS a 
JOIN PARTICIPACIONES p ON a.FICHA = p.FICHA 
JOIN EVENTOS e ON p.EVENTO = e.EVENTO
AND p.TROFEO IS NOT NULL
ORDER BY e.FECHA_EVENTO ASC;

/*8. Obtén la ficha, nombre, apellidos, posición y trofeo de todos 
 * los participantes del evento 'Super Barbo' 
 mostrándolos según su clasificación.*/

SELECT a.FICHA , a.NOMBRE , a.APELLIDOS , p.POSICION , p.TROFEO 
FROM AFILIADOS a , PARTICIPACIONES p 
WHERE a.FICHA = p.FICHA 
AND p.EVENTO LIKE 'Super Barbo'
ORDER BY p.POSICION ASC;

/*9. Mostrar el nombre y apellidos de cada afiliado, junto con el 
 nombre y apellidos de los afiliados que lo han avalado alguna vez 
 como segundo avalador.*/

SELECT a.NOMBRE , a.APELLIDOS, a2.NOMBRE , a2.APELLIDOS 
FROM AFILIADOS a, CAPTURASSOLOS c ,AFILIADOS a2
WHERE a.FICHA = c.FICHA 
AND c.AVAL2 = a2.FICHA;

SELECT a.NOMBRE , a.APELLIDOS, a2.NOMBRE , a2.APELLIDOS 
FROM AFILIADOS a JOIN  CAPTURASSOLOS c ON a.FICHA = c.FICHA 
JOIN AFILIADOS a2 ON c.AVAL2 = a2.FICHA;


/*10. Indica todos los eventos en los que participó el afiliado 3796 en 1995 que no consiguió trofeo, 
 ordenados descendentemente por fecha.*/

SELECT p.EVENTO
FROM PARTICIPACIONES p , EVENTOS e 
WHERE p.EVENTO = e.EVENTO 
AND p.FICHA = 3796
AND EXTRACT(YEAR FROM e.FECHA_EVENTO) = 1995
AND p.TROFEO IS NULL
ORDER BY e.FECHA_EVENTO DESC;
