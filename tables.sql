-- Aqui você deve colocar os códigos SQL referentes à

-- Criação das tabelas

-- Tabela clientes

CREATE TABLE IF NOT EXISTS clientes (
  id BIGSERIAL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  lealdade INTEGER NOT NULL
);

-- Tabela endereços

CREATE TABLE IF NOT EXISTS enderecos (
  id BIGSERIAL PRIMARY KEY,
  cep VARCHAR(9) NOT NULL,
  rua VARCHAR(60) NOT NULL,
  num INTEGER NOT NULL,
  bairro VARCHAR(50) NOT NULL,
  compl VARCHAR(100) NOT NULL,
  id_client INTEGER UNIQUE NOT NULL,
  FOREIGN KEY (id_client) REFERENCES clientes(id)
);

-- Tabela pedidos

CREATE TABLE IF NOT EXISTS pedidos (
  id BIGSERIAL PRIMARY KEY,
  status VARCHAR(50) NOT NULL,
  id_client INTEGER NOT NULL,
  FOREIGN KEY (id_client) REFERENCES clientes(id)
);

-- Tabela produtos

CREATE TABLE IF NOT EXISTS produtos (
  id BIGSERIAL PRIMARY KEY,
  nome VARCHAR(100) UNIQUE NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  preco FLOAT(8) NOT NULL,
  pts_de_lealdade INTEGER NOT NULL
);


-- Tabela produtos_pedidos

CREATE TABLE IF NOT EXISTS produtos_pedidos (
  id_pedido INTEGER NOT NULL,
  id_produto INTEGER NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES pedidos(id),
  FOREIGN KEY (id_produto) REFERENCES produtos(id)
);