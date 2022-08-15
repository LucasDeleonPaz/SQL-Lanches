-- Aqui você deve colocar os códigos SQL referentes às
-- Seleções de dados

-- 1) CONCATENAÇÃO DA TABELA DE PEDIDOS E PRODUTOS RELATIVOS À CADA PEDIDO FEITO

SELECT
	ped.id, ped.status, ped.id_client, prod.id, prod.nome, prod.preco, prod.pts_de_lealdade
FROM
	pedidos ped
JOIN
	produtos_pedidos prod_ped ON ped.id = prod_ped.id_produto
JOIN
	produtos prod ON prod.id = prod_ped.id_produto
ORDER BY
	ped.id;

-- 2) PESQUISA DOS PEDIDOS QUE INCLUAM FRITAS E RETORNE SOMENTE OS ID'S DOS PEDIDOS QUE PASSAM NA CONDIÇÃO.

SELECT
	ped.id
FROM 
	pedidos ped
JOIN
	produtos_pedidos prod_ped ON ped.id = prod_ped.id_produto
JOIN
	produtos prod ON prod.nome = 'fritas'
ORDER BY
	ped.id;

-- 3) PESQUISA DOS CLIENTES QUE GOSTAM DE FRITAS - RETORNO SOMENTE DOS NOMES DOS CLIENTES

SELECT
	cliente.nome Gostam_de_Fritas
FROM
	pedidos ped
JOIN
	clientes cliente ON ped.id_client = cliente.id
JOIN
	produtos_pedidos prod_ped ON ped.id = prod_ped.id_pedido
JOIN
	produtos prod ON prod_ped.id_produto = prod.id
WHERE
	prod.nome = 'Fritas';

-- 4)

SELECT
	SUM(preco) preco_total
FROM
	produtos prod
JOIN
	produtos_pedidos prod_ped ON prod.id = prod_ped.id_produto
JOIN
	pedidos ped ON prod_ped.id_pedido = ped.id
JOIN
	clientes cliente ON ped.id_client = cliente.id
WHERE
	cliente.nome = 'Laura';

-- 5) PESQUISA DA QUANTIDADE DE VEZES QUE DETERMINADOS PRODUTOS FORAM VENDIDOS E RETORNO DA CONTAGEM CONCATENADA COM O NOME

SELECT
	prod.nome, COUNT(prod_ped.id_produto) contagem
FROM
	produtos prod
JOIN
	produtos_pedidos prod_ped ON prod.id = prod_ped.id_produto
GROUP BY
	prod.nome
ORDER BY
	contagem;