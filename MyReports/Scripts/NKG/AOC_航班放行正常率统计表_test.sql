select allf.pd_flightnumber,
       allf.routing,
      allcnt,
      NVL(delcnttmp,0) as delcnt,
	  (allcnt- NVL(delcnttmp,0))/allcnt as rate
       from(
SELECT
        pd_flightnumber ,
        replace(substr(pt_routing,instr(pt_routing,'宁'),10),'宁-','宁'||TO_CHAR(pd_srtd,'hh24mi')||'-'||TO_CHAR(prt_stastation,'hh24mi')) as routing,
        count(1) as allcnt
        FROM PL_DEPARTURE , pl_turn, pl_arrival,pl_routing
        WHERE pt_pd_departure=pd_idseq(+)
        and pt_pa_arrival=pa_idseq(+)
        and PL_DEPARTURE.pd_idseq= prt_pd_departure
        and PL_DEPARTURE.pd_RAP_NEXTAIRPORT=prt_rap_Airport
         and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
         group by  pd_flightnumber,replace(substr(pt_routing,instr(pt_routing,'宁'),10),'宁-','宁'||TO_CHAR(pd_srtd,'hh24mi')||'-'||TO_CHAR(prt_stastation,'hh24mi'))
         )allf
         left join
(SELECT
        pd_flightnumber,
       replace(substr(pt_routing,instr(pt_routing,'宁'),10),'宁-','宁'||TO_CHAR(pd_srtd,'hh24mi')||'-'||TO_CHAR(prt_stastation,'hh24mi')) as routing,
       count(1) as delcnttmp
       FROM PL_DEPARTURE , pl_turn, pl_arrival,pl_routing
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
       and PL_DEPARTURE.pd_idseq= prt_pd_departure
       and PL_DEPARTURE.pd_RAP_NEXTAIRPORT=prt_rap_Airport
        and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
                       (TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND pd_atot>pd_srtd +25/1440 and pd_atot > pa_aldt +35/1440 +(pd_srtd-pa_srta))
                        OR (TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  AND pd_atot>pd_srtd+25/1440)
             )
         group by   pd_flightnumber,replace(substr(pt_routing,instr(pt_routing,'宁'),10),'宁-','宁'||TO_CHAR(pd_srtd,'hh24mi')||'-'||TO_CHAR(prt_stastation,'hh24mi')))delf on allf.pd_flightnumber = delf.pd_flightnumber and allf.routing = delf.routing 
           order by   allf.pd_flightnumber;