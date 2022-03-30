    --1. Descuento medio aplicado en las facturas.
    SELECT AVG(F.DTO)
    FROM FACTURAS F;
   
    --2. Descuento medio aplicado en las facturas sin considerar los valores nulos.
    SELECT AVG(F.DTO)
    FROM FACTURAS F
    WHERE F.DTO IS NOT NULL;
   
    --3. Descuento medio aplicado en las facturas considerando los valores nulos como cero.
    SELECT AVG(NVL(F.DTO, 0))
    FROM FACTURAS F;
   
    --4. Número de facturas.
    SELECT COUNT(F.CODFAC)
    FROM FACTURAS F;
   
    --5. Número de pueblos de la Comunidad de Valencia.
    SELECT COUNT(P.CODPUE)
    FROM PUEBLOS P, PROVINCIAS PR
    WHERE UPPER(PR.NOMBRE) LIKE 'VALEN%';
   
    --6. Importe total de los artículos que tenemos en el almacén. Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
    SELECT A.STOCK * A.PRECIO AS IMPORTE_TOTAL
    FROM ARTICULOS A;
   
    --7. Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
    SELECT COUNT(C.CODPUE)
    FROM CLIENTES C
    WHERE C.CODPOSTAL LIKE '12%';
   
    --8. Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
    SELECT MAX(A.STOCK), MIN(STOCK), MAX(STOCK) - MIN(STOCK) AS DIFERENCIA
    FROM ARTICULOS A
    WHERE A.PRECIO BETWEEN 9 AND 12;
   
    --9. Precio medio de los artículos cuyo stock supera las 10 unidades.
    SELECT AVG(A.PRECIO)
    FROM ARTICULOS A
    WHERE A.STOCK > 10;
    --10. Fecha de la primera y la última factura del cliente con código 210.
    SELECT F.FECHA 
    FROM FACTURAS F
    WHERE F.CODCLI = 210
    ORDER BY F.FECHA ASC;
    
    --11. Número de artículos cuyo stock es nulo.
    SELECT COUNT(CODART)
    FROM ARTICULOS A
    WHERE A.STOCK IS NULL;
    --12. Número de líneas cuyo descuento es nulo (con un decimal)
    SELECT COUNT(LF.LINEA)
    FROM LINEAS_FAC LF
    WHERE LF.DTO IS NULL;
   
    --13. Obtener cuántas facturas tiene cada cliente.
    SELECT COUNT(F.CODFAC)
    FROM FACTURAS F
    GROUP BY F.CODCLI;
   
    --14. Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.
    SELECT COUNT(F.CODFAC)
    FROM FACTURAS F
    GROUP BY F.CODCLI
    HAVING COUNT(F.CODFAC) >= 2;
   
    --15. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los  artículos
    SELECT LF.CANT * LF.PRECIO AS IMPORTE_FACT
    FROM LINEAS_FAC LF;
   
    --16. Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
    SELECT LF.CANT * LF.PRECIO AS IMPORTE_FACT
    FROM LINEAS_FAC LF
    WHERE LF.CODART LIKE '%A%';
   
    --17. Número de facturas para cada fecha, junto con la fecha
    SELECT COUNT(F.CODFAC), F.FECHA 
    FROM FACTURAS F
    GROUP BY F.FECHA;
   
    --18. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan.
    SELECT COUNT(C.CODCLI), P.NOMBRE 
    FROM CLIENTES C, PUEBLOS P
    WHERE P.CODPUE = C.CODPUE 
    GROUP BY P.NOMBRE 
    ORDER BY COUNT(C.CODCLI) DESC;
   
    --19. Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes tengan, siempre y cuando tengan más de dos clientes.
    SELECT COUNT(C.CODCLI), P.NOMBRE 
    FROM CLIENTES C, PUEBLOS P
    WHERE P.CODPUE = C.CODPUE 
    GROUP BY P.NOMBRE 
    HAVING COUNT(C.CODCLI) > 2
    ORDER BY COUNT(C.CODCLI) DESC;
   
    --20. Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de dicho artículo.
    SELECT LF.CANT, A.DESCRIP 
    FROM LINEAS_FAC LF, ARTICULOS A
    WHERE LF.CODART LIKE 'P%';
   
    --21. Precio máximo y precio mínimo de venta (en líneas de facturas) para cada artículo cuyo código empieza por “c”.
    SELECT MAX(LF.PRECIO), MIN(LF.PRECIO) 
    FROM LINEAS_FAC LF
    WHERE LOWER(LF.CODART) LIKE 'c%';
   
    --22. Igual que el anterior pero mostrando también la diferencia entre el precio máximo y mínimo.
    SELECT MAX(LF.PRECIO), MIN(LF.PRECIO), MAX(LF.PRECIO) - MIN(LF.PRECIO) AS DIFERENCIA
    FROM LINEAS_FAC LF
    WHERE LOWER(LF.CODART) LIKE 'c%';
    --23. Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.
    SELECT A.DESCRIP 
    FROM LINEAS_FAC LF, ARTICULOS A
    WHERE LF.CANT * LF.PRECIO > 10000;
    
    --24. Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), con cada IVA distinto que se les ha aplicado.
    SELECT COUNT(F.CODFAC), F.CODCLI, F.IVA
    FROM FACTURAS F
    WHERE F.CODCLI  BETWEEN 150 AND 300
    GROUP BY F.CODCLI, F.IVA;
   
    --25. Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.
    SELECT AVG(LF.PRECIO * LF.CANT)
    FROM LINEAS_FAC LF;
    
    
