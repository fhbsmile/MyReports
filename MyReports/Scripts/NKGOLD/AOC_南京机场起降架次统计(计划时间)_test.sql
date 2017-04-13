

-----计划时间
select direction,directionTime,sum(directionMount) as directionMount from (
select 'A' as direction,'00' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'01' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'02' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'03' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'04' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'05' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'06' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'07' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'08' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'09' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'10' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'11' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'12' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'13' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'14' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'15' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'16' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'17' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'18' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'19' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'20' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'21' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'22' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'23' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'00' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'01' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'02' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'03' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'04' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'05' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'06' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'07' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'08' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'09' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'10' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'11' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'12' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'13' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'14' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'15' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'16' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'17' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'18' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'19' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'20' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'21' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'22' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'23' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction, TO_CHAR(A.PA_SRTA,'hh24') as directionTime,count(*) as directionMount
from PL_ARRIVAL A  
where TO_CHAR(A.PA_SRTA,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and A.PA_RFST_FLIGHTSTATUS !='X' and A.PA_PA_MAINFLIGHT is null
GROUP BY  'A',TO_CHAR(A.PA_SRTA,'hh24')
UNION ALL
select 'D' as direction, TO_CHAR(D.PD_SRTD,'hh24') as directionTime,count(*) as directionMount
from PL_DEPARTURE D  
where TO_CHAR(D.PD_SRTD,'yyyy-mm-dd') =  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
GROUP BY  'D',TO_CHAR(D.PD_SRTD,'hh24') ) group by  direction,directionTime order by direction,directionTime;

select *
from PL_DEPARTURE D  
where TO_CHAR(D.PD_SRTD,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
and TO_CHAR(D.PD_SRTD,'hh24') IN ('04','05');
-----实际时间
select direction,directionTime,sum(directionMount) as directionMount from(
select 'A' as direction,'00' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'01' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'02' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'03' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'04' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'05' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'06' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'07' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'08' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'09' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'10' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'11' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'12' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'13' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'14' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'15' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'16' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'17' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'18' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'19' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'20' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'21' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'22' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction,'23' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'00' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'01' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'02' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'03' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'04' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'05' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'06' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'07' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'08' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'09' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'10' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'11' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'12' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'13' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'14' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'15' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'16' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'17' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'18' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'19' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'20' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'21' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'22' as directionTime,0 as directionMount from dual
UNION ALL
select 'D' as direction,'23' as directionTime,0 as directionMount from dual
UNION ALL
select 'A' as direction, TO_CHAR(A.PA_ALDT,'hh24') as directionTime,count(*) as directionMount
from PL_ARRIVAL A  
where TO_CHAR(A.PA_ALDT,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and A.PA_RFST_FLIGHTSTATUS !='X' and A.PA_PA_MAINFLIGHT is null
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24')
UNION
select 'D' as direction, TO_CHAR(D.PD_ATOT,'hh24') as directionTime,count(*) as directionMount
from PL_DEPARTURE D  
where TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') =  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
GROUP BY  'D',TO_CHAR(D.PD_ATOT,'hh24') )group by  direction,directionTime order by direction,directionTime;

-----实际时间ALL

select direction,directionTime, sum(directionMount) as directionMount from(
select 'AD' as direction,'00' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'01' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'02' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'03' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'04' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'05' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'06' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'07' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'08' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'09' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'10' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'11' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'12' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'13' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'14' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'15' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'16' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'17' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'18' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'19' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'20' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'21' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'22' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction,'23' as directionTime,0 as directionMount from dual
UNION ALL
select 'AD' as direction, TO_CHAR(A.PA_ALDT,'hh24') as directionTime,count(*) as directionMount
from PL_ARRIVAL A  
where TO_CHAR(A.PA_ALDT,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and A.PA_RFST_FLIGHTSTATUS !='X' and A.PA_PA_MAINFLIGHT is null
GROUP BY  'AD',TO_CHAR(A.PA_ALDT,'hh24')
UNION ALL
select 'AD' as direction, TO_CHAR(D.PD_ATOT,'hh24') as directionTime,count(*) as directionMount
from PL_DEPARTURE D  
where TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
GROUP BY  'AD',TO_CHAR(D.PD_ATOT,'hh24')
) group by direction,directionTime order by directionTime;


