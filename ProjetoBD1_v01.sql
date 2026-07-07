CREATE TABLE usuario(
id INT PRIMARY KEY,
nome_usuario VARCHAR(80) NOT NULL,
email VARCHAR(120) NOT NULL,
senha VARCHAR(80) NOT NULL,
bio TEXT,
url VARCHAR(240) NOT NULL
); 
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

-- Configurações 
CREATE TABLE configuracoes (
    id_repositorio INT PRIMARY KEY,
    visibilidade VARCHAR(20) NOT NULL,
    branch_padrao VARCHAR(80) NOT NULL,
    permite_forks BOOLEAN NOT NULL,
    permite_issues BOOLEAN NOT NULL,
    permite_wiki BOOLEAN NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id) ON DELETE CASCADE
);
-- Segurança
CREATE TABLE seguranca_e_qualidade (
    id_repositorio INT PRIMARY KEY,
    analise_dependencias VARCHAR(20) NOT NULL,
    varredura_segredos VARCHAR(20) NOT NULL,
    alertas_vulnerabilidade INT NOT NULL,
    hora_ultima_analise TIMESTAMP NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id) ON DELETE CASCADE
);
-- Commit
CREATE TABLE commit (
    sha_hash CHAR(40) PRIMARY KEY,
    id_repositorio INT NOT NULL,
    id_autor INT NOT NULL,
    mensagem TEXT NOT NULL,
    branch_origem VARCHAR(80) NOT NULL,
    hora_commit TIMESTAMP NOT NULL,
    linhas_adicionadas INT NOT NULL,
    linhas_removidas INT NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id) ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES usuario(id)
);
-- Request
 CREATE TABLE pull_request (
    id INT PRIMARY KEY,
    id_repositorio INT NOT NULL,
    id_autor INT NOT NULL,
    numero_pr INT NOT NULL,
    titulo VARCHAR(80) NOT NULL,
    descricao TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    branch_origem VARCHAR(80) NOT NULL,
    branch_destino VARCHAR(80) NOT NULL,
    hora_criacao TIMESTAMP NOT NULL,
    hora_fechamento TIMESTAMP,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id) ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES usuario(id)
);

CREATE TABLE commit_pull_request (
    id_pull_request INT NOT NULL,
    sha_commit CHAR(40) NOT NULL,
    PRIMARY KEY (id_pull_request, sha_commit),
    FOREIGN KEY (id_pull_request) REFERENCES pull_request(id) ON DELETE CASCADE,
    FOREIGN KEY (sha_commit) REFERENCES commit(sha_hash) ON DELETE CASCADE
);
