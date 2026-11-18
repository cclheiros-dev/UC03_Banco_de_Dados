/* SA2 - Implementação e manipulação do banco de embalagens
   Aluno(a):
   Antes: execute o embalagens-base-sa2.sql. */
USE embalagens;

-- ETAPA 1: dados de teste (INSERT e UPDATE)
INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES ('2026-11-03', '5000', '4800', '200', '60', '1', '1'),
('2026-11-03', '5000', '4950', '50','25', '1','2'),
('2026-11-04', '8000', '7650', '350','160','2','3'),
('2026-11-05', '3000', '2880', '120','18','3','2'),
('2026-11-05', '4000', '3900', '100','48','1','1');

UPDATE produto SET preco_tabela = 0.42 
WHERE codigo = 1;

SELECT * FROM ordem_producao;

INSERT INTO expedicao (numero, data_saida, unidade_codigo, cliente_cnpj)
VALUES ('1', '2026-11-06', '1', '11.111.111/0001-11'),
('2', '2026-11-06', '2', '22.222.222/0001-22'); 

DESCRIBE item_expedicao;
SELECT * FROM item_expedicao;

INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado)
VALUES ('1', '1', '2000', '0.45'),
('1', '2', '2000', '0.12'),
('2', '3', '5000', '0.65');

-- ETAPA 2: consultas 1 a 5

-- CONSULTA 1º
SELECT * FROM ordem_producao
WHERE qtd_refugo > 100
ORDER BY qtd_refugo desc;

-- CONSULTA 2º
CREATE OR REPLACE VIEW vw_refugo_produto AS 
SELECT produto_codigo, SUM(qtd_refugo) AS total_refugo FROM ordem_producao
WHERE qtd_refugo
GROUP BY produto_codigo
ORDER BY total_refugo desc;

-- CONSULTA 3º
SELECT * FROM ordem_producao
WHERE qtd_boa > 5000
ORDER BY qtd_boa desc;

-- CONSULTA 4º

SELECT 
	cl.razao_social AS cliente,
	ie.quantidade,
    u.nome as unidade,
    pr.nome as produto,
    (ie.quantidade * ie.preco_cobrado) AS valor
FROM expedicao e
INNER JOIN item_expedicao ie ON ie.expedicao_numero = e.numero
INNER JOIN unidade u ON u.codigo = e.unidade_codigo
INNER JOIN cliente cl ON cl.cnpj = e.cliente_cnpj
INNER JOIN produto pr ON pr.codigo = ie.produto_codigo;


-- CONSULTA 5º
CREATE OR REPLACE VIEW vw_razao_social_cliente AS
 SELECT 
cl.razao_social AS sem_expedicao
FROM expedicao e
RIGHT JOIN cliente cl ON cl.cnpj = e.cliente_cnpj
WHERE e.cliente_cnpj is null;

SELECT * FROM vw_razao_social_cliente;

-- ETAPA 3: view, procedure e trigger

-- view
SELECT * FROM vw_refugo_produto;

SELECT * FROM vw_razao_social_cliente;

-- procedure

DELIMITER //
CREATE PROCEDURE sp_atualizar_expedição (IN expedicao INT, IN produto INT, IN quantidade INT)
BEGIN 
	UPDATE expedicao SET quantidade = quantidade WHERE id = expedicao AND produto_id = produto;
END;
END //
DELIMITER ;
CALL sp_atualizar_expedição(2, 5, 500);


DELIMITER //
CREATE PROCEDURE sp_registrar_item (IN expedicao INT, IN produto INT, IN quantidade INT)
BEGIN
    INSERT INTO item_expedicao(expedicao_numero, produto_codigo, quantidade, preco_cobrado)
    VALUES (expedicao, produto, quantidade, (SELECT preco_tabela AS 'Preço de tabela' FROM produto WHERE codigo = produto));
END //
DELIMITER ;
DROP PROCEDURE sp_registrar_item;
CALL sp_registrar_item (2, 4, 5000);

-- trigger 

DELIMITER //
CREATE TRIGGER tg_ordem_baixa_resina
AFTER INSERT ON ordem_producao FOR EACH ROW 
BEGIN 
	UPDATE estoque_resina SET quantidade_kg = quantidade_kg - NEW.consumo_kg 
    WHERE unidade_codigo = NEW.unidade_codigo AND produto_codigo = NEW.produto_codigo;
END //
DELIMITER ;

SELECT * FROM ordem_producao;
INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES ('2026/11/09', '1000', '950', '50', '20');

SELECT * FROM estoque_resina where unidade_codigo = 2;

-- ETAPA 4: privilégios dos perfis e SHOW GRANTS

-- prazo encerrado 