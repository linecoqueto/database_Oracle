----->Conectado com o seu usuário, liste todas as roles pertencentes
SELECT * FROM SESSION_ROLES

----->Conectado com o seu usuário, liste todos os privilégios pertencentes a ele
SELECT * FROM SESSION_PRIVS

-----> Privilegios que usuários tem (geral)
select * from DBA_SYS_PRIVS
where GRANTEE = 'user';

-----> Descubra que privilégios outros usuários possuem no sistema (objetos)
SELECT * FROM DBA_TAB_PRIVS

SELECT * FROM dba_role_privs
where grantee = 'user';

select * from DBA_TAB_PRIVS
where GRANTEE in (select granted_role 
	from dba_role_privs
	where grantee = 'user');

--OBS:
--GRANTOR: que é o usuário que concedeu a permissão. No nosso caso DONOSISTEMA.
--GRANTEE: que é o usuário que recebeu a permissão. No nosso caso USERSISTEMA.
