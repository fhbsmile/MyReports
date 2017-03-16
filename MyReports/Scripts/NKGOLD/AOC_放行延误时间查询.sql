 SELECT  pd_idseq,
        pa_flightnumber,
        pd_flightnumber,
        pd_ract_aircrafttype,
        pa_srta,
        pd_srtd,
        floor((pd_srtd-pa_srta)*1440) as sttt,
        pt_mttt,
        pa_aldt,
        pa_aldt+35/1440+(pd_srtd-pa_srta) as normalTakeoffTime,
        pd_atot,
        floor((pd_atot-greatest(pa_aldt+35/1440+(pd_srtd-pa_srta),pd_srtd+25/1440))*1440) as delayTime
       FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       AND pt_pa_arrival=pa_idseq(+)
        AND TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') =  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
        AND TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) 
        AND  pd_atot > pd_srtd +25/1440 
        AND pd_atot>pa_aldt+(pd_srtd-pa_srta) +35/1440
union
 SELECT  pd_idseq,
        pa_flightnumber,
        pd_flightnumber,
        pd_ract_aircrafttype,
        pa_srta,
        pd_srtd,
        floor((pd_srtd-pa_srta)*1440) as sttt,
        pt_mttt,
        pa_aldt,
        pa_aldt+35/1440+(pd_srtd-pa_srta) as normalTakeoffTime,
        pd_atot,
        floor((pd_atot-pd_srtd-25/1440)*1440) as delayTime
       FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq
       AND pt_pa_arrival=pa_idseq(+)
        AND TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') =  to_char(to_date('2017-03-05 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
        AND TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  
        AND pd_atot>pd_srtd+25/1440;