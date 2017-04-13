SELECT * From (
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'00',directionMounts,0 )) AS directionMount ,
              '00' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'00'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'01',directionMounts,0 )) AS directionMount ,
              '01' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'01'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'02',directionMounts,0 )) AS directionMount ,
              '02' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'02'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'03',directionMounts,0 )) AS directionMount ,
              '03' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'03'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'04',directionMounts,0 )) AS directionMount ,
              '04' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'04'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'05',directionMounts,0 )) AS directionMount ,
              '05' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'05'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'06',directionMounts,0 )) AS directionMount ,
              '06' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'06'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'07',directionMounts,0 )) AS directionMount ,
              '07' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'07'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'08',directionMounts,0 )) AS directionMount ,
              '08' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'08'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'09',directionMounts,0 )) AS directionMount ,
              '09' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'09'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'10',directionMounts,0 )) AS directionMount ,
              '10' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'10'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'11',directionMounts,0 )) AS directionMount ,
              '11' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'11'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'12',directionMounts,0 )) AS directionMount ,
              '12' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'12'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'13',directionMounts,0 )) AS directionMount ,
              '13' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'13'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'14',directionMounts,0 )) AS directionMount ,
              '14' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'14'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'15',directionMounts,0 )) AS directionMount ,
              '15' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'15'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'16',directionMounts,0 )) AS directionMount ,
              '16' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'16'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'17',directionMounts,0 )) AS directionMount ,
              '17' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'17'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'18',directionMounts,0 )) AS directionMount ,
              '18' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'18'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'19',directionMounts,0 )) AS directionMount ,
              '19' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'19'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'20',directionMounts,0 )) AS directionMount ,
              '20' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'20'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'21',directionMounts,0 )) AS directionMount ,
              '21' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'21'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'22',directionMounts,0 )) AS directionMount ,
              '22' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'22'
UNION
SELECT         ADtable.directions as direction,
              SUM(DECODE(ADtable.directionTimes,'23',directionMounts,0 )) AS directionMount ,
              '23' as directionTime
              from(
select 'A' as directions, TO_CHAR(A.PA_ALDT,'hh24') as directionTimes, TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')  as dates, count(*) as directionMounts
from PL_ARRIVAL A
GROUP BY  'A',TO_CHAR(A.PA_ALDT,'hh24'),TO_CHAR(A.PA_ALDT,'yyyy-mm-dd')
union
select  'D' as directions ,TO_CHAR(D.PD_ATOT,'hh24') as directionTimes ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd') as dates, count(*) as directionMounts
from PL_DEPARTURE D
GROUP BY 'D', TO_CHAR(D.PD_ATOT,'hh24') ,TO_CHAR(D.PD_ATOT,'yyyy-mm-dd')
) ADtable where ADtable.dates =TO_CHAR(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') group by ADtable.directions ,'23'
) order by direction,directionTime