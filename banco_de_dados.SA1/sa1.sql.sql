/* SA1 - Banco da indústria de embalagens */
CREATE DATABASE embalagens;
USE embalagens;

CREATE TABLE IF NOT EXISTS Produto (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade INT NOT NULL
);
CREATE TABLE IF NOT EXISTS Resina (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(75) UNIQUE NOT NULL,
    produto_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produto(id)
);
CREATE TABLE IF NOT EXISTS Expedição (
	id INT AUTO_INCREMENT PRIMARY KEY,
    data DATE UNIQUE NOT NULL,
    numero INT UNIQUE NOT NULL,
	produto_id INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produto(id)
    );
CREATE TABLE IF NOT EXISTS Unidade (
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    cidade INT NOT NULL,
    telefone VARCHAR(15) UNIQUE NOT NULL
    );
CREATE TABLE IF NOT EXISTS Ordem (
	id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT UNIQUE NOT NULL,
    quantidade_refugo INT NOT NULL,
    quantidade_boa INT NOT NULL,
    quantidade_planejada INT NOT NULL,
    data DATE NOT NULL
    );
CREATE TABLE IF NOT EXISTS Cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
    razão_social VARCHAR(230) NOT NULL,
    CPNJ CHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR (20) UNIQUE
    );
CREATE TABLE IF NOT EXISTS expedição_cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNIQUE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    expedição_id INT UNIQUE NOT NULL,
    FOREIGN KEY (expedição_id) REFERENCES Expedição(id)
    );
CREATE TABLE IF NOT EXISTS expedição_unidade (
	id INT AUTO_INCREMENT PRIMARY KEY,
    expedição_id INT UNIQUE NOT NULL,
    FOREIGN KEY (expedição_id) REFERENCES Expedição(id),
    unidade_id INT UNIQUE NOT NULL,
    FOREIGN KEY (unidade_id) REFERENCES Unidade(id)
    );
CREATE TABLE IF NOT EXISTS unidade_ordem (
	id INT AUTO_INCREMENT PRIMARY KEY,
    unidade_id INT UNIQUE NOT NULL,
    FOREIGN KEY (unidade_id) REFERENCES Unidade(id),
	ordem_id INT NOT NULL,
    FOREIGN KEY (ordem_id) REFERENCES Ordem(id)
    );
    
    
    
    
    
    
    
    