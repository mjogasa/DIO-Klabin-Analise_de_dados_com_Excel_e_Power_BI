# DESAFIO  - DIO AZURE

O Projeto consiste em:
- Configurar o banco de dados na Azure
- Popular o servidor com script fornecido
- Integrar o MySQL com Power BI
- Transfomar os dados
- Criar consultas novas utilizando a operação mesclar

## Base de dados

A base de dados foi coletado da pasta do link abaixo.

[Coleta e extração de dados](https://github.com/julianazanelatto/power_bi_analyst/tree/main/Módulo%203/Coleta%20e%20extração%20de%20dados)


## Desenvolvimento

- A criação da instância na Azure deu um pouco de trabalho porque sempre dava erro para criar no país mostrado no vídeo. 
- A integração no MySQL Workbench foi feita sem problemas, mas para integrar com o Power BI tive que criar uma DSN de Sistema na Fonte de Dados ODBC no windows. Assim foi possível conectar pelo conector ODBC
- Executei os scripts no Azure, e quando temos muitos dados, com certeza utilizar o Workbench é mais prático.
- Executei as devidas transformações no Power Query do Power BI.
Quando comecei a criar os gráficos e tabelas, verifiquei erros nas informações. Notei que havia uma conexão pontilhada na pasta exibição de modelo. Defini para aplicar a conexão, mas ocorreu um problema de ambiguidade. Temos somente três departamentos, mas cinco locais diferentes.

  Inicialmente pensei em alterar as tabelas originais para atualizar esta ocorrência, mas no mundo real não são apenas algumas linhas na tabela. Então verifiquei a conexão do colaborador com o projeto nas tabelas works_on e project. E criei um consulta mesclada com as tabelas employee, works_on, departament e project.
        
    
- Criei medidas com a soma de dependentes conforme a sua relação, para recuperar quantos dependentes e o tipo de relação que cada colaborador tem.

- Foram criados gráficos de horas trabalhadas por projeto, por gerente, por localização e por colaborador na primeira página. E uma tabela contendo o resumo do departamento e das horas trabalhadas por localização.

- Na segunda página foram criados os gráficos de quantidade de colaboradores por gerente, quantidade de dependentes por colaborador. Uma tabela com colaborador que tem dependentes e o tipo de relação, e uma tabela com várias informações do colaborador.

As consultas foram criadas com a operação de mesclar, porque para se combinar tabelas é necessário que elas tenham colunas com o mesmo número e nome. 