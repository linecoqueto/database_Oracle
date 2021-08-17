alter session set "_USE_NOSEGMENT_INDEXES" = true;

CREATE INDEX owner_name.indexname_idx01 ON owner_name.table_name (campo1, compo2, compo3) NOSEGMENT;

analyze index owner_name.indexname_idx01 compute statistics;
analyze index owner_name.indexname_idx01  validate structure;

explain plan for
 <query>;
select * FROM TABLE(DBMS_XPLAN.DISPLAY);
