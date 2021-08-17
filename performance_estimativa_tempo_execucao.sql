sELECT sid, serial#, opname, target, sofar, totalwork, start_time, trunc(time_remaining/60, 2) as FALTA_MINUTOS, message
  from v$session_longops
 where username like upper('%&USERNAME%')
   and time_remaining > 0
 order by time_remaining;
 
