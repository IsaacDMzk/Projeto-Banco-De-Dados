DROP TABLE IF EXISTS USUARIO_PARTICIPA_DE_CLUBES;
DROP TABLE IF EXISTS USUARIO_ASSISTE_ANIMES;
DROP TABLE IF EXISTS USUARIO_LE_MANGAS;
DROP TABLE IF EXISTS MANGAS_TEM_VOLUMES;
DROP TABLE IF EXISTS VOLUMES_TEM_CAPITULOS;
DROP TABLE IF EXISTS ANIMES_TEM_TEMPORADAS;
DROP TABLE IF EXISTS TEMPORADAS_TEM_EPISODIOS;
DROP TABLE IF EXISTS ANIMES_TEM_ESTUDIO_PUBLICACAO;
DROP TABLE IF EXISTS MANGAS_TEM_ESTUDIO_PUBLICACAO;
DROP TABLE IF EXISTS ESTUDIO_PUBLICACAO_TEM_DESENHISTA;
DROP TABLE IF EXISTS TRABALHAM_JUNTOS;

DROP TABLE IF EXISTS USUARIO;
DROP TABLE IF EXISTS ANIMES;
DROP TABLE IF EXISTS CLUBES;
DROP TABLE IF EXISTS MANGAS;
DROP TABLE IF EXISTS VOLUMES;
DROP TABLE IF EXISTS CAPITULOS;
DROP TABLE IF EXISTS ESTUDIO_DE_PUBLICACAO;
DROP TABLE IF EXISTS DESENHISTA;
DROP TABLE IF EXISTS DUBLADOR;
DROP TABLE IF EXISTS EQUIPE_DE_ANIMADORES;
DROP TABLE IF EXISTS TEMPORADAS;
DROP TABLE IF EXISTS EPISODIOS;


-- Entidades
CREATE TABLE USUARIO(
    nick VARCHAR(20),
    nome VARCHAR(100),
    genero VARCHAR(20),
    data_de_nascimento 	VARCHAR(20),
    PRIMARY KEY(nick)
);

CREATE TABLE ANIMES(
    titulo VARCHAR(50),
    condicao ENUM ('Completed','Watching','Plan To Watch','On Hold','Droped'),
    autor VARCHAR(50),
    PRIMARY KEY(titulo)
);

CREATE TABLE CLUBES(
    ID INTEGER,
    nome VARCHAR(100),
    descricao VARCHAR(300),
    PRIMARY KEY(ID)
);

CREATE TABLE MANGAS(
    titulo VARCHAR(50),
    condicao ENUM ('Completed','Reading','Plan to Read','On Hold','Droped'),
    autor VARCHAR(50),
    PRIMARY KEY(titulo)
);

CREATE TABLE VOLUMES(
    numero_de_identificacao INTEGER,
    data_de_publicacao VARCHAR(20),
    data_de_encerramento VARCHAR(20),
    PRIMARY KEY(numero_de_identificacao)
);

CREATE TABLE CAPITULOS(
    numero_de_identificacao INTEGER,
    titulo VARCHAR(50),
    data_de_publicacao VARCHAR(20),
    PRIMARY KEY(numero_de_identificacao)
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

CREATE TABLE TEMPORADAS(
    numero_de_identificacao INTEGER,
    data_de_publicacao VARCHAR(20),
    data_de_encerramento VARCHAR(20),
    PRIMARY KEY(numero_de_identificacao)
);

CREATE TABLE EPISODIOS(
    numero_de_identificacao INTEGER,
    titulo VARCHAR(50),
    data_de_publicacao VARCHAR(20),
    PRIMARY KEY(numero_de_identificacao)
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

CREATE TABLE MANGAS_TEM_VOLUMES(
    titulo_manga VARCHAR(50),
    ID_volume INTEGER,
    
    FOREIGN KEY (titulo_manga) REFERENCES MANGAS(titulo),
    FOREIGN KEY (ID_volume) REFERENCES VOLUMES(numero_de_identificacao),
    PRIMARY KEY (titulo_manga,numero_de_identificacao)
);

CREATE TABLE VOLUMES_TEM_CAPITULOS(
    ID_volume INTEGER,
    ID_capitulo INTEGER,
    
    FOREIGN KEY (ID_volume) REFERENCES VOLUMES(numero_de_identificacao),
    FOREIGN KEY (ID_capitulo) REFERENCES CAPITULOS(numero_de_identificacao),
    PRIMARY KEY(ID_volume,ID_volume)
);

CREATE TABLE ANIMES_TEM_TEMPORADAS(
    titulo_anime VARCHAR(50),
    ID_temporada INTEGER,
    
    FOREIGN KEY(titulo_anime) REFERENCES ANIMES(titulo),
    FOREIGN KEY(ID_temporada) REFERENCES TEMPORADAS(numero_de_identificacao),
    PRIMARY KEY(titulo_anime,ID_temporada)
);

CREATE TABLE TEMPORADAS_TEM_EPISODIOS(
    ID_temporada INTEGER,
    ID_episodio INTEGER,
    
    FOREIGN KEY(ID_temporada) REFERENCES TEMPORADAS(numero_de_identificacao),
    FOREIGN KEY(ID_episodio) REFERENCES EPISODIOS(numero_de_identificacao),
    PRIMARY KEY(ID_temporada,ID_episodio)
);

CREATE TABLE ANIMES_TEM_ESTUDIO_PUBLICACAO(
    titulo_anime VARCHAR(50),
    CNPJ_estudio INTEGER,
    
    FOREIGN KEY(titulo_anime) REFERENCES ANIMES(titulo),
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    PRIMARY KEY(titulo_anime,CNPJ_estudio)
);

CREATE TABLE MANGAS_TEM_ESTUDIO_PUBLICACAO(
    titulo_manga VARCHAR(50),
    CNPJ_estudio INTEGER,
    
    FOREIGN KEY(titulo_manga) REFERENCES MANGAS(titulo),
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    PRIMARY KEY(titulo_manga,CNPJ_estudio)
);

CREATE TABLE ESTUDIO_PUBLICACAO_TEM_DESENHISTA(
    CNPJ_estudio INTEGER,
    email_desenhista VARCHAR(100),
    
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    FOREIGN KEY(email_desenhista) REFERENCES DESENHISTA(email),
    PRIMARY KEY(CNPJ_estudio,email_desenhista)
);

CREATE TABLE TRABALHAM_JUNTOS(
    CNPJ_estudio INTEGER,
    ID_equipe_de_animadores INTEGER,
    email_dublador VARCHAR(100),
    
    FOREIGN KEY(CNPJ_estudio) REFERENCES ESTUDIO_DE_PUBLICACAO(CNPJ),
    FOREIGN KEY(ID_equipe_de_animadores) REFERENCES EQUIPE_DE_ANIMADORES(ID_da_equipe),
    FOREIGN KEY(email_dublador) REFERENCES DUBLADOR(email),
    PRIMARY KEY(CNPJ_estudio,ID_equipe_de_animadores,email_dublador)
);

