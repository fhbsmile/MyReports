select 
pt.PT_IDSEQ,
pa.pa_flightnumber,
      pd.pd_flightnumber,
      pa.PA_RSTC_SERVICETYPECODE,
      pd.PD_RSTC_SERVICETYPECODE,
      pa.PA_RACT_AIRCRAFTTYPE,
      pa.PA_REGISTRATION,
      pt.PT_ROUTING,
      pa.PA_ATOTOUTSTATION,
      pa.PA_SRTA,
      pd.PD_SRTD,
      floor((pd.PD_SRTD-pa.PA_SRTA)*1440) as sttt,
      pt.pt_mttt
      from pl_turn pt
    LEFT JOIN pl_departure pd
    ON pt.pt_pd_departure = pd.pd_idseq
    LEFT JOIN pl_arrival pa
    ON pt.pt_pa_arrival                = pa.pa_idseq
where  pd.pd_SRTD BETWEEN  to_date('2017-03-21 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-03-24 00:00:00','yyyy-mm-dd hh24:mi:ss')
AND pa.PA_SRTA is not null
AND pd.pd_srtd is not null
AND floor((pd.PD_SRTD-pa.PA_SRTA)*1440) < NVL(pt.pt_mttt,0);