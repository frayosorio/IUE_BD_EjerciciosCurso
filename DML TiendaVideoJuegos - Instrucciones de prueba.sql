SELECT *
	FROM Pais
	WHERE Nombre='Colombia'

SELECT *
	FROM Pais
	WHERE Id=392

SELECT *
	FROM Pais
	WHERE LEFT(Nombre, 2)='CO'

SELECT *
	FROM Pais
	WHERE RIGHT(Nombre, 3)='NIA'

SELECT *
	FROM Region

SELECT *
	FROM Region
		JOIN Pais ON Region.IdPais=Pais.Id

INSERT INTO Pais
	(Nombre, CodigoAlfa, Indicativo)
	VALUES ('Antioquia Federal', 'ANT', '57')

UPDATE Pais
	SET Nombre='República Federal de Antioquia'
	WHERE Id=1

INSERT INTO Region 
	(Nombre, IdPais, Codigo)
	VALUES('Estado de Urabá', 1, 'UR')

DELETE FROM Region

DELETE FROM Pais
	WHERE Id=1


SELECT *
	FROM Plataforma

SELECT * FROM Categoria

SELECT *
	FROM Desarrollador
		JOIN Pais ON Desarrollador.IdPais = Pais.Id
	WHERE Pais.Id = 392

SELECT T.Nombre Titulo, D.Nombre EmpresaDesarrolladora, P.Nombre Pais
	FROM Titulo T
		JOIN Desarrollador D ON T.IdDesarrollador = D.Id
		JOIN Pais P ON D.IdPais = P.Id

SELECT * FROM TipoDocumento

SELECT * 
	FROM Ciudad C
		JOIN Region R ON C.IdRegion = R.Id
		JOIN Pais P ON R.IdPais = P.Id

SELECT C.Nombre Cliente, P.Nombre Pais
	FROM Cliente C
		JOIN Ciudad CD ON C.IdCiudad = CD.Id
		JOIN Region R ON CD.IdRegion = R.Id
		JOIN Pais P ON R.IdPais = P.Id

SELECT *
	FROM Empleado

SELECT *
	FROM EstadoVenta

--Listado de Ventas
SELECT V.NumeroFactura, V.Fecha, C.Nombre NombreCliente, TD.Sigla+' '+C.NumeroIdentificacion IdentificacionCliente,
	E.Nombre NombreEmpleado, TDE.Sigla+' '+E.NumeroIdentificacion IdetificacionEmpleado,
	EV.Nombre Estado
	FROM Venta V
		JOIN Cliente C ON C.Id = V.IdCliente
		JOIN TipoDocumento TD ON TD.Id = C.IdTipoDocumento
		JOIN Empleado E ON E.Id = V.IdEmpleado
		JOIN TipoDocumento TDE ON TDE.Id = E.IdTipoDocumento
		JOIN EstadoVenta EV ON EV.Id = V.IdEstado
	WHERE EV.Nombre='Confirmada'

--Listar cuantas ventas hay por cada estado de venta
SELECT EV.Nombre Estado, COUNT(*) TotalVentas
	FROM Venta V
		JOIN EstadoVenta EV ON EV.Id = V.IdEstado
	GROUP BY EV.Nombre

--Listar cuantas ventas hay por cada cliente
SELECT C.Nombre NombreCliente, TD.Sigla+' '+C.NumeroIdentificacion IdentificacionCliente,
	COUNT(*) TotalVentas
	FROM Venta V
		JOIN Cliente C ON C.Id = V.IdCliente
		JOIN TipoDocumento TD ON TD.Id = C.IdTipoDocumento
	GROUP BY C.Nombre, TD.Sigla, C.NumeroIdentificacion

--Listar el valor total de lo comprtado por cada cliente
SELECT C.Nombre NombreCliente, TD.Sigla+' '+C.NumeroIdentificacion IdentificacionCliente,
	SUM(VD.Cantidad*VD.Precio-VD.Descuento) ValorVenta
	FROM Venta V
		JOIN Cliente C ON C.Id = V.IdCliente
		JOIN TipoDocumento TD ON TD.Id = C.IdTipoDocumento
		JOIN VentaDetalle VD ON V.Id = VD.IdVenta
	GROUP BY C.Nombre, TD.Sigla, C.NumeroIdentificacion
	ORDER BY 3 DESC

