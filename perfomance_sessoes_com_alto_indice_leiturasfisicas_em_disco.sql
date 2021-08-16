-- Verifique quais são as sessões do banco de dados que estão com alto indice de leituras fisicas em disco:

SELECT  s.sid,
		ss.value "Total physical read",
		s.wait_class,
		s.event,
FROM ss.statistic# = 54
AND  ss.SID = s.SID
AND  s.status = 'ACTIVE'
AND  wait_class <> 'Idle'
ORDER BY ss.value DESC;
