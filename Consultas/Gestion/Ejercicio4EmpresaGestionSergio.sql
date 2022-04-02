/*1. Número de CLIENTES que tienen alguna factura con IVA 16%.*/
SELECT COUNT(CODCLI)
FROM FACTURAS
WHERE IVA = 16;
/*2. Número de CLIENTES que no tienen ninguna factura con un 16% de IVA.*/
SELECT COUNT(CODFAC)
FROM FACTURAS 
WHERE CODCLI NOT IN (SELECT CODCLI
    					FROM FACTURAS
    					WHERE IVA = 16);
/*3. Número de CLIENTES que en todas sus FACTURAS tienen un 16% de IVA (los CLIENTES deben tener al menos una factura).*/
SELECT COUNT(CODCLI)
FROM FACTURAS
WHERE CODCLI NOT IN (SELECT CODCLI 
    					FROM FACTURAS
    					WHERE IVA != 16 OR IVA IS NULL);

/*4. FECHA de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).*/
SELECT FECHA
FROM FACTURAS
WHERE CODFAC IN (
    SELECT CODFAC
    FROM LINEAS_FAC
    GROUP BY CODFAC
    HAVING SUM(CANT*PRECIO) = (SELECT MAX(SUM(CANT*PRECIO))
      							 FROM LINEAS_FAC
   								 GROUP BY CODFAC));

/*5. Número de PUEBLOS en los que no tenemos CLIENTES.*/
SELECT COUNT(CODPUE)
FROM PUEBLOS
WHERE CODPUE NOT IN(SELECT CODPUE
				    FROM CLIENTES);

/*6. Número de artículos cuyo stock supera las 20 unidades, con PRECIO superior a 15 euros y de los que no hay ninguna 
factura en el último trimestre del año pasado.*/
SELECT COUNT(codart)
FROM ARTICULOS
WHERE stock > 20 
AND PRECIO > 15
AND codart NOT IN (SELECT LINEAS_FAC.codart
					    FROM FACTURAS, LINEAS_FAC
					    WHERE FACTURAS.CODFAC = LINEAS_FAC.CODFAC 
					    AND extract (MONTH FROM FACTURAS.FECHA) 
					    BETWEEN 10 AND 12
					    AND extract(YEAR FROM FACTURAS.FECHA) = 2008);

/*7. Obtener el número de CLIENTES que en todas las FACTURAS del año pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).*/
SELECT COUNT(CODCLI)
FROM CLIENTES
WHERE CODCLI NOT IN(SELECT CODCLI
   						FROM FACTURAS
    					WHERE IVA IS NULL OR IVA = 0 
    					AND extract(YEAR FROM FECHA) = 2008);

/*8. CLIENTES (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y que en diciembre de ese mismo 
año no tienen ninguna factura. Son CLIENTES preferentes de un mes aquellos que han solicitado más de 60,50 euros en FACTURAS durante 
ese mes, sin tener en cuenta descuentos ni impuestos.*/
SELECT FACTURAS.CODCLI
FROM LINEAS_FAC, FACTURAS
WHERE LINEAS_FAC.CODFAC = FACTURAS.CODFAC
AND extract(MONTH FROM FECHA) = 11
GROUP BY FACTURAS.CODCLI
HAVING SUM(CANT*PRECIO) > 60.50
AND CODCLI NOT IN(SELECT CODCLI
   					FROM FACTURAS
    				WHERE extract(MONTH FROM FECHA) = 12
    				AND extract(YEAR FROM FECHA) = 2008);
/*9. Código, descripción y PRECIO de los diez artículos más caros.*/
SELECT distinct codart, descrip, PRECIO
FROM ARTICULOS
WHERE rownum <= 10
ORDER BY PRECIO desc;

/*10. Nombre de la provincia con mayor número de CLIENTES.*/
SELECT provincias.nombre
FROM CLIENTES, PUEBLOS, provincias
WHERE CLIENTES.CODPUE = PUEBLOS.CODPUE AND PUEBLOS.codpro = provincias.codpro
AND rownum <= 1
GROUP BY provincias.nombre
ORDER BY COUNT(CODCLI) desc;

/*11. Código y descripción de los artículos cuyo PRECIO es mayor de 90,15 euros y se han vendido menos de 10 unidades (o ninguna) 
durante el año pasado.*/
SELECT ARTICULOS.codart, ARTICULOS.descrip
FROM ARTICULOS, LINEAS_FAC, FACTURAS
WHERE ARTICULOS.codart = LINEAS_FAC.codart AND LINEAS_FAC.CODFAC = FACTURAS.CODFAC
AND ARTICULOS.PRECIO > 90.15
AND extract(YEAR FROM FECHA) = 2008
AND ARTICULOS.codart IN(SELECT codart
						  FROM LINEAS_FAC
						  GROUP BY codart
						  HAVING SUM(CANT) < 10);

/*12. Código y descripción de los artículos cuyo PRECIO es más de tres mil veces mayor que el PRECIO mínimo de cualquier artículo.*/
SELECT codart, PRECIO 
FROM ARTICULOS
WHERE PRECIO > (SELECT MIN(PRECIO) * 3000
    				FROM ARTICULOS);

/*13. Nombre del cliente con mayor facturación.*/
SELECT distinct CLIENTES.nombre
FROM LINEAS_FAC, FACTURAS, CLIENTES
WHERE LINEAS_FAC.CODFAC = FACTURAS.CODFAC AND FACTURAS.CODCLI = CLIENTES.CODCLI
AND FACTURAS.CODFAC = (SELECT CODFAC
					    FROM LINEAS_FAC
					    GROUP BY CODFAC
					    HAVING SUM(PRECIO*CANT) = (SELECT MAX(SUM(PRECIO*CANT))
											        FROM LINEAS_FAC
											        GROUP BY CODFAC));

/*14. Código y descripción de aquellos artículos con un PRECIO superior a la media y que hayan sido comprados por más de 5 CLIENTES.*/
SELECT distinct ARTICULOS.codart, ARTICULOS.descrip
FROM ARTICULOS, LINEAS_FAC
WHERE ARTICULOS.codart = LINEAS_FAC.codart
AND LINEAS_FAC.codart IN (SELECT LINEAS_FAC.codart 
						    FROM LINEAS_FAC, FACTURAS
						    WHERE LINEAS_FAC.CODFAC = FACTURAS.CODFAC
						    GROUP BY LINEAS_FAC.codart
						    HAVING COUNT(distinct FACTURAS.CODCLI) > 5)
							AND ARTICULOS.PRECIO > (SELECT avg(PRECIO)
						    							FROM ARTICULOS);