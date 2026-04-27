--Consultas de INSERCION no permitidas

INSERT INTO encuentro -- Colombia vs Portugal con goles negativos
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (1, 38, 1, 10, 0, '2026-06-27', 5, -1);


INSERT INTO encuentro -- Colombia vs Colombia
    (idpais1, idpais2, idfase, idcampeonato, idestadio, fecha, goles1, goles2)
    VALUES (1, 1, 1, 10, 0, '2026-06-27', 2, 1);