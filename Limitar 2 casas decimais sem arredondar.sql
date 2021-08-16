select 
to_char(trunc(num_taxa_valor)) ||','||substr(num_taxa_valor,instr(num_taxa_valor,',')+1,2) as valor_taxa
,num_taxa_valor
,to_char(trunc(num_valor_produto)) ||','||substr(num_valor_produto,instr(num_valor_produto,',')+1,2) as valor_produto
from lab01.table_teste
where rownum < 10
