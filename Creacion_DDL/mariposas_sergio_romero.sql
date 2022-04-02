/*Apartado A:
Crear las tablas necesarias para definir a nivel físico la base de datos
representada en el modelo ER. Se deben incluir los siguientes requisitos:
1. Los nombre de las tablas deben ser los nombres de las entidades. En
el caso de tablas de relaciones N:M el nombre debe ser la unión de
los nombres de las tablas que relaciona.

2. Se deben respetar los nombres de los atributos, y decidir en cada
caso el tipo de datos adecuado, incluyendo una justificación su fuera
necesario.
*/

CREATE TABLE FAMILIA
(nombre VARCHAR2 (20),
caracteristicas VARCHAR2 (20),

CONSTRAINT PK_FAMILIA PRIMARY KEY (nombre)
);

CREATE TABLE GENERO 
(nombre VARCHAR2 (20),
caracteristicas VARCHAR2 (20),
nombre_familia VARCHAR2 (20),

CONSTRAINT PK_GENERO PRIMARY KEY (nombre),
CONSTRAINT FK_GENERO FOREIGN KEY (nombre_familia) REFERENCES FAMILIA (nombre)
);

CREATE TABLE ESPECIE 
(nombre VARCHAR2 (20),
caracteristicas VARCHAR2 (20),
nombre_genero VARCHAR2 (20) NOT NULL,

CONSTRAINT PK_ESPECIE PRIMARY KEY (nombre),
CONSTRAINT FK_ESPECIE FOREIGN KEY (nombre_genero) REFERENCES GENERO (nombre)
);

CREATE TABLE ZONA
(nombre VARCHAR2 (20),
localidad VARCHAR2 (20),
extension VARCHAR2 (20),
protegida VARCHAR2 (20),

CONSTRAINT PK_ZONA PRIMARY KEY (nombre),
/*5. El atributo “Protegida” de la entidad Zona debe tomar como valores
posibles “SI” o “NO”.*/
CONSTRAINT CHK_ZONA CHECK (protegida IN ('SI','NO'))
);

CREATE TABLE PERSONA
(dni VARCHAR2 (9),
nombre VARCHAR2 (20),
direccion VARCHAR2 (20),
telefono NUMBER (10),
--4. El nombre de los usuarios asociados a las personas debe ser único.
usuario VARCHAR2 (20) UNIQUE,

CONSTRAINT PK_PERSONA PRIMARY KEY (dni)
);

CREATE TABLE COLECCION
(dni VARCHAR2 (9),
precio NUMBER (20),
fecha_inicio DATE,
nº_ejemplares NUMBER (20),

CONSTRAINT PK_COLECCION PRIMARY KEY (dni),
CONSTRAINT FK_COLECCION FOREIGN KEY (dni) REFERENCES PERSONA (dni),
/*. La cantidad de un ejemplares de una colección debe estar
comprendido entre 1 y 150.*/
CONSTRAINT CHK_COLECCION CHECK (nº_ejemplares BETWEEN 1 AND 150)
);

CREATE TABLE EJEMPLAR_MARIPOSA
(fecha_captura DATE,
hora_captura NUMBER(20),
nombre_especie VARCHAR2 (20),
nombre_zona VARCHAR2 (20),
dni VARCHAR2 (9),
dni_ejemplar VARCHAR2 (9),
precio_ejemplar NUMBER (20),
nombre_comun VARCHAR2 (20),
fecha_coleccion DATE,

CONSTRAINT PK_EJEMPLAR_MARIPOSA PRIMARY KEY (fecha_captura, hora_captura, nombre_especie, nombre_zona, dni, dni_ejemplar),
CONSTRAINT FK_EJEMPLAR_MARIPOSA FOREIGN KEY (nombre_especie) REFERENCES ESPECIE (nombre),
CONSTRAINT FK1_EJEMPLAR_MARIPOSA FOREIGN KEY (nombre_zona) REFERENCES ZONA (nombre),
CONSTRAINT FK2_EJEMPLAR_MARIPOSA FOREIGN KEY (dni) REFERENCES PERSONA (dni),
CONSTRAINT FK3_EJEMPLAR_MARIPOSA FOREIGN KEY (dni_ejemplar) REFERENCES COLECCION (dni),
--3. El precio de un ejemplar debe ser superior a 0 euros.
CONSTRAINT CHK_EJEMPLAR_MARIPOSA CHECK (precio_ejemplar>0)
);
/*Apartado B:
Realizar las siguientes modificaciones sobre las tablas creadas
anteriormente:
1. Incluir un atributo para almacenar los apellidos de una persona.*/
ALTER TABLE PERSONA ADD apellido VARCHAR2 (20);
/*2. Incluir una restricción para controlar la extensión de una zona está
entre 100m y 1500m.*/
ALTER TABLE ZONA ADD CONSTRAINT  CH1_ZONA CHECK (extension BETWEEN 100 AND 1500);
/*3. Deshabilitar la restricción que obligaba a que los ejemplares tienen
que tener un precio mayor que 0.
Aunque "DISABLE" no me lo esta pillando en oracle.*/
ALTER TABLE EJEMPLAR_MARIPOSA DISABLE CONSTRAINT CHK_EJEMPLAR_MARIPOSA  ;

/*Apartado C:
Crear los índices necesarios para facilitar las siguientes búsquedas:
1. Buscar personas por nombre y apellidos.*/
CREATE INDEX INDICE_BUSQUEDA_NOMBRE_APELLIDOS ON PERSONA (nombre,apellido);
--2. Buscar ejemplares de mariposa por fecha de captura.
CREATE INDEX INDICE_BUSQUEDA_EJEMPLARES_MARIPOSA_FECHA_CAPTURA ON EJEMPLAR_MARIPOSA (fecha_captura);

/*Apartado D:
La base de datos se usará en una aplicación de gestión a la que tendrán
acceso los siguientes perfiles, y para los cuales se deben crear roles con la
funcionalidad indicada:
1. Usuarios: deben consultar la información relacionada con personas,
ejemplares de mariposas y colecciones.
CREATE USER usuario IDENTIFIED BY usuario;

GRANT SELECT ON EJEPLA_MARIPOSA TO usuario;
GRANT SELECT ON COLECCION TO usuario;*/

/*2. Empleados: deben consultar, insertar y modificar la información de
los personas, ejemplares, colecciones y zonas.
CREATE USER empleado IDENTIFIED TO empleado;

GRANT SELECT, INSERT, UPDATE ON EJEMPLAR_MARIPOSA TO empleado;
GRANT SELECT, INSERT, UPDATE ON COLLECCION TO empleado;
GRANT SELECT, INSERT, UPDATE ON ZONA TO empleado;*/

/*3. Administrador: usuario que tendrá todos los privilegios.

CREATE USER administrador IDENTIFIED BY administrador;

GRANT ALL PRIVILEGES TO administrador;*/
/*Apartado E:
Incluir las sentencias para eliminar:
1. Los roles creados.
Epleado:
REVOKE SELECT,INSERT,UPDATE ON EJEMPLAR_MARIPOSA FROM empleado;
REVOKE SELECT,INSERT,UPDATE ON COLECCION FROM empleado;
REVOKE SELECT,INSERT,UPDATE ON ZONA FROM empleado;

Administrador:
REVOKE ALL PRIVILEGES FROM administrador;

Usuario:
REVOKE SELECT ON EJEMPLAR_MARIPOSA FROM usuario;
REVOKE SELECT ON COLECCION FROM usuario;

2. Los índices creados.
DROP INDEX INDICE_BUSQUEDA_NOMBRE_APELLIDOS;
DROP INDEX INDICE_BUSQUEDA_EJEMPLARES_MARIPOSA_FECHA_CAPTURA;
3. Las tablas creadas.
DROP TABLE EJEMPLAR_MARIPOSA CASCADE CONSTRAINT;

DROP TABLE ZONA CASCADE CONSTRAINT;

DROP TABLE PERSONA CASCADE CONSTRAINT;

DROP TABLE GENERO CASCADE CONSTRAINT;

DROP TABLE FAMILIA CASCADE CONSTRAINT;

DROP TABLE ESPECIE CASCADE CONSTRAINT;

DROP TABLE COLECCION CASCADE CONSTRAINT;


















*/












