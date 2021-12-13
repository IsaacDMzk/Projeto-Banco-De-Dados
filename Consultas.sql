-- 1- Encontre os animes que o usuário com o nick "Diow Mizuk" assiste
SELECT A.titulo 
FROM ANIMES A
WHERE A.titulo IN (SELECT UA.titulo_anime
		FROM USUARIO_ASSISTE_ANIMES UA
                WHERE UA.nick_usuario = 'Diow Mizuk' );
                
                
-- 2- Encontre o nome do usuario mais novo
SELECT U.nick
FROM USUARIO U
WHERE U.idade <= ALL (SELECT U2.idade
		    FROM USUARIO U2);
                    
			

-- 3- Encontre o nick dos usuarios que já assistiram o anime "86: Eighty Six"
SELECT U.nick
FROM USUARIO U
WHERE U.nick IN ( SELECT UA.nick_usuario
		FROM USUARIO_ASSISTE_ANIMES UA
                WHERE UA.titulo_anime = '86: Eighty Six');
                

-- 4- Encontre o titulo dos mangás que tiveram seu primeiro volume lançado antes de 2010
SELECT M.titulo
FROM MANGAS M
WHERE M.titulo IN ( SELECT V.titulo_manga
		    FROM VOLUMES V
                    WHERE V.ano_de_publicacao <= 2010);
  
  
-- 5- Encontre o nome do dublador que não faz parte de nenhum estudio de publicação  
SELECT D.nome_completo
FROM DUBLADOR D
WHERE NOT EXISTS( SELECT ED.email_dublador
		FROM ESTUDIOPUBLI_DUBLADORES ED
                WHERE ED.email_dublador = D.email);
                    

-- 6 - Encontre o nick e o nome dos usuarios que não participam de nenhum clube
SELECT U.nick,U.nome
FROM USUARIO U
WHERE NOT EXISTS(SELECT UC.nick_usuario
		FROM USUARIO_PARTICIPA_DE_CLUBES UC
                WHERE UC.nick_usuario = U.nick);


-- 7 - Econtre o nome e a descricao dos clubes que possuem mais de dois usuários
SELECT C.nome,C.descricao
FROM CLUBES C
WHERE C.ID IN ( SELECT UC.ID_clube
		FROM USUARIO_PARTICIPA_DE_CLUBES UC
                GROUP BY UC.nick_usuario
                HAVING COUNT(UC.nick_usuario) >= 2);
                

-- 8-  Encontre os animes que possuem mais de 80 episodios
SELECT A.titulo
FROM ANIMES A
WHERE A.titulo IN ( SELECT E.titulo_anime
	      	FROM EPISODIOS E
                WHERE E.numero_de_episodios > 80);
                    

-- 9 - Encontre as equipe de animadores que fazem parte de mais de um estudio de publicação
SELECT E.nome_da_equipe
FROM EQUIPE_DE_ANIMADORES E
WHERE E.ID_da_equipe IN (SELECT EA.ID_equipe
			FROM ESTUDIOPUBLI_EQUIPEANIMADORES EA
			GROUP BY EA.ID_equipe
                        HAVING COUNT(EA.ID_equipe) >=2);
               
               
-- 10 - Encontre os animes que tiveram sua primeira temporada lançada antes de 2019 e possuem mais de 1 temporada              
SELECT A.titulo
FROM ANIMES A
WHERE A.titulo IN ( SELECT T.titulo_anime
		    FROM TEMPORADAS T
                    WHERE T.ano_de_publicacao < 2019 AND T.numero_de_temporadas > 1);
