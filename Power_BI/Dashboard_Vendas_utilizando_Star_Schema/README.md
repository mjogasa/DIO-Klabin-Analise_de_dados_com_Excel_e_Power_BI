# DESAFIO  - DIO - Tabela Estrela

O Projeto consiste em:
- Transformar um tabela relacional para estrela
- Criar banco de dados (MySQL Workbench - opcional)
- Integrar o MySQL com Power BI
- Transfomar os dados
- Atualizar conexões da tabela fato com as tabelas dimensão e criar dashboard

## Base de dados

A base de dados foi criada através do chat gpt, conformme um dos treinamentos anteriores.


## Desenvolvimento

- Conforme instrução incial, a tabela fato foi definida como fato_professor.
- Analisei os dados da imagem fornecida e defini as primary keys e foreign key para conectar as tabelas
  Foi necessário criar foreign keys para associar o idProfessor_coordenador (departamento) com o idProfessor (professor) e idDepartamento (Curso e Departamento). Além das foreign keys na tabela fato_professor.
- Com o auxílio do chatgpt, populacionei as tabelas e conectei ao Power BI.
- Executei as devidas transformações no Power Query do Power BI.
- Atualizei as conexões da tabela fato com as tabelas dimensão.
- Criei duas medidas simples e os gráficos no Dashboard.