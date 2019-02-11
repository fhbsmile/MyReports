select * from (
select 
ROW_NUMBER() OVER(PARTITION BY TRUNC(pa.PA_SRTA-5/24) ORDER BY pa.pa_aldt DESC) rn,
pa.pa_idseq,
pa.pa_flightnumber,
pa.pa_eldt,
pa.pa_srta,
pa.pa_aldt,
pt.pt_routing as arouting,
TRUNC(pa.PA_SRTA-5/24) as da
from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.pa_idseq(+)
and TRUNC(pa.PA_SRTA-5/24) BETWEEN to_date('2019-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss') AND to_date('2019-01-09 23:59:59', 'YYYY-MM-DD hh24:mi:ss')
and pa.pa_rstc_servicetypecode   IN ('W/Z','C/B','L/W')
and pa.pa_rfst_flightstatus !='X'
and pt.pt_rmsc_scenario = 1
) ga where ga.rn =1;
----------------
select gga.da,gga.pa_flightnumber ,gga.arouting,COALESCE(gga.pa_aldt,gga.pa_eldt,gga.pa_srta) as atime, ggd.pd_flightnumber,ggd.drouting,COALESCE(ggd.pd_atot,ggd.pd_etot,ggd.pd_srtd) as dtime  from (
select * from (
select 
ROW_NUMBER() OVER(PARTITION BY TRUNC(pa.PA_SRTA-5/24) ORDER BY pa.pa_aldt DESC) rn,
pa.pa_idseq,
pa.pa_flightnumber,
pa.pa_eldt,
pa.pa_srta,
pa.pa_aldt,
pt.pt_routing as arouting,
TRUNC(pa.PA_SRTA-5/24) as da
from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.pa_idseq(+)
and TRUNC(pa.PA_SRTA-5/24) BETWEEN to_date('2019-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss') AND to_date('2019-01-09 23:59:59', 'YYYY-MM-DD hh24:mi:ss')
and pa.pa_rstc_servicetypecode   IN ('W/Z','C/B','L/W')
and pa.pa_rfst_flightstatus !='X'
and pt.pt_rmsc_scenario = 1
) ga where ga.rn =1) gga left join (select * from (select * from(
select 
ROW_NUMBER() OVER(PARTITION BY TRUNC(pd.PD_SRTD-5/24) ORDER BY pd.pd_atot DESC) rn,
pd.pd_idseq,
pd.pd_flightnumber,
pd.pd_srtd,
pd.pd_etot,
pd.pd_atot,
pt.pt_routing as drouting,
TRUNC(pd.PD_SRTD-5/24) as dd
from pl_departure pd, pl_turn pt
where pt.pt_pd_departure = pd.pd_idseq(+)
and TRUNC(pd.PD_SRTD-5/24) BETWEEN to_date('2019-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss') AND to_date('2019-01-09 23:59:59', 'YYYY-MM-DD hh24:mi:ss')
and pd.pd_rstc_servicetypecode   IN ('W/Z','C/B','L/W')
and pd.pd_rfst_flightstatus !='X'
and pt.pt_rmsc_scenario = 1
) gd where gd.rn =1))ggd on gga.da = ggd.dd;

----------------------
select pa.pa_idseq,
pa.pa_flightnumber,
pa.pa_aldt,
pa.pa_srta
from pl_arrival pa
where pa_idseq=2473420;
select * from pl_arrival pa where pa_idseq=2473420;
SELECT a."RN",a."ID",a."USERCODE",a."LOGINTIME",a."BZ",a."DQCODE" 
  FROM (SELECT ROW_NUMBER() OVER(PARTITION BY usercode ORDER BY logintime DESC) rn,
               sys_userlogin_info.*
          FROM sys_userlogin_info) a where a.rn=1;
