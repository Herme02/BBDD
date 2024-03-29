ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER PARTIDOS identified BY PARTIDOS;
GRANT CONNECT, RESOURCE, DBA TO PARTIDOS;


CREATE TABLE EQUIPO(
CodEquipo			VARCHAR2(4),
Nombre				VARCHAR2(30) NOT NULL,
Localidad			VARCHAR2(15),

CONSTRAINT PK_CodEquipo PRIMARY KEY (CodEquipo)
);


CREATE TABLE JUGADOR(
CodJugador		VARCHAR2(4),
Nombre				VARCHAR2(30)NOT NULL,
FechaNacimiento		DATE,
Demarcacion			VARCHAR2(10),
CodEquipo			VARCHAR2(4),

CONSTRAINT PK_CodJugador PRIMARY KEY (CodJugador),
CONSTRAINT FK_CodEquipo FOREIGN KEY (CodEquipo) REFERENCES EQUIPO(CodEquipo)
);


CREATE TABLE PARTIDO(
CodPartido			VARCHAR2(4),
CodEquipoLocal		VARCHAR2(4),
CodEquipoVisitante	VARCHAR2(4),
Fecha				DATE,
Competicion			VARCHAR2(4),
Jornada				VARCHAR2(20),

CONSTRAINT PK_CodPartido PRIMARY KEY (CodPartido),
CONSTRAINT FK_CodEquipoLocal FOREIGN KEY (CodEquipoLocal) REFERENCES EQUIPO(CodEquipo),
CONSTRAINT FK_CodEquipoVisitante FOREIGN KEY (CodEquipoVisitante) REFERENCES EQUIPO(CodEquipo),

CONSTRAINT CK_Fecha CHECK(EXTRACT(MONTH FROM Fecha)!= 7 OR EXTRACT(MONTH FROM Fecha)!= 8),
CONSTRAINT CK_Competicion CHECK (Competicion IN 'Copa' OR Competicion IN 'Liga')
);


CREATE TABLE INCIDENCIA(
NumIncidencias			VARCHAR2(6),
CodPartido				VARCHAR2(4),
CodJugador				VARCHAR2(4),
Minuto					NUMBER(2),
Tipo					VARCHAR2(20),
CONSTRAINT PK_NumIncidencias PRIMARY KEY (NumIncidencias),
CONSTRAINT FK_CodPartido FOREIGN KEY (CodPartido) REFERENCES PARTIDO(CodPartido),
CONSTRAINT FK_CodJugador FOREIGN KEY (CodJugador) REFERENCES JUGADOR(CodJugador),
CONSTRAINT CK_Minuto CHECK (Minuto >= 1 AND Minuto <= 100)
);

ALTER TABLE INCIDENCIA MODIFY Minuto NUMBER(3);
ALTER TABLE JUGADOR ADD CONSTRAINT CK_NombreJugador CHECK (INITCAP(Nombre) = Nombre);
ALTER TABLE JUGADOR ADD CONSTRAINT CK_Demarcacion CHECK (Demarcacion IN 'Portero' OR Demarcacion IN 'Defensa' OR Demarcacion IN 'Medio' OR Demarcacion IN 'Delantero');
ALTER TABLE EQUIPO ADD CONSTRAINT CK_EQUIPO CHECK (regexp_like(Nombre, '[0-9]{1}'));
ALTER TABLE INCIDENCIA MODIFY Tipo NOT NULL;
ALTER TABLE EQUIPO ADD GolesMarcados NUMBER(3);
