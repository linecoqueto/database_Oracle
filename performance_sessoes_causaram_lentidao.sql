-- quais sessoes causaram lentidão no meu banco de daddos
SELECT * FROM
 (SELECT
  sql_id, 
  disk_reads, 
  executions,
  elapsed_time, --segundos
  first_load_time, 
  last_load_time,
  sql_text
 FROM    v$sql 
ORDER BY elapsed_time DESC) 
WHERE ROWNUM < 10;

-- buscar sid a partir do sql_id retornado anteriormente
SELECT * 
  FROM V$SESSION 
  WHERE sql_id = :1;

-- Verificar os eventos de espera que ocorreram nessa query especifico
SELECT EVENT, TOTAL_WAITS, TOTAL_TIMEOUTS, AVERAGE_WAIT 
  FROM V$SESSION_EVENT
	  WHERE SID = :1 ORDER BY 4;
