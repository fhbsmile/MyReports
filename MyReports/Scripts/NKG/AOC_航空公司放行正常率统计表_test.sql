select allf.pd_ral_airline,
      allcnt,
      NVL(delcnt1,0) as delcnt,
      nvl(allcnt-NVL(delcnt1,0),0) as okcnt,
	  NVL((allcnt-NVL(delcnt1,0))/allcnt,0) as rate
       from(
SELECT
pd_ral_airline  ,

        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
       and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
         group by  pd_ral_airline
         )allf
         left join
(SELECT
         pd_ral_airline,
        NVL(count(1),0) as delcnt1
      FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
        AND (
               (
               TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND  pd_atot > pd_srtd +25/1440 AND pd_atot>pa_aldt+(pd_srtd-pa_srta) +35/1440
               )
            OR (TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  AND pd_atot>pd_srtd+25/1440)

         
             )
         group by   pd_ral_airline)delf on allf.pd_ral_airline = delf.pd_ral_airline
           order by   allf.pd_ral_airline, rate