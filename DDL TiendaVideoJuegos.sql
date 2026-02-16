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

--Crear tabla DESARROLLADOR
CREATE TABLE Desarrollador(
	Id INT IDENTITY NOT NULL,
	CONSTRAINT pk_Desarrolador PRIMARY KEY (Id),
	Nombre VARCHAR(100) NOT NULL,
	IdPais INT NOT NULL,
	CONSTRAINT fk_Desarrollador_Pais FOREIGN KEY (IdPais) REFERENCES Pais(Id)
)



