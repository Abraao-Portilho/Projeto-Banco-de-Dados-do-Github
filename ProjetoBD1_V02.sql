CREATE TABLE configuracoes (
    id_repositorio INT PRIMARY KEY,
    visibilidade VARCHAR(20) NOT NULL,
    branch_padrao VARCHAR(80) NOT NULL,
    permite_forks BOOLEAN NOT NULL,
    permite_issues BOOLEAN NOT NULL,
    permite_wiki BOOLEAN NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id)
);

CREATE TABLE seguranca_e_qualidade (
    id_repositorio INT PRIMARY KEY,
    analise_dependencias VARCHAR(20) NOT NULL,
    varredura_segredos VARCHAR(20) NOT NULL,
    alertas_vulnerabilidade INT NOT NULL,
    hora_ultima_analise TIMESTAMP NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id)
);

CREATE TABLE commit_ (
    sha_hash CHAR(40) PRIMARY KEY,
    id_repositorio INT NOT NULL,
    id_autor INT NOT NULL,
    mensagem TEXT NOT NULL,
    branch_origem VARCHAR(80) NOT NULL,
    hora_commit TIMESTAMP NOT NULL,
    linhas_adicionadas INT NOT NULL,
    linhas_removidas INT NOT NULL,
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id),
    FOREIGN KEY (id_autor) REFERENCES usuario(id)
);

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
    FOREIGN KEY (id_repositorio) REFERENCES repositorio(id),
    FOREIGN KEY (id_autor) REFERENCES usuario(id)
);

CREATE TABLE commit_pull_request (
    id_pull_request INT NOT NULL,
    sha_commit CHAR(40) NOT NULL,
    PRIMARY KEY (id_pull_request, sha_commit),
    FOREIGN KEY (id_pull_request) REFERENCES pull_request(id),
    FOREIGN KEY (sha_commit) REFERENCES commit_(sha_hash)
);
