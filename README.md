# 🗄️ Banco de Dados Relacional em SQL

Relatório técnico desenvolvido como projeto acadêmico para a disciplina de Linguagem de Banco de Dados, abordando a criação e manipulação de um banco de dados relacional com foco em gestão de clientes, municípios, estados e contas a receber.

---

## 📋 Descrição

Este projeto simula um cenário típico de sistema comercial, implementando uma estrutura de banco de dados relacional capaz de armazenar informações geográficas e financeiras de clientes. O código foi desenvolvido em SQL puro, com criação de tabelas, definição de relacionamentos via chaves estrangeiras e inserção de dados fictícios para validação.

---

## 🏗️ Estrutura do Banco de Dados

A estrutura relacional segue a seguinte hierarquia:

```
Estado → Município → Cliente → ContaReceber
```

### Tabelas

| Tabela | Descrição |
|---|---|
| `Estado` | Armazena nome e sigla (UF) das unidades federativas |
| `Municipio` | Contém nome e código IBGE do município |
| `Cliente` | Dados pessoais e endereço do cliente |
| `ContaReceber` | Informações financeiras das contas a receber |

### Relacionamentos

- `Cliente` → `Municipio` (via `Municipio_ID`)
- `Municipio` → `Estado` (via `Estado_ID`)
- `ContaReceber` → `Cliente` (via `Cliente_ID`)

---

## 💻 Código SQL

### Criação das Tabelas

```sql
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

CREATE TABLE Municipio (
    ID int not null auto_increment primary key,
    Nome varchar(80) not null,
    CodIBGE int not null
);

CREATE TABLE Estado (
    ID int not null auto_increment primary key,
    Nome varchar(50) not null,
    UF char(2) not null
);

CREATE TABLE ContaReceber (
    ID int not null auto_increment primary key,
    FaturaVendaID int,
    DataConta date not null,
    DataVencimento date not null,
    Valor decimal(18,2) not null,
    Situacao enum('1','2','3') not null
);
```

### Definição dos Relacionamentos

```sql
ALTER TABLE Cliente
    ADD COLUMN Municipio_ID int,
    ADD CONSTRAINT Municipio_ID FOREIGN KEY (ID) REFERENCES Municipio(ID);

ALTER TABLE ContaReceber
    ADD COLUMN Cliente_ID int,
    ADD CONSTRAINT Cliente_ID FOREIGN KEY (ID) REFERENCES Cliente(ID);

ALTER TABLE Municipio
    ADD COLUMN Estado_ID int,
    ADD CONSTRAINT Estado_ID FOREIGN KEY (ID) REFERENCES Estado(ID);
```

### Inserção de Dados

```sql
INSERT INTO Estado (Nome, UF) VALUES ('Minas Gerais', 'MG');

INSERT INTO Municipio (Estado_ID, Nome, CodIBGE) VALUES (1, 'Pouso Alegre', 3152501);

INSERT INTO Cliente (Nome, CPF, Celular, EndLogradouro, EndNumero, EndMunicipio, EndCEP, Municipio_ID)
VALUES ('Marcos', 12345678912, 123456789, 'Rua F', 100, 11, 12345678, 1);

INSERT INTO ContaReceber (Cliente_ID, FaturaVendaID, DataConta, DataVencimento, Valor, Situacao)
VALUES (1, 001, 20251022, 20251122, 1000.00, 2);
```

---

## 📊 Dados de Exemplo

| Tabela | Registro |
|---|---|
| Estado | Minas Gerais (MG) |
| Município | Pouso Alegre (CodIBGE: 3152501) |
| Cliente | Marcos, CPF: 12345678912 |
| ContaReceber | Fatura 001, Valor: R$1.000,00, Vencimento: 22/11/2025 |

---

## ⚠️ Observações Técnicas

Os comandos `ALTER TABLE` para criação de chaves estrangeiras apresentam um erro de lógica: a referência está apontando para a própria chave primária (`ID`) em vez da nova coluna adicionada (`Municipio_ID`, `Cliente_ID`, `Estado_ID`). A forma correta seria:

```sql
-- Forma correta:
ADD CONSTRAINT fk_municipio FOREIGN KEY (Municipio_ID) REFERENCES Municipio(ID);

-- Em vez de:
ADD CONSTRAINT Municipio_ID FOREIGN KEY (ID) REFERENCES Municipio(ID);
```

---

## 🛠️ Tecnologias Utilizadas

- **SQL** (MySQL / MariaDB)

---

## 👤 Autor

**Matheus Augusto de Oliveira Horta**  
Engenharia da Computação — 6º Período
