-- Ciudades y estadios
-- 1: Saransk       - 1: Mordovia Arena
-- 2: Moscú         - 2: Otkrytie Arena
-- 3: Ekaterimburgo - 3: Ekaterimburgo Arena
-- 4: Kazán         - 4: Kazán Arena
-- 5: Volgogrado    - 5: Volgogrado Arena
-- 6: Samara        - 6: Samara Arena

--Declaracion de variables
DECLARE @nuevoIdPais int,
	@idRusia int,
	@nuevoIdCampeonato int,
	@nuevoIdCiudad int,
	@nuevoIdEstadio int,
	@idCiudad1 int, @idCiudad2 int, @idCiudad3 int, @idCiudad4 int, @idCiudad5 int, @idCiudad6 int,
	@idEstadio1 int, @idEstadio2 int, @idEstadio3 int, @idEstadio4 int,
	@idEstadio5 int, @idEstadio6 int, 
	@nuevoIdGrupo int,
	@idPais1Grupo int, @idPais2Grupo int, @idPais3Grupo int, @idPais4Grupo int,
	@totalPaises int,
	@nuevoIdEncuentro int;

--Obtener el Id de un nuevo PAIS
SELECT @nuevoIdPais=MAX(Id)+1
	FROM Pais;

--***** Agregar el Campeonato ****

SELECT @idRusia=Id 
	FROM Pais 
	WHERE Pais='Rusia';
IF @idRusia IS NULL --Verifica si 'Rusia' no está en la base de datos
BEGIN
	SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico
	INSERT INTO Pais
		(Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Rusia', 'Unión del Fútbol de Rusia');
	SET IDENTITY_INSERT Pais OFF
	SET @idRusia = @nuevoIdPais;
	SET @nuevoIdPais = @nuevoIdPais + 1;
END

--validar si ya está el campeonato
SELECT @nuevoIdCampeonato=Id 
    FROM Campeonato
    WHERE Campeonato='FIFA World Cup 2018';
IF @nuevoIdCampeonato IS NULL --Verifica si el campeonato no está en la base de datos
BEGIN
	INSERT INTO Campeonato
		(Campeonato, Año)
		VALUES('FIFA World Cup 2018', 2022);
	SELECT @nuevoIdCampeonato=Id 
		FROM Campeonato
		WHERE Campeonato='FIFA World Cup 2018';
	INSERT INTO CampeonatoPais
		(IdCampeonato, IdPais)
		VALUES(@nuevoIdCampeonato, @idRusia)	
END

--***** Agregar las ciudades de los encuentros *****

--Obtener el Id de una nueva CIUDAD
SELECT @nuevoIdCiudad=MAX(Id)+1
	FROM Ciudad;

--Obtener el Id de un nuevo ESTADIO
SELECT @nuevoIdEstadio=MAX(Id)+1
        FROM Estadio;

SELECT @idEstadio1=id
	FROM Estadio 
	WHERE Estadio='Mordovia Arena';
IF @idEstadio1 IS NULL --Verifica si 'Mordovia Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad1=id  FROM ciudad WHERE ciudad='Saransk';
    IF @idCiudad1 IS NULL  --Verifica si 'Saransk' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Saransk', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad1 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Mordovia Arena', 41685, @idCiudad1);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio1 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio2=id
	FROM Estadio 
	WHERE Estadio='Otkrytie Arena';
IF @idEstadio2 IS NULL --Verifica si 'Otkrytie Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad2=id  FROM ciudad WHERE ciudad='Moscú';
    IF @idCiudad2 IS NULL  --Verifica si 'Moscú' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Moscú', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad2 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Otkrytie Arena', 44190, @idCiudad2);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio2 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio3=id
	FROM Estadio 
	WHERE Estadio='Ekaterimburgo Arena';
IF @idEstadio3 IS NULL --Verifica si 'Ekaterimburgo Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad3=id  FROM ciudad WHERE ciudad='Ekaterimburgo';
    IF @idCiudad3 IS NULL  --Verifica si 'Ekaterimburgo' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Ekaterimburgo', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad3 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Ekaterimburgo Arena', 33061, @idCiudad3);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio3 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio4=id
	FROM Estadio 
	WHERE Estadio='Kazán Arena';
IF @idEstadio4 IS NULL --Verifica si 'Kazán Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad4=id  FROM ciudad WHERE ciudad='Kazán';
    IF @idCiudad4 IS NULL  --Verifica si 'Kazán' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Kazán', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad4 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Kazán Arena', 42873, @idCiudad4);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio4 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio5=id
	FROM Estadio 
	WHERE Estadio='Volgogrado Arena';
IF @idEstadio5 IS NULL --Verifica si 'Volgogrado Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad5=id  FROM ciudad WHERE ciudad='Volgogrado';
    IF @idCiudad5 IS NULL  --Verifica si 'Volgogrado' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Volgogrado', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad5 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Volgogrado Arena', 43713, @idCiudad5);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio5 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

SELECT @idEstadio6=id
	FROM Estadio 
	WHERE Estadio='Samara Arena';
IF @idEstadio6 IS NULL --Verifica si 'Samara Arena' no está en la base de datos
BEGIN
	SELECT @idCiudad6=id  FROM ciudad WHERE ciudad='Samara';
    IF @idCiudad6 IS NULL  --Verifica si 'Samara' no está en la base de datos
		BEGIN
			SET IDENTITY_INSERT Ciudad ON --Obliga a reemplazar el Id autonumérico
			INSERT INTO Ciudad
				(id, Ciudad, IdPais) VALUES(@nuevoIdCiudad, 'Samara', @idRusia);
			SET IDENTITY_INSERT Ciudad OFF
			SET @idCiudad6 = @nuevoIdCiudad;
			SET @nuevoIdCiudad = @nuevoIdCiudad + 1;
		END;

	--Agregar ESTADIO
    SET IDENTITY_INSERT Estadio ON;
    INSERT INTO Estadio 
		(Id, Estadio, Capacidad, IdCiudad) VALUES (@nuevoIdEstadio, 'Samara Arena', 43713, @idCiudad6);
    SET IDENTITY_INSERT Estadio OFF;
    SET @idEstadio6 = @nuevoIdEstadio;
	SET @nuevoIdEstadio = @nuevoIdEstadio + 1;
END;

--***** Validar si ya estan los grupos *****
SELECT @nuevoIdGrupo=id 
    FROM Grupo
    WHERE IdCampeonato = @nuevoIdCampeonato
        AND Grupo='A';
IF @nuevoIdGrupo IS NULL --Los grupos no estan
BEGIN
	SELECT @nuevoIdGrupo=MAX(Id)+1 FROM Grupo;
	SET IDENTITY_INSERT Grupo ON;
	INSERT INTO Grupo
		(Id, Grupo, IdCampeonato)
		VALUES
		(@nuevoIdGrupo, 'A', @nuevoIdCampeonato),
		(@nuevoIdGrupo+1, 'B', @nuevoIdCampeonato),
		(@nuevoIdGrupo+2, 'C', @nuevoIdCampeonato),
		(@nuevoIdGrupo+3, 'D', @nuevoIdCampeonato),
		(@nuevoIdGrupo+4, 'E', @nuevoIdCampeonato),
		(@nuevoIdGrupo+5, 'F', @nuevoIdCampeonato),
		(@nuevoIdGrupo+6, 'G', @nuevoIdCampeonato),
		(@nuevoIdGrupo+7, 'H', @nuevoIdCampeonato);
	SET IDENTITY_INSERT Grupo OFF;
END

--***** Validar si ya están los Paises del Grupo H *****

SET IDENTITY_INSERT Pais ON --Obliga a reemplazar el Id autonumérico

SELECT @idPais1Grupo=id  FROM Pais WHERE pais='Colombia';
IF @idPais1Grupo IS NULL --verifica si 'Ecuador' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Colombia', '');
    SET @idPais1Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais2Grupo=id  FROM Pais WHERE pais='Japón';
IF @idPais2Grupo IS NULL --verifica si 'Ecuador' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Japón', '');
    SET @idPais2Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais3Grupo=id  FROM Pais WHERE pais='Polonia';
IF @idPais3Grupo IS NULL --verifica si 'Senegal' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Polonia', '');
    SET @idPais3Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @idPais4Grupo=id  FROM Pais WHERE pais='Senegal';
IF @idPais4Grupo IS NULL --verifica si 'Países Bajos' no existe en la base de datos
BEGIN
    INSERT INTO Pais
        (Id, Pais, Entidad) VALUES(@nuevoIdPais, 'Senegal', '');
    SET @idPais4Grupo = @nuevoIdPais;
    SET @nuevoIdPais = @nuevoIdPais + 1;
END;

SELECT @totalPaises=COUNT(*)
    FROM GrupoPais
    WHERE IdGrupo=@nuevoIdGrupo+7;

IF @totalPaises=0
BEGIN
	INSERT INTO GrupoPais
		(IdGrupo, IdPais)
		VALUES
		(@nuevoIdGrupo+7, @idPais1Grupo),
		(@nuevoIdGrupo+7, @idPais2Grupo),
		(@nuevoIdGrupo+7, @idPais3Grupo),
		(@nuevoIdGrupo+7, @idPais4Grupo)
END

SET IDENTITY_INSERT Pais OFF



--***** Validar si ya estan los Encuentros de la Fase de Grupos del Grupo H *****

-- Colombia vs Japón
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais1Grupo AND IdPais2=@idPais2Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais1Grupo, 1, @idPais2Grupo, 2, '20180619', @idEstadio1, 1, @nuevoIdCampeonato);
END

-- Polonia vs Senegal
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais3Grupo AND IdPais2=@idPais4Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais3Grupo, 1, @idPais4Grupo, 2, '20180619', @idEstadio2, 1, @nuevoIdCampeonato);
END

-- Japón vs Senegal
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais2Grupo AND IdPais2=@idPais4Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais2Grupo, 2, @idPais4Grupo, 2, '20180624', @idEstadio3, 1, @nuevoIdCampeonato);
	SET @nuevoIdEncuentro=@nuevoIdEncuentro+1;
END

-- Polonia vs Colombia
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais3Grupo AND IdPais2=@idPais1Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais3Grupo, 0, @idPais1Grupo, 3, '20180624', @idEstadio4, 1, @nuevoIdCampeonato);
END

-- Japón vs Polonia
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais2Grupo AND IdPais2=@idPais3Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais2Grupo, 0, @idPais3Grupo, 1, '20180628', @idEstadio5, 1, @nuevoIdCampeonato);
END

-- Senegal vs Colombia
IF NOT EXISTS(SELECT * FROM Encuentro
			WHERE IdPais1=@idPais4Grupo AND IdPais2=@idPais1Grupo
				AND IdCampeonato=@nuevoIdCampeonato AND IdFase=1)
BEGIN
	INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(@idPais4Grupo, 0, @idPais1Grupo, 1, '20180628', @idEstadio6, 1, @nuevoIdCampeonato);
END


