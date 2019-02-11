select delayRate.pd_date, delayRate.pd_hour, count(case delayRate.delayed when 'Y' then 1 end) as delayNo, count(1) as fltNo,
       delayRate.start_time, delayRate.end_time
from (select delay.*, decode(sign(delayTime),1,'Y','N') as delayed
from(
select dep.*,
       round(decode(dep.passThru||dep.arrDelay, 'YY', (dep.pd_atot - (dep.pa_aldt+10/24/60+(dep.pd_srtd-dep.pa_srta)))*24*60-25,
                                                (dep.pd_atot - dep.pd_srtd)*24*60-25)) as delayTime
from(
select pd.pd_flightnumber, to_char(pd.pd_srtd-5/24,'yyyymmdd') as pd_date, to_char(pd.pd_srtd, 'hh24') as pd_hour, pd.pd_srtd,
       pd.pd_atot, pa.pa_flightnumber, to_char(pa.pa_srta-5/24, 'yyyymmdd') as pa_date, pa.pa_srta, pa.pa_aldt,
       decode(to_char(pd.pd_srtd-5/24,'yyyymmdd'), to_char(pa.pa_srta-5/24, 'yyyymmdd'), 'Y', 'N') as passThru,
       decode(sign(pa.pa_aldt + 10/24/60 - pa.pa_srta), 1, 'Y', 'N') arrDelay,
       to_char(to_date(?, 'yyyymmdd hh24miss'),'yyyy-mm-dd hh24:mi') as start_time,
       to_char(to_date(?, 'yyyymmdd hh24miss'),'yyyy-mm-dd hh24:mi') as end_time
from pl_departure pd
left join pl_turn pt on pt.pt_pd_departure = pd.pd_idseq
left join pl_arrival pa on pa.pa_idseq = pt.pt_pa_arrival
where pd.pd_rstc_servicetypecode in ('W/Z','C/B','H/Y','Z/X','H/G','L/W')
and pd.pd_pd_mainflight is null
and pd.pd_rmsc_scenario = 1
and (pd.pd_rrmk_remark <> 'CNCL' or pd.pd_rrmk_remark is null)
) dep
) delay
where delay.pd_srtd between to_date(?, 'yyyymmdd hh24miss') and to_date(?, 'yyyymmdd hh24miss')) delayRate
group by delayRate.start_time, delayRate.end_time, delayRate.pd_date, delayRate.pd_hour
order by delayRate.pd_date, delayRate.pd_hour