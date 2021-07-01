
create database example_one
go
use example_one
go
CREATE TABLE CLIENTES
( 
dni			int,
nombre		varchar(50),
apellido	varchar(50),
direciion	varchar(50),
fecha_nac	Datetime,
CONSTRAINT	pk_clientes PRIMARY KEY(dni)
)
go
CREATE TABLE PROVEEDOR
( 
nit			int,
nombre		varchar(50),
direciion	varchar(50),
CONSTRAINT	pk_proveedor PRIMARY KEY(nit)
)
go
CREATE TABLE PRODUCTOS
(
codigo	int,
nombre	varchar(50),
precio	float,
fk_nit	int,
foreign key (fk_nit)    references PROVEEDOR(nit),
CONSTRAINT pk_productos PRIMARY KEY(codigo),
)
go
CREATE TABLE COMPRA
(
fk_dni_cliente	int,
fk_cod_producto int,
CONSTRAINT fk_ENVIOS_PRO FOREIGN KEY(fk_dni_cliente)	references CLIENTES(dni),
CONSTRAINT fk_ENVIOS_COM FOREIGN KEY(fk_cod_producto)	references PRODUCTOS(codigo),
)
go
INSERT INTO CLIENTES VALUES (1,'leonardo','guevara','por ahi',convert(datetime ,'19980528  00:00:00 AM'));
INSERT INTO CLIENTES VALUES (2,'elder','joel'   ,'al lado del vecino',convert(datetime ,'19970627  00:00:00 AM'));
INSERT INTO CLIENTES VALUES (3,'ronal','sausedo','de la venta al frente',convert(datetime ,'19960726  00:00:00 AM'));
go
INSERT INTO PROVEEDOR VALUES (123,'phone','china')
INSERT INTO PROVEEDOR VALUES (231,'tablet','china')
INSERT INTO PROVEEDOR VALUES (312,'lapto','china')
go
INSERT INTO PRODUCTOS VALUES (1111,'phone x',800,123)
INSERT INTO PRODUCTOS VALUES (2222,'Galaxy Tab S',600,231)
INSERT INTO PRODUCTOS VALUES (3333,'Surface Pro3',979,312)
go
INSERT INTO COMPRA VALUES (1,3333);
INSERT INTO COMPRA VALUES (2,2222);
INSERT INTO COMPRA VALUES (3,1111);
go


