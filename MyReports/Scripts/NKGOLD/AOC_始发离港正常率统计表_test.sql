select * from (
select allf.pd_flightnumber,
       allf.pd_ral_airline,
      allcnt,
      delcnt,
	  (allcnt-delcnt)/allcnt as rate
       from(
SELECT
        pd_flightnumber ,
		pd_ral_airline,
        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','H/Z','C/B','H/Y','L/W','H/G')
        AND pd_atot is not null
        AND pa_aldt is not null
		AND (
                       TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)
             )
         group by  pd_ral_airline, pd_flightnumber
         )allf
         left join
(SELECT
        pd_flightnumber,

        count(1) as delcnt
      FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','H/Z','C/B','H/Y','L/W','H/G')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
                       TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24) AND pd_atot>pd_srtd +25/1440
             )
         group by   pd_flightnumber)delf on allf.pd_flightnumber = delf.pd_flightnumber
           where delcnt is not null
           order by   allf.pd_ral_airline, rate   )