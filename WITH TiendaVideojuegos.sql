-- Obtener los clientes que más han comprado

WITH TotalesVentasCliente AS (
	SELECT TD.Sigla+'-'+C.NumeroIdentificacion IdentificacionCliente, C.Nombre NombreCliente,
		SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
		FROM Venta V
			JOIN VentaDetalle VD ON V.Id=VD.IdVenta
			JOIN Cliente C ON C.Id=V.IdCliente
			JOIN TipoDocumento TD ON C.IdTipoDocumento=TD.Id
		GROUP BY C.Nombre, TD.Sigla, C.NumeroIdentificacion
	),
	MayorValorComprado AS (
		SELECT MAX(TotalVenta) TotalVentaMaxima
			FROM TotalesVentasCliente
	)
	SELECT *
		FROM TotalesVentasCliente
		WHERE TotalVenta = (SELECT TotalVentaMaxima FROM MayorValorComprado)

--version sin subconsulta
WITH TotalesVentasCliente AS (
	SELECT TD.Sigla+'-'+C.NumeroIdentificacion IdentificacionCliente, C.Nombre NombreCliente,
		SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
		FROM Venta V
			JOIN VentaDetalle VD ON V.Id=VD.IdVenta
			JOIN Cliente C ON C.Id=V.IdCliente
			JOIN TipoDocumento TD ON C.IdTipoDocumento=TD.Id
		GROUP BY C.Nombre, TD.Sigla, C.NumeroIdentificacion
	),
	MayorValorComprado AS (
		SELECT MAX(TotalVenta) TotalVentaMaxima
			FROM TotalesVentasCliente
	)
	SELECT *
		FROM TotalesVentasCliente TV
			JOIN MayorValorComprado MV ON TV.TotalVenta=MV.TotalVentaMaxima

-- Obtener el top 5 de los clientes que más han comprado
WITH TotalesVentasCliente AS (
	SELECT TD.Sigla+'-'+C.NumeroIdentificacion IdentificacionCliente, C.Nombre NombreCliente,
		SUM(VD.Cantidad*VD.Precio-VD.Descuento) TotalVenta
		FROM Venta V
			JOIN VentaDetalle VD ON V.Id=VD.IdVenta
			JOIN Cliente C ON C.Id=V.IdCliente
			JOIN TipoDocumento TD ON C.IdTipoDocumento=TD.Id
		GROUP BY C.Nombre, TD.Sigla, C.NumeroIdentificacion
	)
	SELECT *
		FROM (
			SELECT *,
				RANK() OVER (ORDER BY TotalVenta DESC) AS Puesto
				FROM TotalesVentasCliente
			) TablaRanking
		WHERE Puesto<=5