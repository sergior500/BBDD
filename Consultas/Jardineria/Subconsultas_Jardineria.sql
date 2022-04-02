--MULTITABLA 
--1 ObtÃƒÂ©n un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.NOMBRE_CLIENTE , e.NOMBRE,e.APELLIDO1 FROM CLIENTE c, EMPLEADO e 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;
--2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE 
FROM CLIENTE c, EMPLEADO e, PAGO p 
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE AND c.CODIGO_CLIENTE = e.CODIGO_EMPLEADO; 
--3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE
FROM CLIENTE c,EMPLEADO e
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO 
AND c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PAGO p);

--4 Devuelve el nombre de los clientes que han hecho pagos y
-- el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE, c.CIUDAD, e.NOMBRE 
FROM CLIENTE c, PAGO p, EMPLEADO e
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND c.CODIGO_EMPLEADO_REP_VENTAS  = e.CODIGO_EMPLEADO; 
--5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes 
--junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE, o.CIUDAD, e.NOMBRE 
FROM CLIENTE c,EMPLEADO e, OFICINA o
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO 
AND o.CODIGO_OFICINA = e.CODIGO_OFICINA
AND c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PAGO p);

--6 Lista la direcciÃƒÂ³n de las oficinas que tengan clientes en Fuenlabrada.
SELECT o.LINEA_DIRECCION1, o.LINEA_DIRECCION2 
FROM OFICINA o, EMPLEADO e, CLIENTE c
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO 
AND o.CODIGO_OFICINA = e.CODIGO_OFICINA  
AND UPPER(c.CIUDAD)='FUENLABRADA';

--7 Devuelve el nombre de los clientes y 
--el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT c.NOMBRE_CLIENTE,o.CIUDAD,e.NOMBRE 
FROM CLIENTE c, EMPLEADO e, OFICINA o
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;

--8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes. (MIRAR EN CASA)
SELECT DISTINCT e.NOMBRE, e2.NOMBRE 
FROM EMPLEADO e, EMPLEADO e2
WHERE e.CODIGO_JEFE = e2.CODIGO_JEFE; 

--9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido
SELECT c.NOMBRE_CLIENTE
FROM CLIENTE c, PEDIDO p
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND p.FECHA_ESPERADA >p.FECHA_ENTREGA;

--10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT g.GAMA
FROM CLIENTE c, PEDIDO p, DETALLE_PEDIDO dp, PRODUCTO pr, GAMA_PRODUCTO g
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND p.CODIGO_PEDIDO = dp.CODIGO_PEDIDO
AND dp.CODIGO_PRODUCTO = pr.CODIGO_PRODUCTO;

--CONSULTAS MULTITABLAS (Composicion Externa)
--1 Devuelve un listado que muestre solamente los clientes que no han realizado ningÃºn pago.
SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c
WHERE c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PAGO p);

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ningÃºn pedido.
SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c
WHERE c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PEDIDO p);

--3 Devuelve un listado que muestre los clientes que no han realizado ningÃºn pago y los que no han realizado ningÃºn pedido.
SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c
WHERE c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PAGO p)
AND c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PEDIDO p);

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT e.NOMBRE 
FROM EMPLEADO e
WHERE e.CODIGO_OFICINA NOT IN (SELECT CODIGO_OFICINA FROM OFICINA);

SELECT * FROM EMPLEADO;

SELECT e.NOMBRE 
FROM EMPLEADO e
WHERE e.CODIGO_OFICINA IS NULL;

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT e.NOMBRE 
FROM EMPLEADO e
WHERE e.CODIGO_EMPLEADO NOT IN (SELECT CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE);

SELECT * FROM EMPLEADO ;

--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
SELECT e.NOMBRE 
FROM EMPLEADO e
WHERE e.CODIGO_OFICINA NOT IN (SELECT CODIGO_OFICINA FROM OFICINA)
AND e.CODIGO_EMPLEADO NOT IN (SELECT CODIGO_EMPLEADO FROM CLIENTE);

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido
SELECT DISTINCT p.NOMBRE
FROM PRODUCTO p
WHERE CODIGO_PRODUCTO NOT IN (SELECT CODIGO_PRODUCTO FROM DETALLE_PEDIDO);


--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algÃºn cliente 
--que haya realizado la compra de algÃºn producto de la gama Frutales.
SELECT * FROM OFICINA;


SELECT o.CODIGO_OFICINA
FROM OFICINA o
WHERE o.CODIGO_OFICINA NOT IN (SELECT CODIGO_OFICINA FROM EMPLEADO 
							WHERE CODIGO_EMPLEADO IN 
												(SELECT CODIGO_EMPLEADO_REP_VENTAS  FROM CLIENTE c, PEDIDO p, DETALLE_PEDIDO dp , PRODUCTO pr
												WHERE c.CODIGO_CLIENTE =p.CODIGO_CLIENTE 
												AND p.CODIGO_PEDIDO= dp.CODIGO_PEDIDO
												AND dp.CODIGO_PRODUCTO= pr.CODIGO_PRODUCTO
												AND UPPER(pr.GAMA)='FRUTALES'));
											
											
--9 Devuelve un listado con los clientes que han realizado algÃºn pedido, pero no han realizado ningÃºn pago.
SELECT DISTINCT  c.NOMBRE_CLIENTE 
FROM CLIENTE c, PEDIDO p
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE 
AND c.CODIGO_CLIENTE NOT IN (SELECT CODIGO_CLIENTE FROM PAGO);


--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
SELECT e.NOMBRE, e2.NOMBRE
FROM EMPLEADO e, EMPLEADO e2
WHERE e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE c)
AND e.CODIGO_JEFE  NOT IN (SELECT CODIGO_JEFE FROM EMPLEADO e2);



--CONSULTAS RESUMEN:
--1 ¿Cuántos empleados hay en la compañía?
SELECT count(e.codigo_empleado) FROM empleado e;

--2 ¿Cuántos clientes tiene cada país?
SELECT count(c.CODIGO_CLIENTE), c.PAIS FROM cliente c
GROUP BY c.PAIS;

--3 ¿Cuál fue el pago medio en 2009?
SELECT NVL(AVG(P.TOTAL),0)
FROM PAGO P 
WHERE EXTRACT(YEAR FROM P.FECHA_PAGO)=2009;

--4 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT COUNT(P.CODIGO_PEDIDO), P.ESTADO 
FROM PEDIDO P 
GROUP BY P.ESTADO 
ORDER BY COUNT(P.CODIGO_PEDIDO) DESC;

--5 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(P.PRECIO_VENTA), MIN(P.PRECIO_VENTA)
FROM PRODUCTO P;

--6 Calcula el número de clientes que tiene la empresa.
SELECT COUNT(C.CODIGO_CLIENTE)
FROM CLIENTE C;

--7 ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(C.CODIGO_CLIENTE)
FROM CLIENTE C
WHERE UPPER(C.CIUDAD)='MADRID';


--8 ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT COUNT(C.CODIGO_CLIENTE),C.CIUDAD
FROM CLIENTE C
WHERE C.CIUDAD LIKE 'M%'
GROUP BY C.CIUDAD;

--9 Devuelve el código de empleado y el número de clientes al que atiende cada representante de ventas.
SELECT E.CODIGO_EMPLEADO, COUNT(C.CODIGO_CLIENTE)
FROM EMPLEADO E, CLIENTE C
WHERE E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS
GROUP BY E.CODIGO_EMPLEADO;

--10 Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(C.CODIGO_CLIENTE)
FROM CLIENTE C
WHERE C.CODIGO_EMPLEADO_REP_VENTAS IS NULL
OR C.CODIGO_EMPLEADO_REP_VENTAS=0;

--11 Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
SELECT MIN(P.FECHA_PAGO), MAX(P.FECHA_PAGO), P.CODIGO_CLIENTE 
FROM PAGO P
GROUP BY P.CODIGO_CLIENTE;

--12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT DISTINCT COUNT(DP.CODIGO_PRODUCTO),DP.CODIGO_PEDIDO 
FROM DETALLE_PEDIDO DP
GROUP BY DP.CODIGO_PEDIDO;

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT SUM(DP.PRECIO_UNIDAD*DP.CANTIDAD),DP.CODIGO_PEDIDO 
FROM DETALLE_PEDIDO DP
GROUP BY DP.CODIGO_PEDIDO;

--14 Devuelve un listado de los 20 códigos de productos más vendidos y el número total de unidades 
--que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT dp.*
	FROM (SELECT DP.CODIGO_PRODUCTO, SUM(DP.CANTIDAD)
FROM DETALLE_PEDIDO DP,PRODUCTO P
WHERE DP.CODIGO_PRODUCTO =P.CODIGO_PRODUCTO 
GROUP BY DP.CODIGO_PRODUCTO 
ORDER BY SUM(DP.CANTIDAD) DESC) dp
WHERE ROWNUM<=20;

--15 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible,
-- el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades 
--vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT (P.PRECIO_PROVEEDOR*DP.CANTIDAD) AS BASE_IMPONIBLE,
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_IVA, 
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)+(P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_TOTAL
FROM DETALLE_PEDIDO DP, PRODUCTO P
WHERE DP.CODIGO_PRODUCTO =P.CODIGO_PRODUCTO;


--16 La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT P.CODIGO_PRODUCTO, (P.PRECIO_PROVEEDOR*DP.CANTIDAD) AS BASE_IMPONIBLE,
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_IVA, 
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)+(P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_TOTAL
FROM DETALLE_PEDIDO DP, PRODUCTO P
WHERE DP.CODIGO_PRODUCTO =P.CODIGO_PRODUCTO;

--17 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
SELECT P.CODIGO_PRODUCTO, (P.PRECIO_PROVEEDOR*DP.CANTIDAD) AS BASE_IMPONIBLE,
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_IVA, 
((P.PRECIO_PROVEEDOR*DP.CANTIDAD)+(P.PRECIO_PROVEEDOR*DP.CANTIDAD)*0.21) AS PRECIO_TOTAL
FROM DETALLE_PEDIDO DP, PRODUCTO P
WHERE DP.CODIGO_PRODUCTO =P.CODIGO_PRODUCTO
AND P.CODIGO_PRODUCTO LIKE 'OR%';

--Lista las ventas totales de los productos que hayan facturado más de 3000 euros.
-- Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
SELECT P.NOMBRE,SUM(DP.CANTIDAD) AS UNIDADES_VENDIDAS, (DP.CANTIDAD*PRECIO_UNIDAD) AS TOTAL_FACTURADO,
(((DP.CANTIDAD*DP.PRECIO_UNIDAD)*0.21)+(DP.CANTIDAD*DP.PRECIO_UNIDAD)) AS TOTAL_FACTURADO_MAS_IVA
FROM DETALLE_PEDIDO DP,PRODUCTO P
WHERE P.CODIGO_PRODUCTO = DP.CODIGO_PRODUCTO
GROUP BY P.NOMBRE,(DP.CANTIDAD*PRECIO_UNIDAD),
(((DP.CANTIDAD*DP.PRECIO_UNIDAD)*0.21)+(DP.CANTIDAD*DP.PRECIO_UNIDAD));



--SUBCONSULTAS
--1 Devuelve el nombre del cliente con mayor lÃƒÂ­mite de crÃƒÂ©dito.--
--SELECT NOMBRE_CLIENTE,LIMITE_CREDITO FROM CLIENTE;
SELECT NOMBRE_CLIENTE
FROM CLIENTE
WHERE LIMITE_CREDITO =
(SELECT MAX(LIMITE_CREDITO) FROM CLIENTE);

--  2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningÃƒÂºn cliente.--
SELECT NOMBRE,APELLIDO1,PUESTO FROM EMPLEADO
WHERE EMPLEADO.CODIGO_EMPLEADO NOT IN
(SELECT CLIENTE.CODIGO_EMPLEADO_REP_VENTAS FROM CLIENTE);

--3 Devuelve el nombre del producto que tenga el precio de venta mÃƒÂ¡s caro.
SELECT * FROM PRODUCTO;
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO_VENTA = (SELECT MAX(PRECIO_VENTA) FROM PRODUCTO);

--4 Devuelve el nombre del producto del que se han vendido mÃƒÂ¡s unidades. (Ten en cuenta que tendrÃƒÂ¡s que calcular cuÃƒÂ¡l es el nÃƒÂºmero total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez que sepas cuÃƒÂ¡l es el cÃƒÂ³digo del producto, puedes obtener su nombre fÃƒÂ¡cilmente.)
SELECT p.NOMBRE
FROM PRODUCTO p, (SELECT dp.CODIGO_PRODUCTO,MAX(dp.CANTIDAD)
                            FROM DETALLE_PEDIDO dp
                            HAVING MAX(dp.CANTIDAD) = (SELECT MAX(dp2.cantidad)
                                                        FROM DETALLE_PEDIDO dp2)
                            GROUP BY dp.CODIGO_PRODUCTO) b
WHERE p.CODIGO_PRODUCTO = b.codigo_producto;


--5 Los clientes cuyo lÃƒÂ­mite de crÃƒÂ©dito sea mayor que los pagos que haya realizado.


SELECT c.NOMBRE_CLIENTE 
FROM CLIENTE c
WHERE c.CODIGO_CLIENTE IN (SELECT p.CODIGO_CLIENTE 
							FROM PAGO p
							WHERE c.LIMITE_CREDITO >p.TOTAL); 

--6 El producto que mÃƒÂ¡s unidades tiene en stock y el que menos unidades tiene.
SELECT NOMBRE
FROM PRODUCTO p, (SELECT MIN(p2.CANTIDAD_EN_STOCK) minimo
                    FROM PRODUCTO p2) b,(SELECT max(p3.CANTIDAD_EN_STOCK) maximo
                                            FROM PRODUCTO p3) c
WHERE p.CANTIDAD_EN_STOCK = b.minimo
OR p.CANTIDAD_EN_STOCK = c.maximo;

--7
SELECT NOMBRE , APELLIDO1, APELLIDO2 , EMAIL
FROM EMPLEADO e, (SELECT e2.CODIGO_EMPLEADO
                    FROM EMPLEADO e2
                    WHERE LOWER(e2.NOMBRE) LIKE 'alberto'
                    AND LOWER(e2.APELLIDO1) LIKE 'soria') a
WHERE e.CODIGO_JEFE = a.CODIGO_EMPLEADO;


--CONSULTAS VARIADAS:
 --1 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
    --Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

SELECT c.NOMBRE_CLIENTE , COUNT(NVL(p.CODIGO_PEDIDO,0)) AS NUMERO_PEDIDOS
FROM CLIENTE c, PEDIDO p
WHERE c.CODIGO_CLIENTE  =p.CODIGO_CLIENTE
GROUP BY c.NOMBRE_CLIENTE;

--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos.
--Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

SELECT c.NOMBRE_CLIENTE , SUM(NVL(p.TOTAL,0)) AS DINERO_RORAL_PAGADO
FROM CLIENTE c , PAGO p
WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE
GROUP BY c.NOMBRE_CLIENTE;

--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

SELECT c.NOMBRE_CLIENTE
FROM CLIENTE c , PEDIDO p
WHERE c.CODIGO_CLIENTE = p.CODIGO_PEDIDO
AND EXTRACT(YEAR FROM p.FECHA_PEDIDO)=2008
ORDER BY c.NOMBRE_CLIENTE DESC;


--4 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y
--el número de teléfono de la oficina del representante de ventas,
 --de aquellos clientes que no hayan realizado ningún pago.

SELECT c.NOMBRE_CLIENTE, e.NOMBRE, e.APELLIDO1, o.TELEFONO
FROM CLIENTE c, OFICINA o, EMPLEADO e
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
AND e.CODIGO_OFICINA = o.CODIGO_OFICINA
AND c.CODIGO_CLIENTE NOT IN (SELECT p.CODIGO_CLIENTE FROM PAGO p);

--5 Devuelve el listado de clientes donde aparezca el nombre del cliente,
--el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

SELECT c.NOMBRE_CLIENTE, e.NOMBRE, e.APELLIDO1, o.CIUDAD
FROM CLIENTE c, EMPLEADO e, OFICINA o
WHERE c.CODIGO_EMPLEADO_REP_VENTAS =e.CODIGO_EMPLEADO
AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;

--6 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados
--que no sean representante de ventas de ningún cliente.

SELECT DISTINCT e.NOMBRE , e.APELLIDO1 , e.PUESTO, o.TELEFONO
FROM OFICINA o, EMPLEADO e
WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS  FROM CLIENTE c);

--7 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

SELECT o.CIUDAD, COUNT(e.CODIGO_EMPLEADO)
FROM OFICINA o, EMPLEADO e
WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA
GROUP BY o.CIUDAD;



