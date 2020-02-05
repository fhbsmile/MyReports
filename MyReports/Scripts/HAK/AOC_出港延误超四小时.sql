select  departure.pd_idseq as pid,
departure.pd_flightnumber as flightNumber,
substr(departure.pd_flightnumber,1,2) as airline,
departure.PD_AOBT as sobt,
departure.PD_AOBT as aobt,
departure.PD_SRTD as srtd,
departure.PD_ATOT as atot,
to_CHAR(departure.PD_SRTD,'yyyy-mm-dd') as flightDate,
ceil((departure.PD_ATOT-departure.PD_SRTD)*24*60) as delayTime,
delayview.delayCode as delayCode,
delayview.delaydiscription as delayReason,
departure.PD_RSTC_SERVICETYPECODE as serviceTypeCode 
from PL_DEPARTURE departure left join ( select PL_DELAYREASON.pdlr_pd_departure as pd_seq,PL_DELAYREASON.pdlr_rdlr_delayreason as delayCode,ref_delayreason.rdlr_description as delaydiscription from ref_delayreason, pl_delayreason where pl_delayreason.pdlr_rdlr_delayreason = ref_delayreason.rdlr_codenumeric) delayview on departure.pd_idseq = delayview.pd_seq 
where PD_SRTD between to_date('2018-10-27 00:00:00','yyyy-mm-dd hh24:mi:ss') and to_date('2018-10-27 23:59:59','yyyy-mm-dd hh24:mi:ss') 
and departure.PD_ATOTT is not null 
and departure.PD_RMSC_SCENARIO =1
and ceil((departure.PD_ATOT-departure.PD_SRTD)*24*60) >=240;


---------
select pd_idseq as pid,
pd_flightnumber as flightNumber,
substr(pd_flightnumber,1,2) as airline,
PD_SOBT as sobt,
PD_AOBT as aobt,
PD_SRTD as srtd,
PD_ATOT as atot,
to_CHAR(PD_SRTD,'yyyy-mm-dd') as flightDate,
case when departureindicator ='G' and isontime = 'N' then ceil((NVL(PD_ATOT,sysdate)-NVL(PA_ALDT+10/24/60+(PD_SRTD-PA_SRTA),PD_SRTD))*24*60 -25) else  ceil((NVL(PD_ATOT,sysdate)-PD_SRTD)*24*60 -25) end delayTime,
delayview.delayCode as delayCode,
delayview.delaydiscription as delayReason,
PD_RSTC_SERVICETYPECODE AS serviceTypeCode
from(
select pa_idseq, 
pa.pa_flightnumber,
pa.pa_srta,
pa.pa_aldt,
pd_idseq,
pd.pd_sobt,
pd.pd_flightnumber,
pd.pd_srtd,
pd.pd_atot,
pd.pd_etot,
pd.pd_aobt,
pd.PD_RSTC_SERVICETYPECODE,
decode(to_char(pa.pa_srta - 5/24, 'yyyymmdd'),to_char(pd.pd_srtd - 5/24, 'yyyymmdd'),'G','S') as departureindicator,
CASE WHEN (pa.pa_aldt + 10/1440) <=pa.pa_srta THEN 'Y'  ELSE 'N' END isontime
from pl_turn pt,pl_arrival pa,pl_departure pd
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and pt.pt_pa_arrival is not null
and pt.pt_pd_departure is not null
and pd.pd_srtd  between to_date('2019-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss') and to_date('2019-01-01 23:59:59', 'YYYY-MM-DD hh24:mi:ss')
and pt.pt_rmsc_scenario = 1) flight left join ( select PL_DELAYREASON.pdlr_pd_departure as pd_seq,PL_DELAYREASON.pdlr_rdlr_delayreason as delayCode,ref_delayreason.rdlr_description as delaydiscription from ref_delayreason, pl_delayreason where pl_delayreason.pdlr_rdlr_delayreason = ref_delayreason.rdlr_codenumeric) delayview on flight.pd_idseq = delayview.pd_seq 
where case when departureindicator ='G' and isontime = 'N' then ceil((NVL(PD_ATOT,sysdate)-NVL(PA_ALDT+10/24/60+(PD_SRTD-PA_SRTA),PD_SRTD))*24*60 -25) else  ceil((NVL(PD_ATOT,sysdate)-PD_SRTD)*24*60 -25) end  >0;