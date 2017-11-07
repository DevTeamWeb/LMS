CREATE DATABASE data_lms;

USE data_lms;


CREATE TABLE Professor(
	ra INT UNSIGNED NOT NULL
    ,apelido VARCHAR(30) NOT NULL
    ,nome VARCHAR(120) NOT NULL
    ,email VARCHAR(80) NOT NULL
    ,celular CHAR(11) NOT NULL
    ,CONSTRAINT pk_professor PRIMARY KEY (ra)
    ,CONSTRAINT uqapelido UNIQUE (apelido) 
    )ENGINE=InnoDB;

CREATE TABLE Curso(
	sigla VARCHAR(5) NOT NULL
    ,nome VARCHAR(50) NOT NULL
    ,CONSTRAINT pk_curso PRIMARY KEY (sigla)
    ,CONSTRAINT uqnome UNIQUE (nome)
    )ENGINE=InnoDB;
    
CREATE TABLE GradeCurricular(
	sigla_curso VARCHAR(5) NOT NULL
    ,ano SMALLINT UNSIGNED NOT NULL
    ,semestre CHAR(1) NOT NULL
    ,CONSTRAINT fk_grade_curricular FOREIGN KEY (sigla_curso) REFERENCES Curso (sigla) 
    ,CONSTRAINT pk_grade_curricular PRIMARY KEY (sigla_curso,ano,semestre)
    )ENGINE=InnoDB;
	
CREATE TABLE Periodo(
	sigla_curso VARCHAR(5) NOT NULL
    ,ano_grade SMALLINT UNSIGNED NOT NULL
    ,semestre_grade CHAR (1) NOT NULL
    ,numero TINYINT UNSIGNED NOT NULL
    ,CONSTRAINT fk_periodo FOREIGN KEY (sigla_curso,ano_grade,semestre_grade) REFERENCES GradeCurricular (sigla_curso,ano,semestre)
    ,CONSTRAINT pk_periodo PRIMARY KEY (sigla_curso,ano_grade,semestre_grade,numero)
)ENGINE=InnoDB;    
    
CREATE TABLE Disciplina(
	nome VARCHAR(240) NOT NULL
    ,carga_horario TINYINT UNSIGNED NOT NULL
    ,teoria DECIMAL(3) UNSIGNED NOT NULL
    ,pratica DECIMAL(3) UNSIGNED NOT NULL
    ,ementa TEXT NOT NULL
    ,competencias TEXT NOT NULL
    ,habilidades TEXT NOT NULL
    ,conteudo TEXT NOT NULL
    ,bibliografia_basica TEXT NOT NULL
    ,CONSTRAINT pk_disciplina PRIMARY KEY (nome)
)ENGINE=InnoDB;

CREATE TABLE PeriodoDisciplina(
	sigla_curso VARCHAR(5) NOT NULL
    ,ano_grade SMALLINT UNSIGNED NOT NULL
    ,semestre_grade CHAR (1) NOT NULL
    ,numero_periodo TINYINT UNSIGNED NOT NULL
    ,nome_disciplina VARCHAR(240) NOT NULL
    ,CONSTRAINT fk_periodo_disciplina FOREIGN KEY (sigla_curso,ano_grade,semestre_grade,numero_periodo) 
		REFERENCES Periodo (sigla_curso,ano_grade,semestre_grade,numero) 
    ,CONSTRAINT fk_periodo_disciplina_nome FOREIGN KEY (nome_disciplina) REFERENCES Disciplina(nome)
    ,CONSTRAINT pk_periodo_disciplina PRIMARY KEY (sigla_curso,ano_grade,semestre_grade,numero_periodo,nome_disciplina)
)ENGINE=InnoDB;


CREATE TABLE DisciplinaOfertada(
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano SMALLINT UNSIGNED NOT NULL
    ,semestre CHAR(1) NOT NULL
    ,CONSTRAINT fk_disciplina_ofertada FOREIGN KEY (nome_disciplina) REFERENCES PeriodoDisciplina (nome_disciplina)
    ,CONSTRAINT pk_disciplina_ofertada PRIMARY KEY (nome_disciplina,ano,semestre)
)ENGINE=InnoDB;

CREATE TABLE Aluno(
	ra INT UNSIGNED NOT NULL
    ,nome VARCHAR(120) NOT NULL
    ,email VARCHAR(80) NOT NULL
    ,celular CHAR(11) NOT NULL
    ,sigla_curso CHAR(5) NOT NULL
    ,CONSTRAINT pk_aluno PRIMARY KEY (ra)
)ENGINE=InnoDB;

CREATE TABLE Turma(
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR(1) NOT NULL
    ,id CHAR(1) NOT NULL
    ,turno VARCHAR(15) NOT NULL
    ,ra_professor INT UNSIGNED NOT NULL
    ,CONSTRAINT fk_turma FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado) 
		REFERENCES DisciplinaOfertada (nome_disciplina,ano,semestre)
    ,CONSTRAINT fk_turma_ra_prof FOREIGN KEY (ra_professor) REFERENCES Professor(ra)
    ,CONSTRAINT pk_turma PRIMARY KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id,ra_professor)
)ENGINE=InnoDB;

CREATE TABLE Matricula (
	ra_aluno INT UNSIGNED NOT NULL
    ,nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR(1) NOT NULL
    ,id_turma CHAR(1) NOT NULL
    ,CONSTRAINT fk_matricula_ra_aluno FOREIGN KEY (ra_aluno) REFERENCES Aluno (ra)
    ,CONSTRAINT fk_matricula FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma) REFERENCES Turma (nome_disciplina,ano_ofertado,semestre_ofertado,id)
	,CONSTRAINT pk_matricula PRIMARY KEY (ra_aluno,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
)ENGINE=InnoDB;

CREATE TABLE CursoTurma (
	sigla_curso VARCHAR (5) NOT NULL
    ,nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR (1) NOT NULL
    ,id_turma CHAR (1) NOT NULL
    ,CONSTRAINT fk_curso_turma_sigla_curso FOREIGN KEY (sigla_curso) REFERENCES Curso (sigla)
    ,CONSTRAINT fk_curso_turma FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
		REFERENCES Turma (nome_disciplina,ano_ofertado,semestre_ofertado,id)
    ,CONSTRAINT pk_curso_turma PRIMARY KEY (sigla_curso,nome_disciplina,ano_ofertado,semestre_ofertado,id_turma)
)ENGINE=InnoDB;

CREATE TABLE Questao (
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR (1) NOT NULL
    ,id_turma CHAR (1) NOT NULL
    ,numero INT UNSIGNED NOT NULL
    ,data_limite_entrega DATE NOT NULL
    ,descricao VARCHAR(1000) NOT NULL
    ,data_questao DATE NOT NULL
	,CONSTRAINT fk_questao FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma) REFERENCES Turma (nome_disciplina,ano_ofertado,semestre_ofertado,id)
    ,CONSTRAINT pk_questao PRIMARY KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero)
);

CREATE TABLE ArquivoQuestao (
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR (1) NOT NULL
    ,id_turma CHAR (1) NOT NULL
    ,numero_questao INT UNSIGNED NOT NULL
    ,arquivo VARCHAR (500) NOT NULL
    ,CONSTRAINT fk_arquivo_questao FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao)
		REFERENCES Questao (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero)
    ,CONSTRAINT pk_arquivo_questao PRIMARY KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao,arquivo)
)ENGINE=InnoDB;

CREATE TABLE Resposta (
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR (1) NOT NULL
    ,id_turma CHAR (1) NOT NULL
    ,numero_questao INT UNSIGNED NOT NULL
    ,ra_aluno INT UNSIGNED NOT NULL
    ,data_avaliacao DATE NOT NULL
    ,nota DECIMAL (4,2) UNSIGNED NOT NULL
    ,avaliacao VARCHAR (1000) NOT NULL
    ,descricao VARCHAR (1000) NOT NULL
    ,data_de_envio DATE NOT NULL
    ,CONSTRAINT fk_resposta FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao)
		REFERENCES Questao (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero)
    ,CONSTRAINT fk_resposta_ra_aluno FOREIGN KEY (ra_aluno) REFERENCES Aluno (ra)
    ,CONSTRAINT pk_resposta PRIMARY KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao,ra_aluno)
)ENGINE=InnoDB;


CREATE TABLE ArquivoResposta (
	nome_disciplina VARCHAR (240) NOT NULL
    ,ano_ofertado SMALLINT UNSIGNED NOT NULL
    ,semestre_ofertado CHAR (1) NOT NULL
    ,id_turma CHAR(1) NOT NULL
    ,numero_questao INT UNSIGNED NOT NULL
    ,ra_aluno INT UNSIGNED NOT NULL
    ,arquivo VARCHAR (500) NOT NULL
    ,CONSTRAINT fknome_disciplina FOREIGN KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao,ra_aluno)
		REFERENCES Resposta (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao,ra_aluno)
    ,CONSTRAINT pk_arquivo_resposta PRIMARY KEY (nome_disciplina,ano_ofertado,semestre_ofertado,id_turma,numero_questao,ra_aluno,arquivo)
)ENGINE=InnoDB;
