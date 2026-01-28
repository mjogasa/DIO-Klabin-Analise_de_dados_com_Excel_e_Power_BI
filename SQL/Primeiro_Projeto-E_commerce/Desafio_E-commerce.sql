-- criação do banco de dados para o cenário de E-commerce
-- drop database Desafio_ecommerce;
create database if not exists Desafio_ecommerce;
use Desafio_ecommerce;

create table clientePJ (
	id_cliente_PJ int auto_increment primary key,
    nome varchar(100) not null,
    CNPJ char (14),
    email varchar (100) not null unique,
    Telefone varchar (100),
    Endereço varchar (100),
    criado_em timestamp default current_timestamp
);

create table clientePF (
	id_cliente_PF int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char (11),
    email varchar (100) not null unique,
    Telefone varchar (100),
    Endereço varchar (100),
    criado_em timestamp default current_timestamp
);

create table cliente (
	id_cliente int auto_increment primary key,
    id_cliente_PJ int,
    id_cliente_PF int,
    foreign key (id_cliente_PJ) references clientePJ(id_cliente_PJ),
    foreign key (id_cliente_PF) references clientePF(id_cliente_PF)
);

create table funcionario (
	id_funcionario int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char (11),
    email varchar (100) not null unique,
    Telefone varchar (100),
    Endereço varchar (100),
    criado_em timestamp default current_timestamp
);

create table fornecedor (
	id_fornecedor int auto_increment primary key,
    nome varchar(100) not null,
    CNPJ char (14),
    email varchar (100) not null unique,
    Telefone varchar (100),
    Endereço varchar (100),
    criado_em timestamp default current_timestamp
);

create table produto (
	id_produto int auto_increment primary key,
    descrição varchar (100),
    categoria enum('Eletrônico','Vestimenta','Brinquedo','Alimentos','Móveis') not null,
    valor decimal (10.2)
);

create table pedido (
	id_pedido int auto_increment primary key,
    id_cliente int,
    id_funcionario int,
    data_pedido timestamp default current_timestamp,
    Valor_pedido decimal (10.2),
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_funcionario) references funcionario(id_funcionario)
);

create table item_pedido (
	id_item_pedido int auto_increment primary key,
    id_pedido int,
    id_produto int,
    Quantidade int,
    Valor_produto decimal (10.2),
    foreign key (id_pedido) references pedido(id_pedido),
    foreign key (id_produto) references produto(id_produto)
);

create table metodo_pagamento (
	id_metodo_pagamento int auto_increment primary key,
    tipo_pagamento enum ('Pix','Cartão de Crédito','Cartão de Débito') not null
);

create table status_pagamento (
	id_status_pagamento int auto_increment primary key,
    status_pg enum ('Confirmado','Em processamento')
);

create table pagamento (
	id_pagamento int auto_increment primary key,
    id_pedido int,
    id_metodo_pagamento int,
    id_status_pagamento int,
    foreign key (id_pedido) references pedido (id_pedido),
    foreign key (id_metodo_pagamento) references metodo_pagamento (id_metodo_pagamento),
    foreign key (id_status_pagamento) references status_pagamento (id_status_pagamento)
);

create table status_envio (
	id_status_envio int auto_increment primary key,
    id_pedido int,
    status_envio enum ('Aguardando confirmaçãode pagamento','Objeto Postato','Objeto em trânisto','Objeto saiu para entrega','Objeto entregue'),
	foreign key (id_pedido) references pedido (id_pedido)
);

create table rastreio (
	id_rastreio int auto_increment primary key,
    id_pedido int,
    codigo_rastreio char(13),
    foreign key (id_pedido) references pedido (id_pedido)
);

create table compra (
	id_compra int auto_increment primary key,
    id_funcionario int,
    id_fornecedor int,
    data_compra timestamp default current_timestamp,
    Valor_compra decimal (10.2),
    foreign key (id_funcionario) references funcionario(id_funcionario),
    foreign key (id_fornecedor) references fornecedor(id_fornecedor)
);

create table item_compra (
	id_item_compra int auto_increment primary key,
    id_compra int,
    id_produto int,
    Quantidade int,
    Valor_produto decimal (10.2),
    foreign key (id_compra) references compra(id_compra),
    foreign key (id_produto) references produto(id_produto)
);

create table estoque (
	id_estoque int auto_increment primary key,
    id_produto int,
    quantidade int default 0,
    foreign key (id_produto) references produto(id_produto)
);

insert into clientePF (Fname, Minit, Lname, CPF, email, telefone, endereço, criado_em) values
	('João','A','Silva','12345678900','joao.silva@email.com','(11) 98765-4321','Rua das Flores, 123, SP','25/10/01'),
	('Maria','B','Oliveira','23456789001','maria.oliveira@email.com','(21) 99876-5432','Av. Paulista, 456, RJ','25/10/02'),
	('Carlos','C','Souza','34567890102','carlos.souza@email.com','(61) 92345-6789','Rua 7, 789, DF','25/10/03'),
	('Ana','D','Costa','45678901203','ana.costa@email.com','(51) 93456-7890','Rua dos Jasmins, 987, RS','25/10/04'),
	('Pedro','E','Almeida','56789012304','pedro.almeida@email.com','(31) 91234-5678','Av. Brasil, 654, MG','25/10/05'),
	('Juliana','F','Santos','67890123405','juliana.santos@email.com','(85) 99888-7766','Rua das Acácias, 321, CE','25/10/06'),
	('Roberto','G','Pereira','78901234506','roberto.pereira@email.com','(62) 91234-6789','Av. Goiás, 123, GO','25/10/07'),
	('Larissa','H','Lima','89012345607','larissa.lima@email.com','(79) 98765-4321','Rua das Palmeiras, 456, SE','25/10/08'),
	('Marcos','I','Ferreira','90123456708','marcos.ferreira@email.com','(19) 92345-6789','Av. Campinas, 789, SP','25/10/09'),
	('Beatriz','J','Rodrigues','01234567809','beatriz.rodrigues@email.com','(41) 99887-6655','Rua dos Lírios, 234, PR','25/10/10')
;

select * from clientePF;

insert into funcionario (Fname, Minit, Lname, CPF, email, telefone, endereço, criado_em) values
	('Lucas','R','Martins','12345678910','lucas.martins@email.com','(11) 99876-5432','Rua 15, 223, SP','25/10/11'),
	('Vanessa','E','Souza','23456789011','vanessa.souza@email.com','(21) 92345-6789','Av. Rio Branco, 789, RJ','25/10/12'),
	('Felipe','L','Costa','34567890112','felipe.costa@email.com','(61) 93456-7890','Rua dos Mares, 654, DF','25/10/13'),
	('Isabela','S','Oliveira','45678901213','isabela.oliveira@email.com','(51) 92345-6789','Rua das Acácias, 321, RS','25/10/14'),
	('Renan','M','Almeida','56789012314','renan.almeida@email.com','(31) 91234-5678','Av. do Sol, 432, MG','25/10/15'),
	('Mariana','P','Silva','67890123415','mariana.silva@email.com','(85) 99876-5432','Rua das Flores, 876, CE','25/10/16'),
	('Gabriel','A','Santos','78901234516','gabriel.santos@email.com','(62) 91234-6789','Av. Central, 123, GO','25/10/17'),
	('Juliano','C','Pereira','89012345617','juliano.pereira@email.com','(79) 92345-6789','Rua das Palmeiras, 654, SE','25/10/18'),
	('Laura','R','Ferreira','90123456718','laura.ferreira@email.com','(19) 98765-4321','Rua das Acácias, 789, SP','25/10/19'),
	('Tiago','T','Lima','1234567819','tiago.lima@email.com','(41) 99876-5432','Av. Campinas, 123, PR','25/10/20')
;

select * from funcionario;

insert into clientePJ (nome, CNPJ, email, telefone, endereço, criado_em) values
	('Tech Solutions','12345678000190','contato@techsolutions.com.br','(11) 98765-4321','Av. das Nações, 123, São Paulo - SP','25/10/01'),
	('Nova Era Consultoria','23456789000101','novaera@consultoria.com.br','(21) 99876-5432','Rua do Comércio, 456, Rio de Janeiro - RJ','25/10/02'),
	('GreenTech Indústria','34567890000112','atendimento@greentech.com.br','(61) 91234-5678','Rua Verde, 789, Brasília - DF','25/10/03'),
	('Mundo Digital','45678901000123','contato@mundo.digital','(51) 93456-7890','Av. Central, 234, Porto Alegre - RS','25/10/04'),
	('Global Partners','56789012000134','atendimento@globalpartners.com.br','(31) 91234-5678','Rua das Flores, 123, Belo Horizonte - MG','25/10/05'),
	('Master Services','67890123000145','contato@masterservices.com.br','(41) 92345-6789','Av. Brasil, 654, Curitiba - PR','25/10/06'),
	('Innovate Solutions','78901234000156','contato@innovate.com.br','(62) 91234-6789','Rua Inova, 987, Goiânia - GO','25/10/07'),
	('Bright Ideas Ltda','89012345000167','bright@ideasltda.com.br','(85) 99888-7766','Rua do Sol, 456, Fortaleza - CE','25/10/08')
;

select * from clientePJ;

insert into cliente (id_cliente_PF) values
	('1'),
	('2'),
    ('3'),
    ('4'),
    ('5'),
    ('6'),
    ('7'),
    ('8'),
    ('9'),
    ('10')
;

insert into cliente (id_cliente_PJ) values
	('1'),
	('2'),
    ('3'),
    ('4'),
    ('5'),
    ('6'),
    ('7'),
    ('8')
;

select * from cliente;

insert into fornecedor (nome, CNPJ, email, telefone, endereço, criado_em) values
	('Green Tech Industries','23456789000101','atendimento@greentech.com.br','(21) 99876-5432','Rua das Palmeiras, 345, Rio de Janeiro - RJ','25/11/02'),
	('Future Vision Ltda','34567890000112','suporte@futurevision.com.br','(61) 91234-5678','Av. Brasília, 500, Brasília - DF','25/11/03'),
	('TechPulse Consultoria','45678901000123','contato@techpulse.com.br','(51) 93456-7890','Rua do Comércio, 200, Porto Alegre - RS','25/11/04'),
	('BlueSky Solutions','56789012000134','info@blueskysolutions.com.br','(31) 91234-5678','Rua do Sol, 123, Belo Horizonte - MG','25/11/05'),
	('Visionary Industries','67890123000145','contato@visionaryindustries.com','(41) 92345-6789','Av. Rio Branco, 800, Curitiba - PR','25/11/06'),
	('NextGen Technologies','78901234000156','nextgen@tech.com.br','(62) 91234-6789','Rua dos Jasmins, 900, Goiânia - GO','25/11/07'),
	('Alpha Enterprises','89012345000167','alpha@enterprises.com.br','(85) 99888-7766','Av. Beira Mar, 250, Fortaleza - CE','25/11/08'),
	('Prodigy Group','90123456000178','contato@prodigygroup.com.br','(19) 92345-6789','Rua das Flores, 800, Campinas - SP','25/11/09')
;

select * from fornecedor;
    
insert into produto (descrição, categoria, valor) values
	('Smartphone Galaxy S21','Eletrônico','3299.9'),
	('Fone de Ouvido Bluetooth','Eletrônico','179.9'),
	('Tablet Pro 10"','Eletrônico','1499'),
	('Notebook HP 15','Eletrônico','2799'),
	('Smartwatch FitTracker','Eletrônico','499.9'),
	('Camiseta Masculina Algodão','Vestimenta','39.9'),
	('Blusa de Frio Feminina','Vestimenta','129.9'),
	('Calça Jeans Slim','Vestimenta','99.9'),
	('Vestido Longo de Verão','Vestimenta','159.9'),
	('Jaqueta de Couro','Vestimenta','249.9'),
	('Carro de Controle Remoto 4x4','Brinquedo','229.9'),
	('Lego Creator 1000 Peças','Brinquedo','349.9'),
	('Boneca Bebê Interativa','Brinquedo','149.9'),
	('Quebra-Cabeça 500 Peças','Brinquedo','59.9'),
	('Carrinho de Bebê Reclinável','Brinquedo','399.9'),
	('Arroz Branco Tipo 1 5kg','Alimentos','10.9'),
	('Feijão Carioca 1kg','Alimentos','7.9'),
	('Açúcar Cristal 5kg','Alimentos','14.5'),
	('Óleo de Soja 900ml','Alimentos','5.9'),
	('Macarrão Espaguete 500g','Alimentos','3.5'),
	('Cama Box Queen Size','Móveis','1599'),
	('Sofá 3 Lugares Reclinado','Móveis','2299'),
	('Mesa de Jantar de Vidro','Móveis','1199'),
	('Estante de Livros Moderno','Móveis','899.9'),
	('Cadeira de Escritório Ergonômica','Móveis','649.9')
    ;
        
insert into pedido (id_cliente, id_funcionario, data_pedido, valor_pedido) values
	('3','1','25/11/10','3480'),
	('5','2','25/11/11','2799'),
	('13','3','25/11/12','580'),
	('2','1','25/11/13','470'),
	('17','2','25/11/14','35')
;

insert into item_pedido (id_pedido, id_produto, quantidade, valor_produto) values
	('1','1','1','3300'),
	('1','2','1','180'),
	('2','4','1','2799'),
	('3','7','1','130'),
	('3','8','2','100'),
	('3','10','1','250'),
	('4','12','1','350'),
	('4','14','2','60'),
	('5','16','1','11'),
	('5','17','2','8'),
	('5','20','2','4')
;

insert into metodo_pagamento (tipo_pagamento) values
	('Pix'),
    ('Cartão de Crédito'),
    ('Cartão de Débito')
    ;

insert into status_pagamento (status_pg) values
	('Confirmado'),
    ('Em processamento')
;

insert into pagamento (id_pedido, id_metodo_pagamento, id_status_pagamento) values
	('1','2','2'),
	('2','2','1'),
	('3','3','1'),
	('4','1','1'),
	('5','1','1')
;
 
insert into estoque (id_produto, quantidade) values
	('1','100'),
	('2','100'),
	('3','50'),
	('4','20'),
	('5','30'),
	('6','150'),
	('7','150'),
	('8','120'),
	('9','90'),
	('10','30'),
	('11','30'),
	('12','30'),
	('13','30'),
	('14','50'),
	('15','30'),
	('16','30'),
	('17','30'),
	('18','20'),
	('19','20'),
	('20','30'),
	('21','15'),
	('22','5'),
	('23','10'),
	('24','10'),
	('25','30')
;

insert into status_envio (id_pedido, status_envio) values
	('1','1'),
	('2','5'),
	('3','4'),
	('4','3'),
	('5','2')
;

insert into rastreio (id_pedido, codigo_rastreio) values
	('1',''),
	('2','AE100000005BR'),
	('3','AF100000006BR'),
	('4','AG100000007BR'),
	('5','AH100000008BR')
;

insert into compra (id_funcionario, id_fornecedor, data_compra, valor_compra) values
	('2','3','25/11/10','9899.7'),
	('3','1','25/11/11','5598'),
	('6','4','25/11/12','399'),
	('4','7','25/11/13','1249.5'),
	('9','8','25/11/14','43.6')
;

insert into item_compra (id_compra, id_produto, quantidade, valor_produto) values
	('1','1','3','3299.9'),
	('2','4','2','2799'),
	('3','6','10','39.9'),
	('4','10','5','249.9'),
	('5','16','4','10.9'),
	('5','19','8','5.9')
;

select * from item_compra;
 
-- Recupera o nome do cliente, nome do vendedor, número do pedido, produto comprado, quantidade e valor unitário 
select 
			case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
		concat(f.fname,' ',f.lname) as Vendedor, p.id_pedido as 'Número do Pedido',
		pr.descrição as Produto, i.quantidade as Quantidade, pr.valor as 'Preço unitário'
	from pedido as p
    join cliente as c using (id_cliente)
	join funcionario as f using (id_funcionario)
    join item_pedido as i using (id_pedido)
    join produto as pr using (id_produto)
    left join clientePF as c_pf using (id_cliente_pf)
    left join clientePJ as c_pj using (id_cliente_pj)
    order by 'Numero do Pedido';

-- Recupera número de vendas por funcionário que tiveram número de venda maior que 1
select concat(f.fname,' ',f.lname) as Vendedor, count(id_pedido) as 'Número de Vendas'
	from pedido as p
    join funcionario as f using (id_funcionario)
    group by id_funcionario
    having count(*)>1
    ;
    
    -- Recupera nome do cliente, nome do vendedor e valor total da compra
    select distinct
			case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
		concat(f.fname,' ',f.lname) as Vendedor, 
		p.valor_pedido as 'Total do Pedido'
	from pedido as p
    join cliente as c using (id_cliente)
	join funcionario as f using (id_funcionario)
    left join clientePF as c_pf using (id_cliente_pf)
    left join clientePJ as c_pj using (id_cliente_pj)
    order by 'Numero do Pedido';
    
    -- Recupera nome do cliente, nome do vendedor e valor total da compra de pessoas físicas
    select distinct
			case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
		concat(f.fname,' ',f.lname) as Vendedor, 
		p.valor_pedido as 'Total do Pedido'
	from pedido as p
    join cliente as c using (id_cliente)
	join funcionario as f using (id_funcionario)
    left join clientePF as c_pf using (id_cliente_pf)
    left join clientePJ as c_pj using (id_cliente_pj)
    where c_pf.id_cliente_pf <> 'null'
    order by 'Numero do Pedido';
    
    -- Recupera os produtos que são brinquedos e a quantidade no estoque, ordenado pelo produto
    select p.descrição as Produto, p.categoria as Categoria, e.quantidade as Estoque 
		from produto as p
		join estoque as e using (id_produto)
        where Categoria='Brinquedo'
        order by Produto;
    
    -- Recupera os pedidos que foram comprado com cartão de crédito ou débito 
	select distinct
			case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
            p.id_pedido as 'Número do Pedido',
            p.valor_pedido as 'Valor do Pedido',
            mp.tipo_pagamento as 'Método de Pagamento',
            s.status_pg as 'Status do Pagamento'
		from pedido as p
        join cliente as c using (id_cliente)
        join pagamento as pg using (id_pedido)
        join metodo_pagamento as mp using (id_metodo_pagamento)
        join status_pagamento as s using (id_status_pagamento)
        left join clientePF as c_pf using (id_cliente_pf)
		left join clientePJ as c_pj using (id_cliente_pj)
        where mp.tipo_pagamento like 'cartão%'
        order by p.id_pedido
        ;
    
    -- Recupera o código de rastreio pelo número do pedido
    select distinct
		p.id_pedido as 'Número do Pedido',
			case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
            p.valor_pedido as 'Valor do Pedido',
            mp.tipo_pagamento as 'Método de Pagamento',
            s.status_pg as 'Status do Pagamento',
            r.codigo_rastreio as 'Código de Rastreio'
		from pedido as p
        join cliente as c using (id_cliente)
        join pagamento as pg using (id_pedido)
        join metodo_pagamento as mp using (id_metodo_pagamento)
        join status_pagamento as s using (id_status_pagamento)
        join rastreio as r using (id_pedido)
        left join clientePF as c_pf using (id_cliente_pf)
		left join clientePJ as c_pj using (id_cliente_pj)
        where p.id_pedido=3
        order by p.id_pedido
        ;
        
        -- Recupera o fornecedor, produto das compras e a quantidade no estoque
        select f.nome as Fornecedor, p.descrição as Produto, e.quantidade
			from produto as p
            join item_compra as i using (id_produto)
			join compra as c using (id_compra)
            join fornecedor as f using (id_fornecedor)
            join estoque as e using (id_produto)
		;
        
        -- Recupera a relação dos fornecedores cadastrados
        select * from fornecedor;
        
        -- Recupera a relação dos produtos cadastrados
        select * from produto;
        
