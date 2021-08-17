
--------------------------------------------------------------------------
-- Hint para ignorar registros duplicados e assim nao dar erro ::
--------------------------------------------------------------------------

insert  /*+  ignore_row_on_dupkey_index(table_name_destino, index_Name)  */
into table_name_destino
select * from table_name_origem where campo_data  >= TO_DATE('yyyy-mm-dd hh:mi', 'YYYY-MM-DD HH24:MI');
