--ALTER SESSION SET "_oracle_script"= TRUE;
--CREATE USER UNIVERSIDAD IDENTIFIED BY UNIVERSIDAD;
--GRANT CONNECT, RESOURCE,DBA TO UNIVERSIDAD;


--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.
SELECT A.IDALUMNO 
FROM ALUMNO A, ALUMNO_ASIGNATURA AA
WHERE A.IDALUMNO =AA.IDALUMNO 
AND AA.IDASIGNATURA <> '150121'
AND AA.IDASIGNATURA <> '130113';

--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT A.NOMBRE 
FROM ASIGNATURA A
WHERE A.CREDITOS > 
	(SELECT CREDITOS 
	FROM ASIGNATURA
	WHERE NOMBRE LIKE 'Seguridad Vial');

--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
SELECT A.IDALUMNO 
FROM ALUMNO A, ALUMNO_ASIGNATURA AA
WHERE A.IDALUMNO = AA.IDALUMNO 
AND AA.IDASIGNATURA LIKE '150121'
AND AA.IDASIGNATURA LIKE '130113';

--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero no en ambas a la vez. 
SELECT DISTINCT A.IDALUMNO 
FROM ALUMNO A, ALUMNO_ASIGNATURA AA
WHERE A.IDALUMNO = AA.IDALUMNO 
AND AA.IDASIGNATURA LIKE '150121'
OR AA.IDASIGNATURA LIKE '130113';

--5. Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el coste básico promedio por asignatura en esa titulación.
SELECT A.NOMBRE
FROM ASIGNATURA A
WHERE A.IDTITULACION LIKE '130110' 
AND A.COSTEBASICO > 
	(SELECT AVG(A.COSTEBASICO)
	FROM ASIGNATURA A);

--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" y la "130113”
SELECT DISTINCT AA.IDALUMNO 
FROM ALUMNO_ASIGNATURA AA
WHERE AA.NUMEROMATRICULA NOT LIKE '150212'
AND AA.NUMEROMATRICULA NOT LIKE '130113';

--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 
SELECT AA.IDASIGNATURA 
FROM ALUMNO_ASIGNATURA AA
WHERE AA.NUMEROMATRICULA LIKE '150212'
AND AA.NUMEROMATRICULA NOT LIKE '130113';

--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT A.NOMBRE 
FROM ASIGNATURA A
WHERE A.CREDITOS >
	(SELECT A.CREDITOS 
	FROM ASIGNATURA A
	WHERE A.NOMBRE LIKE 'Seguridad Vial');

--9. Mostrar las personas que no son ni profesores ni alumnos.
SELECT DISTINCT P.NOMBRE 
FROM PERSONA P, ALUMNO A
WHERE P.NOMBRE NOT IN
	(SELECT P.NOMBRE 
	FROM PERSONA P, ALUMNO A, PROFESOR PR
	WHERE P.DNI = A.DNI
	AND P.DNI = PR.DNI);

--10. Mostrar el nombre de las asignaturas que tengan más créditos. 
SELECT A.NOMBRE 
FROM ASIGNATURA A
WHERE A.CREDITOS >= 
	(SELECT A.CREDITOS 
	FROM ASIGNATURA A);
--11. Lista de asignaturas en las que no se ha matriculado nadie. 

--12. Ciudades en las que vive algún profesor y también algún alumno. 