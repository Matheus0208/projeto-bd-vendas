-- Criando tabelas
CREATE TABLE Cliente (
ID int not null auto_increment primary key,
Nome varchar(80) not null,
CPF char(11) not null,
Celular char(11),
EndLogradouro varchar(100) not null,
EndNumero varchar(10) not null,
EndMunicipio int not null,
EndCEP char(8)
);

create table Municipio (
ID int not null auto_increment primary key,
Nome varchar(80) not null,
CodIBGE int not null
);

create table Estado (
ID int not null auto_increment primary key,
Nome varchar(50) not null,
UF char(2) not null
);

create table ContaReceber (
ID int not null auto_increment primary key,
FaturaVendaID int,
DataConta date not null,
DataVencimento date not null,
valor decimal(18,2) not null,
Situacao enum('1','2','3') not null
);

-- Criando os relacionamentos entre as tabelas
ALTER TABLE Cliente
Add column Municipio_ID int,
add constraint Municipio_ID foreign key (ID) references Municipio(ID);

ALTER TABLE contareceber
add column CLiente_ID int,
ADD CONSTRAINT Cliente_ID foreign key (ID) references cliente(ID);

Alter table Municipio
add column Estado_ID int,
add constraint Estado_ID foreign key (ID) references Estado(ID);

-- Mostrando as tabelas criadas
Show tables;

-- Inserindo e exibindo as informações na tabela
insert into Estado (Nome, UF)
values ('Minas Gerais','MG');
select * from Estado;

insert into Municipio (Estado_ID, Nome, CodIBGE)
values (1, 'Pouso Alegre', 3152501);
Select * from Municipio;

insert into Cliente (Nome, CPF, Celular, EndLogradouro, EndNumero, EndMunicipio, EndCEP, Municipio_ID)
values ('Marcos', 12345678912, 123456789, 'Rua F', 100, 11, 12345678, 1);
select * from Cliente;

insert into ContaReceber (Cliente_ID, FaturaVendaID, DataConta, DataVencimento, Valor, situacao)
values (1, 001, 20251022, 20251122, 1000.00,2);
select * from ContaReceber; 