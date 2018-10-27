select pa.pa_flightnumber,
pa.pa_rctt_countrytype,
pa.pa_srta,
pa.pa_aldt,
pd.pd_flightnumber,
pd.pd_rctt_countrytype,
pd.pd_srtd,
pd.pd_atot , 
pt.pt_routing,
pt.PT_ROUTINGIATA3LC
from pl_departure pd, pl_turn pt,pl_arrival pa 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and pt.pt_pa_arrival = pa.pa_idseq(+)
and (to_char(pa.pa_srta - 5/24,'yyyymmdd')=substr('20181027', 1, 8) or to_char(pd.pd_srtd - 5/24,'yyyymmdd')=substr('20181027', 1, 8))
and (pd.pd_rctt_countrytype ! = 'D' or pa.pa_rctt_countrytype ! = 'D')
and pa.pa_aldt is not null
and pt.PT_RMSC_SCENARIO =1
order by pa.pa_srta,pd.pd_srtd;