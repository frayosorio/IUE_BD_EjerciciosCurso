SELECT *
	FROM Pais
	WHERE Nombre='Colombia'

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