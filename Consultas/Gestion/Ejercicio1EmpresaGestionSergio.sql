--1 Código, fecha y doble del descuento de las facturas con iva cero.

SELECT CODFAC codigoFactura, FECHA , DTO*2 descuentoDoble
FROM FACTURAS f
WHERE IVA LIKE 0;

--2 Código de las facturas con iva nulo.

SELECT CODFAC codigoFactura
FROM FACTURAS f 
WHERE IVA IS NULL;

--3 Código y fecha de las facturas sin iva (iva cero o nulo).

SELECT CODFAC codigoFactura, fecha
FROM FACTURAS f 
WHERE IVA IS NULL OR IVA LIKE 0;

/*4 Codigo de factura y de artículo de las líneas de factura en las que la cantidad solicitada es menor de 5 unidades 
y además se ha aplicado un descuento del 25% o mayor.*/

SELECT CODFAC codigoFactura,CODART codArticulo
FROM LINEAS_FAC lf
WHERE CANT<5 AND DTO >= 25;

/*5 Obtener la descripción de los artículos cuyo stock está por debajo del stock mínimo, dado también la cantidad en unidades necesaria para alcanzar dicho mínimo.*/

SELECT DESCRIP descripción
FROM ARTICULOS a 
WHERE STOCK < STOCK_MIN;

-- 6.Ivas distintos aplicados a las facturas.

SELECT DISTINCT IVA IvaDistinto
FROM FACTURAS f;

/* 7.Código, descripción y stock mínimo de los artículos de los que se desconoce la cantidad de stock. 
 Cuando se desconoce la cantidad de stock de un artículo, el stock es nulo.*/

SELECT CODART codigo, DESCRIP descripcion, STOCK_MIN stockMinimo
FROM ARTICULOS a 
WHERE STOCK IS NULL;

--8.Obtener la descripción de los artículos cuyo stock es más de tres veces su stock mínimo y cuyo precio supera los 6 euros.

SELECT DESCRIP Descripcion
FROM ARTICULOS a 
WHERE STOCK > STOCK_MIN*3;

-- 9.Código de los artículos (sin que salgan repetidos) comprados en aquellas facturas cuyo código está entre 8 y 10.

SELECT DISTINCT CODART codigoArticulo
FROM LINEAS_FAC lf 
WHERE CODFAC BETWEEN 8 AND 10;

--10.Mostrar el nombre y la direccion de todos los clientes.

SELECT  NOMBRE ,DIRECCION 
FROM CLIENTES c;

--11.Mostrar los distintos códigos de pueblos en donde tenemos clientes

SELECT DISTINCT CODPUE codigoPueblo
FROM CLIENTES c;

--12.Obtener los códigos de los pueblos en donde hay clientes con código de cliente menor que el código 25. No deben salir códigos repetidos.

SELECT CODPUE codigoPueblo 
FROM CLIENTES c
WHERE CODCLI<25;

--13.Nombre de las provincias cuya segunda letra es una 'O' (bien mayúscula o minúscula).

SELECT NOMBRE 
FROM PROVINCIAS p 
WHERE UPPER(SUBSTR(NOMBRE,2)) LIKE 'O%';

--14.Código y fecha de las facturas del año pasado para aquellos clientes cuyo código se encuentra entre 50 y 100.
SELECT CODCLI codigoCliente,FECHA 
FROM FACTURAS f 
WHERE EXTRACT(YEAR FROM fecha)=(EXTRACT(YEAR FROM SYSDATE)-13) 
AND CODCLI BETWEEN 50 AND 100; 
/* Este es el ejercicio, el de arriba es debido a que no sale por que la fecha mas actual dentro del archivo es de 2009.
SELECT CODCLI ,FECHA 
FROM FACTURAS f 
WHERE EXTRACT(YEAR FROM fecha)=(EXTRACT(YEAR FROM SYSDATE)-1) 
AND CODCLI BETWEEN 50 AND 100; */

--15.Nombre y dirección de aquellos clientes cuyo código postal empieza por “12”. 

SELECT NOMBRE , DIRECCION
FROM CLIENTES c 
WHERE CODPOSTAL LIKE '12%';

--16.	Mostrar las distintas fechas, sin que salgan repetidas, de las factura existentes de clientes cuyos códigos son menores que 50.

SELECT DISTINCT FECHA 
FROM FACTURAS f 
WHERE CODCLI < 50;

--17.	Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004

SELECT CODFAC Codigo, FECHA 
FROM FACTURAS f 
WHERE FECHA BETWEEN '01/06/2004' AND '30/06/2004';

--Este funciona, el de arriba no por que no hay ninguna en 2004.
SELECT CODFAC Codigo, FECHA 
FROM FACTURAS f 
WHERE FECHA BETWEEN '01/06/2008' AND '30/06/2008';

--18.	Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004 para aquellos clientes cuyo código se encuentra entre 100 y 250.

SELECT CODFAC Codigo, FECHA 
FROM FACTURAS f 
WHERE FECHA BETWEEN '01/06/2004' AND '30/06/2004'
AND CODCLI BETWEEN 100 AND 250;

--Igual que el ejercicio anterior.

SELECT CODFAC Codigo, FECHA 
FROM FACTURAS f 
WHERE FECHA BETWEEN '01/06/2008' AND '30/06/2008'
AND CODCLI BETWEEN 100 AND 250;

--19.	Código y fecha de las facturas para los clientes cuyos códigos están entre 90 y 100 y no tienen iva. NOTA: una factura no tiene iva cuando éste es cero o nulo.

SELECT CODFAC Codigo, FECHA , IVA 
FROM FACTURAS f 
WHERE CODCLI BETWEEN 90 AND 100 
AND IVA IS  NULL OR IVA = 0;

--20.	Nombre de las provincias que terminan con la letra 's' (bien mayúscula o minúscula).

SELECT NOMBRE 
FROM PROVINCIAS p 
WHERE LOWER(NOMBRE) LIKE '%s';

--21.	Nombre de los clientes cuyo código postal empieza por “02”, “11” ó “21”.

SELECT NOMBRE 
FROM CLIENTES c 
WHERE CODPOSTAL LIKE '02%'
OR CODPOSTAL LIKE '11%'
OR CODPOSTAL LIKE '21%';

--22.	Artículos (todas las columnas) cuyo stock sea mayor que el stock mínimo  y no haya en stock más de 5 unidades del stock_min.

SELECT *
FROM ARTICULOS a 
WHERE STOCK > STOCK_MIN 
AND STOCK < (STOCK_MIN+5);

--23.	Nombre de las provincias que contienen el texto “MA” (bien mayúsculas o minúsculas).

SELECT NOMBRE 
FROM PROVINCIAS p 
WHERE NOMBRE LIKE '%MA%';

/*24.	Se desea promocionar los artículos de los que se posee un stock grande. 
 Si el artículo es de más de 6000 € y el stock supera los 60000 €, se hará un descuento del 10%. 
 Mostrar un listado de los artículos que van a entrar en la promoción, con su código de artículo, nombre del articulo, precio actual y su precio en la promoción.*/
SELECT CODART Codigo, DESCRIP Nombre, PRECIO PrecioActual, PRECIO-(PRECIO*0.10) PrecioPromocion
FROM ARTICULOS a 
WHERE PRECIO >6000
AND PRECIO*STOCK > 60000;

