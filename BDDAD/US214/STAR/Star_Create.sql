CREATE TABLE Cliente(
    Cliente_Id number(10) GENERATED BY DEFAULT AS IDENTITY,
    Nif        number(9) NOT NULL,
    Email      varchar2(255) NOT NULL,
    Morada     varchar2(255) NOT NULL,
    PRIMARY KEY (Cliente_Id));

CREATE TABLE Hub(
    Hub_id   number(10) GENERATED BY DEFAULT AS IDENTITY,
    Tipo_Hub varchar2(1) NOT NULL,
    Localização varchar(255) NOT NULL,
    PRIMARY KEY (Hub_id));

CREATE TABLE Produto(
    Produto_id   number(10) GENERATED BY DEFAULT AS IDENTITY,
    Tipo_Cultura varchar2(255) NOT NULL,
    Cultura      number(10) NOT NULL,
    PRIMARY KEY (Produto_id));

CREATE TABLE Produção(
    Produção_id number(10) GENERATED BY DEFAULT AS IDENTITY,
    Quantidade  number(10) NOT NULL,
    Tempo_id    number(10) NOT NULL,
    Setor_id    number(10) NOT NULL,
    Produto_id  number(10) NOT NULL,
    PRIMARY KEY (Produção_id));

CREATE TABLE Setor(
    Setor_id number(10) GENERATED BY DEFAULT AS IDENTITY,
    Nome     varchar2(255) NOT NULL,
    PRIMARY KEY (Setor_id));

CREATE TABLE Tempo(
    Tempo_id number(10) GENERATED BY DEFAULT AS IDENTITY,
    Ano      number(4) NOT NULL,
    Mes      number(2) NOT NULL,
    PRIMARY KEY (Tempo_id)
);

CREATE TABLE Venda(
    Venda_id   number(10) GENERATED BY DEFAULT AS IDENTITY,
    Montante   number(10) NOT NULL,
    Tempo_id   number(10) NOT NULL,
    Produto_id number(10) NOT NULL,
    Hub_id     number(10) NOT NULL,
    Cliente_Id number(10) NOT NULL,
    PRIMARY KEY (Venda_id));

ALTER TABLE Venda
    ADD CONSTRAINT FK_Venda_Tempo FOREIGN KEY (Tempo_id) REFERENCES Tempo (Tempo_id);
ALTER TABLE Produção
    ADD CONSTRAINT FK_Produção_Tempo FOREIGN KEY (Tempo_id) REFERENCES Tempo (Tempo_id);
ALTER TABLE Produção
    ADD CONSTRAINT FK_Produção_Setor FOREIGN KEY (Setor_id) REFERENCES Setor (Setor_id);
ALTER TABLE Produção
    ADD CONSTRAINT FK_Produção_Produto FOREIGN KEY (Produto_id) REFERENCES Produto (Produto_id);
ALTER TABLE Venda
    ADD CONSTRAINT FK_Venda_Produto FOREIGN KEY (Produto_id) REFERENCES Produto (Produto_id);
ALTER TABLE Venda
    ADD CONSTRAINT FK_Venda_Hub FOREIGN KEY (Hub_id) REFERENCES Hub (Hub_id);
ALTER TABLE Venda
    ADD CONSTRAINT FK_Venda_Cliente FOREIGN KEY (Cliente_Id) REFERENCES Cliente (Cliente_Id);
ALTER TABLE Cliente ADD CONSTRAINT CK_Cliente_NIF CHECK (Nif > 99999999 AND Nif < 1000000000);
ALTER TABLE Cliente ADD CONSTRAINT CK_Cliente_Email CHECK (Email like '%@%.%');
ALTER TABLE Hub ADD CONSTRAINT CK_Hub_Tipo CHECK (Tipo_Hub like 'E' OR Tipo_Hub like 'P');