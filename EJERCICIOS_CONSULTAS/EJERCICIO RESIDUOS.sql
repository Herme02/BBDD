/*1. Muestra el nombre de las empresas productoras de Huelva o Málaga ordenadas por el
nombre en orden alfabético inverso.*/
SELECT E.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA E
WHERE UPPER(E.CIUDAD_EMPRESA) LIKE 'HUELVA' 
OR UPPER(E.CIUDAD_EMPRESA) LIKE 'MALAGA'
ORDER BY E.NOMBRE_EMPRESA DESC;

--2. Mostrar los nombres de los destinos cuya ciudad contenga una b mayúscula o minúscula.
SELECT D.NOMBRE_DESTINO 
FROM DESTINO D
WHERE D.CIUDAD_DESTINO LIKE '%B%' 
OR D.CIUDAD_DESTINO LIKE '%b%';

--3. Obtener el código de los residuos con una cantidad superior a 4 del constituyente 116.
SELECT RC.COD_RESIDUO 
FROM RESIDUO_CONSTITUYENTE RC
WHERE RC.CANTIDAD > 4
AND RC.COD_CONSTITUYENTE = 116;

/*4. Muestra el tipo de transporte, los kilómetros y el coste de los traslados realizados en
diciembre de 1994.*/
SELECT T.TIPO_TRANSPORTE, T.KMS, T.COSTE 
FROM TRASLADO T
WHERE T.FECHA_ENVIO BETWEEN TO_DATE('01/12/1994','DD/MM/YYYY') 
AND TO_DATE('31/12/1994','DD/MM/YYYY');

--5. Mostrar el código del residuo y el número de constituyentes de cada residuo.
SELECT RC.COD_RESIDUO, COUNT(RC.COD_CONSTITUYENTE) 
FROM RESIDUO_CONSTITUYENTE RC
GROUP BY RC.COD_RESIDUO;

--6. Mostrar la cantidad media de residuo vertida por las empresas durante el año 1994.
SELECT AVG(RE.CANTIDAD)
FROM RESIDUO_EMPRESA RE
WHERE EXTRACT(YEAR FROM RE.FECHA) = 1994;

--7. Mostrar el mayor número de kilómetros de un traslado realizado el mes de marzo.
SELECT MAX(T.KMS) 
FROM TRASLADO T
WHERE EXTRACT(MONTH FROM T.FECHA_ENVIO) = 3;

/*8. Mostrar el número de constituyentes distintos que genera cada empresa, mostrando también
el nif de la empresa, para aquellas empresas que generen más de 4 constituyentes.*/
SELECT DISTINCT COUNT(RC.COD_CONSTITUYENTE), RE.NIF_EMPRESA 
FROM RESIDUO_CONSTITUYENTE RC, RESIDUO R, RESIDUO_EMPRESA RE
WHERE RC.COD_RESIDUO = R.COD_RESIDUO 
AND R.COD_RESIDUO = RE.COD_RESIDUO 
GROUP BY RE.NIF_EMPRESA 
HAVING COUNT(RC.COD_CONSTITUYENTE) > 4;

/*9. Mostrar el nombre de las diferentes empresas que han enviado residuos que contenga la
palabra metales en su descripción.*/

/*10. Mostrar el número de envíos que se han realizado entre cada ciudad, indicando también la
ciudad origen y la ciudad destino.*/

/*11. Mostrar el nombre de la empresa transportista que ha transportado para una empresa que
esté en Málaga o en Huelva un residuo que contenga Bario o Lantano. Mostrar también la
fecha del transporte.*/

/*12. Mostrar el coste por kilómetro del total de traslados encargados por la empresa productora
Carbonsur.*/

--13. Mostrar el número de constituyentes de cada residuo.

/*14. Mostrar la descripción de los residuos y la fecha que se generó el residuo, para aquellos
residuos que se han generado en los últimos 30 días por una empresa cuyo nombre tenga una
c. La consulta debe ser válida para cualquier fecha y el listado debe aparecer ordenado por la
descripción del residuo y la fecha.*/

