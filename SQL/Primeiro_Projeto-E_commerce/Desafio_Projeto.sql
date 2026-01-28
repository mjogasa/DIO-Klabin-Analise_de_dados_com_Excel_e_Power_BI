-- criação do banco de dados para o cenário de E-commerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(100),
    constraint unique_cpf_client unique (CPF)    
);

-- alter table clients auto_increment=1;

-- criar tabela produto (size = dimensão do produto)
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(30),
    classification_kids bool default false,
    categoria enum('Eletrônico','Vestimenta','Brinquedo','Alimentos','Móveis') not null,
    avaliação float default 0,
    size varchar(10)
);

-- Para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento
create table payments(	
    idClient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, idPayment)
);

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    ordersDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
    
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
	contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    Location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

-- criar tabela produto vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

-- criar tabela ordem do produto
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível','Sem estoque') default'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- criar tabela local de estoque
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProdStorage)
);

-- criar tabela produtos por vendedor
create table productSupplier(
	idPsSupplier int,
    idPSProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplieer foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

insert into clients (Fname, Minit, Lname, CPF, Address)
	values	('Maria','M','Silva',12346789,'rua silva de prata 29, Carangola - Cidade das flores'),
			('Matheus','O','Pimentel',987654321,'rua alameda 289, Cento - Cidade das Flores'),
            ('Ricardo','F','Silva',45678913,'avenida alameda vinha 1009, Centro - Cidade das flores'),
            ('Julia','S','França',789123456,'rua laranjeiras 861, Centro - Cidade das flores'),
            ('Roberta','G','Assis',98745631,'avenida Koller 19, Centro - Cidade das flores'),
            ('Isabela','M','Cruz',654789123,'rua alameda das flores 28, Centro - Cidade das flores');
	
insert into product (Pname, classification_kids, categoria, avaliação, size) values
	('Fone de ouvido',false,'Eletrônico','4',null),
    ('Barbie Else',true,'Brinquedo','3',null),
    ('Body Carters',true,'Brinquedo','3',null),
    ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
    ('Sofá retrátil',false,'Moveis','3','3x57x80'),
    ('Farinha de arroz',false,'Alimentos','2',null),
    ('Fire Stick Amazon',false,'Eletrônico','3',null);
    
insert into orders (idOrderClient, orderStatus, ordersDescription, sendValue, paymentCash) values
	(1,default,'compra via aplicativo',null,1),
    (2,default,'compra via aplicativo',50,0),
    (3,'Confirmado',null, null,1),
    (4,default,'compra via web site',150,0);

select * from productorder;

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
	(1,1,2,default),
    (2,1,1,default),
    (3,2,1,default);
    
insert into productStorage (storageLocation,quantity) values
	('Rio de Janeiro',1000),
    ('Rio de Janeiro',500),
    ('São Paulo',10),
    ('São Paulo',100),
    ('São Paulo',10),
    ('Brasília',60);

insert into storageLocation (idLproduct, idLstorage, location) values
		(1,2,'RJ'),
        (2,6,'GO');

insert into supplier (SocialName, CNPJ, contact) values
	('Almeida de Filhos',123456789123456,'21985474'),
    ('Eletrônicos Sila',854519649143457,'21985474'),
    ('Eletônicos Valma',934567893934695,'21975474');

insert into productSupplier (idPsSupplier, idPsproduct, quantity) values
	(1,1,500),
    (1,2,400),
    (2,4,633),
    (3,3,5),
    (2,5,10);

insert into Seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
	('Tech eletronics', null, 12345678956321, null, 'Rido de Janeiro', 219946287),
    ('Botique Durgas', null, null, 123456783,'Rio de Janeiro',219567895),
    ('Kids World', null, 456789123654485, null,'São Paulo', 1198657484);

insert into productSeller (idPseller, idPproduct, prodQuantity) values
	(1,5,80),
    (2,7,10);

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrderClient;
select concat(fname,' ',lname) as Name, idOrder, orderStatus
	from clients c, orders o 
	where c.idClient=idOrderClient;

insert into orders (idOrderClient, orderStatus, ordersDescription, sendValue, paymentCash) values
	(2,default,'compra via aplicativo',null,1);

select * from clients c, orders o
	where c.idClient=idOrderClient;

select * from clients left outer join orders on idClient = idOrderClient;

-- recuperação de pedido com produto associado
select * from clients c
		inner join orders o on c.idClient=o.idOrderClient
        inner join productOrder p on p.idPOorder=o.idOrder
        group by idClient;

-- recuperar quantos pedidos foram realizados pelos Clientes
select c.idClient, fname, count(*) as Number_of_orders from clients c
						inner join orders o on c.idClient=o.idOrderClient
						inner join productOrder p on p.idPOorder=o.idOrder;
					

