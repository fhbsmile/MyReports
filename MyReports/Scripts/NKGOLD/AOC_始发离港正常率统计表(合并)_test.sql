
select allf.pd_flightnumber,
       allf.pd_ral_airline,
      allcnt,
      NVL(delcnttmp,0) as delcnt,
	  (allcnt-NVL(delcnttmp,0))/allcnt as rate
       from(
SELECT
        pd_flightnumber ,
		    pd_ral_airline,
        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
        WHERE pt_pd_departure=pd_idseq(+)
        and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
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
       count(1) as delcnttmp
       FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode     IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
                       TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24) AND pd_atot>pd_srtd +25/1440
             )
         group by   pd_flightnumber)delf on allf.pd_flightnumber = delf.pd_flightnumber
           order by   allf.pd_ral_airline, allf.pd_flightnumber   ;
           
           
           select pt_routing,replace(substr(pt_routing,instr(pt_routing,'宁'),3),'-',TO_CHAR(pt_sibt,'hh24mi')||'-'||TO_CHAR(pt_sobt,'hh24mi')) from pl_turn;
           
           select '-'||to_char(null,'hh24mi') from dual;