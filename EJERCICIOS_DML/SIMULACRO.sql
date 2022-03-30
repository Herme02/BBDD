ALTER SESSION SET "_oracle_script"= TRUE;
CREATE USER SIMULACRO IDENTIFIED BY SIMULACRO;
GRANT CONNECT, RESOURCE,DBA TO SIMULACRO;


--Apartado 1--

CREATE TABLE PROFESOR
(idprofesor NUMBER (10),
nif_p VARCHAR2 (20),
nombre VARCHAR2 (20),
especialidad VARCHAR2 (20),
telefono VARCHAR2 (20),

CONSTRAINT PROFESOR PRIMARY KEY (idprofesor)

);


CREATE TABLE ASIGNATURA
(codasignatura VARCHAR2 (20),
nombre VARCHAR2 (20),
idprofesor NUMBER (10),

CONSTRAINT ASIGNATURA PRIMARY KEY (codasignatura),
CONSTRAINT ASIGNATURA_FK FOREIGN KEY (idprofesor) REFERENCES PROFESOR (idprofesor)

);

CREATE TABLE ALUMNO 
(nummatricula NUMBER (20),
nombre VARCHAR2 (20),
fechanacimiento DATE,
telefono VARCHAR2 (20),

CONSTRAINT ALUMNO_PK PRIMARY KEY (nummatricula)
);


CREATE TABLE RECIBE 
(nummatricula NUMBER (20),
codasignatura VARCHAR2 (20),
cursoescolar VARCHAR2 (20),

CONSTRAINT RECIBE_PK PRIMARY KEY (nummatricula,codasignatura,cursoescolar),
CONSTRAINT RECIBE_FK FOREIGN KEY (nummatricula) REFERENCES ALUMNO (nummatricula),
CONSTRAINT RECIBE_FK1 FOREIGN KEY (codasignatura) REFERENCES ASIGNATURA  (codasignatura)
);





--Apartado 2--


--Inserta dos profesores, inserta 4 asignaturas,  inserta 10 alumnos,
--cada alumno debe realizar al menos 2 asignatura--

--dos profesores--

INSERT INTO PROFESOR (idprofesor, nif_p, nombre, especialidad, telefono) VALUES (555, '56124736P', 'Ricardo', 'Matemáticas', '987456312');
INSERT INTO PROFESOR (idprofesor, nif_p, nombre, especialidad, telefono) VALUES (666, '88124736K', 'Luque', 'Educación Fisica', '555456312');

--cuatro asignaturas--

INSERT INTO ASIGNATURA (codasignatura, nombre, idprofesor) VALUES ('00055', 'Matematica', 555);
INSERT INTO ASIGNATURA (codasignatura, nombre, idprofesor) VALUES ('00066', 'Educacion Fisica', 666);
INSERT INTO ASIGNATURA (codasignatura, nombre, idprofesor) VALUES ('00077', 'Fisica', 555);
INSERT INTO ASIGNATURA (codasignatura, nombre, idprofesor) VALUES ('00088', 'Fisioterapia', 666);

--inserta 10 alumnos--



INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1234, 'Ricardinho', '06/01/2000', '654789123');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1235, 'Nazarinho', '06/02/2001', '654789166');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1236, 'Ronaldinho', '06/02/1999', '654785266');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1237, 'Pele', '06/02/1855', '654789695');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1238, 'Mukoko', '06/02/1998', '654789188');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1210, 'Josebinha', '06/02/1997', '654789555');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1211, 'Alejandrinha', '06/02/1980', '654789666');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1212, 'Pilarinha', '06/02/2002', '654789169');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1213, 'Javielinho', '06/02/1988', '654789155');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1214, 'Pepefinho', '06/02/1999', '654789111');

-- Cada alumno debe realizar al menos 2 asiganturas--

--alumno 1--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1234, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1234, '00066', '2021');
--alumno 2--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1235, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1235, '00066', '2021');
--alumno 3--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1236, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1236, '00066', '2021');
--alumno 4--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1237, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1237, '00066', '2021');
--alumno 5--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1238, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1238, '00066', '2021');
--alumno 6--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1210, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1210, '00066', '2021');
--alumno 7--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1211, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1211, '00066', '2021');
--alumno 8--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1212, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1212, '00066', '2021');
--alumno 9--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1213, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1213, '00066', '2021');
--alumno 10--
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1214, '00055', '2021');
INSERT INTO RECIBE (nummatricula,codasignatura,cursoescolar) VALUES (1214, '00066', '2021');

--Apartado 3--


INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1215, 'Manolinho', '06/02/1999', '654789222');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento, telefono) VALUES (1215, 'Pedrinho', '06/02/1977', '654789777');

--No me deja crear otro alumno con la misma nummatricula por que tengo una restricción que no puede
--ser violada, alumno PK--
--Alumno PK no se puede desactivar por que existen dependencias.--

--Apartado 4--

INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento) VALUES (1216, 'Rambininho', '06/02/1999');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento) VALUES (1217, 'Umtitinho', '06/02/1999');
INSERT INTO ALUMNO (nummatricula, nombre, fechanacimiento) VALUES (1218, 'Marininho', '06/02/1999');

--Apartado 5--



UPDATE ALUMNO SET telefono = '555666333' WHERE nombre ='Rambininho';
UPDATE ALUMNO SET telefono = '555999333' WHERE nombre ='Umtitinho';
UPDATE ALUMNO SET telefono = '555666444' WHERE nombre ='Marininho';

--Apartado6--



UPDATE ALUMNO SET fechanacimiento ='22/07/1981' WHERE fechanacimiento >= '01/01/2000';


--Apartado 7--

UPDATE PROFESOR SET especialidad = 'informatica' WHERE nif_p != '9%';

--Apartado 8--

--SELECT * FROM RECIBE WHERE CODASIGNATURA ='00066';--

DELETE FROM RECIBE WHERE codasignatura  ='00066';


--Apartado 9--

--SELECT * FROM ASIGNATURA WHERE CODASIGNATURA ='00066';

DELETE FROM ASIGNATURA WHERE codasignatura  ='00066';

--Apartado 10--

--SELECT * FROM ASIGNATURA;--

DELETE FROM ASIGNATURA WHERE codasignatura ='00077';
DELETE FROM ASIGNATURA WHERE codasignatura ='00088';

--DELETE FROM ASIGNATURA WHERE codasignatura ='00055';--

-- antertiormente indicando las instrucciones para borrar las asignaturas, hay una 
-- que no se borra, debido a que este campo es foraneo de la tabla RECIBE  y ademas corresponde a parte de la 
-- clave primaria compuesta y no puede quedar sin datos.--

--Para solucionar este problema podemos desabilitar dicha constraint que impide el borrado--

ALTER TABLE RECIBE DISABLE CONSTRAINT RECIBE_FK1;

--Una vez desabilitada procedemos al borrado--

DELETE FROM ASIGNATURA WHERE codasignatura ='00055';

-- Para poder evitarse el problema, el diseño fisico debería haber sido uno en el cual la cardinalidad entre
-- asignatura y alumno no suponga la creacion de una nueva tabla con clave primaria compuesta y que sea una 
-- entidad independiente--.

--Apartado 11--

SELECT * FROM PROFESOR;

DELETE FROM PROFESOR WHERE idprofesor = 555;
DELETE FROM PROFESOR WHERE idprofesor = 666;



--Nos ha dejado borrar a los dos profesores, por que id_profesor
-- es una clave foranea y actualmente no tenemos datos en ASIGNATURA ya que 
-- anteriormente borramos todas las asignaturas y desabilitamos la constraint que tiene con la tabla RECIBE--


COMMIT;

--	Apartado 12--

SELECT * FROM ALUMNO;

UPDATE ALUMNO SET nombre = UPPER(nombre);

--Apartado 13--

CREATE TABLE ALUMNO_BACKUP
(nummatricula_backup NUMBER (20),
nombre_backup VARCHAR2 (20),
fechanacimiento_backup DATE,
telefono_backup VARCHAR2 (20),

CONSTRAINT PK_ALUMNO_BACKUP PRIMARY KEY (nummatricula_backup)
);

INSERT INTO ALUMNO_BACKUP SELECT * FROM ALUMNO;

--SELECT * FROM ALUMNO_BACKUP ;






