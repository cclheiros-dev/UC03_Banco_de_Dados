CREATE DATABASE tarefas_db CHARACTER SET utf8mb4;

USE tarefas_db;

CREATE TABLE categoria(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL UNIQUE
) COMMENT = 'Categoria das tarefas';

CREATE TABLE tarefa (
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NULL,
    status	ENUM ('pendente', 'andamento', 'concluida'),
    prazo DATE NULL,
    categoria_id INT NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id)
) COMMENT = 'Gerenciamento das tarefas';

INSERT INTO categoria (nome)
VALUES ('Estudos'),('Jogos'),('Produção');

SELECT * FROM categoria;