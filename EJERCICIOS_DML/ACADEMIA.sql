--ALTER SESSION SET "_oracle_script"=TRUE;
--CREATE USER ACADEMIA identified BY ACADEMIA;
--GRANT CONNECT, RESOURCE, DBA TO ACADEMIA;


CREATE TABLE PROFESORES(
nombre				VARCHAR2(20),
apellido1			VARCHAR2(20),
apellido2			VARCHAR2(20),
dni					NUMBER(20),
direccion			VARCHAR2(20),
titulo				VARCHAR2(20),
gana				VARCHAR2(20),

CONSTRAINT PK_dni PRIMARY KEY(dni)
);

CREATE TABLE CURSOS(
nombre_curso		VARCHAR2(30),
cod_curso			NUMBER(20),
dni_profesor		NUMBER(20),
maximo_alumnos		NUMBER(20),
fecha_inicio		DATE,
fecha_fin			DATE,
num_horas			NUMBER(20),

CONSTRAINT PK_cod_curso PRIMARY KEY(cod_curso),
CONSTRAINT FK_dni_profesor FOREIGN KEY(dni_profesor) REFERENCES PROFESORES(dni)
);

CREATE TABLE ALUMNOS(
nombre				VARCHAR2(20),
apellido1			VARCHAR2(20),
apellido2			VARCHAR2(20),
dni					NUMBER(20),
direccion			VARCHAR2(20),
sexo				VARCHAR2(20),
fecha_nacimiento	DATE,
curso				NUMBER(5),

CONSTRAINT PK_dni_alumnos PRIMARY KEY(dni),
CONSTRAINT FK_curso FOREIGN KEY(curso) REFERENCES CURSOS(cod_curso),
CONSTRAINT CK_sexo CHECK(sexo IN('H','M'))
);


--2.Insertar las siguientes tuplas:

INSERT INTO PROFESORES(nombre, apellido1, apellido2, dni, direccion, titulo, gana)
VALUES('Juan','Arch','López',32432455,'Puerta Negra,4','Ing. Informatica', 7500);

INSERT INTO PROFESORES(nombre, apellido1, apellido2, dni, direccion, titulo, gana)
VALUES('Maria','Oliva','Rubio',43215643,'Juan Alfonso 32','Lda. Fil. Inglesa', 5400);

--SELECT * FROM PROFESORES

INSERT INTO CURSOS(nombre_curso, cod_curso, dni_profesor, maximo_alumnos, fecha_inicio, fecha_fin, num_horas)
VALUES('Inglés Básico', 1, 43215643, 15, TO_DATE('01/11/2000','DD/MM/YYYY'), TO_DATE('22/12/2000','DD/MM/YYYY'), 120);

INSERT INTO CURSOS(nombre_curso, cod_curso, dni_profesor, fecha_inicio, num_horas)
VALUES('Administración Linux', 2, 32432455, TO_DATE('01/09/2000','DD/MM/YYYY'), 80);

--SELECT * FROM CURSOS

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, direccion, sexo, fecha_nacimiento, curso)
VALUES('Lucas', 'Manilva', 'López', 123523, 'Alhamar,3', 'H', TO_DATE('01/11/1979','DD/MM/YYYY'), 1);

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, direccion, sexo, curso)
VALUES('Antonia', 'López', 'Alcantara', 2567567, 'Maniqui,21', 'M', 2);

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, direccion, sexo, curso)
VALUES('Manuel', 'Alcantara', 'Pedrós', 3123689, 'Julian,2', 'H', 1);

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, direccion, sexo, fecha_nacimiento, curso)
VALUES('José', 'Pérez', 'Caballar', 4896765, 'Jarcha,5', 'H', TO_DATE('03/02/1977','DD/MM/YYYY'), 2);

--SELECT * FROM ALUMNOS


--3.Insertar la siguiente tupla en ALUMNOS:

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, sexo, curso)
VALUES('Sergio', 'Navas', 'Retal', 123524, 'H', 1);

--SELECT * FROM ALUMNOS


--4.Insertar las siguientes tupla en la tabla profesores:

INSERT INTO PROFESORES(nombre, apellido1, apellido2, dni, direccion, titulo, gana)
VALUES('Juan','Arch','López',32432456,'Puerta Negra,4','Ing. Informatica', NULL);


--5.Insertar la siguiente tupla en la tabla estudiante:

INSERT INTO ALUMNOS(nombre, apellido1, apellido2, dni, direccion, sexo, curso)
VALUES('Maria', 'Jaén', 'Sevilla', 789678, 'Martos,5', 'M', 1);


--6.La fecha de nacimiento de Antonia López está equivocada. La verdadera es 23 de diciembre de 1976.

--SELECT * FROM ALUMNOS

UPDATE ALUMNOS 
SET fecha_nacimiento = TO_DATE('23/12/1976','DD/MM/YYYY')
WHERE dni = 2567567;


--7.Cambiar a Antonia López al curso de código 5:

--No es posible cambiar de curso a Antonia, ya que no existe ningun curso con el codigo 5 implementado.
--SOLUCION--> CREAR UN NUEVO CURSO QUE TENGA COMO CODIGO_CURSO EL NUMERO 5 ANTES DE CAMBIAR DE CURSO A ANTONIA.

INSERT INTO CURSOS(nombre_curso, cod_curso, dni_profesor, maximo_alumnos, fecha_inicio, fecha_fin, num_horas)
VALUES('Administracion BBDD', 5, 43215643, 21, TO_DATE('01/11/2000','DD/MM/YYYY'), TO_DATE('22/12/2000','DD/MM/YYYY'), 120);

UPDATE ALUMNOS
SET curso = 5
WHERE dni = 2567567;

--SELECT * FROM CURSOS
--SELECT * FROM ALUMNOS


--8.Eliminar la profesora Laura Jiménez:

--No es posible eliminar a dicha profesora ya que su nombre y apellido no estan registrados en la base de datos.
--SOLUCION: INSERTAR A DICHA PROFESORA EN LA TABLA PROFESORES PARA ASÍ DESPUES PODER ELIMINARLA.

INSERT INTO PROFESORES(nombre, apellido1, dni)
VALUES('Laura','Jimenez', 32432457);

DELETE FROM PROFESORES
WHERE nombre = 'Laura';

--SELECT * FROM PROFESORES


--9.Borrar el curso con código 1.

--No seria posible borrar el curso con codigo 1 ya que aun hay alumnos dentro de dicho curso.
--SOLUCION--> ACTUALIZAR A LOS ALUMNOS DENTRO DEL CURSO 1 Y PASARLOS AL CURSO 2 PARA ASI PODER BORRAR EL CURSO 1.

UPDATE ALUMNOS
SET curso = 2
WHERE curso = 1;

DELETE FROM CURSOS
WHERE cod_curso = 1;


--10.Añadir un campo llamado numero_alumnos en la tabla curso.

ALTER TABLE CURSOS ADD numero_alumnos NUMBER(10);
--SELECT * FROM CURSOS;


--11.Modificar la fecha de nacimiento a 01/01/2012 en aquellos alumnos que no tengan fecha de nacimiento.

UPDATE ALUMNOS
SET fecha_nacimiento = TO_DATE('01/01/2012','DD/MM/YYYY')
WHERE fecha_nacimiento IS NULL;

--SELECT * FROM ALUMNOS


--12.Borra el campo sexo en la tabla de alumnos.

ALTER TABLE ALUMNOS DROP COLUMN sexo;

--SELECT * FROM ALUMNOS


--13. Modificar la tabla profesores para que los  profesores de Informática cobren un 20 pro ciento más de lo que cobran actualmente.

UPDATE PROFESORES
SET gana = gana + ((gana*20)/100)
WHERE titulo = 'Ing. Informatica';

--SELECT * FROM PROFESORES


--13. Modifica el dni de Juan Arch a 1234567

UPDATE PROFESORES
SET dni = 1234567
WHERE dni = 32432456;

--SELECT * FROM PROFESORES


--14. Modifica el dni de todos los profesores de informática para que tengan el dni 7654321

--No seria posible ya que dni es clave primaria, por lo que no puede haber 2 dni iguales.
--SOLUCION-->NINGUNA SOLUCION VIABLE

--UPDATE PROFESORES
--SET dni = 7654321;


--15. - Cambia el sexo de la alumna María Jaén a F.
--No seria posible, ya que anteriormente borramos el sexo de la tabla ALUMNOS.
--SOLUCION--> Volver a añadir el campo sexo en la tabla alumnos y actualizar el sexo de Maria a F.

ALTER TABLE ALUMNOS ADD sexo VARCHAR2(1);

UPDATE ALUMNOS
SET sexo = 'F'
WHERE nombre = 'Maria';

--SELECT * FROM ALUMNOS

