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
    mac_address CHAR(17),
    so_servidor VARCHAR(120),
    descricao VARCHAR(50),
    componentes VARCHAR(255), -- Coluna para armazenar IDs de componentes mudar no DER
    FOREIGN KEY(fk_empresa) REFERENCES Eyes_On_Server.Empresa(id_empresa)
);

-- Tabela Componente 
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Componente
(
	id_componente INT PRIMARY KEY AUTO_INCREMENT,
    nome_componente VARCHAR(120)
);

-- Tabela Processos
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Processos
(
	id_processos INT PRIMARY KEY AUTO_INCREMENT,
    pid_processos BIGINT,
    nome_processos VARCHAR(120),
    uso_memoria_processos DECIMAL(4,1),
    uso_cpu_processos DECIMAL(4,1),
    fk_servidor INT,
    FOREIGN KEY(fk_servidor) REFERENCES Eyes_On_Server.Servidor(id_servidor)
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

-- Tabela Alertas
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Alertas
(
	id_alertas INT PRIMARY KEY AUTO_INCREMENT,
    fk_empresa INT,
    fk_servidor INT,
    fk_componente INT,
    titulo_alerta VARCHAR(120),
    descricao_alerta TEXT,
    data_hora_abertura DATETIME,
    tipoAlerta VARCHAR(10),
    FOREIGN KEY(fk_empresa) REFERENCES Eyes_On_Server.Empresa(id_empresa),
    FOREIGN KEY(fk_servidor) REFERENCES Eyes_On_Server.Servidor(id_servidor),
    FOREIGN KEY(fk_componente) REFERENCES Eyes_On_Server.Componente(id_componente)
);
-- Tipos de chamados: 
-- 0: Prevenção 
-- 1: Perigo
-- 2: Emergencia 

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

-- Tabela Login
INSERT INTO Eyes_On_Server.Login VALUES
(NULL, 1, "isabelaN@sptech.school", "M}{CSS#WH@y;}st;"),
(NULL, 2, "felipeG@sptech.school", "H{(T@6iAvwgo>K)0"),
(NULL, 3, "daviH@sptech.school", "2Qz#CYnYDLo!RcPP"),
(NULL, 4, "gabrielV@etec.gov.br", "?vlYtQatP;3]Txlv"),
(NULL, 5, "pauloM@sptech.school", "Iep%ZfnPL#t$M]P4"),
(NULL, 6, "otavioW@sptech.school", "BJtP?vUdM4nFJZ@K");

-- Tabela Servidor
INSERT INTO Eyes_On_Server.Servidor
    (fk_empresa, nome_servidor, local_servidor, ipv6_servidor, mac_address, so_servidor, descricao, componentes)
VALUES
    (3, "Servidor DN141", "Setor F5", ":db8:3333:4444:5555:6666:7777:8888", "00:1B:44:11:3A:B7", "Windows", "Servidor adquirido no dia 1 de outubro de 2023", "1,2,3"),
    (3, "Servidor DV921", "Setor F5", ":db8:3F3F:AB12:5059:1123:9565:1841", "09:11:44:1F:3A:A9", "Windows", "Servidor adquirido no dia 6 de setembro de 2023", "1,2,3,4"),
    (3, "Servidor FE091", "Setor G4", ":db8:924D:AABB:DAC2:6546:1112:9456", "0B:AB:42:10:FE:BA", "Linux", "Servidor adquirido no dia 7 de outubro de 2023", "1,3"),
    (3, "Servidor IS592", "Setor G4", ":db8:ACF3:CBBC:DA32:1548:19A2:FF56", "04:D3:CC:C1:12:54", "Windows", "Servidor adquirido no dia 30 de setembro de 2023", "1,2"),
    (3, "Servidor OT114", "Setor A2", ":db8:AAA2:CAA2:123D:94DD:099C:12EE", "01:12:CA:FC:00:09", "Windows", "Servidor adquirido no dia 27 de agosto de 2023", "3"),
    (3, "Servidor PA404", "Setor B6", ":db8:AAAA:BBBB:CCCC:DDDD:EEEE:FFFF", "FE:EA:81:00:3C:D2", "Windows", "Servidor adquirido no dia 29 de julho de 2023", "1");

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
SELECT * FROM Eyes_On_Server.Alertas;
SELECT * FROM Eyes_On_Server.Login;
SELECT * FROM Eyes_On_Server.Servidor;
SELECT * FROM Eyes_On_Server.Componente;
SELECT * FROM Eyes_On_Server.Processos;
SELECT * FROM Eyes_On_Server.Medida;
SELECT * FROM Eyes_On_Server.Registro;

select fk_servidor, data_hora_abertura, tipoAlerta, descricao_alerta from Eyes_On_Server.Alertas where fk_servidor = 1;
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

-- select para a pagina do analista (lista de servidores relacionado a empresa)
SELECT
    s.id_servidor AS id,
    s.nome_servidor AS Nome_Servidor,
    s.so_servidor AS Sistema_Operacional,
    s.descricao AS Descricao,
    s.local_servidor AS Local,
    GROUP_CONCAT(c.nome_componente ORDER BY c.id_componente) AS Componentes
FROM Eyes_On_Server.Servidor AS s
LEFT JOIN Eyes_On_Server.Componente AS c
ON FIND_IN_SET(c.id_componente, REPLACE(s.componentes, ' ', ''))
WHERE s.fk_empresa = 3
GROUP BY s.id_servidor, s.nome_servidor, s.so_servidor, s.descricao, s.local_servidor;

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

-- View Servidor DN141
CREATE OR REPLACE VIEW View_Registros_Servidor_DN141 AS
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

-- View Servidor DV921
CREATE OR REPLACE VIEW View_Registros_Servidor_DV921 AS
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

-- View Servidor FE091
CREATE OR REPLACE VIEW View_Registros_Servidor_FE091 AS
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

-- View Servidor IS592
CREATE OR REPLACE VIEW View_Registros_Servidor_IS592 AS
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

-- View Servidor OT114
CREATE OR REPLACE VIEW View_Registros_Servidor_OT114 AS
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

-- View Servidor PA404
CREATE OR REPLACE VIEW View_Registros_Servidor_PA404 AS
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

-- View dos Tipos de Risco de cada Servidor
CREATE OR REPLACE VIEW Eyes_On_Server.view_riscos_servidores 
AS
	SELECT
	  s.id_servidor,
      s.fk_empresa,
	  COALESCE(total_alertas, 0) AS total_alertas,
	  COALESCE(qtd_alertas_prevencao, 0) AS qtd_alertas_prevencao,
	  COALESCE(qtd_alertas_perigo, 0) AS qtd_alertas_perigo,
	  COALESCE(qtd_alertas_emergencia, 0) AS qtd_alertas_emergencia,
	  CASE
		WHEN COALESCE(total_alertas, 0) >= 300 THEN
		  CASE
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Máximo'
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Muito Alto'
			WHEN COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_prevencao, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Alto'
			ELSE 'Risco Moderado'
		  END
		WHEN COALESCE(total_alertas, 0) >= 200 THEN
		  CASE
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Muito Alto'
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Alto'
			WHEN COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_prevencao, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Moderado'
			ELSE 'Risco Baixo'
		  END
		WHEN COALESCE(total_alertas, 0) >= 100 THEN
		  CASE
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Alto'
			WHEN COALESCE(qtd_alertas_emergencia, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Moderado'
			WHEN COALESCE(qtd_alertas_perigo, 0) >= COALESCE(total_alertas, 0) * 0.5 OR
				 COALESCE(qtd_alertas_prevencao, 0) >= COALESCE(total_alertas, 0) * 0.75 THEN 'Risco Baixo'
			ELSE 'Risco Muito Baixo'
		  END
		ELSE 'Sem riscos'
	  END AS nivel_de_risco
	FROM Eyes_On_Server.Servidor s
	LEFT JOIN (
	   SELECT
		fk_servidor,
		COUNT(id_alertas) AS total_alertas,
		SUM(CASE WHEN tipoAlerta = 'Prevenção' THEN 1 ELSE 0 END) AS qtd_alertas_prevencao,
		SUM(CASE WHEN tipoAlerta = 'Perigo' THEN 1 ELSE 0 END) AS qtd_alertas_perigo,
		SUM(CASE WHEN tipoAlerta = 'Emergência' THEN 1 ELSE 0 END) AS qtd_alertas_emergencia
	  FROM Eyes_On_Server.Alertas
	  WHERE DATE(data_hora_abertura) = CURDATE()
	  GROUP BY fk_servidor
	) a ON s.id_servidor = a.fk_servidor;
    
select * from Eyes_On_Server.view_riscos_servidores WHERE fk_empresa = 3; 
-- ------------------- Procedures -------------------
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
  View_Registros_Servidor_DN141;

SET @sql = CONCAT('SELECT Servidor, Momento, ', @sql, '
FROM View_Registros_Servidor_DN141
GROUP BY Servidor, Momento
ORDER BY Momento DESC'); 

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ---------------------------------