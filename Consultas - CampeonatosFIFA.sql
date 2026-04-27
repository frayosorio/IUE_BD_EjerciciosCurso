--Lista de Campeonatos con Grupos
SELECT C.Campeonato, C.Id IdCampeonato, STRING_AGG(PO.Pais, ', ') AS PaisesOrganizadores,
	G.Id IdGrupo, G.Grupo, PG.Pais
	FROM Campeonato C
		JOIN CampeonatoPais CP ON C.Id = CP.IdCampeonato
		JOIN Pais PO ON CP.IdPais = PO.Id
		LEFT JOIN Grupo G ON G.IdCampeonato=C.Id
		LEFT JOIN GrupoPais GP ON G.Id=GP.IdGrupo
		LEFT JOIN Pais PG ON GP.IdPais=PG.Id
	GROUP BY C.Campeonato, C.Id, G.Id, G.Grupo, PG.Pais
	ORDER BY 1, 3, 4

--Lista de Estadios
SELECT *
	FROM Estadio ES 
		JOIN Ciudad CD ON ES.IdCiudad = CD.Id
		JOIN Pais PE ON CD.IdPais = PE.Id
	WHERE PE.Pais='Rusia'

--Consulta con información completa de cada encuentro
SELECT E.id, E.Fecha, E.IdPais1, P1.Pais Pais1, E.Goles1, E.IdPais2, P2.Pais Pais2, E.Goles2,
	C.Campeonato, E.IdCampeonato, STRING_AGG(PO.Pais, ', ') AS PaisesOrganizadores,
	ES.Estadio+ ' ('+ CD.Ciudad+' - '+ PE.Pais +')' Estadio, E.IdEstadio,
	F.Fase
	FROM Encuentro E
		JOIN Pais P1 ON E.IdPais1 = P1.Id
		JOIN Pais P2 ON E.IdPais2 = P2.Id
		JOIN Campeonato C ON E.IdCampeonato=C.Id

		JOIN CampeonatoPais CP ON C.Id = CP.IdCampeonato
		JOIN Pais PO ON CP.IdPais = PO.Id

		JOIN Estadio ES ON E.IdEstadio = ES.Id
		JOIN Ciudad CD ON ES.IdCiudad = CD.Id
		JOIN Pais PE ON CD.IdPais = PE.Id

		JOIN Fase F ON E.IdFase = F.Id
	WHERE PO.Pais='Rusia'

	GROUP BY E.id, E.Fecha, 
    E.IdPais1, P1.Pais, E.Goles1, E.IdPais2, P2.Pais, E.Goles2,
    C.Campeonato, E.IdCampeonato,
    ES.Estadio, CD.Ciudad, PE.Pais, E.IdEstadio,
    F.Fase
	
	ORDER BY 2;

--13 de junio de 2002 15:30 Costa Rica 	2–5	 Brasil Estadio de la Copa Mundial de Suwon , Suwon
INSERT INTO Encuentro
		(IdPais1, Goles1, IdPais2, Goles2, Fecha, IdEstadio, IdFase, IdCampeonato)
		VALUES(13, 2, 11, 5, '2002-06-13',30, 1, 3)

DELETE FROM Encuentro
	WHERE id=22