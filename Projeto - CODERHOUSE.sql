CREATE DATABASE [Faculdade]
GO
USE Faculdade

CREATE TABLE TBL_TURMAS (
    id_turma INT PRIMARY KEY IDENTITY(1,1),
    turno VARCHAR(100),
    alunos INT,
    disciplina VARCHAR(100)
);


CREATE TABLE TBL_PROFESSORES (
    id_professor INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100),
    telefone VARCHAR(100),
    email VARCHAR(100),
    id_turma INT FOREIGN KEY REFERENCES TBL_TURMAS(id_turma),
    turno VARCHAR(100)
);


CREATE TABLE TBL_CURSOS (
    id_curso INT PRIMARY KEY IDENTITY(1,1),
    id_professor INT FOREIGN KEY REFERENCES TBL_PROFESSORES(id_professor),
    tipo_graduacao VARCHAR(100),
    turno VARCHAR(100),
    carga_horaria VARCHAR(100),
    sala INT,
    disciplina VARCHAR(100),
    custo_mensalidade DECIMAL(8,2)
);


CREATE TABLE TBL_STATUS_MATRICULA (
    status VARCHAR(100) PRIMARY KEY,	
    desc_status VARCHAR(100)
);



CREATE TABLE TBL_ALUNOS (
    id_matricula INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100),
    telefone VARCHAR(100),
    email VARCHAR(100),
    endereco VARCHAR(100),
    id_curso INT FOREIGN KEY REFERENCES TBL_CURSOS(id_curso),
    id_turma INT FOREIGN KEY REFERENCES TBL_TURMAS(id_turma),
    turno VARCHAR(100),
    status_matricula VARCHAR(100) FOREIGN KEY REFERENCES TBL_STATUS_MATRICULA(status),
    login VARCHAR(100),
    senha VARCHAR(100)
);


CREATE TABLE TBL_PAGAMENTO (
    id_pagamento INT PRIMARY KEY IDENTITY(1,1),
    id_matricula INT FOREIGN KEY REFERENCES TBL_ALUNOS(id_matricula),
    bolsista VARCHAR(100),
    vlr_mensalidade DECIMAL(8,2),
    forma_pgmt VARCHAR(100),
    status_pgmt VARCHAR(100),
    mes INT
);

CREATE TABLE TBL_APROVACAO (
    id_aprovacao INT PRIMARY KEY IDENTITY(1,1),
    id_matricula INT FOREIGN KEY REFERENCES TBL_ALUNOS(id_matricula),
    id_professor INT FOREIGN KEY REFERENCES TBL_PROFESSORES(id_professor),
    tipo_graduacao VARCHAR(100),
    id_curso INT FOREIGN KEY REFERENCES TBL_CURSOS(id_curso),
    id_turma INT FOREIGN KEY REFERENCES TBL_TURMAS(id_turma),
    frequencia DECIMAL(5,2),
    nota DECIMAL(3,1),
    status_aprovacao VARCHAR(100)
);


CREATE TABLE TBL_TRABALHOS (
    id_trabalho INT PRIMARY KEY IDENTITY(1,1),
    id_matricula INT FOREIGN KEY REFERENCES TBL_ALUNOS(id_matricula),
    id_turma INT FOREIGN KEY REFERENCES TBL_TURMAS(id_turma),
    nota DECIMAL(3,1),
    status_aprovacao VARCHAR(100),
    data_limite DATE,
    data_entrega DATE,
    disciplina VARCHAR(100)
);


ALTER TABLE TBL_PAGAMENTO
ADD CONSTRAINT FK_PAGAMENTO_MATRICULA
FOREIGN KEY (id_matricula) REFERENCES TBL_ALUNOS(id_matricula);


--------------------------------

-- Inserção na tabela TBL_TURMAS
INSERT INTO TBL_TURMAS (turno, alunos, disciplina) VALUES
	
	('Manhã', 7, 'Economia'),
	('Manhã', 10, 'Economia'),
    ('Manhã', 10, 'Administração'),
    ('Manhã', 10, 'Administração'),
    ('Manhã', 8, 'Análise de sistemas'),
    ('Manhã', 8, 'Análise de sistemas');

-- Inserção na tabela TBL_PROFESSORES

INSERT INTO TBL_PROFESSORES (nome, telefone, email, id_turma, turno) VALUES

	('João Silva', '(11) 1234-5678', 'joao.silva@email.com', 1, 'Manhã'),
    ('Maria Oliveira', '(11) 2345-6789', 'maria.oliveira@email.com', 2, 'Manhã'),
    ('Carlos Santos', '(11) 3456-7890', 'carlos.santos@email.com', 3, 'Manhã'),
	('Patrícia Lima', '(11) 4567-8901', 'patricia.lima@email.com', 1, 'Manhã'),
    ('Roberto Costa', '(11) 5678-9012', 'roberto.costa@email.com', 2, 'Manhã'),
    ('Fernanda Oliveira', '(11) 6789-0123', 'fernanda.oliveira@email.com', 3, 'Manhã');

-- Inserção na tabela TBL_STATUS_MATRICULA

INSERT INTO TBL_STATUS_MATRICULA (status, desc_status) VALUES
	
	('Ativo', 'Matrícula Ativa'),
    ('Inativo', 'Matrícula Inativa'),
    ('Trancado', 'Matrícula Trancada'),
    ('Concluído', 'Matrícula Concluída');

-- Inserção na tabela TBL_CURSOS

INSERT INTO TBL_CURSOS (id_professor, tipo_graduacao, turno, carga_horaria, sala, disciplina, custo_mensalidade) VALUES
	
	(1, 'Bacharelado', 'Manhã', '120:00:00', 101, 'Economia', 1000.00),
    (2, 'Bacharelado', 'Manhã', '90:00:00', 201, 'Administração', 800.00),
    (3, 'Bacharelado', 'Manhã', '80:00:00', 301, 'Análise de sistemas', 1000.00);


-- Inserção na tabela TBL_ALUNOS

INSERT INTO TBL_ALUNOS (nome, telefone, email, endereco, id_curso, id_turma, turno, status_matricula, login, senha) VALUES

	('Ana Lima', '(11) 4567-8901', 'ana.lima@email.com', 'Rua A, 123', 1, 1, 'Manhã', 'Ativo', 'ana.lima', 'senha123'),
    ('Pedro Santos', '(11) 5678-9012', 'pedro.santos@email.com', 'Rua B, 456', 1, 2, 'Tarde', 'Ativo', 'pedro.santos', 'senha456'),
    ('Camila Oliveira', '(11) 6789-0123', 'camila.oliveira@email.com', 'Rua C, 789', 1, 3, 'Manhã', 'Trancado', 'camila.oliveira', 'senha789'),
	('Lucas Oliveira', '(11) 1234-5678', 'lucas.oliveira@email.com', 'Rua X, 123', 1, 1, 'Manhã', 'Ativo', 'lucas.oliveira', 'senha123'),
    ('Isabel Silva', '(11) 2345-6789', 'isabel.silva@email.com', 'Rua Y, 456', 1, 1, 'Tarde', 'Ativo', 'isabel.silva', 'senha456'),
    ('Mariana Costa', '(11) 3456-7890', 'mariana.costa@email.com', 'Rua Z, 789', 1, 2, 'Noite', 'Ativo', 'mariana.costa', 'senha789'),
    ('Rafaela Souza', '(11) 4567-8901', 'rafaela.souza@email.com', 'Rua W, 012', 1, 2, 'Manhã', 'Trancado', 'rafaela.souza', 'senha987'),
    ('Carlos Pereira', '(11) 5678-9012', 'carlos.pereira@email.com', 'Rua V, 345', 1, 3, 'Tarde', 'Ativo', 'carlos.pereira', 'senha654'),
    ('Ana Souza', '(11) 6789-0123', 'ana.lima@email.com', 'Rua U, 678', 1, 3, 'Noite', 'Ativo', 'ana.lima', 'senha321'),
    ('Pedro Santos', '(11) 7890-1234', 'pedro.santos@email.com', 'Rua T, 901', 1, 1, 'Manhã', 'Ativo', 'pedro.santos', 'senha789'),
    ('Camila Oliveira', '(11) 8901-2345', 'camila.oliveira@email.com', 'Rua S, 234', 1, 2, 'Tarde', 'Ativo', 'camila.oliveira', 'senha012'),
    ('José Silva', '(11) 9012-3456', 'jose.silva@email.com', 'Rua R, 567', 1, 1, 'Manhã', 'Ativo', 'jose.silva', 'senha345'),
    ('Andreia Costa', '(11) 0123-4567', 'andreia.costa@email.com', 'Rua Q, 890', 1, 3, 'Tarde', 'Ativo', 'andreia.costa', 'senha567'),
	('Fernanda Oliveira', '(11) 2345-6789', 'fernanda.oliveira@email.com', 'Rua P, 567', 1, 2, 'Manhã', 'Ativo', 'fernanda.oliveira', 'senha789'),
    ('Rodrigo Santos', '(11) 3456-7890', 'rodrigo.santos@email.com', 'Rua O, 890', 1, 3, 'Tarde', 'Ativo', 'rodrigo.santos', 'senha012'),
    ('Patricia Lima', '(11) 4567-8901', 'patricia.lima@email.com', 'Rua N, 123', 2, 1, 'Noite', 'Trancado', 'patricia.lima', 'senha987'),
    ('Anderson Silva', '(11) 5678-9012', 'anderson.silva@email.com', 'Rua M, 456', 2, 1, 'Noite', 'Ativo', 'anderson.silva', 'senha654'),
    ('Carolina Costa', '(11) 6789-0123', 'carolina.costa@email.com', 'Rua L, 789', 2, 2, 'Manhã', 'Ativo', 'carolina.costa', 'senha321'),
    ('Gabriel Pereira', '(11) 7890-1234', 'gabriel.pereira@email.com', 'Rua K, 012', 2, 2, 'Tarde', 'Ativo', 'gabriel.pereira', 'senha789'),
    ('Raquel Santos', '(11) 8901-2345', 'raquel.santos@email.com', 'Rua J, 234', 2, 3, 'Noite', 'Ativo', 'raquel.santos', 'senha012'),
    ('Leandro Lima', '(11) 9012-3456', 'leandro.lima@email.com', 'Rua I, 567', 2, 1, 'Manhã', 'Ativo', 'leandro.lima', 'senha345'),
    ('Juliana Oliveira', '(11) 0123-4567', 'juliana.oliveira@email.com', 'Rua H, 890', 2, 3, 'Tarde', 'Ativo', 'juliana.oliveira', 'senha567'),
    ('Renato Silva', '(11) 1234-5678', 'renato.silva@email.com', 'Rua G, 123', 2, 2, 'Noite', 'Ativo', 'renato.silva', 'senha789'),
	('Thiago Oliveira', '(11) 2345-6789', 'thiago.oliveira@email.com', 'Rua F, 567', 2, 2, 'Manhã', 'Ativo', 'thiago.oliveira', 'senha789'),
    ('Ana Santos', '(11) 3456-7890', 'ana.santos@email.com', 'Rua E, 890', 2, 3, 'Tarde', 'Ativo', 'ana.santos', 'senha012'),
    ('Roberto Lima', '(11) 4567-8901', 'roberto.lima@email.com', 'Rua D, 123', 2, 1, 'Noite', 'Trancado', 'roberto.lima', 'senha987'),
    ('Tatiane Silva', '(11) 5678-9012', 'tatiane.silva@email.com', 'Rua C, 456', 2, 1, 'Noite', 'Ativo', 'tatiane.silva', 'senha654'),
    ('Eduardo Costa', '(11) 6789-0123', 'eduardo.costa@email.com', 'Rua B, 789', 2, 2, 'Manhã', 'Ativo', 'eduardo.costa', 'senha321'),
    ('Vanessa Pereira', '(11) 7890-1234', 'vanessa.pereira@email.com', 'Rua A, 012', 2, 2, 'Tarde', 'Ativo', 'vanessa.pereira', 'senha789'),
    ('Marcelo Santos', '(11) 8901-2345', 'marcelo.santos@email.com', 'Rua Z, 234', 2, 3, 'Noite', 'Ativo', 'marcelo.santos', 'senha012'),
    ('Aline Lima', '(11) 9012-3456', 'aline.lima@email.com', 'Rua Y, 567', 2, 1, 'Manhã', 'Ativo', 'aline.lima', 'senha345'),
    ('Fernando Oliveira', '(11) 0123-4567', 'fernando.oliveira@email.com', 'Rua X, 890', 2, 3, 'Tarde', 'Ativo', 'fernando.oliveira', 'senha567'),
    ('Renata Silva', '(11) 1234-5678', 'renata.silva@email.com', 'Rua W, 123', 2, 2, 'Noite', 'Ativo', 'renata.silva', 'senha789'),
	('Luciana Oliveira', '(11) 2345-6789', 'luciana.oliveira@email.com', 'Rua V, 567', 3, 1, 'Manhã', 'Ativo', 'luciana.oliveira', 'senha789'),
    ('Robson Santos', '(11) 3456-7890', 'robson.santos@email.com', 'Rua U, 890', 3, 2, 'Tarde', 'Ativo', 'robson.santos', 'senha012'),
    ('Paula Lima', '(11) 4567-8901', 'paula.lima@email.com', 'Rua T, 123', 3, 3, 'Noite', 'Trancado', 'paula.lima', 'senha987'),
    ('Vitor Silva', '(11) 5678-9012', 'vitor.silva@email.com', 'Rua S, 456', 3, 1, 'Noite', 'Ativo', 'vitor.silva', 'senha654'),
    ('Eliane Costa', '(11) 6789-0123', 'eliane.costa@email.com', 'Rua R, 789', 3, 2, 'Manhã', 'Ativo', 'eliane.costa', 'senha321'),
    ('Gustavo Pereira', '(11) 7890-1234', 'gustavo.pereira@email.com', 'Rua Q, 012', 3, 3, 'Tarde', 'Ativo', 'gustavo.pereira', 'senha789'),
    ('Bianca Santos', '(11) 8901-2345', 'bianca.santos@email.com', 'Rua P, 234', 3, 2, 'Noite', 'Ativo', 'bianca.santos', 'senha012'),
    ('Leonardo Lima', '(11) 9012-3456', 'leonardo.lima@email.com', 'Rua O, 567', 3, 3, 'Manhã', 'Ativo', 'leonardo.lima', 'senha345'),
    ('Carla Oliveira', '(11) 0123-4567', 'carla.oliveira@email.com', 'Rua N, 890', 3, 1, 'Tarde', 'Ativo', 'carla.oliveira', 'senha567'),
    ('Vinicius Silva', '(11) 1234-5678', 'vinicius.silva@email.com', 'Rua M, 123', 3, 2, 'Noite', 'Ativo', 'vinicius.silva', 'senha789'),
    ('Rita Costa', '(11) 2345-6789', 'rita.costa@email.com', 'Rua L, 567', 3, 1, 'Manhã', 'Ativo', 'rita.costa', 'senha012'),
    ('Marcos Pereira', '(11) 3456-7890', 'marcos.pereira@email.com', 'Rua K, 890', 3, 3, 'Tarde', 'Ativo', 'marcos.pereira', 'senha789'),
    ('Simone Lima', '(11) 4567-8901', 'simone.lima@email.com', 'Rua J, 123', 3, 1, 'Noite', 'Trancado', 'simone.lima', 'senha987'),
    ('André Silva', '(11) 5678-9012', 'andre.silva@email.com', 'Rua I, 456', 3, 2, 'Noite', 'Ativo', 'andre.silva', 'senha654'),
    ('Fernando Costa', '(11) 6789-0123', 'fernando.costa@email.com', 'Rua H, 789', 3, 2, 'Manhã', 'Ativo', 'fernando.costa', 'senha321'),
    ('Camila Pereira', '(11) 7890-1234', 'camila.pereira@email.com', 'Rua G, 012', 3, 2, 'Tarde', 'Ativo', 'camila.pereira', 'senha789'),
    ('Ricardo Santos', '(11) 8901-2345', 'ricardo.santos@email.com', 'Rua F, 234', 3, 3, 'Noite', 'Ativo', 'ricardo.santos', 'senha012'),
    ('Julia Oliveira', '(11) 9012-3456', 'julia.oliveira@email.com', 'Rua E, 567', 3, 1, 'Manhã', 'Ativo', 'julia.oliveira', 'senha345'),
    ('Hugo Silva', '(11) 0123-4567', 'hugo.silva@email.com', 'Rua D, 890', 3, 3, 'Tarde', 'Ativo', 'hugo.silva', 'senha567'),
    ('Daniela Lima', '(11) 1234-5678', 'daniela.lima@email.com', 'Rua C, 123', 3, 2, 'Noite', 'Ativo', 'daniela.lima', 'senha789');
	;

-- Inserção na tabela TBL_PAGAMENTO
INSERT INTO TBL_PAGAMENTO (id_matricula, bolsista, vlr_mensalidade, forma_pgmt, status_pgmt, mes) VALUES
    
	(1, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (2, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (3, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(4, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (5, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (6, 'Não', 1000.00, 'Cartão', 'Pendente', 1),
	(7, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (8, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (9, 'Não', 1000.00, 'Cartão', 'Pendente', 1),
	(10, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (11, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (12, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(13, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (14, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (15, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(16, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (17, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (18, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(19, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (20, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (21, 'Não', 1000.00, 'Cartão', 'Pendente', 1),
	(22, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (23, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (24, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(25, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (26, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (27, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(28, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (29, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (30, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(31, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (32, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (33, 'Não', 1000.00, 'Cartão', 'Pago', 1),
    (34, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (35, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(36, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (37, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (38, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(39, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (40, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (41, 'Não', 1000.00, 'Cartão', 'Pendente', 1),
	(42, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (43, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (44, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(45, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (46, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (47, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(48, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (49, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (50, 'Não', 1000.00, 'Cartão', 'Pago', 1),
	(51, 'Não', 1000.00, 'Boleto', 'Pago', 1),
    (52, 'Não', 800.00, 'Dinheiro', 'Pago', 1),
    (53, 'Não', 1000.00, 'Cartão', 'Pago', 1);

-- Inserção na tabela TBL_APROVACAO

INSERT INTO TBL_APROVACAO (id_matricula, id_professor, tipo_graduacao, id_curso, id_turma, frequencia, nota, status_aprovacao) VALUES
    
    (1, 1, 'Bacharelado', 1, 1, 0.85, 8.5, 'Aprovado'),
    (2, 2, 'Licenciatura', 2, 2, 0.63, 7.2, 'Aprovado'),
    (3, 3, 'Tecnólogo', 3, 3, 0.92, 9.3, 'Aprovado'),
    (4, 1, 'Bacharelado', 1, 1, 0.78, 8.7, 'Aprovado'),
    (5, 2, 'Licenciatura', 2, 2, 0.72, 7.5, 'Aprovado'),
    (6, 3, 'Tecnólogo', 3, 3, 0.88, 9.1, 'Aprovado'),
    (7, 1, 'Bacharelado', 1, 1, 0.80, 8.6, 'Aprovado'),
    (8, 2, 'Licenciatura', 2, 2, 0.68, 7.3, 'Aprovado'),
    (9, 3, 'Tecnólogo', 3, 3, 0.91, 9.2, 'Aprovado'),
    (10, 1, 'Bacharelado', 1, 1, 0.83, 8.4, 'Aprovado'),
    (11, 2, 'Licenciatura', 2, 2, 0.69, 7.8, 'Aprovado'),
    (12, 3, 'Tecnólogo', 3, 3, 0.87, 9.5, 'Aprovado'),
    (13, 1, 'Bacharelado', 1, 1, 0.79, 8.8, 'Aprovado'),
    (14, 2, 'Licenciatura', 2, 2, 0.71, 7.1, 'Aprovado'),
    (15, 3, 'Tecnólogo', 3, 3, 0.89, 9.4, 'Aprovado'),
    (16, 1, 'Bacharelado', 1, 1, 0.82, 8.3, 'Aprovado'),
    (17, 2, 'Licenciatura', 2, 2, 0.67, 7.6, 'Aprovado'),
    (18, 3, 'Tecnólogo', 3, 3, 0.86, 9.6, 'Aprovado'),
    (19, 1, 'Bacharelado', 1, 1, 0.81, 8.9, 'Aprovado'),
    (20, 2, 'Licenciatura', 2, 2, 0.73, 7.4, 'Aprovado'),
    (21, 3, 'Tecnólogo', 3, 3, 0.93, 9.7, 'Aprovado'),
    (22, 1, 'Bacharelado', 1, 1, 0.84, 8.2, 'Aprovado'),
    (23, 2, 'Licenciatura', 2, 2, 0.66, 7.9, 'Aprovado'),
    (24, 3, 'Tecnólogo', 3, 3, 0.85, 9.8, 'Aprovado'),
    (25, 1, 'Bacharelado', 1, 1, 0.77, 8.1, 'Aprovado'),
    (26, 2, 'Licenciatura', 2, 2, 0.74, 7.7, 'Aprovado'),
    (27, 3, 'Tecnólogo', 3, 3, 0.94, 9.9, 'Aprovado'),
    (28, 1, 'Bacharelado', 1, 1, 0.76, 8.0, 'Aprovado'),
    (29, 2, 'Licenciatura', 2, 2, 0.65, 7.8, 'Aprovado'),
    (30, 3, 'Tecnólogo', 3, 3, 0.84, 9.7, 'Aprovado'),
    (31, 1, 'Bacharelado', 1, 1, 0.75, 8.3, 'Aprovado'),
    (32, 2, 'Licenciatura', 2, 2, 0.64, 7.5, 'Aprovado'),
    (33, 3, 'Tecnólogo', 3, 3, 0.83, 9.4, 'Aprovado'),
    (34, 1, 'Bacharelado', 1, 1, 0.74, 8.4, 'Aprovado'),
    (35, 2, 'Licenciatura', 2, 2, 0.63, 7.6, 'Aprovado'),
    (36, 3, 'Tecnólogo', 3, 3, 0.82, 9.5, 'Aprovado'),
    (37, 1, 'Bacharelado', 1, 1, 0.73, 8.5, 'Aprovado'),
    (38, 2, 'Licenciatura', 2, 2, 0.62, 7.7, 'Aprovado'),
    (39, 3, 'Tecnólogo', 3, 3, 0.81, 9.6, 'Aprovado'),
    (40, 1, 'Bacharelado', 1, 1, 0.72, 8.6, 'Aprovado'),
    (41, 2, 'Licenciatura', 2, 2, 0.61, 7.8, 'Aprovado'),
    (42, 3, 'Tecnólogo', 3, 3, 0.80, 9.7, 'Aprovado'),
    (43, 1, 'Bacharelado', 1, 1, 0.71, 8.7, 'Aprovado'),
    (44, 2, 'Licenciatura', 2, 2, 0.60, 7.9, 'Aprovado'),
    (45, 3, 'Tecnólogo', 3, 3, 0.79, 9.8, 'Aprovado'),
    (46, 1, 'Bacharelado', 1, 1, 0.70, 8.8, 'Aprovado'),
    (47, 2, 'Licenciatura', 2, 2, 0.59, 7.2, 'Aprovado'),
    (48, 3, 'Tecnólogo', 3, 3, 0.78, 9.9, 'Aprovado'),
    (49, 1, 'Bacharelado', 1, 1, 0.69, 8.9, 'Aprovado'),
    (50, 2, 'Licenciatura', 2, 2, 0.58, 7.3, 'Aprovado'),
    (51, 3, 'Tecnólogo', 3, 3, 0.77, 9.2, 'Aprovado'),
    (52, 1, 'Bacharelado', 1, 1, 0.68, 8.2, 'Aprovado'),
    (53, 2, 'Licenciatura', 2, 2, 0.57, 7.4, 'Aprovado');


--Truncate table TBL_APROVACAO


-- Inserção na tabela TBL_TRABALHOS

INSERT INTO TBL_TRABALHOS (id_matricula, id_turma, nota, status_aprovacao, data_limite, data_entrega, disciplina) VALUES
	
	(1, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (1, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (2, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),
	(2, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (3, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (3, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(4, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (4, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (5, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(5, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (6, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (6, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(7, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (7, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (8, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(8, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (9, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (9, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(10, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (10, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (11, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(11, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (12, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (12, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(13, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (13, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (14, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(14, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (15, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (15, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),
	(16, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (16, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (17, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),
	(17, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (18, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (18, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(19, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (19, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (20, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(20, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (21, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (21, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(22, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (22, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (23, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(23, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (24, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (24, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(25, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (25, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (26, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(26, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (27, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (27, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(28, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (28, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (29, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(29, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (30, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (30, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),
	(31, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (31, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (32, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(32, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (33, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (33, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(34, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (34, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (35, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(35, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (36, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (36, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(37, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (37, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (38, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(38, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (39, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (39, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(40, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (40, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (41, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(41, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (42, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (42, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),
	(43, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (43, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (44, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),
	(44, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (45, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (45, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(46, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (46, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (47, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(47, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (48, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (48, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(49, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (49, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (50, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(50, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2'),
    (51, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 1'),
    (51, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 2'),	
	(52, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 1'),
    (52, 2, 6.5, 'Aprovado', '2024-03-20', '2024-03-25', 'Trabalho 2'),
    (53, 3, 9.0, 'Aprovado', '2024-03-10', '2024-03-05', 'Trabalho 1'),	
	(53, 1, 8.0, 'Aprovado', '2024-03-10', '2024-03-10', 'Trabalho 2');

--SELECT * FROM TBL_ALUNOS
--SELECT * FROM TBL_APROVACAO
--SELECT * FROM TBL_CURSOS
--SELECT * FROM TBL_PAGAMENTO
--SELECT * FROM TBL_PROFESSORES
--SELECT * FROM TBL_STATUS_MATRICULA
--SELECT * FROM TBL_TRABALHOS
--SELECT * FROM TBL_TURMAS

--SELECT COUNT(*) --as alunos, id_turma
--from TBL_ALUNOS
--group by id_turma

GO

-- Primeira View:

Create VIEW Trabalhos as-- Trabalhos entregues, aprovados e nota média
SELECT COUNT(*) as Trabalhos, disciplina as Disciplina, status_aprovacao as Status, count(*) as Qtd, ceiling(AVG(nota)) as Nota_Média
FROM TBL_TRABALHOS
group by status_aprovacao, disciplina

GO

-- Segunda View:

Create VIEW Pagamentos as-- Valor total de pagamentos por mês e Curso, pagos e pendentes
SELECT mes as 'Mês',  C.disciplina as Disciplina, status_pgmt as Status, COUNT(*) as Pagamentos, sum(vlr_mensalidade) as Total
from TBL_PAGAMENTO AS A
JOIN TBL_ALUNOS AS B
	ON A.id_matricula = B.id_matricula
JOIN TBL_CURSOS AS C
	ON B.id_curso = C.id_curso
group by mes, C.disciplina, status_pgmt
--ORDER by Total DESC

GO

-- Terceira View:

CREATE VIEW Frequencia as-- frequencia dos alunos
SELECT b.id_matricula, b.nome as Nome, (concat(sum(frequencia) * 100, '%')) as Frequencia
from TBL_APROVACAO as a
JOIN TBL_ALUNOS as b
	on a.id_matricula = b.id_matricula
group by b.id_matricula, b.Nome


GO

-- Quarta View:

Create VIEW Notas as-- Notas dos alunos
SELECT b.nome as Nome, sum(a.nota) as Notas
from TBL_APROVACAO as a
JOIN TBL_ALUNOS as b
	on a.id_matricula = b.id_matricula
group by b.Nome


GO

-- Quinta View:

Create VIEW Entregas_trabalhos as-- Média de dias até a entrega dos trabalhos
SELECT case when avg(DATEDIFF(DAY, data_limite, data_entrega)) < 0 THEN concat(0, ' dias') else concat(avg(DATEDIFF(DAY, data_limite, data_entrega)), ' dias') end AS 'Média de dias para entrega', b.nome as Nome
FROM TBL_TRABALHOS as a
join TBL_ALUNOS as b
	on a.id_matricula = b.id_matricula
join TBL_TURMAS as c
	on a.id_matricula = b.id_matricula
group by b.nome


--select * FROM Entregas_trabalhos
--select * FROM Frequencia
--select * from Notas
--select * FROM Pagamentos
--select * FROM Trabalhos

GO

-- Função #1: cálculo de reajuste anual (10%) da mensalidade --
CREATE FUNCTION reajuste_mensalidade (@id_matricula INT) 
RETURNS DECIMAL(8,2)
AS
BEGIN

   DECLARE @valor_final decimal (8,2), @taxa decimal (8,2), @vlr_mensalidade decimal (8,2), @mensalidade DECIMAL(8,2);

   select @vlr_mensalidade = vlr_mensalidade
   from TBL_PAGAMENTO
   where @id_matricula = id_matricula 

	set @taxa = 1.1

    SET @valor_final = @vlr_mensalidade * @taxa;

	RETURN @valor_final
    
END

GO

-- Código para execução da função #1 (utilizar o ID da matrícula do aluno para consultar)
	--SELECT [dbo].[reajuste_mensalidade] (1) AS Mensalidade_reajustada
		
GO

-- Função #2: consulta de alunos bolsistas --
CREATE FUNCTION aluno_bolsista (@id_matricula INT)
RETURNS VARCHAR(100)
AS
BEGIN

    DECLARE @bolsista VARCHAR(100);
    SELECT @bolsista = CASE 
                                WHEN bolsista = 'Não' THEN 'Sem Bolsa'
                                ELSE 'Bolsista'
                             END
    FROM TBL_PAGAMENTO
    WHERE @id_matricula = id_matricula;
    RETURN @bolsista;

END;

GO

-- Código para execução da função #2 (utilizar o ID da matrícula do aluno para consultar)
--SELECT [dbo].[aluno_bolsista] (1) AS Status_Bolsa



---PROCEDURE 1 (PROCEDURE DE VIEW)

CREATE PROCEDURE SP_frequencia (@ordem char(4), @coluna char(50)) as --Ordem = Desc| ASC -- Colunas: id_matricula | Nome | Frequencia
begin

--declare @ordem2 char(4) = 'Desc'
--declare @coluna2 char(50) = 'frequencia'

	if @ordem in ('Asc', 'Desc') and @coluna in ('id_matricula', 'Nome', 'Frequencia')
	begin
		declare @comando varchar(100) = concat('SELECT * FROM Frequencia ORDER BY ', @coluna, ' ',  @ordem)

		exec (@comando)
	end
	else
	begin
		print('Ordens: DESC ou ASC e Colunas: id_matricula | Nome | Frequencia. Tente novamente!')
	end
end


GO

---PROCEDURE 2 (PROCEDURE DE TABELA)

CREATE PROCEDURE SP_delete_trabalho (@id_trabalho int, @motivo char(200)) as --id_matricula a ser deletada, motivo
begin
	
	if @id_trabalho > 0 and @motivo <> ''
	
	begin
		declare @comando varchar(100) = concat('DELETE FROM TBL_TRABALHOS WHERE id_trabalho = ', @id_trabalho)
		exec (@comando)
		select concat('Trabalho ', @id_trabalho, ' deletado com sucesso, motivo: ', @motivo) as Mensagem
		declare @comando2 varchar(200) = concat('select * from TBL_TRABALHOS where id_trabalho > ', @id_trabalho - 4, ' and id_trabalho < ', @id_trabalho + 4)
		exec (@comando2)
	end
	
	else
	
	begin
		print('Tente novamente!')
	
	end
end

GO
---TEST

--exec SP_delete_trabalho 1, 'pQ QUIS'


------TRIGGER DE DELETE DA TBL_TRABALHOS

CREATE TRIGGER delete_trabalho
ON TBL_TRABALHOS
AFTER DELETE
AS BEGIN

DECLARE @CONTAGEM INT, @FRASE VARCHAR(50)

SELECT @CONTAGEM = count(*) from deleted

IF @CONTAGEM = 0

	set @FRASE = 'NÃO HÁ REGISTROS'

ELSE IF @CONTAGEM = 1

	SET @FRASE = '1 REGISTRO EXCLUÍDO'

ELSE SET @FRASE = CONCAT(@CONTAGEM, ' REGISTROS EXCLUÍDOS COM SUCESSO')

PRINT @FRASE

END

GO

--teste
---DELETE FROM TBL_TRABALHOS WHERE id_trabalho < 6


--select * from TBL_PAGAMENTO where alterado_por is null

----ADD COLUNA NA TABELA PAGAMENTO
alter table tbl_PAGAMENTO
add alterado_por varchar(50)

GO

--TRIGGER DE UPDATE NA TBL_APAGAMENTO

CREATE TRIGGER update_pagamento
on tbl_PAGAMENTO
after update
as
begin

	update tbl_PAGAMENTO
	set alterado_por = SYSTEM_USER
	from inserted as a
	join TBL_PAGAMENTO as b
		on a.bolsista = b.bolsista
		and a.forma_pgmt = b.forma_pgmt
		and a.id_matricula = b.id_matricula
		and a.id_pagamento = b.id_pagamento
		and a.mes = b.mes
		and a.status_pgmt = b.status_pgmt
		and a.vlr_mensalidade = b.vlr_mensalidade
end

GO

-- Teste TRIGGER

--update TBL_PAGAMENTO
--set status_pgmt = 'Pago'
--where id_matricula = 6

--select *from TBL_PAGAMENTO

--- TRIGGER DE INSERT instead of insert (para evitar criar e-mail duplicado)

CREATE TRIGGER insert_ALUNO
ON TBL_ALUNOS
INSTEAD OF INSERT
AS
BEGIN

DECLARE @nome VARCHAR(100), @telefone VARCHAR(100), @email VARCHAR(100), @endereco VARCHAR(100), @id_curso INT, @id_turma INT, @turno VARCHAR(100), @status_matricula VARCHAR(100), @login VARCHAR(100), @senha VARCHAR(100)

SELECT @nome = I.nome, @telefone = I.telefone, @email = I.email, @endereco = I.endereco, @id_curso = I.id_curso, @id_turma = I.id_turma, @turno = I.turno, @status_matricula = I.status_matricula, @login = I.login, @senha = I.senha
FROM inserted AS I

	IF EXISTS (SELECT *
		FROM TBL_ALUNOS
		WHERE email = @EMAIL)

		PRINT('E-MAIL JÁ CADASTRADO')

	ELSE

		INSERT INTO TBL_ALUNOS VALUES(@nome, @telefone, @email, @endereco, @id_curso, @id_turma, @turno, @status_matricula, @login, @senha)

END
GO

--- test
--insert into TBL_ALUNOS values('Ana Lima', '(11) 4567-8901', 'analima@email.com', 'Rua A, 123', 1, 1, 'Manhã', 'Ativo', 'ana.lima', 'senha123')

--CRIAÇÃO DA TABELA DE LOG

CREATE TABLE LOGS (
REGISTROS INT IDENTITY(1,1),
USUARIO VARCHAR(100),
DATA DATE,
HORA TIME,
ACAO VARCHAR(50));

GO


--TRIGGER de LOG DE INSERT E DELETE (REGISTRA QUEM, QUE DIA, HORA E ACAO REALIZOU ENTRE INSERT E DELETE)

CREATE TRIGGER LOG_I_D
ON TBL_TURMAS
AFTER INSERT, DELETE
AS
BEGIN

	INSERT INTO LOGS
	SELECT DISTINCT SYSTEM_USER, CONVERT(DATE, GETDATE()), CONVERT(TIME, GETDATE()), 'INSERT'
	FROM INSERTED

	UNION ALL

	SELECT DISTINCT SYSTEM_USER, CONVERT(DATE, GETDATE()), CONVERT(TIME, GETDATE()), 'DELETE'
	FROM deleted

END

--TESTE
--TRUNCATE TABLE LOGS
--INSERT INTO TBL_TURMAS VALUES ('Manhã', 7, 'TESTE');
--DELETE TBL_TURMAS WHERE id_turma = 7

--SELECT * FROM TBL_TURMAS
--SELECT * FROM LOGS

GO

-------AULA 19 SUBLINGUAGEM DCL - ENTREGÁVEL: IMPLEMENTAÇÃO DE SENTENÇAS:-------------------- ABAIXO EM VERDE, TODOS OS COMANDOS DE TESTES A SEREM REALIZADOS PELOS USUÁRIOS CRIADOA (VLAD E TESTE)


--PRIMEIRO USUÁRIO (VLAD)---------------------------------------------------------------------------

-- Executar como admin do DB \/ ----------------------------------------------------------------------

USE [master]
GO
CREATE LOGIN [vlad] WITH PASSWORD=N'1234' MUST_CHANGE, DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Português (Brasil)], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [Faculdade]
GO
CREATE USER [vlad] FOR LOGIN [vlad]
GO
USE [Faculdade]
GO
ALTER ROLE [db_datareader] ADD MEMBER [vlad]
GO

--exec sp_table_privileges TBL_ALUNOS



-- INSERINDO ALUNO PARA TESTAR PERMISSÕES:

insert into TBL_ALUNOS values

('Teste', '(11)9999-9999', 'teste@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste'),
('Teste', '(11)9999-9999', 'teste2@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste'),
('Teste', '(11)9999-9999', 'teste3@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste');




-- TESTANDO UPDATE, DELETE E INSERT. Executar com vlad: Login: vlad senha: 1234-----------------------------------------------------

--SELECT * FROM TBL_Alunos -- permitido	

--update TBL_ALUNOS set senha = 1234 where id_matricula = 54 --Negado

--delete TBL_ALUNOS where id_matricula = 54 --Negado

--insert into TBL_ALUNOS values('Teste', '(11)9999-9999', 'teste1@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste') --Negado




-- ALTERANDO PERMISSÕES. Executar como admin do DB \/ ----------------------------------------------------------------------------------

--- Permitindo UPDATE, DELETE E INSERT

GRANT UPDATE, DELETE, INSERT ON TBL_Alunos TO vlad




-- TESTES DE PERMISSÕES. Executar com vlad: Login: vlad senha: 1234------------------------------------------------------------


--SELECT * FROM TBL_ALUNOS --PERMITIDO

--UPDATE TBL_ALUNOS SET senha = 1234 WHERE id_matricula = 54 --SELECT * from TBL_ALUNOS --PERMITIDO

--DELETE TBL_ALUNOS where id_matricula > 53 ----PERMITIDO

--INSERT into TBL_ALUNOS values('Teste', '(11)9999-9999', 'teste@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste') ----PERMITIDO



-- REVOGANDO DELETE E INSERT. Executar como admin do DB \/ --------------------------------------------------------------------


REVOKE INSERT, DELETE ON TBL_Alunos FROM vlad


-- TESTES DE PERMISSÕES. Executar com vlad: Login: vlad senha: 1234------------------------------------------------------------------

--select * from TBL_ALUNOS --PERMITIDO

--update TBL_ALUNOS set senha = 1234 where id_matricula = 1 -- PERMITIDO

--delete TBL_ALUNOS where id_matricula = 55 -- NEGADO

--insert into TBL_ALUNOS values ('Teste', '(11)9999-9999', 'teste5@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste') -- NEGADO







--SEGUNDO USUÁRIO (TESTE)---------------------------------------------------------------------------

-- Executar como admin do DB \/ -------------------------------------------------------------------------

USE [master]
GO
CREATE LOGIN [RAFAEL] WITH PASSWORD=N'1234' MUST_CHANGE, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [Faculdade]
GO
CREATE USER [RAFAEL] FOR LOGIN [RAFAEL]



GO

-- TESTES DE PERMISSÕES. Executar com TESTE: Login: TESTE senha: 1234----------------------------------------------------

--SELECT * FROM TBL_ALUNOS WHERE id_matricula = 56 -- OK

--insert into TBL_ALUNOS values ('Teste', '(11)9999-9999', 'teste6@teste.com', 'Rua teste', 1, 1, 'Manhã', 'Ativo', 'teste', 'senhateste') --NEGADO

--UPDATE TBL_ALUNOS SET senha = 1234 WHERE id_matricula = 56 -- NEGADO

----DELETE TBL_ALUNOS WHERE id_matricula = 56 --NEGADO




-- Executar como admin do DB \/ -------------------------------------------------------------------------

GRANT SELECT(nome, login) ON TBL_Alunos TO RAFAEL




-- TESTES DE PERMISSÕES. Executar com TESTE: Login: TESTE senha: 1234----------------------------------------------------

--SELECT * FROM TBL_ALUNOS -- NEGADO

--SELECT NOME, LOGIN FROM Tbl_Alunos --PERMITIDO


-- Aula 20 TCL-----------------------------------------------------------------------------------------------------------------------------------------

--Aspectos a serem incluídos na entrega:
--Na primeira tabela deverá eliminar alguns registros, iniciando previamente uma transação.
--Deixe em uma próxima linha a sentença Rollback e em uma linha posterior a sentença Commit.
--Execute os SELECTs antes e depois para evidenciar que o comando utilizado foi feito com sucesso.

-- INSERINDO PARA EXCLUIR
INSERT INTO TBL_APROVACAO VALUES(1, 1, 'Bacharelado', 1, 1, 1.0, 10.0, 'Aprovado');

-- DELETANDO
BEGIN TRANSACTION

DELETE TBL_APROVACAO
WHERE id_aprovacao = 55 

ROLLBACK

--COMMIT

--SELECT * FROM TBL_APROVACAO (NOLOCK)

--Na segunda tabela, insira oito novos registros, iniciando também uma transação. 
--Adicione um save transaction após a inserção do registro #4 e outro savepoint após o registro #8.
--Adicione em uma linha comentada a sentença de ROLLBACK do save transaction dos primeiros 4 registros inseridos.

-- INSERINDO
BEGIN TRANSACTION

INSERT INTO TBL_CURSOS VALUES(2, 'Pós-graduação', 'Noite', '160:00:00', 500, 'Data Science', 5000.00) --1
INSERT INTO TBL_CURSOS VALUES(3, 'Graduação', 'Manhã', '180:00:00', 550, 'Engenharia de Software', 6000.00); --2
INSERT INTO TBL_CURSOS VALUES(1, 'Pós-graduação', 'Noite', '140:00:00', 480, 'Ciência de Dados Avançada', 5200.00); --3
INSERT INTO TBL_CURSOS VALUES(1, 'Graduação', 'Tarde', '160:00:00', 520, 'Engenharia Biomédica', 5800.00); --4

SAVE TRANSACTION CHECKPOINT1

INSERT INTO TBL_CURSOS VALUES(2, 'Mestrado', 'Noite', '150:00:00', 490, 'Inteligência Artificial Aplicada', 5400.00); --5
INSERT INTO TBL_CURSOS VALUES(2, 'Pós-graduação', 'Manhã', '170:00:00', 530, 'Big Data Analytics', 5600.00); --6
INSERT INTO TBL_CURSOS VALUES(3, 'Graduação', 'Noite', '150:00:00', 500, 'Engenharia de Telecomunicações', 5700.00); --7
INSERT INTO TBL_CURSOS VALUES(1, 'Pós-graduação', 'Tarde', '160:00:00', 510, 'Machine Learning Avançado', 5300.00); --8

SAVE TRANSACTION CHECKPOINT2

--SELECT * FROM TBL_CURSOS (NOLOCK)-- RESULTADO: 11 LINHAS

ROLLBACK TRANSACTION CHECKPOINT1 -- ROLLBACK ATÉ O PRIMEIRO CHECKPOINT

GO

--SELECT * FROM TBL_CURSOS (NOLOCK)-- RESULTADO: 7 LINHAS

USE MASTER
BACKUP DATABASE [Faculdade]
TO  DISK = N'C:\USERS\ANGELO_GOUVEIA\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Faculdade.bak'
WITH NOFORMAT, 
NOINIT,  
NAME = N'Faculdade-Completo Banco de Dados Backup', 
SKIP, 
NOREWIND, 
NOUNLOAD,  
STATS = 10
GO

-- ELIMINADO PROCESSO EM EXECUÇÃO DO DB FACLDADE
-- REMOVENDO TABELA:


USE [master]
DROP DATABASE FACULDADE

-- TESTE:

USE Faculdade

-- PROCESSO DE IMPORTAÇÃO

USE [master]
RESTORE DATABASE [Faculdade] 
FROM  DISK = N'C:\USERS\ANGELO_GOUVEIA\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\Backup\Faculdade.bak' 
WITH  FILE = 1,  
NOUNLOAD,  
STATS = 5

GO


-- TESTE

USE Faculdade
GO

SELECT * FROM TBL_ALUNOS
