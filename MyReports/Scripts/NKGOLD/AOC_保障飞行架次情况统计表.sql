select * from (
SELECT D.fdate                            AS dfdate,
    SUM(cnt)                                AS sumCount,
    SUM(DECODE(D.typeCode,'C/B',cnt,0 )) AS C_B,--加班
    SUM(DECODE(D.typeCode,'L/W',cnt,0 )) AS H_G,--包机
    SUM(DECODE(D.typeCode,'Z/P',cnt,0 )) AS Z_P,--补班
    SUM(DECODE(D.typeCode,'Q/B',cnt,0 )) AS Q_B,--备降
    SUM(DECODE(D.typeCode,'B/W',cnt,0 )) AS B_W,--专机
    SUM(DECODE(D.typeCode,'X/L',cnt,0 )) AS X_L,--训练
    SUM(DECODE(D.typeCode,'N/M',cnt,0 )) AS N_M,--调机
    SUM(DECODE(D.typeCode,'Q/F',cnt,0 )) AS Q_F,--急救
    SUM(DECODE(D.typeCode,'F/J',cnt,0 )) AS F_J,--校飞
    SUM(DECODE(D.typeCode,'H/F',cnt,0 )) AS H_F,--航摄
    SUM(DECODE(D.typeCode,'U/H',cnt,0 )) AS U_H,--公务
    SUM(DECODE(D.typeCode,'F/H',cnt,0 )) AS F_H,--返航
    SUM(DECODE(D.typeCode,'H/Z',cnt,'H/Y',cnt,'H/G',cnt,0 )) AS H_Z,--货邮
    SUM(DECODE(D.typeCode,'W/Z',cnt,0 )) AS W_Z--正班
  FROM(
select fdate , typeCode ,count(1) as cnt from(

select A.pa_idseq,TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') as fdate, A.PA_RSTC_SERVICETYPECODE as typeCode
from PL_ARRIVAL A
WHERE  A.PA_SRTA                 IS NOT NULL AND  (TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND A.PA_RFST_FLIGHTSTATUS !='X'and A.PA_pa_mainflight is null

union
select d.pd_idseq ,TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') as fdate , D.PD_RSTC_SERVICETYPECODE as typeCode
from PL_DEPARTURE D
WHERE  D.PD_srtd                 IS NOT NULL AND  (TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND D.PD_RFST_FLIGHTSTATUS !='X' and  D.Pd_pd_mainflight is null
) group by fdate,typeCode

) D group by D.fdate order by D.fdate ) bbb
left join (

select TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') as fdate,count(1) as Acnt
from PL_ARRIVAL A
WHERE  A.PA_SRTA                 IS NOT NULL AND  (TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND A.PA_RFST_FLIGHTSTATUS !='X'and A.PA_pa_mainflight is null
group by TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd')) arr on  bbb.dfdate = arr.fdate

left join(
select TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') as fdate , count(1) as Dcnt
from PL_DEPARTURE D
WHERE  D.PD_srtd                 IS NOT NULL AND  (TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND D.PD_RFST_FLIGHTSTATUS !='X' and  D.Pd_pd_mainflight is null
group by TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd')) dep on bbb.dfdate = dep.fdate
left join (

select TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') as fdate,count(1) as AXcnt
from PL_ARRIVAL A
WHERE  A.PA_SRTA                 IS NOT NULL AND  (TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND A.PA_RFST_FLIGHTSTATUS ='X'and A.PA_pa_mainflight is null
group by TO_CHAR(A.PA_SRTA- 5/24,'yyyy-mm-dd')) Xarr on  bbb.dfdate = Xarr.fdate
left join(
select TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') as fdate , count(1) as DXcnt
from PL_DEPARTURE D
WHERE  D.PD_srtd                 IS NOT NULL AND  (TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd') BETWEEN TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')) AND D.PD_RFST_FLIGHTSTATUS ='X' and  D.Pd_pd_mainflight is null
group by TO_CHAR(D.PD_srtd- 5/24,'yyyy-mm-dd')) Xdep on bbb.dfdate = Xdep.fdate order by bbb.dfdate