
 
 select inallxx.RAP_FEderalstate,NVL(inallcntt,0) as inallcnt,NVL(indelcntt,0) as indelcnt,NVL(allcntt,0) as allcnt from (
   select  'link' as linkxx,  RAP_FEderalstate,count(1) as inallcntt
   from PL_DEPARTURE,pl_arrival, pl_turn,ref_airport
   where pt_pd_departure=pd_idseq(+)
    and pt_pa_arrival=pa_idseq(+)
   And PD_RAP_DESTINATIONAIRPORT=RAP_INTERNALCODE(+)
    and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
    AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
    AND pd_atot is not null
    AND pa_aldt is not null
    group by  RAP_FEderalstate) inallxx        
 left join (        
   select    RAP_FEderalstate,count(1) as indelcntt
   from PL_DEPARTURE ,pl_arrival, pl_turn,ref_airport
   where pt_pd_departure=pd_idseq(+)
    and pt_pa_arrival=pa_idseq(+)
   And PD_RAP_DESTINATIONAIRPORT=RAP_INTERNALCODE(+)
    and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND pd_atot is not null
        AND pa_aldt is not null
        AND (
                       (TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND pd_atot>pd_srtd +25/1440 and pd_atot > pa_aldt +35/1440 +(pd_srtd-pa_srta))
                        OR (TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  AND pd_atot>pd_srtd+25/1440)
             ) group by    RAP_FEderalstate ) indelxx on inallxx.RAP_FEderalstate = indelxx.RAP_FEderalstate
             
   left join (
    select 'link' as alink,  count(1) as allcntt
   from PL_DEPARTURE,pl_arrival, pl_turn
   where pt_pd_departure=pd_idseq(+)
    and pt_pa_arrival=pa_idseq(+)
    and pl_departure.pd_SRTD BETWEEN  to_date('2017-03-06 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-09 00:00:00','yyyy-mm-dd hh24:mi:ss')
    AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
    AND pd_atot is not null
    AND pa_aldt is not null
   ) allxx on allxx.alink= inallxx.linkxx ;
   
         
         
         
         
         
         
         
         
         
         
         
         