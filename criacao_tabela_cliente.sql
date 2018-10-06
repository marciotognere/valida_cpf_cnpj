CREATE TABLE cliente(
  codcliente NUMBER(10,0) NOT NULL,
  nome       VARCHAR2(30) NOT NULL,
  cpf        CHAR(11)     NULL,
  cnpj       CHAR(14)     NULL,
  CONSTRAINT pk_cliente
    PRIMARY KEY(codcliente)
);