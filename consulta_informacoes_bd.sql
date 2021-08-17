SELECT * FROM V$DATABASE;
SELECT * FROM V$INSTANCE;

select * from v$parameter where name like '%service_name%';

select name from V$SERVICES;
select name from V$ACTIVE_SERVICES;

select dbtimezone, sessiontimezone from dual;

-----------------------------------------------------------------

set echo on
set timing on
set serveroutput on

begin
    dbms_output.put_line('Início: ' || to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss')
                      || ' - ' || sys_context('userenv','instance_name')
                      || ' @ ' || sys_context('userenv','server_host'));
end;
/
