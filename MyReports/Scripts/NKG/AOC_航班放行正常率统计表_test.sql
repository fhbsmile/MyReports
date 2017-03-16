select allf.pd_flightnumber,
       allf.PD_RAP_NEXTAIRPORT,
      allcnt,
      delcnt,
	  (allcnt-delcnt)/allcnt as rate
       from(
SELECT
        pd_flightnumber ,
        PD_RAP_NEXTAIRPORT,

        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       and pt_pa_arrival=pa_idseq(+)
         and pl_departure.pd_SRTD BETWEEN  to_date(?,'yyyy-mm-dd hh24:mi:ss') AND to_date(?,'yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','H/Z','C/B','H/Y','L/W','H/G')
        AND pd_atot is not null
        AND pa_aldt is not null
		AND (
                       TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24)
             )
         group by  pd_flightnumber,PD_RAP_NEXTAIRPORT
         )allf
         left join
(SELECT
        pd_flightnumber,
        PD_RAP_NEXTAIRPORT,
        count(1) as delcnt
      FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       and pt_pa_arrival=pa_idseq(+)
        and pl_departure.pd_SRTD BETWEEN  to_date(?,'yyyy-mm-dd hh24:mi:ss') AND to_date(?,'yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','H/Z','C/B','H/Y','L/W','H/G')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
                       TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND pd_atot>pd_srtd +25/1440 and pd_atot > pa_aldt +35/1440 +(pd_srtd-pa_srta)
             )
         group by   pd_flightnumber,PD_RAP_NEXTAIRPORT)delf on allf.pd_flightnumber = delf.pd_flightnumber
           where delcnt is not null
           order by   allf.pd_flightnumber, rate