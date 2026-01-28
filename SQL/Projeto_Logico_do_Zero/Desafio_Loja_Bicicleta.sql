-- criação do banco de dados para o cenário de Loja de Bicicleta
-- drop database Desafio_Loja_Bicicleta;
create database if not exists Desafio_Loja_Bicicleta;
use Desafio_Loja_Bicicleta;

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

create table bike (
	id_bike int auto_increment primary key,
    descricao  varchar (100) not null,
    categoria enum ('Mountain Bike','Urbana','BMX','Speed'),
	fabricante varchar (100),
	valor decimal (10.2)
);

create table peça (
	id_peça int auto_increment primary key,
    categoria enum ('Quadro','Suspensão e Garfos','Bancos','Pedivelas','Cambios'),
    descricao  varchar (100) not null,
	fabricante varchar (100),
	valor decimal (10.2)
);

create table acessorio (
	id_acessorio int auto_increment primary key,
    categoria enum ('Capacete','Luva','Bomba de ar','Bolsa Selim'),
    descricao  varchar (100) not null,
	fabricante varchar (100),
	valor decimal (10.2)
);

create table serviço (
	id_serviço int auto_increment primary key,
    tipo enum ('Revisão','Lavagem','Conserto'),
    descricao  varchar (100) not null,
	valor decimal (10.2)
);

create table produto (
	id_produto int auto_increment primary key,
    id_bike int,
    id_peça int,
    id_acessorio int,
    foreign key (id_bike) references bike(id_bike),
    foreign key (id_peça) references peça(id_peça),
    foreign key (id_acessorio) references acessorio(id_acessorio)
);

create table pedido (
	id_pedido int auto_increment primary key,
    id_cliente int,
    id_funcionario int,
    data_pedido timestamp default current_timestamp,
    foreign key (id_cliente) references cliente(id_cliente),
    foreign key (id_funcionario) references funcionario(id_funcionario)
);

create table item_pedido (
	id_item_pedido int auto_increment primary key,
    id_pedido int,
    id_produto int,
    id_serviço int,
    Quantidade int,
    foreign key (id_pedido) references pedido(id_pedido),
    foreign key (id_produto) references produto(id_produto),
    foreign key (id_serviço) references serviço(id_serviço)
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
	('Pedal Forte Distribuidora LTDA','12345678000190','contato@pedalforte.com.br','(11) 98765-4321','Av. das Nações, 1200 – São Paulo/SP','12/03/15'),
	('Ciclo Premium Importações ME','23456789000181','vendas@ciclopremium.com.br','(21) 96543-2187','R. das Américas, 450 – Rio de Janeiro/RJ','15/07/08'),
	('BikeBrasil Atacadista EIRELI','34567890000172','comercial@bikebrasil.com.br','(31) 98456-7098','Av. Contorno, 980 – Belo Horizonte/MG','10/11/02'),
	('Giro Máximo Bicicletas LTDA','45678901000163','contato@gironmaximo.com.br','(41) 97777-1122','R. XV de Novembro, 555 – Curitiba/PR','18/05/21'),
	('EcoPedal Distribuição e Logística','67890123000145','contato@ecopedal.com.br','(62) 98521-4432','R. Goiás, 88 – Goiânia/GO','17/01/10'),
	('Altitude Bikes Import LTDA','78901234000136','vendas@altitudebikes.com.br','(19) 97412-5699','Av. Brasil, 760 – Campinas/SP','14/04/12'),
	('Trilha Sul Bicicletas ME','89012345000127','trilhasul@bicicletas.com.br','(47) 98888-6677','R. Blumenau, 302 – Joinville/SC','16/06/25'),
	('Velocidade Total Comércio LTDA','90123456000118','comercial@velocidadetotal.com.br','(85) 99741-2233','Av. Beira Mar, 210 – Fortaleza/CE','19/02/19'),
	('Nova Rota Bikes e Peças LTDA','01234567000109','contato@novarota.com.br','(71) 98655-9944','Av. Sete de Setembro, 1010 – Salvador/BA','11/08/07')
;

insert into bike (descricao, categoria, fabricante, valor) values
	('Bike TrailMaster 29” Alumínio','Mountain Bike','1','3499.9'),
	('Bicicleta Urbana CityRide Aro 26','Urbana','1','1899'),
	('Speed Racer Carbon Pro 700c','Speed','3','8750'),
	('BMX Street Radical 20” Cromoly','BMX','2','2450'),
	('Mountain Storm XT 27.5 Shimano','Mountain Bike','2','4280')
;

insert into acessorio (categoria, descricao, fabricante, valor) values
	('Capacete','Capacete Ventisol Pro MTB – Tamanho M','4','289.9'),
	('Capacete','Capacete Urban Ride com viseira','4','199'),
	('Capacete','Capacete Speed Aero Carbon','6','459.5'),
	('Luva','Luva Gel Comfort – Dedo Curto','6','79.9'),
	('Luva','Luva Térmica Inverno – Dedo Longo','5','119'),
	('Luva','Luva MTB MaxGrip com Proteção Extra','7','99.5'),
	('Bomba de ar','Bomba Portátil Alumínio BikePro','8','89.9'),
	('Bomba de ar','Bomba de Chão SteelForce c/ Manômetro','8','159'),
	('Bomba de ar','Mini Bomba Compacta SpeedLine','9','69.9')
;

insert into peça (categoria, descricao, fabricante, valor) values
	('Quadro','Quadro Alumínio 29” MTB TrailX','1','1299'),
	('Quadro','Quadro Carbon SpeedLine Aero 700c','1','3890'),
	('Suspensão e Garfos','Garfo Suspensão Dianteira RockTrail 100mm','3','749.9'),
	('Suspensão e Garfos','Suspensão Dianteira Hidráulica ProShock 120mm','4','1280'),
	('Bancos','Banco Ergonômico ComfortGel Preto','5','189.9'),
	('Bancos','Selim Speed AeroLite Racing','5','259'),
	('Pedivelas','Pedivela Shimano Alivio 9V','6','679'),
    ('Pedivelas','Pedivela Triplo Alumínio Absolute Wild','7','329.9'),
	('Câmbios','Câmbio Traseiro Shimano Deore M6100 12V','10','589'),
	('Câmbios','Câmbio Dianteiro SRAM X5 2x10','9','399.9')
;

insert into serviço (tipo, descricao, valor) values
	('Revisão','Revisão completa + Lavagem','700.0'),
	('Lavagem','Lavagem completa','350.0'),
	('Conserto','Valor por período','50.0')
;

insert into produto (id_bike) values
	('1'),
	('2'),
    ('3'),
    ('4'),
    ('5')
    ;
    
    insert into produto (id_acessorio) values
	('1'),
	('2'),
    ('3'),
    ('4'),
    ('5'),
    ('6'),
    ('7'),
    ('8'),
    ('9')
    ; 
    
     insert into produto (id_peça) values
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
    
select * from produto;

insert into pedido (id_cliente, id_funcionario, data_pedido) values	
	('3','1','25/11/10'),
	('5','2','25/11/11'),
	('13','3','25/11/12'),
	('2','1','25/11/13'),
	('17','2','25/11/14'),
    ('3','2','25/11/15'),	
	('5','3','25/11/16'),
	('13','1','25/11/17'),
	('2','3','25/11/18'),
	('17','1','25/11/19')
;	

insert into item_pedido (id_pedido, id_produto, id_serviço, quantidade) values
	('1','2',null,'1'),
	('1','6',null,'1'),
	('1','11',null,'1'),
	('2','15',null,'1'),
	('2','17',null,'2'),
	('3','3',null,'1'),
	('3','8',null,'1'),
	('4','7',null,'2'),
	('4','11',null,'2'),
	('5',null,'1','1'),
	('6','14',null,'1'),
	('7','21',null,'1'),
	('7','23',null,'1'),
	('8','10',null,'2'),
	('8','12',null,'1'),
	('9','12',null,'1'),
	('9','5',null,'1'),
	('10','12',null,'1'),
	('10','23',null,'1')
;

insert into metodo_pagamento (tipo_pagamento) values
	('Pix'),
    ('Cartão de Débito'),
    ('Cartão de Crédito')
    ;

insert into status_pagamento (status_pg) values
	('Confirmado'),
    ('Em processamento')
;

insert into pagamento (id_pedido, id_metodo_pagamento, id_status_pagamento) values
	('1','1','1'),
	('2','1','1'),
	('3','3','1'),
	('4','2','1'),
    ('5','1','1'),
	('6','3','2'),
	('7','3','2'),
	('8','1','1'),
    ('9','1','1'),
	('10','1','1')
;

insert into estoque (id_produto, quantidade) values
	('1','5'),
	('2','3'),
	('3','4'),
	('4','6'),
	('5','5'),
	('6','10'),
	('7','8'),
	('8','12'),
	('9','15'),
	('10','18'),
	('11','20'),
	('12','5'),
	('13','5'),
	('14','5'),
	('15','3'),
	('16','3'),
	('17','2'),
	('18','2'),
	('19','5'),
	('20','5'),
	('21','3'),
	('22','3'),
	('23','3'),
	('24','3')
;

insert into status_envio (id_pedido, status_envio) values
	('1','5'),
	('2','5'),
	('3','5'),
	('4','4'),
	('5','4'),
	('6','1'),
	('7','1'),
	('8','4'),
	('9','3'),
	('10','2')
;

insert into rastreio (id_pedido, codigo_rastreio) values
	('1','AU100000021BR'),	
	('2','AV100000022BR'),
	('3','AW100000023BR'),
	('4','AX100000024BR'),
	('5','AY100000025BR'),
	('6',null),
	('7',null),
	('8','BB100000028BR'),
	('9','BC100000029BR'),
	('10','BD100000030BR')
;

insert into compra (id_funcionario, id_fornecedor, data_compra) values
	('2','3','25/11/10'),
	('3','1','25/11/11'),
	('6','4','25/11/12'),
	('4','7','25/11/13'),
	('9','8','25/11/14')
;

insert into item_compra (id_compra, id_produto, quantidade, valor_produto) values
	('1','3','2','6500.0'),
	('2','7','5','149.0'),
    ('2','10','7','99.0'),
	('3','12','5','39.9'),
    ('3','6','3','249.9'),
    ('3','11','10','69.5'),
	('4','5','2','2159.9'),
	('5','15','2','1099.9'),
	('5','17','2','709.9')
;

select * from pedido as p				
join pagamento as pg using (id_pedido)				
join metodo_pagamento as mp using (id_metodo_pagamento)				
join status_pagamento as s using (id_status_pagamento)	
			
;				
				
-- Recupero os itens do pedido 3 
select 		p.id_pedido as 'Número do Pedido',
			case
				when id_peça <> 'null' then pç.categoria
				when id_acessorio <> 'null' then a.categoria
                when id_bike <>'null' then b.categoria
			end as Produto,
			case
				when id_peça <> 'null' then pç.descricao
				when id_acessorio <> 'null' then a.descricao
                when id_bike <>'null' then b.descricao
			end as 'Especificação',
            i.quantidade,
            case
				when id_peça <> 'null' then pç.valor
				when id_acessorio <> 'null' then a.valor
                when id_bike <>'null' then b.valor
			end as 'Valor unitário'
from pedido as p
join item_pedido as i using (id_pedido)
join produto as pr using (id_produto)
left join peça as pç using (id_peça)
left join acessorio as a using (id_acessorio)
left join bike as b using (id_bike)
where id_pedido = 3
;

-- Recupera o cliente, vendedor, valor total da compra por pedido, método de pagamento, status do pagamento e status do envio
    select distinct
			p.id_pedido as 'Número do Pedido',
            case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
			concat(f.fname,' ',f.lname) as Vendedor,
            sum(case
				when id_bike <> 'null' then (i.quantidade*b.valor)
				when id_peça <> 'null' then (i.quantidade*pç.valor)
                when id_acessorio <> 'null' then (i.quantidade*a.valor)
            end) as 'Valor do Pedido',
            mp.tipo_pagamento as 'Método de Pagamento',
            s.status_pg as 'Status do Pagamento',
            se.status_envio,
            r.codigo_rastreio
			
	from pedido as p
    join cliente as c using (id_cliente)
	join funcionario as f using (id_funcionario)
    left join clientePF as c_pf using (id_cliente_pf)
    left join clientePJ as c_pj using (id_cliente_pj)
    join item_pedido as i using (id_pedido)
	join produto as pr using (id_produto)
	left join peça as pç using (id_peça)
	left join acessorio as a using (id_acessorio)
	left join bike as b using (id_bike)
    join pagamento as pg using (id_pedido)				
	join metodo_pagamento as mp using (id_metodo_pagamento)				
	join status_pagamento as s using (id_status_pagamento)
    join status_envio as se using (id_pedido)
    join rastreio as r using (id_pedido)
    group by id_pedido, mp.tipo_pagamento, s.status_pg, se.status_envio, r.codigo_rastreio
    order by id_pedido
    ;

-- Recupero a quantidade vendida por Tipo de Produto entre os dia 10-11-2025 e 15-11-2025
select 		
			case
				when id_peça <> 'null' then pç.categoria
				when id_acessorio <> 'null' then a.categoria
                when id_bike <>'null' then b.categoria
			end as Produto,
			count(*) as Quantidade           
	from pedido as p
		join item_pedido as i using (id_pedido)
		join produto as pr using (id_produto)
		left join peça as pç using (id_peça)
		left join acessorio as a using (id_acessorio)
		left join bike as b using (id_bike)
	where p.data_pedido between '2025-11-10' and '2025-11-15'
	group by Produto
	order by Produto
;

select * from produto;

 -- Recupera nome do cliente, nome do vendedor e valor total da compra de pessoas físicas
    select distinct
			p.id_pedido as 'Número do Pedido',
            case
				when id_cliente_pf <> 'null' then concat(c_pf.fname,' ',c_pf.lname)
				when id_cliente_pj <> 'null' then nome
			end as 'Nome do Cliente',
			concat(f.fname,' ',f.lname) as Vendedor
                       
	from pedido as p
    join cliente as c using (id_cliente)
	join funcionario as f using (id_funcionario)
    left join clientePF as c_pf using (id_cliente_pf)
    left join clientePJ as c_pj using (id_cliente_pj)
    where c_pf.id_cliente_pf <> 'null'
    order by id_pedido
    ;


-- Recupero os o total de vendas por produto entre os dia 10-11-2025 e 15-11-2025
SELECT
		nome_produto,
		SUM(valor_total) AS soma_total_vendas
FROM
    (
    -- venda de peças
    select
		pç.categoria as nome_produto,
        (i.quantidade * pç.valor) AS valor_total
        from pedido as p
		join item_pedido as i using (id_pedido)
		join produto as pr using (id_produto)
		left join peça as pç using (id_peça)
        where p.data_pedido between '2025-11-10' and '2025-11-15'
    union all
    
    -- venda de acessorios
    select
		a.categoria as nome_produto,
        (i.quantidade * a.valor) AS valor_total
	from pedido as p
		join item_pedido as i using (id_pedido)
		join produto as pr using (id_produto)
		left join acessorio as a using (id_acessorio)
		where p.data_pedido between '2025-11-10' and '2025-11-15'
    union all
    
    -- venda de bikes
    select
		b.categoria as nome_produto,
        (i.quantidade * b.valor) AS valor_total
    from pedido as p
		join item_pedido as i using (id_pedido)
		join produto as pr using (id_produto)
		left join bike as b using (id_bike)
		where p.data_pedido between '2025-11-10' and '2025-11-15'
    ) as todas_vendas
    group by nome_produto
    order by soma_total_vendas
    ;
    
    -- Recupero os valores de venda e de compra dos produtos 
select distinct		
			case
				when id_peça <> 'null' then pç.categoria
				when id_acessorio <> 'null' then a.categoria
                when id_bike <>'null' then b.categoria
			end as 'Produto',
			case
				when id_peça <> 'null' then pç.descricao
				when id_acessorio <> 'null' then a.descricao
                when id_bike <>'null' then b.descricao
			end as 'Especificação',
           
            case
				when id_peça <> 'null' then pç.valor
				when id_acessorio <> 'null' then a.valor
                when id_bike <>'null' then b.valor
			end as 'Valor de Venda',
            ic.valor_produto as 'Valor de Compra' 

from produto as pr
join compra as c
join item_compra as ic using (id_compra)
left join peça as pç using (id_peça)
left join acessorio as a using (id_acessorio)
left join bike as b using (id_bike)
where ic.id_produto = pr.id_produto
order by produto
;
    