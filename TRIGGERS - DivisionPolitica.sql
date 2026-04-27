CREATE OR ALTER TRIGGER trActualizarCapitalRegion
ON Ciudad
FOR INSERT, UPDATE
AS
BEGIN
	WITH UltimaCapital AS (
		SELECT Id, IdRegion
			FROM inserted
			WHERE CapitalRegion=1
	)
	UPDATE C
		SET C.CapitalRegion = CASE WHEN C.Id=U.Id
									THEN 1
								ELSE 0
								END
		FROM Ciudad C
			JOIN UltimaCapital U ON U.IdRegion=C.IdRegion
END
GO

CREATE OR ALTER TRIGGER trActualizarCapitalPais
ON Ciudad
FOR INSERT, UPDATE
AS
BEGIN
	-- Evitar ejecución recursiva del trigger
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;
	
	WITH UltimaCapitalPais AS (
		SELECT C.Id, R.IdPais
			FROM Inserted I
				JOIN Ciudad C ON I.Id = C.Id
				JOIN Region R ON C.IdRegion = R.Id
			WHERE I.CapitalPais = 1
	)
	UPDATE C
		SET C.CapitalPais = CASE WHEN C.Id=U.Id
									THEN 1
								ELSE 0
								END
		FROM Ciudad C
			JOIN Region R ON C.IdRegion = R.Id
			JOIN UltimaCapitalPais U ON U.IdPais=R.IdPais
END
GO

