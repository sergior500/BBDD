--1.Mostrar el nombre de los clientes junto al nombre de su pueblo.

SELECT c.NOMBRE Clientes, p.NOMBRE Pueblo
FROM CLIENTES c , PUEBLOS p 
WHERE c.CODPUE = p.CODPUE;

--2.Mostrar el nombre de los pueblos junto con el nombre de la provincia correspondiente.

SELECT p.NOMBRE Pueblo,p2.NOMBRE Provincia
FROM PUEBLOS p ,PROVINCIAS p2 
WHERE p.CODPRO = p2.CODPRO;

--3.Mostrar el nombre de los clientes junto al nombre de su pueblo y el de su provincia.

SELECT c.NOMBRE Clientes,p.NOMBRE Pueblo,p2.NOMBRE Provincia
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.CODPUE = p.CODPUE 
AND p.CODPRO = p2.CODPRO;

--4.Nombre de las provincias donde residen clientes sin que salgan valores repetidos.

SELECT DISTINCT p2.NOMBRE Provincias
FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
WHERE c.CODPUE = p.CODPUE 
AND p.CODPRO = p2.CODPRO;

/*5.Mostrar la descripción de los artículos que se han vendido en una cantidad superior a 10 unidades.
Si un artículo se ha vendido más de una vez en una cantidad superior a 10 sólo debe salir una vez.*/

SELECT DISTINCT a.DESCRIP Descripcion
FROM LINEAS_FAC lf , ARTICULOS a
WHERE lf.CODART = a.CODART 
AND CANT >10;


/*6.Mostrar la fecha de factura junto con el código del artículo y la cantidad vendida por cada artículo vendido en alguna factura. 
Los datos deben salir ordenado por fecha, primero las más reciente, luego por el código del artículos, 
y si el mismo artículo se ha vendido varias veces en la misma fecha los más vendidos primero.*/

SELECT f.FECHA , a.CODART Codigo,lf.CANT Cantidad
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC 
ORDER BY f.FECHA DESC, a.CODART , lf.CANT DESC;

--7.Mostrar el código de factura y la fecha de las mismas de las facturas que se han facturado a un cliente que tenga en su código postal un 7.
SELECT f.CODFAC Codigo, f.FECHA
FROM FACTURAS f ,CLIENTES c 
WHERE f.CODCLI = c.CODCLI 
AND c.CODPOSTAL LIKE '%7%'

--8.Mostrar el código de factura, la fecha y el nombre del cliente de todas las facturas existentes en la base de datos.
SELECT f.CODFAC Codigo_Factura ,f.FECHA ,c.NOMBRE 
FROM FACTURAS f ,CLIENTES c 
WHERE f.CODCLI = c.CODCLI

/*9.Mostrar un listado con el código de la factura, la fecha, el iva, 
el dto y el nombre del cliente para aquellas facturas que obien no se le ha cobrado iva (no se ha cobrado iva si el iva es nulo o cero), 
o bien el descuento es nulo.*/
SELECT f.CODFAC Codigo_Factura,f.FECHA ,f.IVA ,f.DTO descuento,c.NOMBRE 
FROM FACTURAS f ,CLIENTES c 
WHERE f.CODCLI = c.CODCLI
AND (IVA IS NULL OR IVA LIKE '0')
OR  DTO IS NULL;

/*10.Se quiere saber que artículos se han vendido más baratos que el precio que actualmente tenemos almacenados en la tabla de artículos, 
para ello se necesita mostrar la descripción de los artículos junto con el precio actual. 
Además deberá aparecer el precio en que se vendió si este precio es inferior al precio original.*/
SELECT a.DESCRIP descripcion,a.PRECIO precio_actual,lf.PRECIO precio_venta
FROM ARTICULOS a , LINEAS_FAC lf
WHERE a.CODART = lf.CODART 
AND a.PRECIO > lf.PRECIO;


/*11.Mostrar el código de las facturas, junto a la fecha, iva y descuento. 
También debe aparecer la descripción de los artículos vendido junto al precio de venta, la cantidad y el descuento de ese artículo, 
para todos los artículos que se han vendido.*/

SELECT f.CODFAC Codigo_Factura ,f.FECHA ,f.IVA ,f.DTO descuento , a.DESCRIP descripción ,lf.PRECIO precio_venta , lf.CANT ,lf.DTO descuento_articulo
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC;


--12.Igual que el anterior, pero mostrando también el nombre del cliente al que se le ha vendido el artículo.

SELECT f.CODFAC Codigo_Factura ,f.FECHA ,f.IVA ,f.DTO descuento , a.DESCRIP descripción ,lf.PRECIO precio_venta , lf.CANT ,lf.DTO descuento_articulo, c.NOMBRE 
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC
AND f.CODCLI = c.CODCLI ;


--13.Mostrar los nombres de los clientes que viven en una provincia que contenga la letra ma.

SELECT c.NOMBRE 
FROM CLIENTES c ,PUEBLOS p ,PROVINCIAS p2 
WHERE c.CODPUE = p.CODPUE 
AND p.CODPRO = p2.CODPRO 
AND UPPER(p2.NOMBRE) LIKE '%MA%';

--14.Mostrar el código del cliente al que se le ha vendido un artículo que tienen un stock menor al stock mínimo.

SELECT c.CODCLI Codigo_Cliente
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
WHERE c.CODCLI = f.CODCLI 
AND f.CODFAC = lf.CODFAC 
AND lf.CODART = a.CODART 
AND a.STOCK < a.STOCK_MIN;

--15.Mostrar el nombre de todos los artículos que se han vendido alguna vez. (no deben salir valores repetidos)

SELECT DISTINCT a.DESCRIP descripción 
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.CODART = a.CODART;

/*16.Se quiere saber el precio real al que se ha vendido cada vez los artículos. Para ello es necesario mostrar el nombre del artículo, 
junto con el precio de venta (no el que está almacenado en la tabla de artículos) menos el descuento aplicado en la línea de descuento.*/

SELECT a.DESCRIP descripción ,lf.PRECIO-lf.DTO  PRECIO_real
FROM LINEAS_FAC lf ,ARTICULOS a 
WHERE lf.CODART = a.CODART
AND lf.DTO IS NOT NULL;

--17.Mostrar el nombre de los artículos que se han vendido a clientes que vivan en una provincia cuyo nombre termina  por a.

SELECT a.DESCRIP Nombre
FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c,PUEBLOS p ,PROVINCIAS p2 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC
AND f.CODCLI = c.CODCLI 
AND c.CODPUE = p.CODPUE 
AND p.CODPRO = p2.CODPRO 
AND UPPER(p2.NOMBRE) LIKE '%A';

--18.Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas.

SELECT DISTINCT c.NOMBRE 
FROM CLIENTES c ,FACTURAS f 
WHERE c.CODCLI = f.CODCLI 
AND f.DTO > 10;

/*19.Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas 
o en alguna de las líneas que componen la factura o en ambas.*/

SELECT DISTINCT c.NOMBRE 
FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf 
WHERE c.CODCLI = f.CODCLI 
AND f.CODFAC = lf.CODFAC 
AND f.DTO > 10 OR lf.DTO >10;

--20.Mostrar la descripción, la cantidad y el precio de venta de los artículos vendidos al cliente con nombre MARIA MERCEDES

SELECT a.DESCRIP ,lf.CANT ,lf.PRECIO 
FROM ARTICULOS a ,LINEAS_FAC lf ,FACTURAS f ,CLIENTES c 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC 
AND f.CODCLI = c.CODCLI 
AND c.NOMBRE LIKE '%MARIA MERCEDES%'
