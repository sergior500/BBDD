--1.Descuento medio aplicado en las facturas.

SELECT AVG(DTO) Descuento_Medio
FROM FACTURAS f;

--2.Descuento medio aplicado en las facturas sin considerar los valores nulos.

SELECT AVG(DTO) Descuento_Medio
FROM FACTURAS f;

--3.Descuento medio aplicado en las facturas considerando los valores nulos como cero.

SELECT AVG(NVL(DTO,0))
FROM FACTURAS f;

--4.Número de facturas.

SELECT COUNT(CODFAC) Numero_Facturas
FROM FACTURAS f;

--5.Número de pueblos de la Comunidad de Valencia.

SELECT COUNT(p.NOMBRE) 
FROM PUEBLOS p, PROVINCIAS p2 
WHERE p.CODPRO = p2.CODPRO 
AND UPPER(p2.NOMBRE) LIKE 'VALENCIA';

--6.Importe total de los artículos que tenemos en el almacén. Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad

SELECT (SUM(STOCK*PRECIO)) Importe
FROM ARTICULOS a;


--7.Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.

SELECT COUNT(p.CODPUE) Numero_Pueblos
FROM PUEBLOS p , CLIENTES c 
WHERE p.CODPUE = c.CODPUE
AND c.CODPOSTAL LIKE '12%';

--8.Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores

SELECT MAX(STOCK) STOCK_Max ,MIN(STOCK) STOCK_Min
FROM ARTICULOS
WHERE PRECIO BETWEEN '9' AND '12';

--9.Precio medio de los artículos cuyo stock supera las 10 unidades.

SELECT AVG(PRECIO) Precio_Medio
FROM ARTICULOS a 
WHERE STOCK > 10;

--10.Fecha de la primera y la última factura del cliente con código 210.

SELECT MAX(FECHA) MAX_Fecha, MIN(FECHA) MIN_Fecha
FROM FACTURAS f
WHERE CODCLI LIKE '210';

--11.Número de artículos cuyo stock es nulo.

SELECT COUNT(CODART) Cantidades_codart
FROM ARTICULOS a 
WHERE STOCK IS NULL;

--12.Número de líneas cuyo descuento es nulo (con un decimal)

SELECT COUNT(LINEA) Cantidades_linea
FROM LINEAS_FAC lf 
WHERE DTO IS NULL;

--13.Obtener cuántas facturas tiene cada cliente.

SELECT COUNT(f.CODFAC) Cantidades_codfac
FROM FACTURAS f , CLIENTES c 
WHERE f.CODCLI = c.CODCLI;

--14.Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.

SELECT count(f.CODFAC) Cantidades_codfac
FROM FACTURAS f , CLIENTES c 
WHERE f.CODCLI = c.CODCLI 
HAVING count(f.CODFAC)>=2;

--15.Importe de la facturación (suma de la cantidad del producto  por el precio de las líneas de factura) de los  artículos

SELECT SUM(CANT + PRECIO) total 
FROM LINEAS_FAC lf;


/*16.Importe de la facturación (suma de la cantidad del producto  por el precio de las líneas de factura) 
de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).*/

SELECT SUM(CANT + PRECIO) total
FROM LINEAS_FAC lf
WHERE UPPER(CODART) LIKE '%A%';

--17.Número de facturas para cada fecha, junto con la fecha

SELECT COUNT(CODFAC) codigo_factura , FECHA 
FROM FACTURAS f 
GROUP BY FECHA;

--18.Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.

SELECT COUNT(CODCLI) codigo_cliente , p.NOMBRE 
FROM CLIENTES c ,PUEBLOS p 
WHERE c.CODPUE = p.CODPUE
GROUP BY p.NOMBRE 
ORDER BY COUNT(c.CODCLI) DESC;

/*19.Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando 
primero los pueblos que más clientes tengan, 
siempre y cuando tengan más de dos clientes.*/

SELECT COUNT(CODCLI) codigo_cliente, p.NOMBRE 
FROM CLIENTES c ,PUEBLOS p 
WHERE c.CODPUE = p.CODPUE
HAVING COUNT(c.CODCLI)>2
GROUP BY p.NOMBRE 
ORDER BY COUNT(c.CODCLI) DESC;

/*20.Cantidades totales vendidas para cada artículo cuyo código empieza por “P", 
mostrando también la descripción de dicho artículo.9.-Precio máximo y precio mínimo de venta 
(en líneas de facturas) para cada artículo cuyo código empieza por “c”.*/

SELECT lf.CANT cantidad , a.DESCRIP descripción 
FROM LINEAS_FAC lf, ARTICULOS a 
WHERE lf.CODART = a.CODART 
AND UPPER(lf.CODART) LIKE 'P%'

SELECT MAX(lf.PRECIO) MAX_Precio, MIN(lf.PRECIO) MIN_Precio
FROM LINEAS_FAC lf
WHERE UPPER(lf.CODART) LIKE 'C%'; 

--21.Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.

SELECT lf.CANT cantidad , a.DESCRIP descripción , MAX(lf.PRECIO) MAX_Precio, MIN(lf.PRECIO) MIN_Precio
FROM LINEAS_FAC lf, ARTICULOS a 
WHERE lf.CODART = a.CODART 
AND UPPER(lf.CODART) LIKE 'P%'
GROUP BY a.DESCRIP , lf.CANT ;

--22.Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.

SELECT a.DESCRIP descripción 
FROM LINEAS_FAC lf  , ARTICULOS a 
WHERE lf.CODART = a.CODART 
AND lf.PRECIO>10000;

--23.Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), con cada IVA distinto que se les ha aplicado.

SELECT DISTINCT f.IVA, f.CODFAC codigo_factura,COUNT(f.CODFAC) cantidad_fac
FROM FACTURAS f , CLIENTES c 
WHERE c.CODCLI = f.CODCLI 
AND c.CODCLI BETWEEN 150 AND 300
GROUP BY f.CODFAC, IVA;

--24.Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.

SELECT  CODFAC codigo_factura ,AVG(CANT+PRECIO) importe_total
FROM LINEAS_FAC lf 
GROUP BY CODFAC;