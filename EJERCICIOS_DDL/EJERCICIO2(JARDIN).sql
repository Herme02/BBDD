ALTER SESSION SET "_oracle_script"=TRUE;
CREATE USER TIENDA identified BY TIENDA;
GRANT CONNECT, RESOURCE, DBA TO TIENDA;


CREATE TABLE FABRICANTES (
cod_fabricante			NUMBER(3),
nombre					VARCHAR2(15),
pais					VARCHAR2(15),

CONSTRAINT PK_cod_fabricante PRIMARY KEY(cod_fabricante),
CONSTRAINT CK_mayusculas CHECK (nombre = UPPER(nombre) AND pais = UPPER(pais))
);


CREATE TABLE ARTICULOS (
articulo				VARCHAR2(20),
cod_fabricante			NUMBER(3),
peso					NUMBER(3),
categoria				VARCHAR2(10),
precio_venta			NUMBER(4, 2),
precio_costo			NUMBER(4, 2),
existencias				NUMBER(5),

CONSTRAINT PK_articulos PRIMARY KEY (articulo, cod_fabricante, peso, categoria),
CONSTRAINT FK_cod_fabricante FOREIGN KEY(cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT CK_preciosventa CHECK (peso > 0 AND precio_venta > 0 AND precio_costo > 0),
CONSTRAINT CK_categoria CHECK (REGEXP_LIKE(categoria, '[A-Z]{1}{2}{3}'))
);


CREATE TABLE TIENDAS (
nif						VARCHAR2(10),
nombre					VARCHAR2(20),
direccion				VARCHAR2(20),
poblacion				VARCHAR2(20),
provincia				VARCHAR2(20),
codpostal				NUMBER(5),

CONSTRAINT PK_nif PRIMARY KEY (nif),
CONSTRAINT CK_provincia CHECK (provincia = UPPER(provincia)) 
);


CREATE TABLE PEDIDOS (
nif						VARCHAR2(10),
articulo				VARCHAR2(20),
cod_fabricante			NUMBER(3),
peso					NUMBER(3),
categoria				VARCHAR2(10),
fecha_pedido			DATE,
unidades_pedidas		NUMBER(4),

CONSTRAINT PK_pedidos PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_pedido),
CONSTRAINT FK_pedido1 FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT FK_pedido2 FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES ARTICULOS(articulo, cod_fabricante, peso, categoria) ON DELETE CASCADE,
CONSTRAINT FK_pedido5 FOREIGN KEY (nif) REFERENCES TIENDAS(nif),
CONSTRAINT CK_unidades CHECK (unidades_pedidas > 0)
);



CREATE TABLE VENTAS (
nif						VARCHAR2(10),
articulo				VARCHAR2(20),
cod_fabricante			NUMBER(3),
peso					NUMBER(3),
categoria				VARCHAR2(10),
fecha_venta				DATE,
unidades_ventas			NUMBER(4),

/*CONSTRAINT DFFGFEFBE CHECK (fecha_venta(DEFAULT SYSDATE)),*/
CONSTRAINT PK_pedidos34 PRIMARY KEY (nif, articulo, cod_fabricante, peso, categoria, fecha_venta),
CONSTRAINT FK_pedido11 FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
CONSTRAINT FK_pedido21 FOREIGN KEY (articulo, cod_fabricante, peso, categoria) REFERENCES ARTICULOS(articulo, cod_fabricante, peso, categoria) ON DELETE CASCADE,
CONSTRAINT FK_pedido51 FOREIGN KEY (nif) REFERENCES TIENDAS(nif),
CONSTRAINT CK_unidades3 CHECK (unidades_ventas > 0)
);


ALTER TABLE PEDIDOS MODIFY unidades_pedidas NUMBER(6);
ALTER TABLE VENTAS MODIFY unidades_ventas NUMBER(6);
ALTER TABLE PEDIDOS ADD pvp NUMBER(10);
ALTER TABLE VENTAS ADD pvp NUMBER(10);
ALTER TABLE FABRICANTES DROP (pais);
ALTER TABLE VENTAS ADD CONSTRAINT CK_u CHECK (unidades_ventas >= 100);
ALTER TABLE VENTAS DROP CONSTRAINT CK_u;

DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE FABRICANTES CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
DROP TABLE TIENDAS CASCADE CONSTRAINT;
DROP TABLE VENTAS CASCADE CONSTRAINT;
