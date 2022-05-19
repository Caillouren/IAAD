begin;
create schema Startup;
use Startup;
-- Criando as tabelas
create table Programador(
	Id_programador char(5),
    Id_startup char(5),
    Nome_programador varchar(21),
    Gênero char(1),
    Data_nascimento date not NULL,
    Email varchar(28) not NULL,
    PRIMARY KEY(Id_programador),
    UNIQUE(Email)
);
create table Startup(
	Id_startup char(5),
    Nome_startup varchar(21),
    Cidade_sede varchar(21),
    PRIMARY KEY(Id_startup)
);
create table Linguagem_Programação(
	Id_linguagem char(5),
    Nome_linguagem varchar(10),
    Ano_lançamento int,
    PRIMARY KEY(Id_linguagem)
);
create table Programador_Linguagem(
	Id_programador char(5),
    Id_linguagem char(5),
    PRIMARY KEY(Id_programador,Id_linguagem)
);
-- Populando o banco de dados:
insert into Programador values
	('30001','10001','João Pedro','M','1993-06-23','joaop@mail.com'),
    ('30002','10002','Paula Silva','F','1986-01-10','paulas@mail.com'),
    ('30003','10003','Renata Viera','F','1991-07-05','renatav@mail.com'),
    ('30004','10004','Felipe Santos','M','1976-11-25','felipes@mail.com'),
    ('30005','10001','Ana Cristina','F','1968-02-19','anac@mail.com'),
    ('30006','10004','Alexandre Alves','M','1988-07-07','alexandrea@mail.com'),
    ('30007','10002','Laura Marques','F','1987-10-04','lauram@mail.com');
insert into Startup values
	('10001','Tech4Toy','Porto Alegre'),
    ('10002','Smart123','Belo Horizonte'),
    (10003,'knowledgeUp','Rio de Janeiro'),
    ('10004','BSI Next Level','Recife'),
    ('10006','ProEdu','Florianópolis');
insert into Linguagem_Programação values
	('20001','Python',1991),
	('20002','PHP',1995),
	('20003','Java',1995),
	('20004','C',1972),
	('20005','JavaScript',1995),
	('20006','Dart',2011);
insert into Programador_Linguagem values
	(30001,20001),
	(30001,20002),
	(30002,20003),
	(30003,20004),
	(30003,20005),
	(30004,20005),
	(30007,20001),
	(30007,20002);
-- Aplicando as chaves estrangeiras
alter table Programador
ADD CONSTRAINT Id_startup FOREIGN KEY(Id_startup)
	REFERENCES Startup(Id_startup)
ON UPDATE CASCADE;
alter table Programador_Linguagem 
ADD CONSTRAINT Id_programador FOREIGN KEY(Id_programador)
	REFERENCES Programador(Id_programador)
ON UPDATE CASCADE
ON DELETE CASCADE;
alter table Programador_Linguagem 
ADD CONSTRAINT Id_linguagem FOREIGN KEY(Id_linguagem) 
	REFERENCES Linguagem_Programação(Id_linguagem)
ON DELETE restrict;
commit;