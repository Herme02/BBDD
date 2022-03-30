    --1. Mostrar el nombre de los clientes junto al nombre de su pueblo.
	SELECT c.nombre Clientes, p.nombre Pueblo
	FROM clientes c , pueblos p 
	WHERE c.codpue = p.codpue ;
    
    --2. Mostrar el nombre de los pueblos junto con el nombre de la provincia correspondiente.
    SELECT p.nombre Pueblo,p2.nombre Provincia
	FROM PUEBLOS p ,PROVINCIAS p2 
	WHERE p.codpro = p2.codpro ;
    --3. Mostrar el nombre de los clientes junto al nombre de su pueblo y el de su provincia.
    SELECT c.nombre Clientes,p.nombre Pueblo,p2.nombre Provincia
	FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
	WHERE c.codpue = p.codpue 
	AND p.codpro = p2.codpro ;
    --4. Nombre de las provincias donde residen clientes sin que salgan valores repetidos.
    SELECT DISTINCT p2.nombre Provincias
	FROM PUEBLOS p ,PROVINCIAS p2 ,CLIENTES c 
	WHERE c.codpue = p.codpue 
	AND p.codpro = p2.codpro ;
    --5. Mostrar la descripción de los artículos que se han vendido en una cantidad superior a 10 unidades. Si un artículo se ha vendido más de una vez en una cantidad superior a 10 sólo debe salir una vez.
    SELECT DISTINCT a.descrip Descripcion
	FROM LINEAS_FAC lf , ARTICULOS a
	WHERE lf.codart = a.codart 
	AND CANT >10;
    --6. Mostrar la fecha de factura junto con el código del artículo y la cantidad vendida por cada artículo 
    --vendido en alguna factura. Los datos deben salir ordenado por fecha, primero las más reciente, luego por 
    --el código del artículos, y si el mismo artículo se ha vendido varias veces en la misma fecha los más vendidos primero.
    SELECT f.FECHA , a.CODART Codigo,lf.CANT Cantidad
	FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
	WHERE a.codart = lf.codart 
	AND lf.codfac = f.codfac 
	ORDER BY f.fecha DESC, a.codart , lf.cant DESC;
    --7. Mostrar el código de factura y la fecha de las mismas de las facturas que se han facturado a un cliente que tenga en su código postal un 7.
    SELECT f.codfac Codigo, f.fecha 
	FROM FACTURAS f ,CLIENTES c 
	WHERE f.codcli = c.codcli 
	AND c.codpostal LIKE '%7%';
    --8. Mostrar el código de factura, la fecha y el nombre del cliente de todas las facturas existentes en la base de datos.
    SELECT f.codfac Codigo_Factura ,f.fecha ,c.NOMBRE 
	FROM FACTURAS f ,CLIENTES c 
	WHERE f.codcli = c.codcli ;
    --9. Mostrar un listado con el código de la factura, la fecha, el iva, el dto y el nombre del cliente para aquellas facturas 
    --que o bien no se le ha cobrado iva (no se ha cobrado iva si el iva es nulo o cero), o bien el descuento es nulo.
    SELECT f.codfac Codigo_Factura,f.fecha ,f.iva ,f.dto descuento,c.nombre 
	FROM FACTURAS f ,CLIENTES c 
	WHERE f.codcli = c.codcli 
	AND (iva IS NULL OR iva LIKE '0')
	OR  dto IS NULL;
    --10. Se quiere saber que artículos se han vendido más baratos que el precio que actualmente tenemos almacenados en la tabla de artículos, 
    --para ello se necesita mostrar la descripción de los artículos junto con el precio actual. Además deberá aparecer el precio en que se vendió si este precio es inferior al precio original.
    SELECT a.descrip descripcion,a.precio precio_actual,lf.precio precio_venta
	FROM ARTICULOS a , LINEAS_FAC lf
	WHERE a.codart = lf.codfac 
	AND a.precio > lf.precio ;
    --11. Mostrar el código de las facturas, junto a la fecha, iva y descuento. También debe aparecer la descripción de los artículos vendido junto al precio de venta, la cantidad y el descuento
    -- de ese artículo, para todos los artículos que se han vendido.
    SELECT f.codfac Codigo_Factura ,f.fecha ,f.iva ,f.dto descuento , a.descrip descripción ,lf.precio precio_venta , lf.cant ,lf.dto descuento_articulo
	FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
	WHERE a.codart = lf.codfac 
	AND lf.codfac = f.codfac ;
    --12. Igual que el anterior, pero mostrando también el nombre del cliente al que se le ha vendido el artículo.
    SELECT f.codfac Codigo_Factura ,f.fecha ,f.iva ,f.dto descuento , a.descrip descripción ,lf.precio precio_venta , lf.cant ,lf.dto descuento_articulo, c.nombre 
	FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c 
	WHERE a.codart = lf.codart 
	AND lf.codfac = f.codfac 
	AND f.codcli = c.codcli ;
    --13. Mostrar los nombres de los clientes que viven en una provincia que contenga la letra ma.
    SELECT c.nombre 
	FROM CLIENTES c ,PUEBLOS p ,PROVINCIAS p2 
	WHERE c.codpue = p.codpue 
	AND p.codpro = p2.codpro 
	AND UPPER(p2.nombre) LIKE '%MA%';
    --14. Mostrar el código del cliente al que se le ha vendido un artículo que tienen un stock menor al stock mínimo.
    SELECT c.codcli Codigo_Cliente
	FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a 
	WHERE c.codcli = f.codcli 
	AND f.codfac = lf.codfac 
	AND lf.codart = a.codart 
	AND a.stock < a.stock_min ;
    --15. Mostrar el nombre de todos los artículos que se han vendido alguna vez. (no deben salir valores repetidos)
    SELECT DISTINCT a.descrip descripción 
	FROM LINEAS_FAC lf ,ARTICULOS a 
	WHERE lf.codart = a.codart ;
    --16. Se quiere saber el precio real al que se ha vendido cada vez los artículos. Para ello es necesario mostrar el nombre del artículo, 
    --junto con el precio de venta (no el que está almacenado en la tabla de artículos) menos el descuento aplicado en la línea de descuento.
    SELECT a.descrip descripción ,lf.precio -lf.dto  PRECIO_real
	FROM LINEAS_FAC lf ,ARTICULOS a 
	WHERE lf.codart = a.codart 
	AND lf.dto IS NOT N
    --17. Mostrar el nombre de los artículos que se han vendido a clientes que vivan en una provincia cuyo nombre termina  por a.
    SELECT a.descrip Nombre
	FROM FACTURAS f ,LINEAS_FAC lf ,ARTICULOS a ,CLIENTES c,PUEBLOS p ,PROVINCIAS p2 
	WHERE a.codart = lf.codart 
	AND lf.codfac = f.codfac 
	AND f.codcli = c.codcli 
	AND c.codpue = p.codpue 
	AND p.codpro = p2.codpro 
	AND UPPER(p2.nombre) LIKE '%A';
    --18. Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas.
    SELECT DISTINCT c.nombre 
	FROM CLIENTES c ,FACTURAS f 
	WHERE c.codcli = f.codcli 
	AND f.dto > 10;
    --19. Mostrar el nombre de los clientes sin que salgan repetidos a los que se les ha hecho un descuento superior al 10% en alguna de sus facturas o en alguna de las líneas que componen la factura o en ambas.
    SELECT DISTINCT c.nombre 
	FROM CLIENTES c ,FACTURAS f ,LINEAS_FAC lf 
	WHERE c.codcli = f.codcli 
	AND f.codfac = lf.codfac 
	AND f.dto > 10 OR lf.dto >10;
    --20. Mostrar la descripción, la cantidad y el precio de venta de los artículos vendidos al cliente con nombre MARIA MERCEDES.
    SELECT a.descrip ,lf.cant ,lf.precio 
	FROM ARTICULOS a ,LINEAS_FAC lf ,FACTURAS f ,CLIENTES c 
	WHERE a.codart = lf.codart 
	AND lf.codfac = f.codfac 
	AND f.codcli = c.codcli 
	AND c.nombre LIKE '%MARIA MERCEDES%'
    