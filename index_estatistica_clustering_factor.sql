-- VERIFICA A ESTATISTICA DO INDEX : CLUSTERING FACTOR

--quanto mais proximo o numero de blocos (blocks) do clustering factor MELHOR : isso significa que a chave do index ta mais juntinha.
--quanto mais proximo o numero de linhas (num_rows) do clustering factor PIOR.

--- Mesmo que eu esteja acessando apenas 2% dos dados da minha tabela, mas se os dados buscados estiverem muito espalhados, 
--- pode ser mais interessante pro Oracle fazer um full table scan do que acesso por index.

SELECT 
T.TABLE_NAME,
I.INDEX_NAME,
I.CLUSTERING_FACTOR,
T.BLOCKS,
T.NUM_ROWS
FROM DBA_TABLES, DBA_INDEXES I
WHERE T.TABLE_NAME = I.TABLE_NAME
AND T.OWNER = 'owner_name'
AND T.TABLE = 'table_name'
ORDER BY T.TABLE_NAME, I.INDEX_NAME;
