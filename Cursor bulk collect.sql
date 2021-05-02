
SET SERVEROUTPUT ON
SET ECHO ON
SET TIMING ON

DECLARE
  LIMIT_IN 			PLS_INTEGER := 10000;
  QTD_INS           NUMBER(10)  := 0;
  L_START           NUMBER;

--Primeiro Cursor 
  CURSOR C_TESTE IS
      (
			SELECT col1, col2, col3 FROM tablex
			WHERE col1 >= 'dd/mm/yyyy'
      );

--declarando a variavel que receberá os registros da tabela
   TYPE TY_TESTE
   IS
   TABLE OF C_TESTE%rowtype INDEX BY PLS_INTEGER;
   MC_TESTE TY_TESTE;

--abre o cursor
   BEGIN
   L_START := DBMS_UTILITY.GET_TIME;
   
     OPEN C_TESTE;
       LOOP
         FETCH C_TESTE BULK COLLECT INTO MC_TESTE LIMIT LIMIT_IN;
         EXIT WHEN MC_TESTE.COUNT = 0;
          FORALL INDX IN 1 .. MC_TESTE.COUNT
			
			UPDATE tabley 
			SET col3 = 'xxxxxx'
			WHERE col1 = MC_TESTE(INDX).col1;
			
			QTD_INS := QTD_INS + SQL%ROWCOUNT;
        
			IF (MOD(QTD_INS,300000) = 0) then
			  COMMIT;
		    END IF;
			
         END LOOP;
       CLOSE C_TESTE;
	   
 DBMS_OUTPUT.PUT_LINE('Qtde de registros atualizados: ' || QTD_INS);
 DBMS_OUTPUT.PUT_LINE('Tempo Total: ' || ROUND((DBMS_UTILITY.GET_TIME - L_START)/100,2) || 's');
 COMMIT;	   
	   
END;

/