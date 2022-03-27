DROP DATABASE IF EXISTS observatorioSARS;
CREATE DATABASE observatorioSARS;

CREATE TABLE hospital (
  cod_hospital int PRIMARY KEY,
  nome varchar(100),
  descricao text,
  estado varchar(100),
  cidade varchar(100),
  bairro varchar(100),
  rua varchar(200)
);

CREATE TABLE leito (
  num_leito int PRIMARY KEY,
  tipo varchar(50),
  cod_hospital int NOT NULL
);

CREATE TABLE recepcionista (
  cod_recepcionista int PRIMARY KEY,
  nome varchar(100),
  acesso_sistema varchar(50),
  cod_hospital int NOT NULL
); 

CREATE TABLE profissional_da_saude (
  cod_profissional int PRIMARY KEY,
  nome varchar(100),
  salario decimal,
  acesso_sistema varchar(50),
  cod_hospital int NOT NULL
);

CREATE TABLE enfermeiro (
  cod_profissional int PRIMARY KEY,
  COREN int NOT NULL,
  especialidade text
);

CREATE TABLE medico (
  cod_profissional int PRIMARY KEY,
  CRM int NOT NULL,
  especialidade text
);

CREATE TABLE paciente (
  cod_paciente int PRIMARY KEY,
  num_cartao_sus int NOT NULL,
  nome varchar(100) NOT NULL,
  sintomas text,
  endereco text,
  data_entrada timestamp DEFAULT (now()),
  num_leito int,
  cod_recepcionista int NOT NULL
);

CREATE TABLE monitora (
  cod_paciente int NOT NULL,
  cod_profissional int NOT NULL,
  status_paciente text,
  data_visita timestamp DEFAULT (now()),
  conclusao text,
  CRM_responsavel int NOT NULL,
  data_alta timestamp
);

CREATE TABLE exame (
  cod_exame int PRIMARY KEY,
  nome varchar(100),
  tipo_exame varchar(100),
  resultado text,
  data_exame timestamp DEFAULT (now()),
  cod_paciente int NOT NULL,
  cod_profissional int NOT NULL
);

CREATE TABLE tratamento (
  cod_tratamento int PRIMARY KEY,
  antibiotico varchar(50),
  antiviral varchar(50),
  oxigenoterapia varchar(50),
  drogas_vasoactivas varchar(50),
  cod_paciente int NOT NULL,
  cod_profissional int NOT NULL
);

-- Criando FK
ALTER TABLE leito ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE recepcionista ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE profissional_da_saude ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE medico ADD FOREIGN KEY (cod_profissional) REFERENCES profissional_da_saude (cod_profissional) ON DELETE CASCADE;
ALTER TABLE enfermeiro ADD FOREIGN KEY (cod_profissional) REFERENCES profissional_da_saude (cod_profissional) ON DELETE CASCADE;
ALTER TABLE paciente ADD FOREIGN KEY (num_leito) REFERENCES leito (num_leito) ON DELETE CASCADE;
ALTER TABLE paciente ADD FOREIGN KEY (cod_recepcionista) REFERENCES recepcionista (cod_recepcionista) ON DELETE CASCADE;
ALTER TABLE monitora ADD FOREIGN KEY (cod_paciente) REFERENCES paciente (cod_paciente) ON DELETE CASCADE;
ALTER TABLE monitora ADD FOREIGN KEY (cod_profissional) REFERENCES profissional_da_saude (cod_profissional) ON DELETE CASCADE;
ALTER TABLE exame ADD FOREIGN KEY (cod_paciente) REFERENCES paciente (cod_paciente) ON DELETE CASCADE;
ALTER TABLE exame ADD FOREIGN KEY (cod_profissional) REFERENCES medico (cod_profissional) ON DELETE CASCADE;
ALTER TABLE tratamento ADD FOREIGN KEY (cod_paciente) REFERENCES paciente (cod_paciente) ON DELETE CASCADE;
ALTER TABLE tratamento ADD FOREIGN KEY (cod_profissional) REFERENCES profissional_da_saude (cod_profissional) ON DELETE CASCADE;

-- SEMEANDO TABLES
INSERT INTO hospital (cod_hospital, nome, descricao, estado, cidade, bairro, rua) 
VALUES (1, 'Hospital Pedro 1','Hospital especializado no tratamento de crianças', 'Paraiba','Campina Grande', 'Centro', 'Rua da Alvorada'),
(2, 'UPA 1','Hospital emergencial de rápido atendimento', 'Paraiba','Campina Grande', 'Alto Branco', 'Rua Manoel Tavares'),
(3, 'Trauma','Hospital de urgencia e emergencia', 'Paraiba','Campina Grande', 'Liberdade', 'Avenida 123');

INSERT INTO leito (num_leito, tipo, cod_hospital) 
VALUES (1,'Enfermaria',1),
(2,'Enfermaria',1), 
(3,'Enfermaria',1),
(4,'Enfermaria',1),
(5,'Enfermaria',1),
(6,'Enfermaria',1),
(7,'UTI',1),
(8,'UTI',1),
(9,'Enfermaria',2), 
(10,'Enfermaria',2),
(11,'Enfermaria',2),
(12,'Enfermaria',2),
(13,'UTI',2),
(14,'UTI',2),
(15,'UTI',2),
(16,'Enfermaria',3), 
(17,'Enfermaria',3),
(18,'UTI',3),
(19,'UTI',3),
(20,'UTI',3),
(21,'UTI',3),
(22,'UTI',3),
(23,'UTI',3);

INSERT INTO recepcionista (cod_recepcionista, nome, acesso_sistema, cod_hospital)
VALUES (1020, 'Simeone S.', 'admin', 1),
(2040, 'Dennie', 'admin', 1),
(3040, 'Renan', 'admin', 2),
(4060, 'Fabio', 'admin', 3);

INSERT INTO profissional_da_saude (cod_profissional, nome, salario, acesso_sistema, cod_hospital)
VALUES (1,  'Pedro', 2000, 'simples',1),
(2, 'Maria', 2500, 'simple',2),
(3, 'Felipe', 2000, 'simples',2),
(4, 'Ana', 3000, 'simples',3),
(5, 'Rosa', 2000, 'simples',3),
(6, 'Mario', 1800, 'simples',1),
(7, 'Carlos', 10000, 'intermediario',2),
(8, 'João', 8000, 'intermediario',2),
(9, 'Damiao', 10000, 'intermediario',3),
(10, 'Larissa', 10000, 'intermediario',1),
(11, 'Luiz', 2500, 'simple',2),
(12, 'Fernanda', 2000, 'simples',2),
(13, 'Socorro', 8000, 'intermediario',3),
(14,'Inacia', 20000, 'intermediario',3);

INSERT INTO enfermeiro (cod_profissional, COREN, especialidade)
VALUES (1,  11111, 'enfermagem da criança'),
(2,  22222, 'enfermagem emergencial'),
(3,  33333, 'enfermagem emergencial'),
(4,  44444, 'enfermagem emergencial'),
(5,  55555, 'enfermagem emergencial'),
(6,  66666, 'enfermagem preventiva'),
(11,  99999, 'enfermagem emergencial'),
(12,  88866, 'enfermagem preventiva');


INSERT INTO medico (cod_profissional, CRM, especialidade)
VALUES (7, 66666, 'Medico da Especialista'),
(8, 77777, 'Medico geral'),
(9, 88888, 'Medico de emergencia'),
(10, 99999, 'Medico geral'),
(13, 122345, 'Medico de emergencia'),
(14, 125468, 'Medico de emergencia');

INSERT INTO paciente (cod_paciente, num_cartao_sus, nome, sintomas, endereco, data_entrada, num_leito,cod_recepcionista)
VALUES (1, 1111, 'Fabio Jr', 'Febre e dor de cabeça', 'Rua 123', DEFAULT, NULL,1020),
(2, 2222, 'Pedro felipe', 'covid', 'Rua 456', '03-05-2020', 1,3040),
(3, 3333, 'Ricardo Silvas', 'covid', 'Rua 77', '03-06-2020', 3,3040),
(4, 4444, 'Robson Andre', 'dedo roxo e torcao', 'Rua 888', '10-06-2020', NULL,2040),
(7, 5555, 'Renata R.', 'covid', 'Rua 123', '2020-04-02', NULL,4060),
(8, 6666, 'Saulo', 'Febre e dor de cabeça', 'Av 123', '15-06-2020', 4,4060),
(9, 1234, 'Robson', 'covid', 'Rua 888', '2020-04-01', 17,2040),
(10, 1233, 'Renata', 'covid', 'Rua 123', '2020-04-02', 13,4060),
(11, 1222, 'Saulo', 'covid e febre', 'Av 123', '2020-10-10', 12,3040),
(12, 9999, 'Freixo', 'Febre e dor nos olhos', 'Av 123', '15-06-2020', 15,4060),
(13, 8888, 'Jose', 'covid', 'Rua 788', '2020-07-01', 14,2040),
(14, 7777, 'Fabia', 'covid', 'Rua 5523', '2020-07-02', 20,4060),
(15, 9876, 'Beatriz', 'covid e febre', 'Av 123', '2020-07-10', 21,3040);

INSERT INTO monitora (cod_paciente, cod_profissional, status_paciente, data_visita, conclusao, CRM_responsavel, data_alta)
VALUES (1, 1, 'Sintomas leves', DEFAULT, 'paciente internado devido sintomas de covid', 66666, NULL),
(2, 2, 'Sem sintomas', '2020-05-28', 'liberado', 77777, '2020-05-28'),
(3, 6, 'Sem sintomas', '2020-07-01', 'liberado', 77777, '2020-07-01'),
(11,8,'Sem sintomas', '2020-11-05', 'liberado', 77777, '2020-11-05'),
(12,8,'Sem sintomas', '2020-07-05', 'liberado', 77777, '2020-07-05'),
(10,8,'Sem sintomas', '2020-05-05', 'liberado', 77777, '2020-05-05'),
(15,8,'Sem sintomas', '2020-08-05', 'liberado', 77777, '2020-08-05'),
(13,8,'Sem sintomas', '2020-08-05', 'liberado', 77777, '2020-08-06'),
(8,8,'Sem sintomas', '2020-07-10', 'liberado', 77777, '2020-07-10'),
(14,7,'Sem sintomas', '2020-08-10', 'liberado', 10000, '2020-08-10'),
(9,7,'Sem sintomas', '2020-04-10', 'liberado', 10000, '2020-04-10');

INSERT INTO exame (cod_exame, nome, tipo_exame, resultado, data_exame, cod_paciente, cod_profissional)
VALUES (2,'teste covid', 'simples', 'positivo', '2020-07-01',2,8),
		(3,'teste covid', 'simples', 'positivo', '2020-07-02',7,8),
		(4,'teste covid - Antígeno', 'detecção do virus', 'positivo', '2020-08-01',10,8),
		(5,'teste dengue', 'detecção', 'negativo', '2020-09-01',10,8),
		(6,'teste covid - Antígeno', 'detecção do virus', 'positivo', '2020-08-10',11,8),
		(7,'teste covid - Antígeno', 'detecção do virus', 'positivo', '2020-08-11',3,8),
		(8,'teste covid - Antígeno', 'detecção do virus', 'negativo', '2020-08-10',1,8);

INSERT INTO tratamento (cod_tratamento, antibiotico, antiviral, oxigenoterapia, drogas_vasoactivas, cod_paciente, cod_profissional)
VALUES (1, NULL, 'Coquetel Covid', 'Sim', NULL, 3, 6),
	   (2, NULL, 'Coquetel Covid', 'Sim', NULL, 2, 7),
	   (3, NULL, 'Coquetel Covid', 'Sim', NULL, 10, 7),
	   (4, NULL, 'Coquetel Covid', 'Não', NULL, 11, 7),
	   (5, NULL, 'Coquetel Covid', 'Não', NULL, 7, 8);


-- -- create procedure
-- CREATE FUNCTION trigger_set_timestamp()
-- RETURNS TRIGGER AS $$
-- BEGIN
-- 	NEW.updated_at = NOW();
--   RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- auto updated_at paciente
-- CREATE TRIGGER set_timestamp
-- BEFORE UPDATE ON data_entrada
-- FOR EACH ROW
-- EXECUTE PROCEDURE trigger_set_timestamp();

-- to run DELETE tables
-- DELETE FROM profissional_da_saude;
-- DELETE FROM hospital;
-- DELETE FROM recepcionista;
-- DELETE FROM leito;
-- DELETE FROM paciente;
-- DELETE FROM medico;
-- DELETE FROM enfermeiro;
-- DELETE FROM exame;
-- DELETE FROM tratamento;

-- restart sequence auto-increment from tables ids
-- ALTER SEQUENCE hospital_cod_hospital_seq RESTART WITH 1;

