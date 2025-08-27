/*
Base de Datos
Una base de datos es un almacén de datos (lógico/físico)debe estar estructurado bajo las reglas de normalizacion (1FN,2FN y 3FN).
*/

/*
Base de Datos Relacionales (SQL)
Una base de datos es un almacén de datos (lógico/físico) debe estar correctamente estructurado bajo las
reglas de normalización (1FN, 2FN y 3FN).
Tener presente que también existe la desnormalización, que no es muy recomendada pero en ciertos
escenarios es aplicable.
En una base de datos también es posible poder organizar de manera sistemática los objetos utilizando
esquemas lógicos, estos permiten acceder de manera más segura y eficiente.
Una base de datos tiene archivos físicos: *.mdf (estructura de la bd), *.ndf (datos) y *.ldf (logs).
*/
CREATE DATABASE dbSalesTech;


USE dbSalesTech;

-- CREAR UN ESQUEMA  LLAMADO VENTAS 
CREATE SCHEMA ventas;

-- CREAR UN ESQUEMA  LLAMADO RRHH
CREATE SCHEMA rrhh;

-- LISTAR LOS ESQUEMAS
SELECT * FROM sys.schemas;

/*
Tipos de Datos
Los tipos de datos aseguran la consistencia y homogeneidad de los datos. Por ejemplo:
asignamos un tipo de dato INT para las cantidades de stock de producto, asignamos un tipo
de dato decimal para los precios de los productos.
*/

-- Ejemplo: Listando tipos de datos
SELECT * FROM sys.types;

-- Podemos estandarizar los tipos de datos creando nuestros propios tipos de datos
-- Se recomienda hacerlo cuando deseamos estandarizar los datos que vamos a almacenar
-- Ejemplo: celular char(9) null [restricciones: sólo debe permitir 9 digitos y el primero debe ser 9] ->
Tablas: cliente, vendedor, conductor, repartidor, etc.
CREATE TYPE fono
FROM char(9) null;

CREATE TYPE sueldo
FROM decimal(8,2); -- ######,##

-- Para poder eliminar un tipo de dato, este no debe ser utilizado en la definición de ninguna tabla.
-- Si el tipo de dato no está asignado en ningun campo de ninguna tabla se puede eliminar de la siguiente
manera:
DROP TYPE sueldo;

-- Ejemplo:
CREATE TABLE cliente
(
    id int IDENTITY,
    nombre VARCHAR(80),
    apellidos VARCHAR(120),
    celular fono
);

CREATE TABLE vendedor
(
    id int IDENTITY,
    nombre VARCHAR(80),
    apellidos VARCHAR(120),
    celular fono
);

-- Transferir una tabla a un esquema
ALTER SCHEMA rrhh
TRANSFER dbo.cliente;

ALTER SCHEMA rrhh
TRANSFER dbo.vendedor;

-- Crear una tabla y asignarle a un esquema
CREATE TABLE rrhh.repartidor
(
    id int IDENTITY,
    nombre VARCHAR(80),
    apellidos VARCHAR(120),
    direccion VARCHAR(150),
    celular fono
);

/*
Son objetos que consumen datos de otras tablas o que almacenan datos temporales, es
decir, mientras esté la sesión activa de la base de datos.
*/
-- Ejemplo: Crear tabla temporal llamada producto
CREATE TABLE #producto
(
    id int,
    producto VARCHAR(100),
    descripcion VARCHAR(150)
);

SELECT * FROM #producto;

/* Tablas temporales globales
Son aquellas tablas que existen mientras el servidor de la base de datos esté activo. Si
se cierra la sesión o se reinicia la tabla deja de existir.
Esta tabla es accesible sin importar el número de sesión del cual se desee acceder.
*/

-- Ejemplo
CREATE TABLE ##categorias
(
    codigo char(3),
    nombre VARCHAR(80),
    descripcion VARCHAR(120)
);

SELECT * FROM ##categorias;

/* Tablas de tipo variable
Esta tabla es accesible siempre y cuando se ejecute su script de implementacion, datos y
consulta.
*/
-- Ejemplo:
DECLARE @asistente table
(
    codigo char(4),
    nombre VARCHAR(80),
    apellidos VARCHAR(100)
);

SELECT * FROM @asistente;