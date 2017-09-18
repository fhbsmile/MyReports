select * from (select pa.PA_FLIGHTNUMBER as flightNumber,pt.PT_ROUTING as routing,pa.PA_DELAYREASONS as delayReason,'1进港取消航班' as reportType from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')= '2017-09-11'
and pa.PA_RFST_FLIGHTSTATUS='X'
UNION ALL
select pd.Pd_FLIGHTNUMBER  as flightNumber,pt.PT_ROUTING  as routing,pd.Pd_DELAYREASONS  as delayReason,'2出港取消航班'  as reportType from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.Pd_IDSEQ(+)
and to_char(pd.pd_srtd - 5/24,'yyyy-mm-dd')= '2017-09-11' and pd.Pd_RFST_FLIGHTSTATUS='X'
UNION ALL
select pd.Pd_FLIGHTNUMBER  as flightNumber,pt.PT_ROUTING  as routing,pd.Pd_DELAYREASONS  as delayReason,'3出港延误超过4小时航班'  as reportType from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.Pd_IDSEQ(+)
and to_char(pd.pd_srtd - 5/24,'yyyy-mm-dd')= '2017-09-11' and pd.pd_atot is not null and (pd.pd_atot-pd.pd_srtd)*1440 > 240
UNION ALL
select pa.PA_FLIGHTNUMBER  as flightNumber,pt.PT_ROUTING  as routing,pa.PA_DELAYREASONS  as delayReason,'4备降航班'  as reportType from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11' and (pa.pa_rstc_servicetypecode='C/B' or pa.pa_rap_diversionairport='HAK')
UNION ALL 
select null  as flightNumber,null  as routing,null  as delayReason,'4备降航班'  as reportType from dual) order by reportType;

