CREATE TABLE vehiculos
(matricula VARCHAR2(7),
marca VARCHAR2(10) NOT NULL,
modelo VARCHAR2(10) NOT NULL,
fecha_Compra DATE,
precio_por_dia NUMBER(5,2),
CONSTRAINT PK_VEHICULOS PRIMARY KEY (matricula),
CONSTRAINT CHK_VEHICULOS CHECK(EXTRACT (YEAR FROM fecha_compra)>2001)
);

CREATE TABLE clientes
(dni VARCHAR2(9),
nombre VARCHAR2(30) NOT NULL,
nacionalidad VARCHAR2(30),
fecha_nacimiento DATE,
direccion VARCHAR(50),
CONSTRAINT PK_CLIENTES PRIMARY KEY (dni)
);

CREATE TABLE alquileres
(matricula VARCHAR2(7),
dni VARCHAR2(10),
fechaHora DATE,
num_dias NUMBER(2) NOT NULL,
kilometros number(4) DEFAULT(0),
CONSTRAINT PK_ALQUILERES PRIMARY KEY (matricula,DNI,fechaHora)
);