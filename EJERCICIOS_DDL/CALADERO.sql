ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER CALADERO identified BY CALADERO;
GRANT CONNECT, RESOURCE, DBA TO CALADERO;



CREATE TABLE BARCOS (
matricula			VARCHAR2(10),
nombre				VARCHAR2(30),
clase				VARCHAR2(30),
armador				VARCHAR2(30),
capacidad			VARCHAR2(30),
nacionalidad		VARCHAR2(20),

CONSTRAINT PK_matricula PRIMARY KEY(matricula)
);


CREATE TABLE ESPECIE (
codigo				VARCHAR2(20),
nombre				VARCHAR2(30),
tipo				VARCHAR2(20),
cupoporbarco		VARCHAR2(30),
caladero_principal	VARCHAR2(30),

CONSTRAINT PK_codigo_especie PRIMARY KEY (codigo)
);


CREATE TABLE CALADERO (
codigo				VARCHAR2(20),
nombre				VARCHAR2(30),
ubicacion			VARCHAR2(30),
especie_principal	VARCHAR2(30),

CONSTRAINT PK_codigo_caladero PRIMARY KEY (codigo),
CONSTRAINT FK_especie_principal FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo) ON DELETE SET NULL 
);


ALTER TABLE ESPECIE ADD CONSTRAINT FK_caladero_principal FOREIGN KEY (caladero_principal) REFERENCES CALADERO(codigo);


CREATE TABLE LOTES (
codigo				VARCHAR2(30),
matricula			VARCHAR2(10),
numkilos			NUMBER(10),
preciosporkilosalida NUMBER(10),
precioporkilosadjudicado NUMBER(10),
fecha_venta			DATE,
cod_especie			VARCHAR2(20),

CONSTRAINT PK_codigo_lotes PRIMARY KEY(codigo),
CONSTRAINT FK_matricula FOREIGN KEY (matricula) REFERENCES BARCOS(matricula) ON DELETE CASCADE,
CONSTRAINT FK_cod_especie FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo) ON DELETE CASCADE
);


CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS (
cod_especie			VARCHAR2(20),
cod_caladero		VARCHAR2(20),
fecha_inicial		DATE,
fecha_final			DATE,

CONSTRAINT PK_codigos PRIMARY KEY (cod_especie,cod_caladero),
CONSTRAINT FK_cod_especie_fecha FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
CONSTRAINT FK_cod_caladero_fecha FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
);


ALTER TABLE BARCOS ADD CONSTRAINT CK_matricula CHECK (REGEXP_LIKE(matricula, '[A-Z]{2}[-]{1}[0-9]{4}')));
ALTER TABLE LOTES MODIFY fecha_venta NOT NULL;
ALTER TABLE LOTES ADD CONSTRAINT CK_precios CHECK (precioporkilosadjudicado > preciosporkilosalida);
ALTER TABLE LOTES ADD CONSTRAINT CK_mayorcero CHECK (numkilos > 0 AND preciosporkilosalida > 0 AND precioporkilosadjudicado > 0);
ALTER TABLE CALADERO ADD CONSTRAINT CK_mayusculas CHECK (nombre = UPPER(nombre) AND ubicacion = UPPER(ubicacion));
ALTER TABLE FECHAS_CAPTURAS_PERMITIDAS ADD CONSTRAINT CK_fecha CHECK (TO_CHAR(fecha_inicial, 'DD/MM') < '02/02' AND TO_CHAR(fecha_final, 'DD/MM') < '28/03';



ALTER TABLE CALADERO ADD nombre_cientifico VARCHAR2(30);

INSERT INTO BARCOS(nacionalidad) VALUES('español');
INSERT INTO ESPECIE(tipo) VALUES('herviboros');
INSERT INTO CALADERO(nombre) VALUES('Paco');
INSERT INTO LOTES(numkilos) VALUES(50);
INSERT INTO FECHAS_CAPTURAS_PERMITIDAS(cod_caladero) VALUES('AB-1234');

ALTER TABLE BARCOS DROP COLUMN armador;

DROP TABLE BARCOS CASCADE CONSTRAINT;
DROP TABLE CALADERO CASCADE CONSTRAINT;
DROP TABLE ESPECIE CASCADE CONSTRAINT;
DROP TABLE FECHAS_CAPTURAS_PERMITIDAS CASCADE CONSTRAINT,
DROP TABLE LOTES CASCADE CONSTRAINT;