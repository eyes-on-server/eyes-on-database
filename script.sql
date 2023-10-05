CREATE DATABASE IF NOT EXISTS Eyes_On_Server;
USE Eyes_On_Server;
-- DROP DATABASE IF EXISTS Eyes_On_Server;

-- ------------------- Criação das Tabelas -------------------

-- Tabela Empresa
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Empresa
(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_fantasia VARCHAR(120),
    cnpj CHAR(18) UNIQUE NOT NULL,
    email VARCHAR(120),
    cep CHAR(9)
);

-- Tabela Usuário
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Usuario
(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    nome VARCHAR(120),
    cargo INT CHECK (cargo in (0,1)),
    email VARCHAR(120),
    FOREIGN KEY(fk_empresa) REFERENCES Eyes_On_Server.Empresa(id_empresa)
);

-- Tabela Chamados
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Chamados
(
	id_chamados INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    titulo_chamado VARCHAR(120),
    descricao_chamado TEXT,
    data_hora_abertura DATETIME,
    status_chamado VARCHAR(60),
    FOREIGN KEY(fk_Empresa) REFERENCES Eyes_On_Server.Empresa(id_empresa)
);

-- Tabela Login
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Login
(
	id_login INT PRIMARY KEY AUTO_INCREMENT,
    fk_usuario INT,
    login VARCHAR(120) UNIQUE NOT NULL,
    senha VARCHAR(16) UNIQUE NOT NULL,
    FOREIGN KEY(fk_usuario) REFERENCES Eyes_On_Server.Usuario(id_usuario)
);

-- Tabela Servidor
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Servidor
(
	id_servidor INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    nome_servidor VARCHAR(120),
    local_servidor VARCHAR(120),
    ipv6_servidor VARCHAR(39),
    so_servidor VARCHAR(120),
    FOREIGN KEY(fk_empresa) REFERENCES Eyes_On_Server.Empresa(id_empresa)
);

-- Tabela Componente 
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Componente
(
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome_componente VARCHAR(120)
);

-- Tabela Medida
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Medida
(
	id_medida INT PRIMARY KEY AUTO_INCREMENT,
    nome_medida VARCHAR(30),
    simbolo_medida VARCHAR(5)
);

-- Tabela Registro
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Registro
(
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
    fk_componente INT,
    fk_medida INT,
    fk_servidor INT,
    valor_registro VARCHAR(45),
    momento_registro DATETIME,
    FOREIGN KEY(fk_componente) REFERENCES Eyes_On_Server.Componente(id_componente),
    FOREIGN KEY(fk_medida) REFERENCES Eyes_On_Server.Medida(id_medida),
    FOREIGN KEY(fk_servidor) REFERENCES Eyes_On_Server.Servidor(id_servidor)
);

-- ------------------- Inserindo Dados -------------------

-- Tabela Empresa
INSERT INTO Eyes_On_Server.Empresa VALUES
(NULL, "Memory Analytics", "22.577.094/0001-07", "MemoryAnalytics@outlook.com", "66026-362"),
(NULL, "UCEAE", "99.008.198/0001-17", "Uceae@gmail.com", "88503-015"),
(NULL, "Eyes On Server", "53.569.582/0001-98", "EyesOnServer@outlook.com", "81825-380");

-- Tabela Usuario
INSERT INTO Eyes_On_Server.Usuario VALUES
(NULL, 1, "Isabela Noronha", 1, "isabelaN@sptech.school"),
(NULL, 1, "Felipe Guerrino", 0, "felipeG@sptech.school"),
(NULL, 2, "Davi Hilário", 1, "daviH@sptech.school"),
(NULL, 2, "Gabriel Volpiani", 0, "gabrielV@etec.gov.br"),
(NULL, 3, "Paulo Macena", 1, "pauloM@sptech.school"),
(NULL, 3, "Otávio Walcovics", 0, "otavioW@sptech.school");

-- Tabela Chamados
INSERT INTO Eyes_On_Server.Chamados VALUES
(NULL, 1, "Excesso de CPU", "O CPU atingiu 95% de uso!", now(), "Aberto"),
(NULL, 1, "Excesso de Memória", "A memória está utilizando 100% da sua capacidade!", now(), "Fechado"),
(NULL, 1, "Falha na Rede", "A rede do servidor está apresentando falhas!", now(), "Em Andamento"),
(NULL, 2, "Excesso de CPU", "O CPU atingiu 95% de uso!", now(), "Aberto"),
(NULL, 2, "Nova Conta no UCEAE", "Boa tarde! Gostaria de uma nova conta administrativa no sistema! Agradecido", now(), "Aberto"),
(NULL, 3, "Site com Lentidão", "O site do UCEAE está apresentando lentidão!", now(), "Em Andamento"),
(NULL, 3, "Necessário novo Componente", "Olá, para meu sistema, eu gostaria de poder ler dados da GPU!", now(), "Aberto"),
(NULL, 3, "Nova Medida", "Para o novo componente que requisitei, gostaria de, além da porcentagem de uso, seja lido a frequência também!", now(), "Fechado");

-- Tabela Login
INSERT INTO Eyes_On_Server.Login VALUES
(NULL, 1, "isabelaN@sptech.school", "M}{CSS#WH@y;}st;"),
(NULL, 2, "felipeG@sptech.school", "H{(T@6iAvwgo>K)0"),
(NULL, 3, "daviH@sptech.school", "2Qz#CYnYDLo!RcPP"),
(NULL, 4, "gabrielV@etec.gov.br", "?vlYtQatP;3]Txlv"),
(NULL, 5, "pauloM@sptech.school", "Iep%ZfnPL#t$M]P4"),
(NULL, 6, "otavioW@sptech.school", "BJtP?vUdM4nFJZ@K");

-- Tabela Servidor
INSERT INTO Eyes_On_Server.Servidor VALUES
(NULL, 3, "Maquina Danilo", "Setor F5", ":db8:3333:4444:5555:6666:7777:8888", "Windows"),
(NULL, 3, "Maquina Davi", "Setor F5", ":db8:3F3F:AB12:5059:1123:9565:1841", "Windows"),
(NULL, 3, "Maquina Felipe", "Setor G4", ":db8:924D:AABB:DAC2:6546:1112:9456", "Linux"),
(NULL, 3, "Maquina Isabela", "Setor G4", ":db8:ACF3:CBBC:DA32:1548:19A2:FF56", "Windows"),
(NULL, 3, "Maquina Otavio", "Setor A2", ":db8:AAA2:CAA2:123D:94DD:099C:12EE", "Windows"),
(NULL, 3, "Maquina Paulo", "Setor B6", ":db8:AAAA:BBBB:CCCC:DDDD:EEEE:FFFF", "Windows");

-- Tabela Componente
INSERT INTO Eyes_On_Server.Componente VALUES
(NULL, "Cpu"),
(NULL, "Memoria"),
(NULL, "Disco"),
(NULL, "Rede");

-- Tabela Medida
INSERT INTO Eyes_On_Server.Medida VALUES
(NULL, "Temperatura", "°C"),
(NULL, "PorcentagemUso", "%"),
(NULL, "tamanhoGigaBytes", "Gb"),
(NULL, "Frequencia", "Hz"),
(NULL, "Latencia", "ms"),
(NULL, "bytesEnviados", "B"),
(NULL, "bytesRecebidos", "B");

-- ------------------- Selects -------------------

SELECT * FROM Eyes_On_Server.Empresa;
SELECT * FROM Eyes_On_Server.Usuario;
SELECT * FROM Eyes_On_Server.Chamados;
SELECT * FROM Eyes_On_Server.Login;
SELECT * FROM Eyes_On_Server.Servidor;
SELECT * FROM Eyes_On_Server.Componente;
SELECT * FROM Eyes_On_Server.Medida;
SELECT * FROM Eyes_On_Server.Registro;

-- ------------------- Joins -------------------

-- Funcionários, Empresa, Login
SELECT 
	u.nome,
    u.email,
    u.cargo,
    e.nome_fantasia,
    l.senha
FROM Eyes_On_Server.Usuario u
	join Eyes_On_Server.Empresa e on u.fk_empresa = e.id_empresa
	join Eyes_On_Server.Login l on l.fk_usuario = u.id_usuario;

-- Empresa, Servidor, Componente, Medida
SELECT
	e.nome_fantasia,
	s.nome_servidor, 
    s.so_servidor,
    s.local_servidor,
    c.nome_componente,
    m.nome_medida
FROM Eyes_On_Server.Empresa e
	JOIN Eyes_On_Server.Servidor s on s.fk_empresa = e.id_empresa
    JOIN Eyes_On_Server.Registro r on r.fk_servidor = s.id_servidor
    JOIN Eyes_On_Server.Componente c on r.fk_componente = c.id_componente
    JOIN Eyes_On_Server.Medida m on r.fk_medida = m.id_medida
WHERE e.id_empresa = 3;

-- ------------------- Views -------------------

-- View Todos Registros
CREATE OR REPLACE VIEW View_Registros AS
SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor
ORDER BY Servidor;

-- View Máquina Danilo
CREATE OR REPLACE VIEW View_Registros_Servidor_Danilo AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 1
ORDER BY Momento);

-- View Máquina Davi
CREATE OR REPLACE VIEW View_Registros_Servidor_Davi AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 2
ORDER BY Momento);

-- View Máquina Felipe
CREATE OR REPLACE VIEW View_Registros_Servidor_Felipe AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 3
ORDER BY Momento);

-- View Máquina Isabela
CREATE OR REPLACE VIEW View_Registros_Servidor_Isabela AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 4
ORDER BY Momento);

-- View Máquina Otavio
CREATE OR REPLACE VIEW View_Registros_Servidor_Otavio AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 5
ORDER BY Momento);

-- View Máquina Paulo
CREATE OR REPLACE VIEW View_Registros_Servidor_Paulo AS
(SELECT
	s.id_servidor `Servidor`,
    r.momento_registro `Momento`,
    r.valor_registro `Valor`,
    c.nome_componente `Componente`,
    m.nome_medida `Medida`
FROM Eyes_On_Server.Registro r
	join Eyes_On_Server.Componente c on c.id_componente = r.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = r.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = r.fk_servidor and r.fk_servidor = 6
ORDER BY Momento);

-- ------------------- Procedures -------------------

-- playground do paulo

DELIMITER $$
CREATE PROCEDURE Cadastrar_Empresa (
	nome_fantasia VARCHAR(120),
    cnpj CHAR(18),
    cep CHAR(9),
    email_empresa VARCHAR(120),
    nome_adm VARCHAR(120),
    email_adm VARCHAR(120),
    senha VARCHAR (16)
)
BEGIN

INSERT INTO Eyes_On_Server.Empresa VALUES
(NULL, nome_fantasia, cnpj, email_empresa, cep);

INSERT INTO Eyes_On_Server.Usuario VALUES
(NULL, (SELECT max(id_empresa) from  Eyes_On_Server.Empresa), nome_adm, 1, email_adm);

INSERT INTO Eyes_On_Server.Login VALUES
(NULL, (SELECT max(id_usuario) from Eyes_On_Server.Usuario), email_adm, senha);

END $$

-- ------------------- Statement -------------------
SET @sql = NULL;

SELECT
  GROUP_CONCAT(DISTINCT
    CONCAT(
      'max(case when Componente = ''', 
      Componente, 
      ''' and Medida = ''', 
      Medida, 
      ''' then Valor end) ',
      Componente,Medida
    )
  )
INTO @sql
FROM
  View_Registros_Servidor_Davi;

SET @sql = CONCAT('SELECT Servidor, Momento, ', @sql, '
FROM View_Registros_Servidor_Davi
GROUP BY Servidor, Momento
ORDER BY Momento DESC'); 

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
