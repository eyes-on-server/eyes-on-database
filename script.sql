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

-- Tabela Comandos
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Comandos(
	id_comandos INT PRIMARY KEY AUTO_INCREMENT,
    nome_comando VARCHAR(120),
    comando_java VARCHAR(120),
    comando_python VARCHAR(120)
);

-- Taela ComponenteMedida
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Componente_Medida(
	id_componente_medida INT PRIMARY KEY AUTO_INCREMENT,
    nome_componente_medida VARCHAR(120),
    fk_componente INT NOT NULL, 
    fk_medida INT NOT NULL,
    fk_comando INT,
    FOREIGN KEY(fk_componente) REFERENCES Eyes_On_Server.Componente(id_componente),
    FOREIGN KEY(fk_medida) REFERENCES Eyes_On_Server.Medida(id_medida),
    FOREIGN KEY(fk_comando) REFERENCES Eyes_On_Server.Comandos(id_comandos)
);

-- Taela ComponenteServidor
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Componente_Servidor(
	id_componente_servidor INT PRIMARY KEY AUTO_INCREMENT,
    fk_servidor INT NOT NULL, 
    fk_componente_medida INT NOT NULL,
    FOREIGN KEY(fk_componente_medida) REFERENCES Eyes_On_Server.Componente_Medida(id_componente_medida),
    FOREIGN KEY(fk_servidor) REFERENCES Eyes_On_Server.Servidor(id_servidor)
);

-- Tabela Registro
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Registro
(
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
    fk_componente_servidor INT,
    valor_registro VARCHAR(45),
    momento_registro DATETIME,
    FOREIGN KEY(fk_componente_servidor) REFERENCES Eyes_On_Server.Componente_Servidor(id_componente_servidor)
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

-- Tabela Downtime
CREATE TABLE IF NOT EXISTS Eyes_On_Server.Downtime(
	id_downtime INT PRIMARY KEY AUTO_INCREMENT,
    fk_servidor INT,
    tempo_downtime INT,
    prejuizo DECIMAL(63,1),
    momento datetime,
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
(NULL, 3, "Otávio Walcovics", 0, "otavioW@sptech.school"),
(NULL, 3, "Rafael Ferreira", 1, "rafael.ferreira.gerente@outlook.com"),
(NULL, 3, "Claudio Sousa", 0, "claudio.sousa@analista@outlook.com");

-- Tabela Login
INSERT INTO Eyes_On_Server.Login VALUES
(NULL, 1, "isabelaN@sptech.school", "M}{CSS#WH@y;}st;"),
(NULL, 2, "felipeG@sptech.school", "H{(T@6iAvwgo>K)0"),
(NULL, 3, "daviH@sptech.school", "2Qz#CYnYDLo!RcPP"),
(NULL, 4, "gabrielV@etec.gov.br", "?vlYtQatP;3]Txlv"),
(NULL, 5, "pauloM@sptech.school", "Iep%ZfnPL#t$M]P4"),
(NULL, 6, "otavioW@sptech.school", "BJtP?vUdM4nFJZ@K"),
(NULL, 7, "rafael.ferreira.gerente@outlook.com", "Senhagerente"),
(NULL, 8, "claudio.sousa@analista@outlook.com", "Senhaanalista");

-- Tabela Servidor
INSERT INTO Eyes_On_Server.Servidor
    (fk_empresa, nome_servidor, local_servidor, ipv6_servidor, mac_address, so_servidor, descricao)
VALUES
    (3, "Servidor DN141", "Setor F5", ":db8:3333:4444:5555:6666:7777:8888", "00:1B:44:11:3A:B7", "Windows", "Servidor adquirido no dia 1 de outubro de 2023"),
    (3, "Servidor DV921", "Setor F5", ":db8:3F3F:AB12:5059:1123:9565:1841", "09:11:44:1F:3A:A9", "Windows", "Servidor adquirido no dia 6 de setembro de 2023"),
    (3, "Servidor FE091", "Setor G4", ":db8:924D:AABB:DAC2:6546:1112:9456", "0B:AB:42:10:FE:BA", "Linux", "Servidor adquirido no dia 7 de outubro de 2023"),
    (3, "Servidor IS592", "Setor G4", ":db8:ACF3:CBBC:DA32:1548:19A2:FF56", "04:D3:CC:C1:12:54", "Windows", "Servidor adquirido no dia 30 de setembro de 2023"),
    (3, "Servidor OT114", "Setor A2", ":db8:AAA2:CAA2:123D:94DD:099C:12EE", "01:12:CA:FC:00:09", "Windows", "Servidor adquirido no dia 27 de agosto de 2023"),
    (3, "Servidor PA404", "Setor B6", ":db8:AAAA:BBBB:CCCC:DDDD:EEEE:FFFF", "FE:EA:81:00:3C:D2", "Windows", "Servidor adquirido no dia 29 de julho de 2023");

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

-- Tabela Comandos
INSERT INTO Eyes_On_Server.Comandos VALUES
(NULL, "Frequência da CPU", "org.example.looca.cpu.CpuFrequencia", ""),
(NULL, "Uso da CPU", "org.example.looca.cpu.CpuUso", ""),
(NULL, "Memória em Uso", "org.example.looca.memoria.MemoriaUso", ""),
(NULL, "Disco em Uso", "org.example.looca.disco.DiscoUso", ""),
(NULL, "Bytes Enviados", "org.example.looca.rede.RedeBytesEnviados", ""),
(NULL, "Bytes Recebidos", "org.example.looca.rede.RedeBytesRecebidos", "");

-- Tabela Componente Medida
INSERT INTO Eyes_On_Server.Componente_Medida VALUES
(NULL, "Uso da CPU (%)", 1, 2, 2),
(NULL, "Frequência da CPU (Htz)", 1, 4, 1),
(NULL, "Uso da Memória (%)", 2, 2, 3),
(NULL, "Uso do Disco (%)", 3, 2, 4),
(NULL, "Bytes Enviados", 4, 6, 5),
(NULL, "Bytes Recebidos", 4, 7, 6);

-- Tabela Componente Servidor
INSERT INTO Eyes_On_Server.Componente_Servidor VALUES 
(NULL, 1, 1),
(NULL, 1, 2),
(NULL, 1, 3),
(NULL, 1, 4),
(NULL, 1, 5),
(NULL, 1, 6),
(NULL, 2, 1),
(NULL, 2, 2),
(NULL, 2, 3),
(NULL, 2, 4),
(NULL, 3, 1),
(NULL, 3, 3),
(NULL, 4, 1),
(NULL, 4, 2),
(NULL, 4, 3),
(NULL, 4, 4),
(NULL, 4, 5),
(NULL, 4, 6),
(NULL, 5, 1),
(NULL, 5, 4),
(NULL, 5, 5),
(NULL, 5, 6),
(NULL, 6, 1),
(NULL, 6, 2),
(NULL, 6, 3),
(NULL, 6, 4),
(NULL, 6, 5),
(NULL, 6, 6);

-- ------------------- Selects -------------------

SELECT * FROM Eyes_On_Server.Empresa;
SELECT * FROM Eyes_On_Server.Usuario;
SELECT * FROM Eyes_On_Server.Alertas;
SELECT * FROM Eyes_On_Server.Login;
SELECT * FROM Eyes_On_Server.Servidor;
SELECT * FROM Eyes_On_Server.Componente;
SELECT * FROM Eyes_On_Server.Medida;
SELECT * FROM Eyes_On_Server.Comandos;
SELECT * FROM Eyes_On_Server.Componente_Medida;
SELECT * FROM Eyes_On_Server.Componente_Servidor;
SELECT * FROM Eyes_On_Server.Processos;
SELECT * FROM Eyes_On_Server.Registro;
SELECT * FROM Eyes_On_Server.Downtime;

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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida 
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor
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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor and cs.fk_servidor = 1
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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida 
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor and cs.fk_servidor = 2
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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida 
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor and cs.fk_servidor = 3
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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor and cs.fk_servidor = 4
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
	JOIN Eyes_On_Server.Componente_Servidor cs on cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida
	join Eyes_On_Server.Componente c on c.id_componente = cm.fk_componente
	join Eyes_On_Server.Medida m on m.id_medida = cm.fk_medida
    join Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor and cs.fk_servidor = 5
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
	JOIN Eyes_On_Server.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
	JOIN Eyes_On_Server.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
	JOIN Eyes_On_Server.Componente c ON c.id_componente = cm.fk_componente
	JOIN Eyes_On_Server.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.Servidor s ON s.id_servidor = cs.fk_servidor AND cs.fk_servidor = 6
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

-- Empresa, Servidor, Componente, Medida
CREATE OR REPLACE VIEW Eyes_On_Server.view_componentes_servidores
AS
SELECT
	e.nome_fantasia `empresa`,
	s.nome_servidor `servidor`, 
    s.so_servidor `sistemaOperacional`,
    s.mac_address `macAddress`,
    s.local_servidor `local`,
    c.nome_componente `componente`,
    m.nome_medida `medida`,
    cd.comando_java `comandoJava`,
    cd.comando_python `comandoPython`
FROM Eyes_On_Server.Empresa e
	JOIN Eyes_On_Server.Servidor s on s.fk_empresa = e.id_empresa
    JOIN Eyes_On_Server.Componente_Servidor cs on cs.fk_servidor = s.id_servidor
    JOIN Eyes_On_Server.Componente_Medida cm on cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.Componente c on cm.fk_componente = c.id_componente
    JOIN Eyes_On_Server.Medida m on cm.fk_medida = m.id_medida
    JOIN Eyes_On_Server.Comandos cd on cm.fk_comando = cd.id_comandos;

-- Login, Usuario e Empresa
CREATE OR REPLACE VIEW Eyes_On_Server.View_Login
AS
SELECT
	u.nome,
    e.id_empresa,
    l.login,
    l.senha
FROM Eyes_On_Server.Login l
	JOIN Eyes_On_Server.Usuario u ON u.id_usuario = l.fk_usuario
    JOIN Eyes_On_Server.Empresa e ON e.id_empresa = u.fk_empresa;

CREATE OR REPLACE VIEW View_Downtime_Servidores
AS
SELECT
	e.id_empresa,
	s.id_servidor,
    s.nome_servidor,
    s.local_servidor,
    COALESCE(d.tempo_downtime,0) tempo_downtime,
    COALESCE(d.prejuizo,0) prejuizo,
    COALESCE(d.momento,0) momento
FROM Eyes_On_Server.Downtime d
	RIGHT JOIN Eyes_On_Server.Servidor s ON s.id_servidor = d.fk_servidor
	JOIN Eyes_On_Server.Empresa e ON e.id_empresa = s.fk_empresa
ORDER BY d.fk_servidor, s.local_servidor, d.momento DESC;

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

SELECT max(momento_registro) FROM Eyes_On_Server.Registro r
	JOIN Eyes_On_Server.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.Servidor s ON s.id_servidor = cs.fk_servidor
    WHERE s.id_servidor = (
		SELECT fk_servidor FROM Eyes_On_Server.Servidor s
        JOIN Eyes_On_Server.Componente_Servidor cs ON cs.fk_servidor = s.id_servidor
        LIMIT 1
    );

-- ------------------- Trigger -------------------
select * from view_registros;
DELIMITER //

CREATE TRIGGER verificar_downtime
AFTER INSERT ON Eyes_On_Server.Registro
FOR EACH ROW
BEGIN
    DECLARE ultimo_momento_registro DATETIME;
    DECLARE penultimo_momento_registro DATETIME;
    DECLARE diferenca_segundos INT;
    DECLARE fk_servidor INT;
    DECLARE prejuizo_por_segundo DECIMAL (63,1);
    DECLARE margem INT;
    
    SET margem = 25;
    SET prejuizo_por_segundo = 1111111.1;
	
    SELECT cs.fk_servidor INTO fk_servidor
    FROM Eyes_On_Server.Registro r
		JOIN Eyes_On_Server.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
		JOIN Eyes_On_Server.Servidor s on s.id_servidor = cs.fk_servidor
    WHERE id_componente_servidor = NEW.fk_componente_servidor
    LIMIT 1;
    
    SELECT MAX(Momento) INTO ultimo_momento_registro
    FROM View_Registros
    WHERE Servidor = fk_servidor;
    
    SELECT MAX(Momento) INTO penultimo_momento_registro
    FROM View_Registros
    WHERE Servidor = fk_servidor AND Momento < ultimo_momento_registro;
    
    IF penultimo_momento_registro IS NOT NULL 
    THEN
		SET diferenca_segundos = TIMESTAMPDIFF(SECOND, penultimo_momento_registro, ultimo_momento_registro);
        
		IF diferenca_segundos > margem
        THEN
			INSERT INTO Eyes_On_Server.Downtime VALUES (NULL, fk_servidor, diferenca_segundos - margem, (diferenca_segundos - margem) * prejuizo_por_segundo, now());
		END IF;
        
	END IF;
END;
//

DELIMITER ;