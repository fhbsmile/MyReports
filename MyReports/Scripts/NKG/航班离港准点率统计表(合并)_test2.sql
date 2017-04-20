select allf.pd_flightnumber,
      allcnt,
      NVL(delcnttmp,0) as delcnt,
	  (allcnt- NVL(delcnttmp,0))/allcnt as rate
       from(
SELECT
        pd_flightnumber ,
        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival
        WHERE pt_pd_departure=pd_idseq(+)
        and pt_pa_arrival=pa_idseq(+)
         and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-21 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-24 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
         group by  pd_flightnumber
         )allf
         left join
(SELECT
        pd_flightnumber,
       count(1) as delcnttmp
       FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
        and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-21 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-24 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND pd_atot>pd_SRTD+25/1440
         group by   pd_flightnumber)delf on allf.pd_flightnumber = delf.pd_flightnumber order by allf.pd_flightnumber