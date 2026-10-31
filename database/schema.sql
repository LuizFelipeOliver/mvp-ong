-- Projeto Integrador Extensionista II · Atividade 2
-- ONG de Doações de Itens e Alimentos · schema.sql
-- LGPD: armazena apenas os dados pessoais estritamente necessários para identificação
-- e contato com o doador (nome, e-mail e telefone opcional), sem CPF ou endereço completo.

SET NAMES utf8mb4;
DROP DATABASE IF EXISTS mvp_ong;
CREATE DATABASE mvp_ong CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mvp_ong;

-- 1. Entidade: Doador
CREATE TABLE doador (
  id_doador INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  data_cadastro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Entidade: Categoria de Itens (ex.: Alimentos, Roupas, Higiene)
CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL UNIQUE,
  descricao VARCHAR(255)
);

-- 3. Entidade: Item do catálogo de arrecadação (1:N com categoria)
CREATE TABLE item (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_categoria INT NOT NULL,
  nome VARCHAR(120) NOT NULL UNIQUE,
  unidade_medida VARCHAR(20) NOT NULL DEFAULT 'un',
  valor_estimado DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (valor_estimado >= 0),
  estoque_atual INT NOT NULL DEFAULT 0 CHECK (estoque_atual >= 0),
  FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

-- 4. Entidade: Campanha de Arrecadação
CREATE TABLE campanha (
  id_campanha INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL UNIQUE,
  descricao VARCHAR(500) NOT NULL,
  meta_financeira DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (meta_financeira >= 0),
  data_inicio DATE NOT NULL,
  data_fim DATE,
  ativa BOOLEAN NOT NULL DEFAULT TRUE,
  data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

-- 5. Entidade: Doação (1:N com doador e 1:N opcional com campanha)
CREATE TABLE doacao (
  id_doacao INT AUTO_INCREMENT PRIMARY KEY,
  id_doador INT NOT NULL,
  id_campanha INT,
  data_doacao DATE NOT NULL,
  valor_financeiro DECIMAL(10,2) NOT NULL DEFAULT 0.00 CHECK (valor_financeiro >= 0),
  status_doacao VARCHAR(20) NOT NULL DEFAULT 'recebida' CHECK (status_doacao IN ('pendente', 'recebida', 'cancelada')),
  observacao VARCHAR(255),
  data_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_doador) REFERENCES doador (id_doador),
  FOREIGN KEY (id_campanha) REFERENCES campanha (id_campanha) ON DELETE SET NULL
);

-- 6. Tabela Associativa (N:N): Itens contidos em cada Doação
CREATE TABLE doacao_item (
  id_doacao INT NOT NULL,
  id_item INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (id_doacao, id_item),
  FOREIGN KEY (id_doacao) REFERENCES doacao (id_doacao) ON DELETE CASCADE,
  FOREIGN KEY (id_item) REFERENCES item (id_item)
);
