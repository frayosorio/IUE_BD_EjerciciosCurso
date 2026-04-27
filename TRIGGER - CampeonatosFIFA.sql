-- Validar los resultados de los partidos
-- No se pueden registrar goles negativos en un encuentro

CREATE OR ALTER TRIGGER trValidarGolesEncuentro
ON Encuentro
AFTER INSERT, UPDATE
AS BEGIN
	IF EXISTS(
		SELECT * FROM INSERTED
			WHERE Goles1<0 OR Goles2<0 OR Penalties1<0 or Penalties2<0
	)
	BEGIN
		RAISERROR('No se permiten goles o penales negativos.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
	END
END
GO

--Evitar que un equipo juegue contra sí mismo
CREATE OR ALTER TRIGGER trValidarEquiposDiferentesEncuentro
ON Encuentro
AFTER INSERT, UPDATE
AS BEGIN
	IF EXISTS(
		SELECT * FROM INSERTED
			WHERE IdPais1 = IdPais2
	)
	BEGIN
		RAISERROR('Un país no puede jugar contra sí mismo.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
	END
END
GO