DROP TABLE IF EXISTS USUARIO_PARTICIPA_DE_CLUBES;
DROP TABLE IF EXISTS USUARIO_ASSISTE_ANIMES;
DROP TABLE IF EXISTS USUARIO_LE_MANGAS;
DROP TABLE IF EXISTS ESTUDIO_PUBLICACAO_TEM_DESENHISTA;
DROP TABLE IF EXISTS ESTUDIOPUBLI_EQUIPEANIMADORES;
DROP TABLE IF EXISTS ESTUDIOPUBLI_DUBLADORES;
DROP TABLE IF EXISTS EPISODIOS;
DROP TABLE IF EXISTS CAPITULOS;
DROP TABLE IF EXISTS VOLUMES;
DROP TABLE IF EXISTS TEMPORADAS;
DROP TABLE IF EXISTS ANIMES;
DROP TABLE IF EXISTS MANGAS;

DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS CLUBES;
DROP TABLE IF EXISTS ESTUDIO_DE_PUBLICACAO;
DROP TABLE IF EXISTS DESENHISTA;
DROP TABLE IF EXISTS DUBLADOR;
DROP TABLE IF EXISTS EQUIPE_DE_ANIMADORES;


-- Entidades
CREATE TABLE USUARIO(
nick VARCHAR(20),
    nome VARCHAR(100),
    genero ENUM('Masculino','Feminino','Não especificado'),
	idade INTEGER,
    PRIMARY KEY(nick)
);

CREATE TABLE CLUBES(
ID INTEGER,
    nome VARCHAR(100),
    descricao VARCHAR(300),
    PRIMARY KEY(ID)
);

CREATE TABLE ESTUDIO_DE_PUBLICACAO(
CNPJ INTEGER,
    nome VARCHAR(50),
    endereco VARCHAR(100),
    PRIMARY KEY(CNPJ)
);

CREATE TABLE DESENHISTA(
email VARCHAR(100),
    nome_completo VARCHAR(50),
    telefone_de_contato VARCHAR(20),
    PRIMARY KEY(email)
);

CREATE TABLE DUBLADOR(
email VARCHAR(100),
    nome_completo VARCHAR(50),
    telefone_de_contato VARCHAR(20),
    PRIMARY KEY(email)
);

CREATE TABLE EQUIPE_DE_ANIMADORES(
ID_da_equipe INTEGER,
    nome_da_equipe VARCHAR(50),
    telefone_de_contato VARCHAR(20),
    PRIMARY KEY(ID_da_equipe)
);


CREATE TABLE ANIMES(
titulo VARCHAR(50),
    condicao ENUM ('Completed','Watching','Plan To Watch','On Hold','Droped'),
    autor VARCHAR(50),
    anime_estdPubli INTEGER,
    FOREIGN KEY (anime_estdPubli) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    PRIMARY KEY(titulo)
);

CREATE TABLE MANGAS(
titulo VARCHAR(50),
    condicao ENUM ('Completed','Reading','Plan to Read','On Hold','Droped'),
    autor VARCHAR(50),
    manga_estdPubli INTEGER,
    FOREIGN KEY (manga_estdPubli) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    PRIMARY KEY(titulo)
);

CREATE TABLE VOLUMES(
numero_do_volume INTEGER,
    ano_de_publicacao INTEGER,
    ano_de_encerramento INTEGER,
    titulo_manga VARCHAR(50),
    PRIMARY KEY(titulo_manga,numero_do_volume),
    FOREIGN KEY (titulo_manga) REFERENCES MANGAS(titulo) ON DELETE CASCADE
);

CREATE TABLE CAPITULOS(
numero_do_capitulo INTEGER,
    titulo VARCHAR(50),
    ano_de_publicacao INTEGER,
    tituloManga VARCHAR(50),
    numero_volume INTEGER,
	PRIMARY KEY(tituloManga,numero_volume,numero_do_capitulo),
    FOREIGN KEY(tituloManga,numero_volume) REFERENCES VOLUMES(titulo_manga,numero_do_volume) ON DELETE CASCADE
);


CREATE TABLE TEMPORADAS(
	numero_da_temporada INTEGER,
	ano_de_publicacao INTEGER,
    ano_de_encerramento INTEGER,
    titulo_anime VARCHAR(50),
    PRIMARY KEY(numero_da_temporada,titulo_anime),
    FOREIGN KEY(titulo_anime) REFERENCES ANIMES(titulo) ON DELETE CASCADE
);

CREATE TABLE EPISODIOS(
numero_do_episodio INTEGER,
    titulo VARCHAR(50),
    ano_de_publicacao INTEGER,
    titulo_anime VARCHAR(50),
    temp_ep INTEGER,
    PRIMARY KEY(numero_do_episodio,titulo_anime,temp_ep),
    FOREIGN KEY (titulo_anime,temp_ep) REFERENCES TEMPORADAS(titulo_anime,numero_da_temporada) ON DELETE CASCADE
);



-- Relações
CREATE TABLE USUARIO_PARTICIPA_DE_CLUBES(
nick_usuario VARCHAR(20),
    ID_clube INTEGER,
    
    FOREIGN KEY (nick_usuario) REFERENCES USUARIO(nick),
    FOREIGN KEY (ID_clube) REFERENCES CLUBES(ID),
    PRIMARY KEY (nick_usuario,ID_clube)
);

CREATE TABLE USUARIO_ASSISTE_ANIMES(
nick_usuario VARCHAR(20),
    titulo_anime VARCHAR(50),
    
    FOREIGN KEY (nick_usuario) REFERENCES USUARIO(nick),
    FOREIGN KEY (titulo_anime) REFERENCES ANIMES(titulo),
    PRIMARY KEY (nick_usuario,titulo_anime)
);

CREATE TABLE USUARIO_LE_MANGAS(
nick_usuario VARCHAR(20),
    titulo_manga VARCHAR(50),
    
    FOREIGN KEY (nick_usuario) REFERENCES USUARIO(nick),
    FOREIGN KEY (titulo_manga) REFERENCES MANGAS(titulo),
    PRIMARY KEY (nick_usuario,titulo_manga)
);


CREATE TABLE ESTUDIO_PUBLICACAO_TEM_DESENHISTA(
CNPJ_estudio INTEGER,
    email_desenhista VARCHAR(100),
    
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    FOREIGN KEY(email_desenhista) REFERENCES DESENHISTA(email),
    PRIMARY KEY(CNPJ_estudio,email_desenhista)
);

CREATE TABLE ESTUDIOPUBLI_EQUIPEANIMADORES(
CNPJ_estudio INTEGER,
    ID_equipe INTEGER,
    
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    FOREIGN KEY(ID_equipe) REFERENCES EQUIPE_DE_ANIMADORES(ID_da_equipe),
    PRIMARY KEY(CNPJ_estudio,ID_equipe)
);

CREATE TABLE ESTUDIOPUBLI_DUBLADORES(
CNPJ_estudio INTEGER,
    email_dublador VARCHAR(100),
    
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    FOREIGN KEY(email_dublador) REFERENCES DUBLADOR(email),
    PRIMARY KEY(CNPJ_estudio,email_dublador)
);
