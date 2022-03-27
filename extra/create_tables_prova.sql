-- DROP DATABASE IF EXISTS escola;
-- CREATE DATABASE escola;

CREATE TABLE aluno (
  matricula SERIAL primary key,
  nome varchar(100),
  cpf int UNIQUE,
  identidade int UNIQUE,
  endereco varchar(200),
  email varchar(100)
);


CREATE TABLE disciplina (
  cod SERIAL primary key,
  nome varchar(100),
  creditos int,
  descricao text
);

	CREATE TABLE eletiva(
	 cod_eletiva int primary key,
	 cod_disciplina int not null,
	 foreign key (cod_disciplina) references disciplina (cod)
	);
	
	CREATE TABLE obrigatoria(
	 cod_obrigatoria int PRIMARY KEY,
	 cod_disciplina int not null,
	 foreign key (cod_disciplina) references disciplina (cod)
	);
	
	CREATE TABLE complementar(
	 cod_complementar int PRIMARY KEY,
	 cod_disciplina int not null,
	 foreign key(cod_disciplina) references disciplina(cod)
	);

create table departamento (
	cod_dep SERIAL primary key,
	nome varchar (200)
);

CREATE TABLE curso (
	cod_curso SERIAL primary key,
	nome varchar(200),
	descricao text,
	grade_curricular text,
	cod_dep int not null,
	foreign key(cod_dep) references departamento(cod_dep)
);

CREATE TABLE professor (
	matricula SERIAL primary key,
	nome varchar(100),
	cpf int,	-- nao unique porque UML não estabelece (possibilidade do professor ter mais de uma matricula. Ex.: sair e retornar a Escola)
	cod_curso int not null,
	coordena_curso int,
	foreign key(cod_curso) references curso(cod_curso),
	foreign key(coordena_curso) references curso(cod_curso),
	data_ini_coordena date,
	data_fim_coordena date
);

create table projeto (
	cod_proj SERIAL primary key,
	nome varchar(100),
	descricao text,
	arquivo_projeto text
);

create table orienta (
	cod_projeto int not null,
	matricula_professor int not null,
	matricula_aluno int not null,
	foreign key(cod_projeto) references projeto(cod_proj),
	foreign key (matricula_professor) references professor(matricula), --considerando que um professor pode orientar mais de um projeto
	foreign key (matricula_aluno) references aluno(matricula)
);

CREATE TABLE cursa (
	cod_disciplina int,
	matricula_aluno int,
	matricula_professor int not null,
	foreign key (cod_disciplina) references disciplina(cod),
	foreign key (matricula_aluno) references aluno(matricula),
	foreign key (matricula_professor) references professor(matricula),
	sala varchar(100),
	periodo varchar(100)
)
