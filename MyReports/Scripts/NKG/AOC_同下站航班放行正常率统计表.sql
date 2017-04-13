select allf.PD_RAP_NEXTAIRPORT as airport,
      allcnt,
      NVL(delf.delcnttmp,0) as delcnt,
      allcnt-NVL(delf.delcnttmp,0) as okcnt,
	  (allcnt-NVL(delf.delcnttmp,0))/allcnt as rate
       from(
              SELECT
        PD_RAP_NEXTAIRPORT  ,
        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
        WHERE pt_pd_departure=pd_idseq(+)
        and pt_pa_arrival=pa_idseq(+)
        and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
         group by  PD_RAP_NEXTAIRPORT
         )allf
         left join
     (SELECT
         PD_RAP_NEXTAIRPORT,
        count(1) as delcnttmp
       FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
        and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
               ( TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND  pd_atot > pd_srtd +25/1440 AND pd_atot>pa_aldt+(pd_srtd-pa_srta) +35/1440 )
              OR (TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  AND pd_atot>pd_srtd+25/1440)        
             ) group by   PD_RAP_NEXTAIRPORT )delf on allf.PD_RAP_NEXTAIRPORT = delf.PD_RAP_NEXTAIRPORT
           order by   allf.PD_RAP_NEXTAIRPORT, rate;