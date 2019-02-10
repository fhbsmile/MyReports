

-----计划时间
select scheduleDate,directionTime,sum(directionMount) as directionMount from (
select '0000-00-00' as scheduleDate,'00' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'01' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'02' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'03' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'04' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'05' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'06' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'07' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'08' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'09' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'10' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'11' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'12' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'13' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'14' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'15' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'16' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'17' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'18' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'19' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'20' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'21' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'22' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'23' as directionTime,0 as directionMount from dual
UNION ALL
select to_char(A.PA_SRTA,'yyyy-mm-dd') as scheduleDate, TO_CHAR(A.PA_SRTA,'hh24') as directionTime,count(*) as directionMount
from PL_ARRIVAL A  
where TO_CHAR(A.PA_SRTA,'yyyy-mm-dd') between   to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and  to_char(to_date('2017-03-11 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') 
and A.PA_RFST_FLIGHTSTATUS !='X' and A.PA_PA_MAINFLIGHT is null
GROUP BY  TO_CHAR(A.PA_SRTA,'yyyy-mm-dd'),TO_CHAR(A.PA_SRTA,'hh24')
UNION ALL
select TO_CHAR(D.PD_SRTD,'yyyy-mm-dd') as scheduleDate, TO_CHAR(D.PD_SRTD,'hh24') as directionTime,count(*) as directionMount
from PL_DEPARTURE D  
where TO_CHAR(D.PD_SRTD,'yyyy-mm-dd') between  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and  to_char(to_date('2017-03-11 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  
AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
GROUP BY  TO_CHAR(D.PD_SRTD,'yyyy-mm-dd'),TO_CHAR(D.PD_SRTD,'hh24') ) group by  scheduleDate,directionTime order by scheduleDate,directionTime;

select *
from PL_DEPARTURE D  
where TO_CHAR(D.PD_SRTD,'yyyy-mm-dd') =  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
and TO_CHAR(D.PD_SRTD,'hh24') IN ('04','05');
-----实际时间
select scheduleDate,directionTime,sum(directionMount) as directionMount from(
select '0000-00-00' as scheduleDate,'00' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'01' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'02' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'03' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'04' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'05' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'06' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'07' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'08' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'09' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'10' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'11' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'12' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'13' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'14' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'15' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'16' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'17' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'18' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'19' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'20' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'21' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'22' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'23' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'00' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'01' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'02' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'03' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'04' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'05' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'06' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'07' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'08' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'09' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'10' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'11' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'12' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'13' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'14' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'15' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'16' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'17' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'18' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'19' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'20' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'21' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'22' as directionTime,0 as directionMount from dual
UNION ALL
select '0000-00-00' as scheduleDate,'23' as directionTime,0 as directionMount from dual
UNION ALL
select to_char(A.PA_ALDT,'yyyy-mm-dd') as scheduleDate, TO_CHAR(A.PA_ALDT,'hh24') as directionTime,count(*) as directionMount
from PL_ARRIVAL A  
where TO_CHAR(A.PA_ALDT,'yyyy-mm-dd') between   to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and  to_char(to_date('2017-03-11 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') 
and A.PA_RFST_FLIGHTSTATUS !='X' and A.PA_PA_MAINFLIGHT is null
GROUP BY  TO_CHAR(A.PA_ALDT,'yyyy-mm-dd'),TO_CHAR(A.PA_ALDT,'hh24')
UNION ALL
select TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as scheduleDate, TO_CHAR(D.PD_ATOT,'hh24') as directionTime,count(*) as directionMount
from PL_DEPARTURE D  
where TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') between  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') and  to_char(to_date('2017-03-11 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  
AND D.PD_RFST_FLIGHTSTATUS !='X' and D.PD_PD_MAINFLIGHT is null
GROUP BY  TO_CHAR(D.PD_ATOT,'yyyy-mm-dd'),TO_CHAR(D.PD_ATOT,'hh24') ) group by  scheduleDate,directionTime order by scheduleDate,directionTime;

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


