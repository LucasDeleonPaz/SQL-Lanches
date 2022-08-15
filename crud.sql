-- Aqui você deve colocar os códigos SQL referentes às
-- Simulações de um CRUD

-- Criação

-- 1) - INSERÇÃO DE NOVOS CLIENTES

INSERT INTO 
    clientes(nome, lealdade)
VALUES
    ('Georgia', 0);

-- 2) - INSERÇÃO DE UM NOVO PEDIDO

INSERT INTO
    pedidos(status, id_client)
VALUES
    ('Recebido', (SELECT id FROM clientes WHERE nome = 'Georgia'));


-- 3) - INSERÇÃO DOS PRODUTOS NA TABELA produtos_pedidos

INSERT INTO
	produtos_pedidos(id_pedido, id_produto)
VALUES
	((SELECT id FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Georgia')), (SELECT id FROM produtos WHERE nome = 'Big Serial')),
    ((SELECT id FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Georgia')), (SELECT id FROM produtos WHERE nome = 'Varchapa')),
    ((SELECT id FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Georgia')), (SELECT id FROM produtos WHERE nome = 'Fritas')),
    ((SELECT id FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Georgia')), (SELECT id FROM produtos WHERE nome = 'Coca-Cola')),
    ((SELECT id FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Georgia')), (SELECT id FROM produtos WHERE nome = 'Coca-Cola'));
    

-- Leitura

-- 1) - Relação de 1:N - Concatenação do cliente (id, nome e lealdade), pedido (id, status e id_cliente) e produtos (id, nome, tipo, preço e pontos de lealdade)

SELECT 
	client.id, client.nome, client.lealdade, pedido.id, pedido.status, pedido.id_client, prod.id, prod.nome, prod.tipo, prod.preco, prod.pts_de_lealdade
FROM 
	clientes client
JOIN 
	pedidos pedido ON client.id = pedido.id_client
JOIN 
	produtos_pedidos prod_ped ON pedido.id = prod_ped.id_pedido
JOIN
	produtos prod ON prod.id = prod_ped.id_produto
WHERE 
	client.nome = 'Georgia';

-- Atualização

-- 1) ALTERAÇÃO DOS PONTOS DE LEALDADE DA CLIENTE 'GEORGIA' COM BASE NOS ITENS COMPRADOS

UPDATE
	clientes cliente
SET
	lealdade =(
SELECT
	SUM(pts_de_lealdade) total_lealdade
FROM
	clientes cliente
JOIN
	pedidos pedido ON cliente.id = pedido.id_client
JOIN
	produtos_pedidos prod_ped ON pedido.id = prod_ped.id_pedido
JOIN
	produtos prod ON prod.id = prod_ped.id_produto
WHERE
	cliente.nome = 'Georgia'
)
WHERE
	cliente.nome='Georgia';



-- Deleção | Por existir as Foreign Keys, a deleção precisa acontecer em todos as tabelas onde a mesma
-- se conecta, garantindo assim que o cliente possa ser excluído por completo, por isso, abaixo, excluo primeiro da tabela produtos_pedidos, 
-- depois em pedidos, por fim vou para endereços e por último, excluo o cliente.


-- 1) 

DELETE FROM
	produtos_pedidos 
WHERE 
	id_pedido = (SELECT id_client FROM pedidos WHERE id_client = (SELECT id FROM clientes WHERE nome = 'Marcelo'));

DELETE FROM
	pedidos
WHERE 
	id_client = (SELECT id FROM clientes WHERE nome = 'Marcelo');

DELETE FROM
	enderecos
WHERE 
	id_client = (SELECT id FROM clientes WHERE nome = 'Marcelo');

DELETE FROM 
    clientes
WHERE  
    nome = 'Marcelo';


