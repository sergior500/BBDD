CREATE TABLE oficina
(codigo_oficina VARCHAR2(10),
ciudad VARCHAR2(30),
pais VARCHAR2(50),
region VARCHAR2(50),
codigo_postal VARCHAR2(10),
telefono VARCHAR2(20),
linea_direccion1 VARCHAR2(50),
linea_direccion2 VARCHAR2(50),
CONSTRAINT PK_OFICINA PRIMARY KEY (codigo_oficina)
);

CREATE TABLE empleado
(codigo_empleado NUMBER(11),
nombre VARCHAR2(50),
apellido VARCHAR2(50),
apellido2 VARCHAR2(50),
extension VARCHAR2(10),
email VARCHAR2(100),
codigo_oficina VARCHAR2(10),
codigo_jefe NUMBER(11),
puesto VARCHAR2(50),
CONSTRAINT PK_EMPLEADO PRIMARY KEY (codigo_empleado),
CONSTRAINT FK_EMPLEADO FOREIGN KEY (codigo_oficina) REFERENCES oficina(codigo_oficina),
CONSTRAINT FK_EMPLEADO2 FOREIGN KEY (codigo_jefe) REFERENCES empleado(codigo_empleado)
);

CREATE TABLE cliente
(codigo_cliente NUMBER(11),
nombre_cliente VARCHAR2(50),
nombre_contacto VARCHAR2(30),
apellido_contacto VARCHAR2(30),
telefono VARCHAR2(15),
fax VARCHAR2(15),
linea_direccion1 VARCHAR2(50),
linea_direccion2 VARCHAR2(50),
ciudad VARCHAR2(50),
region VARCHAR2(50),
pais VARCHAR2(50),
codigo_postal VARCHAR2(10),
codigo_empleado_rep_ventas NUMBER(11),
limite_credito NUMBER(15,2),
CONSTRAINT PK_CLIENTE PRIMARY KEY (codigo_cliente),
CONSTRAINT FK_CLIENTE FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(codigo_empleado)
);

CREATE TABLE pago
(id_transaccion VARCHAR2(50),
forma_pago VARCHAR2(40),
fecha_pago DATE,
total NUMBER(15,2),
codigo_cliente NUMBER(11),
CONSTRAINT PK_PAGO PRIMARY KEY (id_transaccion),
CONSTRAINT FK_PAGO FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

CREATE TABLE gama_producto
(gama VARCHAR2(50),
descripcion_texto VARCHAR2(400),
descripcion_html VARCHAR2(400),
imagen VARCHAR2(256),
CONSTRAINT PK_GAMA_PRODUCTO PRIMARY KEY (gama)
);

CREATE TABLE producto
(codigo_producto VARCHAR2(15),
nombre VARCHAR2(70),
gama VARCHAR2(50),
dimensiones VARCHAR2(25),
proveedor VARCHAR2(50),
descripcion VARCHAR2(400),
cantidad_en_stock NUMBER(6),
precio_venta NUMBER(15,2),
precio_proveedor NUMBER(15,2),
CONSTRAINT PK_PRODUCTO PRIMARY KEY (codigo_producto),
CONSTRAINT FK_PRODUCTO FOREIGN KEY (gama) REFERENCES gama_producto(gama)
);

CREATE TABLE pedido
(codigo_pedido NUMBER(11),
fecha_pedido DATE,
fecha_esperada DATE,
fecha_entrega DATE,
estado VARCHAR2(15),
comentarios VARCHAR2(280),
codigo_cliente number(11),
CONSTRAINT PK_pedido PRIMARY KEY (codigo_pedido),
CONSTRAINT FK_pedido FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente)
);

CREATE TABLE detalle_pedido
(codigo_pedido NUMBER(11),
codigo_producto VARCHAR2(15),
cantidad NUMBER(11),
precio_unidad NUMBER(15,2),
numero_linea NUMBER(6),
CONSTRAINT PK_detalle_pedido PRIMARY KEY (codigo_pedido,codigo_producto),
CONSTRAINT FK_detalle_pedido FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto),
CONSTRAINT FK_detalle_pedido2 FOREIGN KEY (codigo_pedido) REFERENCES pedido (codigo_pedido)
);