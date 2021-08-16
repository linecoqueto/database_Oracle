--+----------------------------------------------------------------------------------------------+--
-- Criação de função e job para coleta de estatítiscas na partição atual da tabela de forma automatizada.
-- script necessário pois a coleta de estatisticas padrão não atendia, devido ao grande volume gerado
--+----------------------------------------------------------------------------------------------+--

set echo on
set timing on
set serveroutput on


--CRIAR FUNCAO PARA BUSCAR PARTIÇÃO QUE SERÁ COLETADO AS ESTATISTICAS
create or replace FUNCTION OWNER.PARTITION_CURRENT_TABLE RETURN varchar2 IS
    part_name   varchar2(4000);
Begin
     SELECT P.PARTITION_NAME INTO PART_NAME 
      FROM  ALL_TAB_PARTITIONS P 
      WHERE  P.TABLE_NAME = 'table'
        AND P.TABLE_OWNER = 'owner'
        AND P.PARTITION_POSITION = (SELECT MAX(B.PARTITION_POSITION) FROM ALL_TAB_PARTITIONS B WHERE B.TABLE_OWNER = P.TABLE_OWNER AND B.TABLE_NAME= P.TABLE_NAME);
    return part_name;
END;
/


--EXCLUIR O JOB 
BEGIN
  dbms_scheduler.drop_job(job_name => 'OWNER.PARTITION_CURRENT_TABLE');
END;
/

--CRIAR JOB PARA AGENDAR EXECUCAO
--NESSE CASO SERÁ EXECUTADO DIARIAMENTE NA HORA EXATA ESPECIFICADA EM BYHOUR
begin
dbms_scheduler.create_job(
        job_name => 'JOB_COLETA_STATS_TABLE',
        job_type => 'PLSQL_BLOCK',
        job_action => 'begin DBMS_STATS.GATHER_TABLE_STATS ( ownname => ''"OWNER_NAME"'', tabname => ''"TABLE_NAME"'', partname => OWNER.PARTITION_CURRENT_TABLE, degree  => 16 ); end;',
        start_date => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=0,1,2,3,4,5; BYMINUTE=10; BYSECOND=00',
        enabled => TRUE,
        auto_drop => FALSE,
        comments => 'Coletar estatisticas para a tabela OWNER.TABLE a cada 1h após a criação da partição da 00a.m. as 5a.m.'
);
end;
/  

-------------------------------------------------------------------------------------
-- VALIDAÇÃO
-------------------------------------------------------------------------------------
/*

-- verificar estatisticas das partições:
select partition_name, last_analyzed from dba_tab_partitions 
	where table_owner = 'OWNER' 
		and table_name = 'TABKE' 
	--	and partition_name = 'SYS_P11111'
	;


-- validar funcao:
select * from dba_objects 
	where object_name = 'PARTITION_CURRENT_TABLE';



-- validar job:
select owner as schema_name,
       job_name,
       job_style,
       case when job_type is null 
                 then 'PROGRAM'
            else job_type end as job_type,  
       case when job_type is null
                 then program_name
                 else job_action end as job_action,
       start_date,
       case when repeat_interval is null
            then schedule_name
            else repeat_interval end as schedule,
       last_start_date,
       next_run_date,
       state
from dba_scheduler_jobs
where job_name = 'JOB_COLETA_STATS_TABLE'
order by owner,
         job_name;


-- validar se job rodou corretamente:
select * 
   from dba_scheduler_job_run_details
   where job_name = 'JOB_COLETA_STATS_TABLE'
   order by log_date desc;

*/
