--Listar las ciudades Capital Región
SELECT *
	FROM vwCiudades
	WHERE Pais='Colombia'
		AND Region='Antioquia'
		AND CapitalRegion=1

--Listar las ciudades Capital País
SELECT *
	FROM vwCiudades
	WHERE Pais='Colombia'
		AND CapitalPais=1


SELECT *
	FROM vwCiudades
	WHERE Ciudad LIKE '%Bogo%'

--Consultar Departamentos con sus capitales 
SELECT R.Nombre Departamento,
	CASE WHEN EXISTS(SELECT * FROM Ciudad WHERE IdRegion=R.Id AND CapitalRegion=1)
		THEN (SELECT TOP 1 Nombre FROM Ciudad WHERE IdRegion=R.Id AND CapitalRegion=1)
	ELSE
		'** SIN CAPITAL **'
	END Capital
	FROM Pais P 
		JOIN Region R ON P.Id=R.IdPais
	WHERE P.Nombre='Colombia' 

--Colocar las capitales de Región correctas
UPDATE Ciudad SET  CapitalRegion=1 WHERE Id=1 --'Amazonas ' : 'Leticia'
UPDATE Ciudad SET  CapitalRegion=1 WHERE Id=72 --'Antioquia' : 'Medellín'
UPDATE Ciudad SET  CapitalRegion=1 WHERE Id=129 --'Arauca' : 'Arauca'
UPDATE Ciudad SET  CapitalRegion=1 WHERE Id=139 --'Atlántico' : 'Barranquilla'


--Hacer capital de 'Antioquia' a 'Envigado'
UPDATE Ciudad
	SET  CapitalRegion=1
	WHERE Id=49

--Hacer capital de 'Antioquia' a todas las ciudades (**ERROR**)
UPDATE Ciudad
	SET  CapitalRegion=1
	WHERE IdRegion=2

--Hacer capital de 'Antioquia' a 'Medellín', 'Envigado' y 'Rionegro' (**ERROR**)
UPDATE Ciudad
	SET  CapitalRegion=1
	WHERE Id IN (49, 72, 88)

--Quitar todas las capitales de region de la region con Id=1
UPDATE Ciudad
	SET  CapitalRegion=0
	WHERE IdRegion=1

--Hacer todos los municipios capitales de departamentos de 'COLOMBIA' (**ERROR**)
UPDATE Ciudad
	SET CapitalRegion=1
	FROM Pais P 
		JOIN Region R ON P.Id=R.IdPais
		JOIN Ciudad C ON C.IdRegion=R.Id
	WHERE P.Nombre='Colombia'

--Hacer todos los municipios capitales del país de 'COLOMBIA' (**ERROR**)
UPDATE Ciudad
	SET CapitalPais=1
	FROM Pais P 
		JOIN Region R ON P.Id=R.IdPais
		JOIN Ciudad C ON C.IdRegion=R.Id
	WHERE P.Nombre='Colombia'

--Hacer 'Medellin' la capital del país 'Colombia'
UPDATE Ciudad SET CapitalPais=1 WHERE Id=72 


--Hacer 'Bogotá' la capital del país 'Colombia'
UPDATE Ciudad SET CapitalPais=1 WHERE Id=541
