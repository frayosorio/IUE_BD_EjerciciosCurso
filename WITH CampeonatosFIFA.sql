--Listar los grupos y paises de RUSIA 2028
SELECT C.Campeonato, C.Id IdCampeonato, STRING_AGG(PO.Pais, ', ') AS PaisesOrganizadores,
	G.Id IdGrupo, G.Grupo, PG.Pais, GP.IdPais
	FROM Campeonato C
		JOIN CampeonatoPais CP ON C.Id = CP.IdCampeonato
		JOIN Pais PO ON CP.IdPais = PO.Id
		LEFT JOIN Grupo G ON G.IdCampeonato=C.Id
		LEFT JOIN GrupoPais GP ON G.Id=GP.IdGrupo
		LEFT JOIN Pais PG ON GP.IdPais=PG.Id
	WHERE PO.Pais='Rusia'
	GROUP BY C.Campeonato, C.Id, G.Id, G.Grupo, PG.Pais, GP.IdPais
	ORDER BY 1, 3, 4

--Agregar grupos al Campeonato Rusia
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'A');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'B');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'C');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'D');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'E');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'F');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'G');
INSERT INTO grupo
    (idcampeonato, grupo) VALUES(10, 'H');  

--Agregar los paises al grupo H
INSERT INTO GrupoPais
	(IdGrupo, IdPais)
	SELECT G.Id, P.Id --,  G.Grupo, P.Pais
		FROM Grupo G, Pais P
			WHERE G.Grupo='H' AND G.IdCampeonato=10
				AND P.Pais IN ('Colombia', 'Japón', 'Polonia', 'Senegal')

-- listar los encuentros del grupo H del Campeonato FIFA RUSIA 2018
SELECT P1.pais, E.goles1, E.goles2, P2.pais, E.fecha
    FROM encuentro E
        JOIN pais P1 ON E.idpais1=P1.id
        JOIN pais P2 ON E.idpais2=P2.id
    WHERE idcampeonato=10
        AND idfase=1
        AND (idpais1 IN (SELECT GP.idpais
                            FROM grupopais GP
                                JOIN pais P ON GP.idpais=P.id
                            WHERE GP.idgrupo=34)
             OR idpais2 IN (SELECT GP.idpais
                            FROM grupopais GP
                                JOIN pais P ON GP.idpais=P.id
                            WHERE GP.idgrupo=34)
             )

-- agregar los encuentros 
INSERT INTO encuentro -- Colombia vs Japón
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (1, 5, 1, 10, 0, '2018-06-19', 1, 2);
INSERT INTO encuentro -- Polonia vs Senegal
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (64, 61, 1, 10, 0, '2018-06-19', 1, 2);
INSERT INTO encuentro -- Japón vs Senegal
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (5, 61, 1, 10, 0, '2018-06-24', 2, 2);
INSERT INTO encuentro -- Polonia vs Colombia
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (64, 1, 1, 10, 0, '2018-06-24', 0, 3);
INSERT INTO encuentro -- Japoón vs Polonia
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (5, 64, 1, 10, 0, '2018-06-28', 0, 1);
INSERT INTO encuentro -- Senegal vs Colombia
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (61, 1, 1, 10, 0, '2018-06-28', 0, 1);

-- ***** Obtener la tabla de pociciones de un grupo ******

WITH Resultados AS (
	SELECT GP.IdPais,
        COUNT(*) PJ,
        SUM(CASE WHEN ((E.IdPais1=GP.IdPais AND E.Goles1>E.Goles2) OR 
				(E.IdPais2=GP.IdPais AND E.Goles2>E.Goles1))
			THEN 1
			ELSE 0
			END) PG,
        SUM(CASE WHEN E.Goles1=E.Goles2
			THEN 1
			ELSE 0
			END) PE,
        SUM(CASE WHEN ((E.IdPais1=GP.IdPais AND E.Goles1<E.Goles2) OR 
				(E.IdPais2=GP.IdPais AND E.Goles2<E.Goles1))
			THEN 1
			ELSE 0
			END) PP,
        SUM(CASE WHEN E.IdPais1 = GP.IdPais THEN E.Goles1 ELSE E.Goles2 END) GF,
		SUM(CASE WHEN E.IdPais1 = GP.IdPais THEN E.Goles2 ELSE E.Goles1 END) GC
        FROM Grupo G
			JOIN GrupoPais GP ON GP.IdGrupo=G.Id
            JOIN Encuentro E 
                ON G.IdCampeonato=E.IdCampeonato 
                    AND E.IdFase=1
                    AND (GP.IdPais=E.IdPais1 OR GP.IdPais=E.IdPais2)
        WHERE G.Id=34
        GROUP BY GP.IdPais
    ),
    Posiciones AS (
        SELECT ROW_NUMBER() OVER (ORDER BY R.PG*3+R.PE DESC, R.GF-R.GC DESC, R.GF DESC) Posicion,
            P.Pais, R.PJ, R.PG, R.PE, R.PP, R.GF, R.GC, 
            R.GF-R.GC Diferencia, R.PG*3+R.PE Puntos
            FROM Resultados R
                JOIN Pais P ON R.IdPais=P.Id
    )
    SELECT *
        FROM Posiciones
