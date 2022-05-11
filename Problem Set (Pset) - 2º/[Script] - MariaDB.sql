/* 01 */
/* CAST converte o valor da média (calculada por AVG) em um número decimal */


SELECT nome_departamento AS Departamento, CAST(AVG(salario) AS DECIMAL(10,2)) AS Média_salário FROM funcionario f INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento;




/* 02 */


SELECT f.sexo AS Sexo,CAST(AVG(f.salario) AS DECIMAL(10,2))  AS Média_salário
FROM funcionario f
GROUP BY f.sexo;




/* 03 */
/* CONCAT junta o conteúdo dos campos do nome do funcionário em um único campo */
/* A expressão de calcular data calcula a diferença entre a data atual do SGBD e a data de nascimento da pessoa e divide essa diferença por 365.25, para mostrar o resultado em anos completos */


SELECT nome_departamento AS Departamento, CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, data_nascimento AS Data_de_nascimento, 
FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, salario AS Salário 
FROM departamento d INNER JOIN funcionario f
WHERE d.numero_departamento = f.numero_departamento
ORDER BY d.nome_departamento;




/* 04 */
/* Faço um select que mostra o novo salário de quem recebe acima de 35 mil e faço a união com o select de quem recebe menos de 35 mil */


SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
CAST(salario AS DECIMAL(10,2)) AS Salário, CAST((salario*1.15) AS DECIMAL(10,2)) AS Salário_reajustado FROM funcionario f WHERE salario >= '35000'
UNION
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
CAST(salario AS DECIMAL(10,2)) AS Salário, CAST((salario*1.2) AS DECIMAL(10,2)) AS Salário_reajustado FROM funcionario f WHERE salario < '35000';










/* 05 */
/* Fiz um select dentro do FROM para pegar apenas o nome e o cpf dos gerentes */


SELECT nome_departamento AS Departamento, g.primeiro_nome AS Gerente, f.primeiro_nome AS Nome_funcionário, salario AS Salário
FROM funcionario f INNER JOIN departamento d, 
(SELECT cpf, primeiro_nome FROM funcionario f INNER JOIN departamento d WHERE d.cpf_gerente = f.cpf) AS g
WHERE d.cpf_gerente = g.cpf AND d.numero_departamento = f.numero_departamento
ORDER BY d.nome_departamento ASC, f.salario DESC;




/* 06 */
/* Caso o valor de ‘sexo’ seja M, o será exibido ‘Masculino’. Caso seja F, será exibido ‘Feminino’ */


SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, dpto.nome_departamento AS Departamento,
dpnd.nome_dependente AS Nome_dependente, FLOOR(DATEDIFF(CURDATE(), dpnd.data_nascimento)/365.25) AS Idade_dependente,
CASE  WHEN dpnd.sexo = 'F' THEN 'Feminino' WHEN dpnd.sexo = 'M' THEN 'Masculino'END AS Sexo_dependente
FROM funcionario f INNER JOIN departamento dpto ON f.numero_departamento = dpto.numero_departamento INNER JOIN dependente dpnd ON dpnd.cpf_funcionario = f.cpf;




/* 07 */
/* No WHERE, ele verifica onde NÃO HÁ o cpf do funcionário na tabela dependente */


SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, dpto.nome_departamento AS Departamento, salario AS Salário 
FROM funcionario f INNER JOIN dependente dpnd INNER JOIN departamento dpto
WHERE f.numero_departamento = dpto.numero_departamento AND
f.cpf NOT IN (SELECT dpnd.cpf_funcionario FROM dependente dpnd);




/* 08 */


SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto,
CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, t.horas AS Horas FROM funcionario f INNER JOIN departamento d INNER JOIN projeto p INNER JOIN trabalha_em t WHERE p.numero_projeto = t.numero_projeto AND f.cpf = t.cpf_funcionario AND p.numero_departamento = d.numero_departamento;










/* 09 */


SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto, SUM(t.horas) AS Horas_totais FROM departamento d INNER JOIN projeto p INNER JOIN trabalha_em t WHERE  p.numero_departamento = d.numero_departamento AND p.numero_projeto = t.numero_projeto GROUP BY p.nome_projeto;




/* 10 */


SELECT d.nome_departamento AS Departamento, CAST(AVG(f.salario) AS DECIMAL(10,2)) AS Média_salário FROM departamento d INNER JOIN funcionario f WHERE f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento;




/* 11 */


SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, p.nome_projeto AS Projeto, t.horas*50 AS Total_ganho
FROM funcionario f INNER JOIN projeto p INNER JOIN trabalha_em t 
WHERE t.cpf_funcionario = f.cpf  AND t.numero_projeto = p.numero_projeto
GROUP BY f.primeiro_nome;




/* 12 */
/* Verifico se o número de horas trabalhadas do funcionário é 0 ou nula */


SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto,
CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, t.horas AS Horas_totais FROM funcionario f INNER JOIN departamento d INNER JOIN projeto p INNER JOIN trabalha_em t WHERE t.numero_projeto = p.numero_projeto AND f.cpf = t.cpf_funcionario AND (horas = 0 OR horas = NULL)
GROUP BY f.primeiro_nome;




/* 13 */
/* Pesquiso todos os dependentes e todos os funcionários, depois uno os resultados */


SELECT d.nome_dependente AS Nome, CASE WHEN sexo = 'F' THEN 'Feminino'  WHEN sexo = 'M' THEN 'Masculino' END AS Sexo, FLOOR(DATEDIFF(CURDATE(), d.data_nascimento)/365.25) AS Idade FROM dependente d 
UNION
SELECT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome,
CASE WHEN sexo = 'F' THEN 'Feminino'  WHEN sexo = 'M' THEN 'Masculino' END AS Sexo, FLOOR(DATEDIFF(CURDATE(), f.data_nascimento)/365.25) AS Idade
FROM funcionario f ORDER BY Idade;


/* 14 */
/* COUNT conta quantos valores existem para o campo ‘numero_departamento’ */


SELECT d.nome_departamento AS Departamento, COUNT(f.numero_departamento) AS Num_funcionários FROM funcionario f INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento
GROUP BY d.nome_departamento;


/* 15 */
/* Seleciono os funcionários que não estão em nenhum projeto e faço união com a seleção dos que estão cadastrados em projetos */
/* Caso não haja registro do funcionário na tabela ‘trabalha_em’, significa que ele não está em nenhum projeto */
/* Como todos os funcionários estão cadastrados em algum projeto, o resultado não exibirá nenhum funcionário desatrelado a um projeto */


SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, d.nome_departamento AS Departamento, 'Não há' AS Projeto
FROM projeto p INNER JOIN departamento d INNER JOIN funcionario f INNER JOIN trabalha_em t WHERE f.numero_departamento = d.numero_departamento AND t.numero_projeto = p.numero_projeto AND (cpf NOT IN (SELECT cpf_funcionario FROM trabalha_em))
UNION
SELECT DISTINCT CONCAT(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) AS Nome_funcionário, d.nome_departamento AS Departamento, p.nome_projeto AS Projeto
FROM projeto p INNER JOIN departamento d INNER JOIN funcionario f INNER JOIN trabalha_em t 
WHERE d.numero_departamento = f.numero_departamento AND f.cpf = t.cpf_funcionario AND t.numero_projeto = p.numero_projeto;
