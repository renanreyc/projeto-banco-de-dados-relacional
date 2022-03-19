DROP DATABASE IF EXISTS observatorioSARS;
CREATE DATABASE observatorioSARS;

CREATE TABLE hospital (
  cod_hospital SERIAL PRIMARY KEY,
  nome varchar(100) NOT NULL,
  descricao text,
  estado varchar(50),
  cidade varchar(50),
  bairro varchar(50),
  rua varchar(100)
);

CREATE TABLE leito (
  num_leito SERIAL PRIMARY KEY,
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
  cod_profissional PRIMARY KEY,
  nome varchar(100),
  salario smallmoney,
  acesso_sistema varchar(50),
  cod_hospital int NOT NULL
);

CREATE TABLE paciente (
  cod_paciente int PRIMARY KEY,
  num_cartao_sus int NOT NULL,
  nome varchar(100) NOT NULL,
  sintomas text,
  endereco text,
  data_entrada timestamp DEFAULT (now()),
  cod_profissional int,
  num_leito int,
  cod_recepcionista int NOT NULL
);

CREATE TABLE monitora (
  cod_paciente int PRIMARY KEY,
  cod_profissional int PRIMARY KEY,
  status_paciente text,
  data_visita timestamp DEFAULT (now()),
  conclusao,
  CRM_responsavel NOT NULL,
  data_alta datetime
)
  -- "is_admin" boolean DEFAULT false,
  -- "created_at" timestamp DEFAULT (now()),
  -- "updated_at" timestamp DEFAULT (now())

ALTER TABLE leito ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE recepcionista ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE profissional_da_saude ADD FOREIGN KEY (cod_hospital) REFERENCES hospital (cod_hospital) ON DELETE CASCADE;
ALTER TABLE paciente ADD FOREIGN KEY (cod_profissional) REFERENCES profissional_da_saude (cod_profissional);
ALTER TABLE paciente ADD FOREIGN KEY (num_leito) REFERENCES leito (num_leito);
ALTER TABLE paciente ADD FOREIGN KEY (cod_recepcionista) REFERENCES recepcionista (cod_recepcionista);


-- create procedure
CREATE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
	NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- auto updated_at recipes
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON recipes
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- auto updated_at chefs
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON chefs
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- auto updated_at users
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();

-- connect pg simple table
CREATE table "session" (
  "sid" varchar NOT NULL COLLATE "default",
  "sess" json NOT NULL,
  "expire" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);
ALTER TABLE "session"
ADD CONSTRAINT "session_pkey"
PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

-- to run seeds
-- DELETE FROM recipe_files;
-- DELETE FROM recipes;
-- DELETE FROM chefs;
-- DELETE FROM users;
-- DELETE FROM files;

-- -- restart sequence auto-increment from tables ids
-- ALTER SEQUENCE recipe_files_id_seq RESTART WITH 1;
-- ALTER SEQUENCE recipes_id_seq RESTART WITH 1;
-- ALTER SEQUENCE chefs_id_seq RESTART WITH 1;
-- ALTER SEQUENCE users_id_seq RESTART WITH 1;
-- ALTER SEQUENCE files_id_seq RESTART WITH 1;