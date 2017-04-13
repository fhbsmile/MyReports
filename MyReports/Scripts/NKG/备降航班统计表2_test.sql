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
      pa.PA_ALDT,
      pd.PD_ATOT,
      pa.PA_RSTA_STAND,
      pd.PD_RSTA_STAND
      from pl_turn pt,pl_departure pd,pl_arrival pa
      where pt.pt_pd_departure = pd.pd_idseq(+)
      AND  pt.pt_pa_arrival   = pa.pa_idseq(+)
      AND TO_CHAR(pa.pa_srta- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date('2017-02-01 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date('2017-03-07 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
      AND  pa.PA_RSTC_SERVICETYPECODE='Q/B'
      AND pa.PA_RFST_FLIGHTSTATUS !='X';