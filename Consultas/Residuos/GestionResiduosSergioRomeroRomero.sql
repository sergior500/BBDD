--EJERCICIOS REPASO Consultas Simples, agregados y varias tablas
/*1. Muestra el nombre de las empresas productoras de Huelva o Málaga ordenadas por el
nombre en orden alfabético inverso.*/

SELECT NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA 
ORDER BY NOMBRE_EMPRESA ASC;


--2. Mostrar los nombres de los destinos cuya ciudad contenga una b mayúscula o minúscula.

SELECT NOMBRE_DESTINO
FROM DESTINO
WHERE LOWER(CIUDAD_DESTINO) LIKE '%b%';

--3. Obtener el código de los residuos con una cantidad superior a 4 del constituyente 116.

SELECT COD_RESIDUO 
FROM RESIDUO_CONSTITUYENTE rc  
WHERE CANTIDAD > 4 
AND COD_CONSTITUYENTE LIKE '116';

/*4. Muestra el tipo de transporte, los kilómetros y el coste de los traslados realizados en
diciembre de 1994.*/

SELECT TIPO_TRANSPORTE , KMS, COSTE 
FROM TRASLADO t 
WHERE EXTRACT(YEAR FROM(FECHA_ENVIO)) = 1994;

--5. Mostrar el código del residuo y el número de constituyentes de cada residuo.

SELECT COD_RESIDUO , COUNT(COD_CONSTITUYENTE)
FROM RESIDUO_CONSTITUYENTE rc
GROUP BY COD_RESIDUO;

--6. Mostrar la cantidad media de residuo vertida por las empresas durante el año 1994.

SELECT NVL(AVG(NVL(CANTIDAD,0)),0)
FROM RESIDUO_EMPRESA re 
WHERE EXTRACT(YEAR FROM(FECHA)) = 1994;

--7. Mostrar el mayor número de kilómetros de un traslado realizado el mes de marzo.

SELECT MAX(KMS)
FROM TRASLADO t
WHERE EXTRACT(MONTH FROM(FECHA_ENVIO)) = 03;

/*8. Mostrar el número de constituyentes distintos que genera cada empresa, mostrando también
el nif de la empresa, para aquellas empresas que generen más de 4 constituyentes.*/

SELECT DISTINCT  COUNT(rc.COD_CONSTITUYENTE), re.NIF_EMPRESA 
FROM RESIDUO_EMPRESA re , RESIDUO r , RESIDUO_CONSTITUYENTE rc 
WHERE re.COD_RESIDUO = r.COD_RESIDUO 
AND r.COD_RESIDUO = rc.COD_RESIDUO 
GROUP BY re.NIF_EMPRESA
HAVING COUNT(rc.COD_CONSTITUYENTE)>4;
/*9. Mostrar el nombre de las diferentes empresas que han enviado residuos que contenga la
palabra metales en su descripción.*/

SELECT DISTINCT e.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e , RESIDUO_EMPRESA re ,RESIDUO r 
WHERE e.NIF_EMPRESA = re.NIF_EMPRESA 
AND re.COD_RESIDUO = r.COD_RESIDUO 
AND LOWER(r.OD_RESIDUO) LIKE '%metales%';

/*10. Mostrar el número de envíos que se han realizado entre cada ciudad, indicando también la
ciudad origen y la ciudad destino.*/

SELECT count(d.COD_DESTINO), d.CIUDAD_DESTINO, e.CIUDAD_EMPRESA CIUDAD_ORIGEN
FROM DESTINO d , TRASLADO t , EMPRESAPRODUCTORA e 
WHERE e.NIF_EMPRESA = t.NIF_EMPRESA 
AND t.COD_DESTINO = d.COD_DESTINO
GROUP BY d.CIUDAD_DESTINO , e.CIUDAD_EMPRESA ;

/*11. Mostrar el nombre de la empresa transportista que ha transportado para una empresa que
esté en Málaga o en Huelva un residuo que contenga Bario o Lantano. Mostrar también la
fecha del transporte.*/

SELECT e2.NOMBRE_EMPTRANSPORTE, t.FECHA_ENVIO 
FROM EMPRESAPRODUCTORA e ,EMPRESATRANSPORTISTA e2 ,TRASLADO t ,RESIDUO r , RESIDUO_CONSTITUYENTE rc ,CONSTITUYENTE c 
WHERE e.NIF_EMPRESA = t.NIF_EMPRESA 
AND t.NIF_EMPTRANSPORTE = e2.NIF_EMPTRANSPORTE 
AND t.COD_RESIDUO = r.COD_RESIDUO 
AND r.COD_RESIDUO = rc.COD_RESIDUO 
AND rc.COD_CONSTITUYENTE = c.COD_CONSTITUYENTE 
AND (UPPER(e.CIUDAD_EMPRESA) LIKE 'HUELVA%'
OR UPPER(e.CIUDAD_EMPRESA) LIKE 'MÁLAGA')
AND (UPPER(c.NOMBRE_CONSTITUYENTE) LIKE '%BARIO%'
OR UPPER(c.NOMBRE_CONSTITUYENTE) LIKE '%LANTANO%');

/*12. Mostrar el coste por kilómetro del total de traslados encargados por la empresa productora
Carbonsur.*/

SELECT SUM(t.COSTE) Coste_TOTAL
FROM TRASLADO t ,EMPRESAPRODUCTORA e 
WHERE t.NIF_EMPRESA = e.NIF_EMPRESA  
AND upper(e.NOMBRE_EMPRESA) LIKE '%CARBONSUR%';

--13. Mostrar el número de constituyentes de cada residuo.

SELECT r.COD_RESIDUO ,COUNT(rc.COD_CONSTITUYENTE)
FROM RESIDUO r , RESIDUO_CONSTITUYENTE rc 
WHERE r.COD_RESIDUO = rc.COD_RESIDUO 
GROUP BY r.COD_RESIDUO ;

/*14. Mostrar la descripción de los residuos y la fecha que se generó el residuo, para aquellos
residuos que se han generado en los últimos 30 días por una empresa cuyo nombre tenga una
c. La consulta debe ser válida para cualquier fecha y el listado debe aparecer ordenado por la
descripción del residuo y la fecha.*/

SELECT r.OD_RESIDUO,re.FECHA 
FROM RESIDUO r,RESIDUO_EMPRESA re,EMPRESAPRODUCTORA e 
WHERE re.NIF_EMPRESA = e.NIF_EMPRESA  
AND r.COD_RESIDUO =re.COD_RESIDUO 
AND UPPER(e.NOMBRE_EMPRESA) LIKE '%C%'
AND FECHA BETWEEN SYSDATE-30 AND SYSDATE
ORDER BY r.COD_RESIDUO, re.FECHA;



