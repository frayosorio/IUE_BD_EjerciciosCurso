--Crear la base de datos
CREATE DATABASE TiendaVideoJuegos_IUE
GO

--Ir a la base de datos
USE TiendaVideoJuegos_IUE

--Crear la tabla PAIS
CREATE TABLE Pais(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Pais PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	CodigoAlfa VARCHAR(5) NOT NULL,
	Indicativo INT NULL
)

CREATE UNIQUE INDEX ix_Pais_Nombre
	ON Pais(Nombre)

CREATE UNIQUE INDEX ix_Pais_CodigoAlfa
	ON Pais(CodigoAlfa)

--Crear tabla DESARROLLADOR
CREATE TABLE Desarrollador(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Desarrolador PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT fk_Desarrollador_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

CREATE UNIQUE INDEX ix_Desarrollador_Nombre
	ON Desarrollador(Nombre)

--Crear tabla REGION
CREATE TABLE Region(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Region PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	Codigo VARCHAR(5) NOT NULL,
	CONSTRAINT fk_Region_IdPais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)

--Crear indice de la tabla REGION
CREATE UNIQUE INDEX ix_Region_Nombre
	ON Region(IdPais, Nombre)


--Crear tabla CIUDAD
CREATE TABLE Ciudad(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Ciudad PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdRegion INT NOT NULL,
	CONSTRAINT fk_Ciudad_IdRegion FOREIGN KEY (IdRegion) REFERENCES Region(Id)
)

--Crear indice de la tabla CIUDAD
CREATE UNIQUE INDEX ix_Ciudad_Nombre
	ON Ciudad(IdRegion, Nombre)

--Crear tabla TIPODOCUMENTO
CREATE TABLE TipoDocumento(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_TipoDocumento_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	Sigla VARCHAR(5) NOT NULL
)

--Crear indice de la tabla TIPODOCUMENTO
CREATE UNIQUE INDEX ix_TipoDocumento_Nombre
	ON TipoDocumento(Nombre)

--Crear tabla CLIENTE
CREATE TABLE Cliente(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Cliente PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdTipoDocumento INT NOT NULL,
	CONSTRAINT fk_Cliente_IdTipoDocumento FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento(Id),
	NumeroIdentificacion VARCHAR(20) NOT NULL,
	CodigoPostal VARCHAR(10) NULL,
	FechaNacimiento DATE NULL,
	Direccion VARCHAR(100) NOT NULL,
	IdCiudad INT NOT NULL,
	CONSTRAINT fk_Cliente_IdCiudad FOREIGN KEY (IdCiudad) REFERENCES Ciudad(Id),
	Correo VARCHAR(100) NOT NULL,
	Movil VARCHAR(20) NOT NULL,
	Clave VARCHAR(50) NULL
)

--Crear indices de la tabla CLIENTE
CREATE INDEX ix_Cliente_Nombre
	ON Cliente(Nombre)

CREATE INDEX ix_Cliente_Identificacion
	ON Cliente(IdTipoDocumento, NumeroIdentificacion)

--Crear tabla EMPLEADO
CREATE TABLE Empleado(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Empleado_Id PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdTipoDocumento INT NOT NULL,
	CONSTRAINT fk_Empleado_IdTipoDocumento FOREIGN KEY (IdTipoDocumento) REFERENCES TipoDocumento(Id),
	NumeroIdentificacion VARCHAR(20) NOT NULL,
	Clave VARCHAR(20) NOT NULL
)

--Crear indices de la tabla EMPLEADO
CREATE INDEX ix_Empleado_Nombre
	ON Empleado(Nombre)

CREATE UNIQUE INDEX ix_Empleado_Identificacion
	ON Empleado(IdTipoDocumento, NumeroIdentificacion)

--Crear tabla ESTADOVENTA
CREATE TABLE EstadoVenta(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_EstadoVenta_Id PRIMARY KEY (Id),
	Nombre VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(200) NULL
)

--Crear indice de la tabla ESTADOVENTA
CREATE INDEX ix_EstadoVenta_Nombre
	ON EstadoVenta(Nombre)

--Crear tabla VENTA
CREATE TABLE Venta(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Venta PRIMARY KEY (Id),
	NumeroFactura INT NOT NULL,
	Fecha DATE NOT NULL,
	FechaEntrega DATE NULL,
	IdCliente INT NOT NULL,
	CONSTRAINT fk_Venta_IdCliente FOREIGN KEY (IdCliente) REFERENCES Cliente(Id),
	IdEmpleado INT NOT NULL,
	CONSTRAINT fk_Venta_IdEmpleado FOREIGN KEY (IdEmpleado) REFERENCES Empleado(Id),
	IdEstado INT NOT NULL,
	CONSTRAINT fk_Venta_IdEstado FOREIGN KEY (IdEstado) REFERENCES EstadoVenta(Id)
)

--Crear indice de la tabla VENTA
CREATE UNIQUE INDEX ix_Venta_NumeroFactura
	ON Venta(NumeroFactura)

--Crear tabla TITULO
CREATE TABLE Titulo(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Titulo PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	Año INT NULL,
	Version VARCHAR(20) NOT NULL DEFAULT '1',
	PrecioActual FLOAT NOT NULL DEFAULT 0,
	Existencia INT NOT NULL DEFAULT 0,
	IdDesarrollador INT NOT NULL,
	CONSTRAINT fk_Titulo_IdDesarrollador FOREIGN KEY (IdDesarrollador) REFERENCES Desarrollador(Id)
)

--Crear indice de la tabla TITULO
CREATE UNIQUE INDEX ix_Titulo_Nombre
	ON Titulo(Nombre, Version)

	--Crear tabla VENTADETALLE
CREATE TABLE VentaDetalle(
	IdVenta INT NOT NULL,
	CONSTRAINT fk_VentaDetalle_IdVenta FOREIGN KEY (IdVenta) REFERENCES Venta(Id),
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_VentaDetalle_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	CONSTRAINT pk_VentaDetalle PRIMARY KEY (IdVenta, IdTitulo),
	Cantidad INT NOT NULL,
	Precio DECIMAL(9,2) NOT NULL,
	Descuento DECIMAL(9,2) NOT NULL
)

--Crear tabla PLATAFORMA
CREATE TABLE Plataforma(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Plataforma PRIMARY KEY (Id),
	Nombre VARCHAR(50) NOT NULL,
	Portable BIT NOT NULL,
	Año INT NULL
)

--Crear indice de la tabla PLATAFORMA
CREATE UNIQUE INDEX ix_Plataforma_Nombre
	ON Plataforma(Nombre)

--Crear tabla CATEGORIA
CREATE TABLE Categoria(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Categoria PRIMARY KEY (Id),
	Nombre VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(200) NULL
)

--Crear indice de la tabla CATEGORIA
CREATE UNIQUE INDEX ix_Categoria_Nombre
	ON Categoria(Nombre)

--Crear tabla FORMATO
CREATE TABLE Formato(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Formato PRIMARY KEY (Id),
	Nombre VARCHAR(50) NOT NULL,
	Descripcion VARCHAR(200) NULL
)

--Crear indice de la tabla FORMATO
CREATE UNIQUE INDEX ix_Formato_Nombre
	ON Formato(Nombre)

--Crear tabla TITULOPLATAFORMA
CREATE TABLE TituloPlataforma(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloPlataforma_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdPlataforma INT NOT NULL,
	CONSTRAINT fk_TituloPlataforma_IdPlataforma FOREIGN KEY (IdPlataforma) REFERENCES Plataforma(Id),
	CONSTRAINT pk_TituloPlataforma PRIMARY KEY (IdTitulo, IdPlataforma)
)

--Crear tabla TITULOCATEGORIA
CREATE TABLE TituloCategoria(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloCategoria_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdCategoria INT NOT NULL,
	CONSTRAINT fk_TituloCategoria_IdCategoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(Id),
	CONSTRAINT pk_TituloCategoria PRIMARY KEY (IdTitulo, IdCategoria)
)

--Crear tabla TITULOFORMATO
CREATE TABLE TituloFormato(
	IdTitulo INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdTitulo FOREIGN KEY (IdTitulo) REFERENCES Titulo(Id),
	IdFormato INT NOT NULL,
	CONSTRAINT fk_TituloFormato_IdFormato FOREIGN KEY (IdFormato) REFERENCES Formato(Id),
	CONSTRAINT pk_TituloFormato PRIMARY KEY (IdTitulo, IdFormato)
)