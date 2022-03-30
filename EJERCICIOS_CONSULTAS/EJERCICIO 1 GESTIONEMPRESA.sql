    --1. Código, fecha y doble del descuento de las facturas con iva cero.
    SELECT F.CODFAC, F.FECHA, F.DTO * 2 AS DESCUENTO
    FROM FACTURAS F
    WHERE F.IVA = 0;
    --2. Código de las facturas con iva nulo.
    SELECT F.CODFAC 
    FROM FACTURAS F
    WHERE F.IVA IS NULL;
    --3. Código y fecha de las facturas sin iva (iva cero o nulo).
    SELECT F.CODFAC, F.FECHA 
    FROM FACTURAS F
    WHERE F.IVA = 0 OR F.IVA IS NULL;
    --4. Código de factura y de artículo de las líneas de factura en las que la cantidad solicitada es menor de 5 unidades y además se ha aplicado un descuento del 25% o mayor.
    SELECT LF.CODFAC, LF.CODART 
    FROM LINEAS_FAC LF
    WHERE LF.CANT < 5 AND LF.DTO >= 25;
   
    --5. Obtener la descripción de los artículos cuyo stock está por debajo del stock mínimo, dado también la cantidad en unidades necesaria para alcanzar dicho mínimo.
    SELECT A.DESCRIP, A.STOCK_MIN - A.STOCK AS CANT_NECESARIA_PARA_MINIMO
    FROM ARTICULOS A
    WHERE A.STOCK < A.STOCK_MIN;
   
    --6. Ivas distintos aplicados a las facturas.
    SELECT DISTINCT F.IVA 
    FROM FACTURAS F;
   
    --7. Código, descripción y stock mínimo de los artículos de los que se desconoce la cantidad de stock. Cuando se desconoce la cantidad de stock de un artículo, el stock es nulo.
    SELECT A.CODART, A.DESCRIP, A.STOCK_MIN 
    FROM ARTICULOS A
    WHERE A.STOCK IS NULL;
   
    --8. Obtener la descripción de los artículos cuyo stock es más de tres veces su stock mínimo y cuyo precio supera los 6 euros.
    SELECT A.DESCRIP 
    FROM ARTICULOS A
    WHERE A.STOCK > A.STOCK_MIN * 3 AND A.PRECIO > 6;
   
    --9. Código de los artículos (sin que salgan repetidos) comprados en aquellas facturas cuyo código está entre 8 y 10.
    SELECT DISTINCT LF.CODART 
    FROM LINEAS_FAC LF
    WHERE LF.CODFAC BETWEEN 8 AND 10;
    
    --10. Mostrar el nombre y la dirección de todos los clientes.
    SELECT C.NOMBRE, C.DIRECCION 
    FROM CLIENTES C;
   
    --11. Mostrar los distintos códigos de pueblos en donde tenemos clientes
    SELECT DISTINCT C.CODPUE
    FROM CLIENTES C;
   
    --12. Obtener los códigos de los pueblos en donde hay clientes con código de cliente menor que el código 25. No deben salir códigos repetidos.
    SELECT DISTINCT C.CODPUE 
    FROM CLIENTES C
    WHERE C.CODCLI < 25;
   
    --13. Nombre de las provincias cuya segunda letra es una 'O' (bien mayúscula o minúscula).
    SELECT P.NOMBRE 
    FROM PROVINCIAS P
    WHERE P.NOMBRE LIKE '_O%';
   
    --14. Código y fecha de las facturas del año pasado para aquellos clientes cuyo código se encuentra entre 50 y 100.
    SELECT F.CODFAC, EXTRACT(YEAR FROM F.FECHA) - 1 AS AÑO_PASADO
    FROM FACTURAS F
    WHERE F.CODCLI BETWEEN 50 AND 100;
    --15. Nombre y dirección de aquellos clientes cuyo código postal empieza por “12”. 
    SELECT C.NOMBRE, C.DIRECCION 
    FROM CLIENTES C
    WHERE C.CODPOSTAL LIKE '12%';
    --16. Mostrar las distintas fechas, sin que salgan repetidas, de las factura existentes de clientes cuyos códigos son menores que 50.
    SELECT DISTINCT F.FECHA 
    FROM FACTURAS F
    WHERE F.CODCLI < 50;
    --17. Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004.
    SELECT F.CODFAC, FECHA 
    FROM FACTURAS F
    WHERE F.FECHA BETWEEN TO_DATE('2004/06/01', 'YYYY/MM/DD') AND TO_DATE('2004/06/30', 'YYYY/MM/DD');
    
    --18. Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004 para aquellos clientes cuyo código se encuentra entre 100 y 250.
	SELECT F.CODFAC, FECHA 
    FROM FACTURAS F
    WHERE (F.FECHA BETWEEN TO_DATE('2004/06/01', 'YYYY/MM/DD') AND TO_DATE('2004/06/30', 'YYYY/MM/DD')) AND (F.CODCLI BETWEEN 100 AND 250);
    
    --19. Código y fecha de las facturas para los clientes cuyos códigos están entre 90 y 100 y no tienen iva. NOTA: una factura no tiene iva cuando éste es cero o nulo.
    SELECT F.CODFAC, F.FECHA 
    FROM FACTURAS F
    WHERE (F.CODCLI BETWEEN 90 AND 100) AND (F.IVA IS NULL OR F.IVA = 0);
  
    --20. Nombre de las provincias que terminan con la letra 's' (bien mayúscula o minúscula).
    SELECT P.NOMBRE 
    FROM PROVINCIAS P
    WHERE P.NOMBRE LIKE '%S' OR P.NOMBRE LIKE '%s';
   
    --21. Nombre de los clientes cuyo código postal empieza por “02”, “11” ó “21”.
    SELECT C.NOMBRE 
    FROM CLIENTES C
    WHERE C.CODPOSTAL LIKE '02%' OR C.CODPOSTAL LIKE '11%' OR C.CODPOSTAL LIKE '21%';
   
    --22. Artículos (todas las columnas) cuyo stock sea mayor que el stock mínimo y no haya en stock más de 5 unidades del stock_min.
    SELECT *
    FROM ARTICULOS A
    WHERE A.STOCK > A.STOCK_MIN AND A.STOCK - A.STOCK_MIN BETWEEN 1 AND 5;
   
    --23. Nombre de las provincias que contienen el texto “MA” (bien mayúsculas o minúsculas).
   SELECT P.NOMBRE 
   FROM PROVINCIAS P
   WHERE P.NOMBRE LIKE '%MA%' OR P.NOMBRE LIKE '%ma%'
   
    /*24. Se desea promocionar los artículos de los que se posee un stock grande. Si el artículo 
      es de más de 6000 € y el stock supera los 60000 €, se hará un descuento del 10%. Mostrar 
      un listado de los artículos que van a entrar en la promoción, con su código de artículo, 
      nombre del articulo, precio actual y su precio en la promoción.*/
    SELECT A.CODART, A.DESCRIP, A.PRECIO, (A.PRECIO - (A.PRECIO * 0.10)) AS PRECIO_PROMOCION
    FROM ARTICULOS A
    WHERE A.PRECIO > 6000 AND A.PRECIO * A.STOCK > 60000;
    
    