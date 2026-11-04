USE sakila;
-- snake case = item_pedido
DESCRIBE film;
SELECT
title,
description,
 length
FROM film;

CREATE DATABASE IF NOT EXISTS lanchonete_manha CHARACTER SET utf8mb4;
USE lanchonete_manha;

CREATE TABLE IF NOT EXISTS bairro(
	id_bairro INT AUTO_INCREMENT PRIMARY KEY,
    nome_bairro VARCHAR(150) NOT NULL,
    taxa_entrega DECIMAL(6,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS endereco(
	id	INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(150) NOT NULL,
    numero CHAR(10),
    complemento VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS produto(
	codigo INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(60) NOT NULL,
    preco 		DECIMAL(6,2) CHECK(preco > 0) NOT NULL
);

CREATE TABLE IF NOT EXISTS cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
    endereco_id INT NOT NULL,
    id_bairro INT NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id),
	FOREIGN KEY (id_bairro) REFERENCES bairro(id_bairro)
);
    
CREATE TABLE IF NOT EXISTS telefone_cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
	cliente_id INT NOT NULL,
	telefone CHAR(11) UNIQUE NOT NULL,
	FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);
CREATE TABLE IF NOT EXISTS pedido (
	codigo		INT AUTO_INCREMENT PRIMARY KEY,
    data		DATE NOT NULL,
    cliente_id	INT NOT NULL,
    total_pedido DECIMAL(6,2) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE IF NOT EXISTS item_pedido (
	codigo_produto	INT NOT NULL,
    codigo_pedido 	INT NOT NULL,
    quantidade 		INT NOT NULL,
    FOREIGN KEY (codigo_pedido) REFERENCES pedido(codigo),
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo)

);