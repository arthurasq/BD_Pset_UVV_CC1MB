WITH recursive classificacao_fml
AS ( SELECT pai.codigo, CONCAT (pai.nome) AS pai.codigo_pai, nome_pai
FROM classificacao as pai
WHERE pai.codigo_pai IS NULL


UNION ALL


SELECT filho.codigo, CONCAT (filho.nome), filho.codigo_pai
FROM classificacao AS filho

INNER JOIN classificacao_fml AS fml
ON (filho.codigo = fml.codigo)
WHERE filho.codigo IS NOT NULL )

SELECT* FROM classificacao_fml
ORDER BY classificacao_fml.nome;
