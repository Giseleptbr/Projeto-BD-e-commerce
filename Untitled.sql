-- Criação de banco de dados

create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table client (
    idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);


-- criar tabela produto
-- size = dimensão do produto
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    classification_kids BOOLEAN DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- criar tabela de pagamentos
CREATE TABLE payments (
    idClient INT,
    idPayment INT,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    PRIMARY KEY (idClient, idPayment)
);

-- criar tabela pedido
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL,
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES client(idClient)
);

desc orders

-- criar tabela estoque
CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- criar tabela fornecedor
CREATE TABLE supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

-- criar tabela vendedor
CREATE TABLE seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,         -- razão social ou nome completo
    AbstName VARCHAR(255),                    -- nome fantasia ou abreviado
    CNPJ CHAR(15),                            -- para PJ
    CPF CHAR(9),                              -- para PF
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

CREATE TABLE productSeller (
    idPseller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
CREATE TABLE productOrder (
    idPOProduct INT,
    idPOOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOProduct, idPOOrder),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPOProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_product FOREIGN KEY (idPOOrder) REFERENCES orders(idOrder)
);
CREATE TABLE storageLocation (
    idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_product_seller FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_product FOREIGN KEY (idLstorage) REFERENCES orders(productSeller)
);

show tables;

-- idClient, Fname, Minit, Lname, CPF, Address
INSERT INTO Client (Fname, Minit, Lname, CPF, Address)
VALUES
    ('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
    ('Matheus', 'O', 'Pimentel', 987654321, 'rua alemeda 289, Centro - Cidade das flores'),
    ('Ricardo', 'F', 'Silva', 45678913, 'avenida alemeda vinha 1009, Centro - Cidade das flores'),
    ('Julia', 'S', 'França', 789123456, 'rua lareijras 861, Centro - Cidade das flores'),
    ('Roberta', 'G', 'Assis', 98745631, 'avenidade koller 19, Centro - Cidade das flores'),
    ('Isabela', 'M', 'Cruz', 654789123, 'rua alemeda das flores 28, Centro - Cidade das flores');

ALTER TABLE client MODIFY COLUMN Address VARCHAR(100);

-- idProduct, Pname, classification_kids boolean, category, avaliação, size
ALTER TABLE product MODIFY COLUMN Pname VARCHAR(50);


INSERT INTO product (Pname, classification_kids, category, avaliacao, size)
VALUES
    ('Fone de ouvido', false, 'Eletrônico', 4, NULL),
    ('Barbie Elsa', true, 'Brinquedos', 3, NULL),
    ('Body Carters', true, 'Vestimenta', 5, NULL),
    ('Microfone Vedo - Youtuber', false, 'Eletrônico', 4, NULL),
    ('Sofá retrátil', false, 'Móveis', 3, '3x57x80'),
    ('Farinha de arroz', false, 'Alimentos', 2, NULL),
    ('Fire Stick Amazon', false, 'Eletrônico', 3, NULL);

-- idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES
    (1, 'Em processamento', 'compra via aplicativo', NULL, 1),
    (2, 'Em processamento', 'compra via aplicativo', 50, 0),
    (3, 'Confirmado', NULL, NULL, 1),
    (4, 'Em processamento', 'compra via web site', 150, 0);

CREATE TABLE productOrder (
    idPOProduct INT,
    idPOOrder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOProduct, idPOOrder),
    CONSTRAINT fk_product FOREIGN KEY (idPOProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_order FOREIGN KEY (idPOOrder) REFERENCES orders(idOrder)
);


INSERT INTO ProductOrder (idPOProduct, idPOOrder, poQuantity, poStatus)
VALUES
    (1, 1, 2, 'Disponível'),
    (2, 1, 1, 'Disponível'),
    (3, 2, 1, 'Sem estoque');


INSERT INTO productStorage (storageLocation, quantity)
VALUES
    ('Rio de Janeiro', 1000),
    ('Rio de Janeiro', 500),
    ('São Paulo', 10),
    ('São Paulo', 100),
    ('São Paulo', 10),
    ('Brasília', 60);

CREATE TABLE storageLocation (
    idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_product_storage_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_product_storage_ref FOREIGN KEY (idLstorage) REFERENCES productStorage(idProdStorage)
);


INSERT INTO storageLocation (idLproduct, idLstorage, location)
VALUES
    (1, 2, 'RJ'),
    (2, 6, 'GO');

CREATE TABLE productSupplier (
    idPsSupplier INT,
    idPsProduct INT,
    quantity INT,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_ps_supplier FOREIGN KEY (idPsSupplier) REFERENCES seller(idSeller),
    CONSTRAINT fk_ps_product FOREIGN KEY (idPsProduct) REFERENCES product(idProduct)
);


INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) 
VALUES 
    (1, 1, 500),
    (1, 2, 400),
    (2, 4, 633),
    (3, 3, 5),
    (2, 5, 10);

INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) 
VALUES 
    ('Tech eletronics', NULL, 123456789456321, NULL, 'Rio de Janeiro', 219946287),
    ('Botique Durgas', NULL, NULL, 123456783, 'Rio de Janeiro', 219567895),
    ('Kids World', NULL, 456789123654485, NULL, 'São Paulo', 1198657484);


-- Nome e avaliação dos produtos infantis
SELECT Pname, avaliacao
FROM product
WHERE classification_kids = true;


-- Pedidos pagos em dinheiro
SELECT * FROM orders
WHERE paymentCash = true;

-- Quantos pedidos foram feitos por cada cliente?

SELECT 
    c.idClient,
    CONCAT(c.Fname, ' ', c.Lname) AS nome_cliente,
    COUNT(o.idOrder) AS total_pedidos
FROM client c
LEFT JOIN orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient, c.Fname, c.Lname
ORDER BY total_pedidos DESC;

-- Algum vendedor também é fornecedor?
SELECT 
    s.idSeller,
    s.SocialName,
    'Sim' AS eh_fornecedor
FROM seller s
JOIN productSupplier ps ON s.idSeller = ps.idPsSupplier
GROUP BY s.idSeller, s.SocialName;

-- Relação de produtos, fornecedores e estoques
SELECT 
    p.idProduct,
    p.Pname AS nome_produto,
    s.SocialName AS fornecedor,
    ps.quantity AS quantidade_fornecida,
    sl.location AS local_estoque
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN seller s ON ps.idPsSupplier = s.idSeller
LEFT JOIN storageLocation sl ON sl.idLproduct = p.idProduct;

-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
    s.SocialName AS fornecedor,
    p.Pname AS nome_produto
FROM seller s
JOIN productSupplier ps ON s.idSeller = ps.idPsSupplier
JOIN product p ON p.idProduct = ps.idPsProduct
ORDER BY s.SocialName, p.Pname;

