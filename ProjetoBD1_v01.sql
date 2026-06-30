CREATE TABLE repositorio(
id INT PRIMARY KEY,
nome VARCHAR NOT NULL,
leia_me	TEXT,
estrelas INT NOT NULL,
visualizacoes int NOT NULL
);

CREATE TABLE contribuidor(
id_usuario int NOT NULL,
id_repositorio INT NOT NULL,
qtd_adicoes int,
qtd_exclusoes INT,
FOREIGN KEY (id_usuario) REFERENCES usuario(id),
FOREIGN KEY (id_repositorio) REFERENCES repositorio(id)
);

CREATE TABLE problema(
id int PRIMARY KEY,
autor INT NOT NULL,
id_repositorio INT NOT NULL,
titulo VARCHAR(80) NOT NULL,
numero_problema INT NOT NULL,
descricao TEXT NOT NULL,
status VARCHAR(20) NOT NULL,
hora_criacao TIMESTAMP NOT NULL,
hora_modificaçao TIMESTAMP NOT NULL,
hora_conclusao TIMESTAMP,
FOREIGN KEY (autor) REFERENCES usuario(id),
FOREIGN KEY (id_repositorio) REFERENCES repositorio(id)
);

CREATE TABLE responsavel_problema(
id_responsavel INT NOT NULL,
id_problema INT NOT NULL,
hora_atribuicao TIMESTAMP NOT NULL,
FOREIGN KEY (id_responsavel) REFERENCES usuario(id),
FOREIGN KEY (id_problema) REFERENCES problema(id),
PRIMARY KEY (id_responsavel, id_problema)
);

CREATE TABLE etiqueta(
id INT PRIMARY KEY,
id_problema INT NOT NULL,
nome_etiqueta VARCHAR(40) NOT NULL,
cor_etiqueta VARCHAR(40) NOT NULL,
descricao_etiqueta VARCHAR(80),
FOREIGN KEY (id_problema) REFERENCES problema(id)
);

CREATE TABLE comentario_do_problema(
id INT PRIMARY KEY,
id_problema INT NOT NULL,
id_autor INT NOT NULL,
conteudo TEXT,
hora_comentario TIMESTAMP NOT NULL,
FOREIGN KEY (id_problema) REFERENCES problema(id),
FOREIGN KEY (id_autor) REFERENCES usuario(id)
);

CREATE TABLE etiqueta_problema(
id_etiqueta INT NOT NULL,
id_problema INT NOT NULL,
FOREIGN KEY (id_etiqueta) REFERENCES etiqueta(id),
FOREIGN KEY (id_problema) REFERENCES problema(id),
PRIMARY KEY (id_etiqueta , id_problema)
);





 
