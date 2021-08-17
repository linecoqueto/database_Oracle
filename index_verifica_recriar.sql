-- a consulta abaixo mostra os indices que precisam ser recriados - quando o reorganize for maior que 30

SELECT 	BLOCKS,
		PCT_USED,
		DISTINCT_KEYS,
		LF_ROWS,
		DEL_LF_ROWS,
		CASE 
			WHEN ((DEL_LF_ROWS)*100) >= 30 THEN 'TRUE'
			ELSE 'FALSE'
		END AS REORGANIZE
FROM index_stats;
