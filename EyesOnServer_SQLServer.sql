
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Eyes_On_Server')
BEGIN
    CREATE DATABASE Eyes_On_Server;
END
GO
USE Eyes_On_Server;

CREATE TABLE Empresa
(
    id_empresa INT PRIMARY KEY IDENTITY,
    nome_fantasia VARCHAR(120),
    cnpj CHAR(18) UNIQUE NOT NULL,
    email VARCHAR(120),
    cep CHAR(9)
);

CREATE TABLE Usuario
(
    id_usuario INT PRIMARY KEY IDENTITY,
    fk_empresa INT,
    nome VARCHAR(120),
    cargo INT CHECK (cargo IN (0,1)),
    email VARCHAR(120),
    CONSTRAINT FK_Empresa FOREIGN KEY(fk_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Eyes_On_Server.dbo.login
(
    id_login INT PRIMARY KEY IDENTITY,
    fk_usuario INT,
    login VARCHAR(120) UNIQUE NOT NULL,
    senha VARCHAR(16) UNIQUE NOT NULL,
    CONSTRAINT FK_Usuario FOREIGN KEY(fk_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Eyes_On_Server.dbo.Servidor
(
    id_servidor INT PRIMARY KEY IDENTITY,
    fk_empresa INT,
    nome_servidor VARCHAR(120),
    local_servidor VARCHAR(120),
    ipv6_servidor VARCHAR(39),
    mac_address CHAR(17),
    so_servidor VARCHAR(120),
    descricao VARCHAR(50),
    CONSTRAINT FK_Empresa_Servidor FOREIGN KEY(fk_empresa) REFERENCES Empresa(id_empresa)
);

CREATE TABLE Eyes_On_Server.dbo.Componente
(
    id_componente INT PRIMARY KEY IDENTITY,
    nome_componente VARCHAR(120)
);

CREATE TABLE Eyes_On_Server.dbo.Processos
(
    id_processos INT PRIMARY KEY IDENTITY,
    pid_processos BIGINT,
    nome_processos VARCHAR(120),
    uso_memoria_processos DECIMAL(4,1),
    uso_cpu_processos DECIMAL(4,1),
    fk_servidor INT,
    CONSTRAINT FK_Servidor FOREIGN KEY(fk_servidor) REFERENCES Servidor(id_servidor)
);

CREATE TABLE Eyes_On_Server.dbo.Medida
(
    id_medida INT PRIMARY KEY IDENTITY,
    nome_medida VARCHAR(30),
    simbolo_medida VARCHAR(5)
);

CREATE TABLE Eyes_On_Server.dbo.Componente_Medida
(
    id_componente_medida INT PRIMARY KEY IDENTITY,
    nome_componente_medida VARCHAR(120),
    tipo VARCHAR(80),
    fk_componente INT NOT NULL, 
    fk_medida INT NOT NULL,
    CONSTRAINT FK_Componente FOREIGN KEY(fk_componente) REFERENCES Componente(id_componente),
    CONSTRAINT FK_Medida FOREIGN KEY(fk_medida) REFERENCES Medida(id_medida)
);

CREATE TABLE Eyes_On_Server.dbo.Componente_Servidor
(
    id_componente_servidor INT PRIMARY KEY IDENTITY,
    fk_servidor INT NOT NULL, 
    fk_componente_medida INT NOT NULL,
    CONSTRAINT FK_Componente_Medida FOREIGN KEY(fk_componente_medida) REFERENCES Componente_Medida(id_componente_medida),
    CONSTRAINT FK_ComponenteServidor FOREIGN KEY(fk_servidor) REFERENCES Servidor(id_servidor)
);

CREATE TABLE Eyes_On_Server.dbo.Registro
(
    id_registro INT PRIMARY KEY IDENTITY,
    fk_componente_servidor INT,
    valor_registro VARCHAR(45),
    momento_registro DATETIME,
    CONSTRAINT FK_Componente_Servidor FOREIGN KEY(fk_componente_servidor) REFERENCES Componente_Servidor(id_componente_servidor)
);

CREATE TABLE Eyes_On_Server.dbo.Alertas
(
    id_alertas INT PRIMARY KEY IDENTITY,
    fk_empresa INT,
    fk_servidor INT,
    fk_componente INT,
    titulo_alerta VARCHAR(120),
    descricao_alerta TEXT,
    data_hora_abertura DATETIME,
    tipoAlerta VARCHAR(10),
    CONSTRAINT FK_EmpresaAlertas FOREIGN KEY(fk_empresa) REFERENCES Empresa(id_empresa),
    CONSTRAINT FK_ServidorAlertas FOREIGN KEY(fk_servidor) REFERENCES Servidor(id_servidor),
    CONSTRAINT FK_ComponenteAlertas FOREIGN KEY(fk_componente) REFERENCES Componente(id_componente)
);

CREATE TABLE Eyes_On_Server.dbo.Downtime
(
    id_downtime INT PRIMARY KEY IDENTITY,
    fk_servidor INT,
    tempo_downtime INT,
    prejuizo DECIMAL(18,1),
    momento DATETIME,
    CONSTRAINT FK_ServidorDowntime FOREIGN KEY(fk_servidor) REFERENCES Servidor(id_servidor)
);

INSERT INTO Eyes_On_Server.dbo.Empresa ( nome_fantasia, cnpj, email, cep)
VALUES
( 'Memory Analytics', '22.577.094/0001-07', 'MemoryAnalytics@outlook.com', '66026-362'),
( 'UCEAE', '99.008.198/0001-17', 'Uceae@gmail.com', '88503-015'),
( 'Eyes On Server', '53.569.582/0001-98', 'EyesOnServer@outlook.com', '81825-380');

INSERT INTO Eyes_On_Server.dbo.Usuario (fk_empresa, nome, cargo, email)
VALUES
(1, 'Isabela Noronha', 1, 'isabelaN@sptech.school'),
(1, 'Felipe Guerrino', 0, 'felipeG@sptech.school'),
(2, 'Davi Hilário', 1, 'daviH@sptech.school'),
(2, 'Gabriel Volpiani', 0, 'gabrielV@etec.gov.br'),
(3, 'Paulo Macena', 1, 'pauloM@sptech.school'),
(3, 'Otávio Walcovics', 0, 'otavioW@sptech.school'),
(3, 'Rafael Ferreira', 1, 'rafael.ferreira.gerente@outlook.com'),
(3, 'Claudio Sousa', 0, 'claudio.sousa@analista@outlook.com');

INSERT INTO Eyes_On_Server.dbo.login (fk_usuario, login, senha)
VALUES
(1, 'isabelaN@sptech.school', 'M}{CSS#WH@y;}st;'),
(2, 'felipeG@sptech.school', 'H{(T@6iAvwgo>K)0'),
(3, 'daviH@sptech.school', '2Qz#CYnYDLo!RcPP'),
(4, 'gabrielV@etec.gov.br', '?vlYtQatP;3]Txlv'),
(5, 'pauloM@sptech.school', 'Iep%ZfnPL#t$M]P4'),
(6, 'otavioW@sptech.school', 'BJtP?vUdM4nFJZ@K'),
(7, 'rafael.ferreira.gerente@outlook.com', 'Senhagerente'),
(8, 'claudio.sousa@analista@outlook.com', 'Senhaanalista');

INSERT INTO Eyes_On_Server.dbo.Servidor
    (fk_empresa, nome_servidor, local_servidor, ipv6_servidor, mac_address, so_servidor, descricao)
VALUES
    (3, 'Servidor DN141', 'Setor F5', ':db8:3333:4444:5555:6666:7777:8888', '00:1B:44:11:3A:B7', 'Windows', 'Servidor adquirido no dia 1 de outubro de 2023'),
    (3, 'Servidor DV921', 'Setor F5', ':db8:3F3F:AB12:5059:1123:9565:1841', '09:11:44:1F:3A:A9', 'Windows', 'Servidor adquirido no dia 6 de setembro de 2023'),
    (3, 'Servidor FE091', 'Setor G4', ':db8:924D:AABB:DAC2:6546:1112:9456', '0B:AB:42:10:FE:BA', 'Linux', 'Servidor adquirido no dia 7 de outubro de 2023'),
    (3, 'Servidor IS592', 'Setor G4', ':db8:ACF3:CBBC:DA32:1548:19A2:FF56', '04:D3:CC:C1:12:54', 'Windows', 'Servidor adquirido no dia 30 de setembro de 2023'),
    (3, 'Servidor OT114', 'Setor A2', ':db8:AAA2:CAA2:123D:94DD:099C:12EE', '01:12:CA:FC:00:09', 'Windows', 'Servidor adquirido no dia 27 de agosto de 2023'),
    (3, 'Servidor PA404', 'Setor B6', ':db8:AAAA:BBBB:CCCC:DDDD:EEEE:FFFF', 'FE:EA:81:00:3C:D2', 'Windows', 'Servidor adquirido no dia 29 de julho de 2023');

INSERT INTO Eyes_On_Server.dbo.Componente (nome_componente)
VALUES
('Cpu'),
('Memoria'),
('Disco'),
('Rede');



INSERT INTO Eyes_On_Server.dbo.Medida (nome_medida, simbolo_medida)
VALUES
('Temperatura', '°C'),
('PorcentagemUso', '%'),
('tamanhoGigaBytes', 'Gb'),
('Frequencia', 'Hz'),
('Latencia', 'ms'),
('bytesEnviados', 'B'),
('bytesRecebidos', 'B');



INSERT INTO Eyes_On_Server.dbo.Componente_Medida (nome_componente_medida, tipo, fk_componente, fk_medida)
VALUES
('Uso da CPU (%)', 'USO_PORCENTAGEM_CPU', 1, 2),
('Frequência da CPU (Htz)', 'FREQUENCIA_CPU', 1, 4),
('Uso da Memória (%)', 'USO_MEMORIA_PORCENTAGEM', 2, 2),
('Uso do Disco (%)', 'USO_DISCO_PORCENTAGEM', 3, 2),
('Bytes Enviados', 'BYTES_ENVIADOS_REDE', 4, 6),
('Bytes Recebidos', 'BYTES_RECEBIDOS_REDE', 4, 7);

INSERT INTO Eyes_On_Server.dbo.Componente_Servidor (fk_servidor, fk_componente_medida)
VALUES 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 3),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 4),
(5, 5),
(5, 6),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6);

SELECT * FROM Eyes_On_Server.dbo.Empresa;
SELECT * FROM Eyes_On_Server.dbo.Usuario;
SELECT * FROM Eyes_On_Server.dbo.Alertas;
SELECT * FROM Eyes_On_Server.dbo.login;
SELECT * FROM Eyes_On_Server.dbo.Servidor;
SELECT * FROM Eyes_On_Server.dbo.Componente;
SELECT * FROM Eyes_On_Server.dbo.Medida;
SELECT * FROM Eyes_On_Server.dbo.Componente_Medida;
SELECT * FROM Eyes_On_Server.dbo.Componente_Servidor;
SELECT * FROM Eyes_On_Server.dbo.Processos;
SELECT * FROM Eyes_On_Server.dbo.Registro;
SELECT * FROM Eyes_On_Server.dbo.Downtime;

SELECT 
    u.nome,
    u.email,
    u.cargo,
    e.nome_fantasia,
    l.senha
FROM Eyes_On_Server.dbo.Usuario u
JOIN Eyes_On_Server.dbo.Empresa e ON u.fk_empresa = e.id_empresa
JOIN Eyes_On_Server.dbo.Login l ON l.fk_usuario = u.id_usuario

GO

CREATE VIEW View_Registros AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida 
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor;

GO

CREATE OR ALTER VIEW View_Registros_Servidor_DN141 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 1;

GO

CREATE OR ALTER VIEW View_Registros_Servidor_DV921 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida 
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 2; -- Considerando o servidor com ID 2, correspondente ao 'DV921'

GO


CREATE OR ALTER VIEW View_Registros_Servidor_FE091 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida 
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 3; -- Considerando o servidor com ID 3, correspondente ao 'FE091'

GO

CREATE OR ALTER VIEW View_Registros_Servidor_IS592 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 4; -- Considerando o servidor com ID 4, correspondente ao 'IS592'

GO

CREATE OR ALTER VIEW View_Registros_Servidor_OT114 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 5; -- Considerando o servidor com ID 5, correspondente ao 'OT114'

GO

CREATE OR ALTER VIEW View_Registros_Servidor_PA404 AS
SELECT
    s.id_servidor AS Servidor,
    r.momento_registro AS Momento,
    r.valor_registro AS Valor,
    c.nome_componente AS Componente,
    m.nome_medida AS Medida
FROM
    Eyes_On_Server.dbo.Registro r
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.id_componente_servidor = r.fk_componente_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.dbo.Componente c ON c.id_componente = cm.fk_componente
    JOIN Eyes_On_Server.dbo.Medida m ON m.id_medida = cm.fk_medida
    JOIN Eyes_On_Server.dbo.Servidor s ON s.id_servidor = cs.fk_servidor
WHERE
    s.id_servidor = 6; -- Considerando o servidor com ID 6, correspondente ao 'PA404'
GO

CREATE OR ALTER VIEW view_riscos_servidores 
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
FROM Eyes_On_Server.dbo.Servidor s
LEFT JOIN (
    SELECT
        fk_servidor,
        COUNT(id_alertas) AS total_alertas,
        SUM(CASE WHEN tipoAlerta = 'Prevenção' THEN 1 ELSE 0 END) AS qtd_alertas_prevencao,
        SUM(CASE WHEN tipoAlerta = 'Perigo' THEN 1 ELSE 0 END) AS qtd_alertas_perigo,
        SUM(CASE WHEN tipoAlerta = 'Emergência' THEN 1 ELSE 0 END) AS qtd_alertas_emergencia
    FROM Eyes_On_Server.dbo.Alertas
    WHERE CAST(data_hora_abertura AS DATE) = CAST(GETDATE() AS DATE)
    GROUP BY fk_servidor
) a ON s.id_servidor = a.fk_servidor;


GO


CREATE OR ALTER VIEW view_componentes_servidores
AS
SELECT
    e.nome_fantasia AS empresa,
    s.nome_servidor AS servidor,
    s.so_servidor AS sistemaOperacional,
    s.mac_address AS macAddress,
    s.local_servidor AS local,
    cm.tipo AS Tipo,
    c.nome_componente AS componente,
    m.nome_medida AS medida,
    cs.id_componente_servidor AS idComponenteServidor 
FROM 
    Eyes_On_Server.dbo.Empresa e
    JOIN Eyes_On_Server.dbo.Servidor s ON s.fk_empresa = e.id_empresa
    JOIN Eyes_On_Server.dbo.Componente_Servidor cs ON cs.fk_servidor = s.id_servidor
    JOIN Eyes_On_Server.dbo.Componente_Medida cm ON cm.id_componente_medida = cs.fk_componente_medida
    JOIN Eyes_On_Server.dbo.Componente c ON cm.fk_componente = c.id_componente
    JOIN Eyes_On_Server.dbo.Medida m ON cm.fk_medida = m.id_medida;


GO

CREATE OR ALTER VIEW View_Login
AS
SELECT
    u.nome,
    e.id_empresa,
    l.login,
    l.senha
FROM
    Eyes_On_Server.dbo.Login l
    JOIN Eyes_On_Server.dbo.Usuario u ON u.id_usuario = l.fk_usuario
    JOIN Eyes_On_Server.dbo.Empresa e ON e.id_empresa = u.fk_empresa;

GO


CREATE OR ALTER VIEW View_Downtime_Servidores
AS
SELECT
    e.id_empresa,
    s.id_servidor,
    s.nome_servidor,
    s.local_servidor,
    COALESCE(d.tempo_downtime, 0) AS tempo_downtime,
    COALESCE(d.prejuizo, 0) AS prejuizo,
    COALESCE(d.momento, CONVERT(DATETIME, '19000101', 112)) AS momento
FROM
    Eyes_On_Server.dbo.Servidor s
    JOIN Eyes_On_Server.dbo.Empresa e ON e.id_empresa = s.fk_empresa
    LEFT JOIN Eyes_On_Server.dbo.Downtime d ON s.id_servidor = d.fk_servidor
ORDER BY
    s.id_servidor, s.local_servidor, d.momento DESC;


GO


CREATE OR ALTER VIEW View_Downtime_Servidores
AS
SELECT
    e.id_empresa,
    s.id_servidor,
    s.nome_servidor,
    s.local_servidor,
    COALESCE(d.tempo_downtime, 0) AS tempo_downtime,
    COALESCE(d.prejuizo, 0) AS prejuizo,
    COALESCE(d.momento, CONVERT(DATETIME, '19000101', 112)) AS momento
FROM
    Eyes_On_Server.dbo.Servidor s
    JOIN Eyes_On_Server.dbo.Empresa e ON e.id_empresa = s.fk_empresa
    LEFT JOIN Eyes_On_Server.dbo.Downtime d ON s.id_servidor = d.fk_servidor;

GO


CREATE OR ALTER PROCEDURE Cadastrar_Empresa (
    @nome_fantasia VARCHAR(120),
    @cnpj CHAR(18),
    @cep CHAR(9),
    @email_empresa VARCHAR(120),
    @nome_adm VARCHAR(120),
    @email_adm VARCHAR(120),
    @senha VARCHAR(16)
)
AS
BEGIN
    DECLARE @id_empresa INT;

    -- Habilitar a inserção explícita na coluna de identidade da tabela Empresa
    SET IDENTITY_INSERT Eyes_On_Server.dbo.Empresa ON;

    -- Inserir explicitamente o ID e os outros valores
    INSERT INTO Eyes_On_Server.dbo.Empresa ( nome_fantasia, cnpj, email, cep)
    VALUES ( @nome_fantasia, @cnpj, @email_empresa, @cep);

    -- Desativar a inserção explícita na coluna de identidade da tabela Empresa
    SET IDENTITY_INSERT Eyes_On_Server.dbo.Empresa OFF;

    -- Recuperar o último ID inserido na tabela Empresa
    SELECT @id_empresa = SCOPE_IDENTITY();

   INSERT INTO Eyes_On_Server.dbo.Usuario (fk_empresa, nome, cargo, email)
    VALUES (@id_empresa, @nome_adm, 1, @email_adm);

    INSERT INTO Eyes_On_Server.dbo.login (fk_usuario, login, senha)
    VALUES ((SELECT SCOPE_IDENTITY()), @email_adm, @senha);
END;

GO

DECLARE @ComponenteMedida VARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);

-- Construindo a lista de colunas dinamicamente
SELECT @ComponenteMedida = COALESCE(@ComponenteMedida + ', ', '') + 
  QUOTENAME(CONCAT(Componente, Medida))
FROM (
  SELECT DISTINCT Componente, Medida
  FROM View_Registros_Servidor_DN141
) AS ComponenteMedida;

SET @sql = N'
SELECT Servidor, Momento, ' + @ComponenteMedida + '
FROM View_Registros_Servidor_DN141
PIVOT (
  MAX(Valor) FOR CONCAT(Componente, Medida) IN (' + @ComponenteMedida + ')
) AS PivotTable
GROUP BY Servidor, Momento
ORDER BY Momento DESC;';

-- Executando a consulta dinâmica

EXEC sp_executesql @sql;






