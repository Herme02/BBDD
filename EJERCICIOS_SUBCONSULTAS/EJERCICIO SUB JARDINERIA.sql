--ALTER SESSION SET "_oracle_script"= TRUE;
--CREATE USER JARDINERIA IDENTIFIED BY JARDINERIA;
--GRANT CONNECT, RESOURCE,DBA TO JARDINERIA;


--Consultas multitabla (composición interna)
    --1 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
    SELECT C.NOMBRE_CLIENTE, E.NOMBRE, E.APELLIDO1, E.APELLIDO2 
    FROM CLIENTE C, EMPLEADO E
    WHERE E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS;
   
    --2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
    SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE 
    FROM CLIENTE C, PAGO P, EMPLEADO E
    WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE
    AND C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO;
   
    --3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
    SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE 
    FROM CLIENTE C, PAGO P, EMPLEADO E
    WHERE C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
    AND C.CODIGO_CLIENTE NOT IN 
    		(SELECT P.CODIGO_CLIENTE 
    		 FROM PAGO P);
    		
    --4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
    SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE, O.CIUDAD 
    FROM CLIENTE C, PAGO P, EMPLEADO E, OFICINA O
    WHERE P.CODIGO_CLIENTE = C.CODIGO_CLIENTE 
    AND C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO 
    AND E.CODIGO_OFICINA = O.CODIGO_OFICINA;
   
    --5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
    SELECT DISTINCT C.NOMBRE_CLIENTE, E.NOMBRE, O.CIUDAD 
    FROM CLIENTE C, PAGO P, EMPLEADO E, OFICINA O
    WHERE C.CODIGO_CLIENTE NOT IN 
    		(SELECT P.CODIGO_CLIENTE 
    		 FROM PAGO P)
    AND C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO 
    AND E.CODIGO_OFICINA = O.CODIGO_OFICINA;
   
    --6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
    SELECT O.LINEA_DIRECCION1, O.LINEA_DIRECCION2 
    FROM OFICINA O, EMPLEADO E, CLIENTE C
    WHERE O.CODIGO_OFICINA = E.CODIGO_OFICINA 
    AND E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS 
    AND UPPER(C.CIUDAD) LIKE 'FUENLABRADA';
    
    --7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
    SELECT C.NOMBRE_CLIENTE, E.NOMBRE, O.CODIGO_OFICINA 
    FROM CLIENTE C, EMPLEADO E, OFICINA O
    WHERE E.CODIGO_EMPLEADO = C.CODIGO_EMPLEADO_REP_VENTAS
    AND E.CODIGO_OFICINA = O.CODIGO_OFICINA;
   
    --8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
    SELECT E.NOMBRE AS EMPLEADO, E2.NOMBRE AS JEFE
    FROM EMPLEADO E, EMPLEADO E2
    WHERE E.CODIGO_EMPLEADO = E2.CODIGO_JEFE;
   
    --9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
    SELECT DISTINCT C.NOMBRE_CLIENTE 
    FROM CLIENTE C, PEDIDO P
    WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
    AND P.FECHA_ESPERADA < P.FECHA_ENTREGA;
   
    --10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT DISTINCT PR.GAMA, C.NOMBRE_CLIENTE 
FROM CLIENTE C, PEDIDO P, DETALLE_PEDIDO DP, PRODUCTO PR
WHERE C.CODIGO_CLIENTE = P.CODIGO_CLIENTE 
AND P.CODIGO_PEDIDO = DP.CODIGO_PEDIDO 
AND DP.CODIGO_PRODUCTO = PR.CODIGO_PRODUCTO;

--Consultas multitabla (composición externa)
    --1 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
    SELECT DISTINCT C.NOMBRE_CLIENTE 
    FROM CLIENTE C, PAGO P
    WHERE C.CODIGO_CLIENTE NOT IN 
    		(SELECT P.CODIGO_CLIENTE 
    		 FROM PAGO P);
    		
    --2 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
    SELECT DISTINCT C.NOMBRE_CLIENTE 
    FROM CLIENTE C, PEDIDO P
    WHERE C.CODIGO_CLIENTE NOT IN 
    		(SELECT P.CODIGO_CLIENTE 
    		 FROM PEDIDO P);
    		
	--3 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
    SELECT DISTINCT C.NOMBRE_CLIENTE 
    FROM CLIENTE C, PEDIDO P, PAGO P2
    WHERE C.CODIGO_CLIENTE NOT IN 
    		(SELECT P.CODIGO_CLIENTE 
    		 FROM PEDIDO P)
    AND C.CODIGO_CLIENTE NOT IN 
    		(SELECT P2.CODIGO_CLIENTE 
    		 FROM PAGO P2 );
    		
	--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
	SELECT E.NOMBRE 
	FROM EMPLEADO E
	WHERE E.CODIGO_OFICINA IS NULL;

    --5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
    SELECT DISTINCT E.NOMBRE 
    FROM EMPLEADO E, CLIENTE C
    WHERE E.CODIGO_EMPLEADO NOT IN 
    		(SELECT C.CODIGO_EMPLEADO_REP_VENTAS 
    		 FROM CLIENTE C);
    		
	--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
    SELECT e.NOMBRE
	FROM EMPLEADO e 
	WHERE e.CODIGO_OFICINA NOT IN 
			(SELECT o.CODIGO_OFICINA 
             FROM OFICINA o
             WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA)
	OR  e.CODIGO_EMPLEADO NOT IN 
			(SELECT c.CODIGO_EMPLEADO_REP_VENTAS 
             FROM CLIENTE c
             WHERE e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS);
            
	--7 Devuelve un listado de los productos que nunca han aparecido en un pedido
    SELECT DISTINCT p.NOMBRE 
	FROM PRODUCTO p
	WHERE p.CODIGO_PRODUCTO NOT IN 
			(SELECT dp.CODIGO_PRODUCTO 
             FROM DETALLE_PEDIDO dp);
            
	--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
    SELECT o.CODIGO_OFICINA 
	FROM OFICINA o 
	WHERE o.CODIGO_OFICINA NOT IN 
			(SELECT e.CODIGO_OFICINA 
             FROM EMPLEADO e,CLIENTE c,DETALLE_PEDIDO dp,PEDIDO p,PRODUCTO p2, GAMA_PRODUCTO gp 
             WHERE e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS
             AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
             AND p.CODIGO_PEDIDO=dp.CODIGO_PEDIDO
             AND dp.CODIGO_PRODUCTO=p2.CODIGO_PRODUCTO
             AND p2.GAMA=gp.GAMA
             AND gp.GAMA LIKE 'Frutales');
            
	--9 Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.
    SELECT DISTINCT c.NOMBRE_CLIENTE 
	FROM CLIENTE c ,PEDIDO p 
	WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE 
	AND c.CODIGO_CLIENTE NOT IN 
			(SELECT p2.CODIGO_CLIENTE 
             FROM PAGO p2);
	--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
	SELECT *
	FROM EMPLEADO e
	WHERE e.CODIGO_EMPLEADO =e.CODIGO_JEFE
	AND e.CODIGO_EMPLEADO NOT IN 
			(SELECT c.CODIGO_EMPLEADO_REP_VENTAS 
             FROM CLIENTE c);

--Consultas resumen
    --1 ¿Cuántos empleados hay en la compañía?
    SELECT COUNT(e.CODIGO_EMPLEADO)
	FROM EMPLEADO e;
    --2 ¿Cuántos clientes tiene cada país?
    SELECT C.PAIS, COUNT(C.CODIGO_CLIENTE)
    FROM CLIENTE C
    GROUP BY C.PAIS;
   
    --3 ¿Cuál fue el pago medio en 2009?
    SELECT AVG(p.TOTAL)
	FROM PAGO p 
	WHERE EXTRACT (YEAR FROM p.FECHA_PAGO)=2009;

    --4 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
    SELECT P.ESTADO, COUNT(P.CODIGO_PEDIDO) AS NUM_PEDIDOS
    FROM PEDIDO P
    GROUP BY P.ESTADO 
    ORDER BY COUNT(P.CODIGO_PEDIDO) DESC;
   
    --5 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
    SELECT MAX(p.PRECIO_VENTA),MIN(p.PRECIO_VENTA) 
	FROM PRODUCTO p;

    --6 Calcula el número de clientes que tiene la empresa.
    SELECT COUNT(C.CODIGO_CLIENTE)
    FROM CLIENTE C;
   
    --7 ¿Cuántos clientes tiene la ciudad de Madrid?
    SELECT COUNT(c.CODIGO_CLIENTE)
	FROM CLIENTE c 
	WHERE LOWER(c.CIUDAD) LIKE 'madrid';

    --8 ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
    SELECT C.CIUDAD, COUNT(C.CODIGO_CLIENTE) AS NUM_CLIENTE
    FROM CLIENTE C
    WHERE C.CIUDAD LIKE 'M%'
    GROUP BY C.CIUDAD;
    
    --9 Devuelve el código de empleado y el número de clientes al que atiende cada representante de ventas.
    SELECT e.CODIGO_EMPLEADO,COUNT(c.CODIGO_CLIENTE) 
	FROM CLIENTE c,EMPLEADO e 
	WHERE c.CODIGO_EMPLEADO_REP_VENTAS=e.CODIGO_EMPLEADO
	GROUP BY e.CODIGO_EMPLEADO;

    --10 Calcula el número de clientes que no tiene asignado representante de ventas.
    SELECT COUNT(DISTINCT C.CODIGO_EMPLEADO_REP_VENTAS)
    FROM CLIENTE C, EMPLEADO E
    WHERE E.CODIGO_EMPLEADO NOT IN 
    		(SELECT C.CODIGO_EMPLEADO_REP_VENTAS 
    		 FROM CLIENTE C);
    		
    --11 Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
    SELECT MIN(p.FECHA_PAGO), MAX(p.FECHA_PAGO) 
	FROM PAGO p,CLIENTE c 
	WHERE p.CODIGO_CLIENTE =c.CODIGO_CLIENTE;

    --12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
    SELECT DP.CODIGO_PEDIDO, COUNT(DISTINCT DP.CODIGO_PRODUCTO)
    FROM DETALLE_PEDIDO DP
    GROUP BY DP.CODIGO_PEDIDO;
   
    --13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
    SELECT SUM(p.CANTIDAD_EN_STOCK)
	FROM PRODUCTO p,PEDIDO p2,DETALLE_PEDIDO dp 
	WHERE p.CODIGO_PRODUCTO =dp.CODIGO_PRODUCTO 
	AND dp.CODIGO_PEDIDO =p2.CODIGO_PEDIDO;
   
    --14 Devuelve un listado de los 20 códigos de productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
    SELECT DP.CODIGO_PRODUCTO, DP.CANTIDAD 
    FROM DETALLE_PEDIDO DP
    ORDER BY DP.CANTIDAD DESC;
    
    --15 La facturación que ha tenido la empresa en toda la historia, 
    --indicando la base imponible, el IVA y el total facturado. La base imponible 
    --se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
    SELECT SUM(DP.CANTIDAD) AS FACTURACION, DP.PRECIO_UNIDAD AS BASE_IMPONIBLE, '21%' IVA, SUM(DP.CANTIDAD)+DP.PRECIO_UNIDAD AS TOTAL_FACTURADO
	FROM DETALLE_PEDIDO DP
	GROUP BY DP.PRECIO_UNIDAD;

    --16 La misma información que en la pregunta anterior, pero agrupada por código de producto.
    SELECT SUM(DP.CANTIDAD) AS FACTURACION, DP.PRECIO_UNIDAD AS BASE_IMPONIBLE, '21%' IVA, SUM(DP.CANTIDAD)+DP.PRECIO_UNIDAD AS TOTAL_FACTURADO
	FROM DETALLE_PEDIDO DP
	GROUP BY DP.PRECIO_UNIDAD, DP.CODIGO_PRODUCTO;

    --17 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
    SELECT SUM(DP.CANTIDAD) AS FACTURACION, DP.PRECIO_UNIDAD AS BASE_IMPONIBLE, '21%' IVA, SUM(DP.CANTIDAD)+DP.PRECIO_UNIDAD AS TOTAL_FACTURADO
	FROM DETALLE_PEDIDO DP
	WHERE CODIGO_PRODUCTO LIKE 'OD%'
	GROUP BY DP.PRECIO_UNIDAD, DP.CODIGO_PRODUCTO;

    --18 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
	SELECT pr.nombre, p.total,sum(dp.cantidad)+dp.precio_unidadcantidad total_facturado, (sum(dp.cantidad)+dp.precio_unidadcantidad)21/100 total_facturado
	FROM pago p, producto pr, detalle_pedido dp, pedido p2, cliente c
	WHERE p.codigo_cliente = c.codigo_cliente 
	AND c.codigo_cliente = p2.codigo_cliente
	AND dp.codigo_producto = pr.codigo_producto 
	GROUP BY pr.nombre,p.total,dp.precio_unidadcantidad
	HAVING sum(dp.cantidad)+dp.precio_unidadcantidad > 3000;

--Subconsultas
    --1 Devuelve el nombre del cliente con mayor límite de crédito.
    --2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
    --3 Devuelve el nombre del producto que tenga el precio de venta más caro.
    --4 Devuelve el nombre del producto del que se han vendido más unidades. (Ten en cuenta que tendrás que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez que sepas cuál es el código del producto, puedes obtener su nombre fácilmente.)
    --5 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado.
    --6 El producto que más unidades tiene en stock y el que menos unidades tiene.
    --7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.


--Consultas variadas
    --1 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
    --2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
    --3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
    --4 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
    --5 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
    --6 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
    --7 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

