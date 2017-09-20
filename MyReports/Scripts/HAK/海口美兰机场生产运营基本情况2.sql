select * from pl_arrival pa
where to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and pa.PA_DELAYREASONS is not null;

select * from pl_arrival pa
where to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and pa.PA_RRMK_REMARK like 'DI%';
select * from pl_arrival pa
where to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and pa.PA_RSTC_SERVICETYPECODE ='Q/B';

select * from ref_delayreason rd;

select * from REF_SERVICETYPECODE;
select * from REF_AIRLINE;

select count(*), pa.PA_RAL_AIRLINE from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
group by pa.PA_RAL_AIRLINE;
------------------------------------生产运营基本情况航班运行表-航空公司停场情况表
select * from (
select count(*) cnt, pa.PA_RAL_AIRLINE airline from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
and  pa.PA_RSTC_SERVICETYPECODE !='U/H'
and pt.PT_RMSC_SCENARIO =1
group by pa.PA_RAL_AIRLINE 
UNION ALL
select count(*) cnt,'TT' as airline from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
and  pa.PA_RSTC_SERVICETYPECODE ='U/H'
and pt.PT_RMSC_SCENARIO =1
group by 'TT') order by airline;
------------------------------------生产运营基本情况航班运行表-机型停场情况表

select count(*) cnt, ac.RACT_ICAOTYPE  as airtype from pl_arrival pa, pl_turn pt , pl_departure pd, REF_AIRCRAFTTYPE ac
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+) and pa.PA_RACT_AIRCRAFTTYPE = ac.RACT_INTERNALCODE(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
and pt.PT_RMSC_SCENARIO =1
group by ac.RACT_ICAOTYPE order by ac.RACT_ICAOTYPE;
-----------
select pa.pa_flightnumber as flightNumber,pa.PA_DELAYREASONS as rea from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) 
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170910'
and pa.PA_DELAYREASONS like '%延误%' ;
select pd.pd_flightnumber as flightNumber ,pd.PD_DELAYREASONS as rea from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170909'
and pd.PD_DELAYREASONS like '%延误%';
------------------------------------生产运营基本情况航班运行表-取消延误原因情况表

select SUM(NVL(cnt,0 )) AS All_cnt,
       SUM(DECODE(flow,'Y',cnt,0 )) AS flow_cnt ,
       SUM(DECODE(airline,'Y',cnt,0 )) AS airline_cnt ,
       SUM(DECODE(broken,'Y',cnt,0 )) AS broken_cnt ,
       SUM(DECODE(army,'Y',cnt,0 )) AS army_cnt ,
       SUM(DECODE(weather,'Y',cnt,0 )) AS weather_cnt ,
       SUM(DECODE(airport,'Y',cnt,0 )) AS airport_cnt ,
       SUM(DECODE(atc,'Y',cnt,0 )) AS atc_cnt ,
       SUM(DECODE(passenger,'Y',cnt,0 )) AS passenger_cnt ,
       SUM(DECODE(otherr,'Y',cnt,0 )) AS otherr_cnt ,
       'delay' as reportType
from(
select 1 as cnt,pd.PD_DELAYREASONS as rea ,
           (case when pd.pd_delayreasons like '%流量%' then 'Y' else 'N' end) as flow,
           (case when pd.pd_delayreasons like '%公司%' then 'Y' else 'N' end) as airline,
           (case when pd.pd_delayreasons like '%故障%' then 'Y' else 'N' end) as broken,
           (case when pd.pd_delayreasons like '%军事%' then 'Y' else 'N' end) as army,
           (case when pd.pd_delayreasons like '%天气%' then 'Y' else 'N' end) as weather,
           (case when pd.pd_delayreasons like '%机场%' then 'Y' else 'N' end) as airport,
           (case when pd.pd_delayreasons like '%管制%' then 'Y' else 'N' end) as atc,
           (case when pd.pd_delayreasons like '%旅客%' then 'Y' else 'N' end) as passenger,
           (case when pd.pd_delayreasons not like '%流量%' and pd.pd_delayreasons not like '%公司%' and pd.pd_delayreasons not like '%故障%' and pd.pd_delayreasons not like '%军事%' and pd.pd_delayreasons not like '%天气%' and pd.pd_delayreasons not like '%机场%' and pd.pd_delayreasons not like '%管制%' and pd.pd_delayreasons not like '%旅客%' then 'Y' when pd.pd_delayreasons is null then 'Y' else 'N' end) as otherr
           from pl_departure pd, pl_turn pt,pl_arrival pa 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and pt.pt_pa_arrival = pa.pa_idseq(+)
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_atot is not null
and pa.pa_aldt is not null
and ((to_char(pd.pd_srtd - 5/24,'yyyymmdd')!=to_char(pa.pa_srta - 5/24,'yyyymmdd') and (pd.pd_atot - pd.pd_srtd)*1440-20>0) or
     (to_char(pd.pd_srtd - 5/24,'yyyymmdd')=to_char(pa.pa_srta - 5/24,'yyyymmdd') and ((pa.pa_aldt<=pa.pa_srta and (pd.pd_atot - pd.pd_srtd)*1440-20>0) or (pa.pa_aldt>pa.pa_srta and (pd.pd_atot- pd.pd_srtd)*1440 - (pa.pa_aldt  - pa.pa_srta)*1440 -10 -20>0)))
         )
and pt.PT_RMSC_SCENARIO =1)
union all
select SUM(NVL(cnt,0 )) AS All_cnt,
       SUM(DECODE(flow,'Y',cnt,0 )) AS flow_cnt ,
       SUM(DECODE(airline,'Y',cnt,0 )) AS airline_cnt ,
       SUM(DECODE(broken,'Y',cnt,0 )) AS broken_cnt ,
       SUM(DECODE(army,'Y',cnt,0 )) AS army_cnt ,
       SUM(DECODE(weather,'Y',cnt,0 )) AS weather_cnt ,
       SUM(DECODE(airport,'Y',cnt,0 )) AS airport_cnt ,
       SUM(DECODE(atc,'Y',cnt,0 )) AS atc_cnt ,
       SUM(DECODE(passenger,'Y',cnt,0 )) AS passenger_cnt ,
       SUM(DECODE(otherr,'Y',cnt,0 )) AS otherr_cnt ,
       'cancel' as reportType
from(
select 1 as cnt,pa.PA_DELAYREASONS as rea ,
           (case when pa.pa_delayreasons like '%流量%' then 'Y' else 'N' end) as flow,
           (case when pa.pa_delayreasons like '%公司%' then 'Y' else 'N' end) as airline,
           (case when pa.pa_delayreasons like '%故障%' then 'Y' else 'N' end) as broken,
           (case when pa.pa_delayreasons like '%军事%' then 'Y' else 'N' end) as army,
           (case when pa.pa_delayreasons like '%天气%' then 'Y' else 'N' end) as weather,
           (case when pa.pa_delayreasons like '%机场%' then 'Y' else 'N' end) as airport,
           (case when pa.pa_delayreasons like '%管制%' then 'Y' else 'N' end) as atc,
           (case when pa.pa_delayreasons like '%旅客%' then 'Y' else 'N' end) as passenger,
           (case when pa.pa_delayreasons not like '%流量%' and pa.pa_delayreasons not like '%公司%' and pa.pa_delayreasons not like '%故障%' and pa.pa_delayreasons not like '%军事%' and pa.pa_delayreasons not like '%天气%' and pa.pa_delayreasons not like '%机场%' and pa.pa_delayreasons not like '%管制%' and pa.pa_delayreasons not like '%旅客%' then 'Y' when pa.pa_delayreasons is null then 'Y' else 'N' end) as otherr
           from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) 
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rfst_flightstatus ='X'
and pt.PT_RMSC_SCENARIO =1
union all
select 1 as cnt,pd.PD_DELAYREASONS as rea ,
           (case when pd.pd_delayreasons like '%流量%' then 'Y' else 'N' end) as flow,
           (case when pd.pd_delayreasons like '%公司%' then 'Y' else 'N' end) as airline,
           (case when pd.pd_delayreasons like '%故障%' then 'Y' else 'N' end) as broken,
           (case when pd.pd_delayreasons like '%军事%' then 'Y' else 'N' end) as army,
           (case when pd.pd_delayreasons like '%天气%' then 'Y' else 'N' end) as weather,
           (case when pd.pd_delayreasons like '%机场%' then 'Y' else 'N' end) as airport,
           (case when pd.pd_delayreasons like '%管制%' then 'Y' else 'N' end) as atc,
           (case when pd.pd_delayreasons like '%旅客%' then 'Y' else 'N' end) as passenger,
           (case when pd.pd_delayreasons not like '%流量%' and pd.pd_delayreasons not like '%公司%' and pd.pd_delayreasons not like '%故障%' and pd.pd_delayreasons not like '%军事%' and pd.pd_delayreasons not like '%天气%' and pd.pd_delayreasons not like '%机场%' and pd.pd_delayreasons not like '%管制%' and pd.pd_delayreasons not like '%旅客%' then 'Y' when pd.pd_delayreasons is null then 'Y' else 'N' end) as otherr
           from pl_departure pd, pl_turn pt  
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_rfst_flightstatus ='X'
and pt.PT_RMSC_SCENARIO =1);

-------------
  select pa.pa_flightnumber,pa.pa_srta,pa.pa_aldt,pd.pd_flightnumber, pd.pd_srtd,pd.pd_atot , pd.pd_delayreasons     from pl_departure pd, pl_turn pt,pl_arrival pa 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and pt.pt_pa_arrival = pa.pa_idseq(+)
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_atot is not null
and pa.pa_aldt is not null
and ((to_char(pd.pd_srtd - 5/24,'yyyymmdd')!=to_char(pa.pa_srta - 5/24,'yyyymmdd') and (pd.pd_atot - pd.pd_srtd)*1440-20>0) or
     (to_char(pd.pd_srtd - 5/24,'yyyymmdd')=to_char(pa.pa_srta - 5/24,'yyyymmdd') and ((pa.pa_aldt<=pa.pa_srta and (pd.pd_atot - pd.pd_srtd)*1440-20>0) or (pa.pa_aldt>pa.pa_srta and (pd.pd_atot- pd.pd_srtd)*1440 - (pa.pa_aldt  - pa.pa_srta)*1440 -10 -20>0)))
         )
and pt.PT_RMSC_SCENARIO =1
order by pd.pd_flightnumber;
-------------------航班运行
select count(*) as cnt  from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911';

select count(*) as cnt  from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911';


select count(*) as cnt , 'sch' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
group by 'sch',pa.pa_ral_airline ;

select count(*) as cnt , 'sch' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
group by 'sch',pd.pd_ral_airline ;

select count(*) as cnt , 'act' as cntType,  pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_aldt - 5/24,'yyyymmdd')='20170911'
group by 'act',pa.pa_ral_airline ;

select count(*) as cnt , 'act' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_atot - 5/24,'yyyymmdd')='20170911'
group by 'act',pd.pd_ral_airline ;

select count(*) as cnt , 'ret' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rstc_servicetypecode = 'F/H'
group by 'ret',pa.pa_ral_airline ;

select count(*) as cnt , 'ret' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_rstc_servicetypecode = 'F/H'
group by 'ret',pd.pd_ral_airline ;

select count(*) as cnt , 'cnl' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rrmk_remark = 'CNCL'
group by 'cnl',pa.pa_ral_airline ;

select count(*) as cnt , 'cnl' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_rrmk_remark = 'CNCL'
group by 'cnl',pd.pd_ral_airline ;

select count(*) as cnt , 'divin' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and (pa.pa_rstc_servicetypecode = 'C/B' or pa.pa_rap_diversionairport='HAK')
group by 'divin',pa.pa_ral_airline ;

select count(*) as cnt , 'divout' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rap_diversionairport is not null
and pa.pa_rap_diversionairport !='HAK'
group by 'divout',pa.pa_ral_airline ;

----------------------------------------
select cnt as sch_cnt, 0 as act_cnt, 0 as ret_cnt, 0 as cnl_cnt, 0 as ncb_cnt, 0 as divin, 0 as divout, airline from (
select count(*) as cnt , 'sch' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
group by 'sch',pa.pa_ral_airline 
UNION ALL
select count(*) as cnt , 'sch' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
group by 'sch',pd.pd_ral_airline );

select 0 as sch_cnt, cnt as act_cnt, 0 as ret_cnt, 0 as cnl_cnt, 0 as ncb_cnt, 0 as divin, 0 as divout, airline from (
select count(*) as cnt , 'act' as cntType,  pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_aldt - 5/24,'yyyymmdd')='20170911'
group by 'act',pa.pa_ral_airline 
UNION ALL
select count(*) as cnt , 'act' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_atot - 5/24,'yyyymmdd')='20170911'
group by 'act',pd.pd_ral_airline) ;

select 0 as sch_cnt, 0 as act_cnt, cnt as ret_cnt, 0 as cnl_cnt, 0 as ncb_cnt, 0 as divin, 0 as divout, airline from (
select count(*) as cnt , 'ret' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rstc_servicetypecode = 'F/H'
group by 'ret',pa.pa_ral_airline
UNION ALL
select count(*) as cnt , 'ret' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_rstc_servicetypecode = 'F/H'
group by 'ret',pd.pd_ral_airline) ;
select 0 as sch_cnt, 0 as act_cnt, 0 as ret_cnt, cnt as cnl_cnt, 0 as ncb_cnt, 0 as divin, 0 as divout, airline from (
select count(*) as cnt , 'cnl' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rrmk_remark = 'CNCL'
group by 'cnl',pa.pa_ral_airline
UNION ALL
select count(*) as cnt , 'cnl' as cntType, pd.pd_ral_airline airline from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.pd_rrmk_remark = 'CNCL'
group by 'cnl',pd.pd_ral_airline) ;
select 0 as sch_cnt, 0 as act_cnt, 0 as ret_cnt, 0 as cnl_cnt, 0 as ncb_cnt, cnt as divin, 0 as divout, airline from (
select count(*) as cnt , 'divin' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and (pa.pa_rstc_servicetypecode = 'C/B' or pa.pa_rap_diversionairport='HAK')
group by 'divin',pa.pa_ral_airline);

select 0 as sch_cnt, 0 as act_cnt, 0 as ret_cnt, 0 as cnl_cnt, 0 as ncb_cnt, 0 as divin, cnt as divout, airline from (
select count(*) as cnt , 'divout' as cntType, pa.pa_ral_airline airline from pl_arrival pa, pl_turn pt
where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.pa_rap_diversionairport is not null
and pa.pa_rap_diversionairport !='HAK'
group by 'divout',pa.pa_ral_airline) ;


---------------生产运营基本情况航班运行表

select A.agents as agents,
    SUM(NVL(cnt,0))                                AS AllCount,
    SUM(DECODE(A.cntType,'sch',cnt,0 )) AS SCH,
    SUM(DECODE(A.cntType,'act',cnt,0 )) AS ACT,
    SUM(DECODE(A.cntType,'ret',cnt,0 )) AS RET,
    SUM(DECODE(A.cntType,'cnl',cnt,0 )) AS CNL,
    SUM(DECODE(A.cntType,'cnlb',cnt,0 )) AS CNLB,
    SUM(DECODE(A.cntType,'divin',cnt,0 )) AS DIVIN,
    SUM(DECODE(A.cntType,'divout',cnt,0 )) AS DIVOUT
from(
    select sum(NVL(B.cnt,0)) as cnt, B.cntType as cntType, DECODE(B.agents,'CSN','南航','CHH','海航','外航') as agents from (
          select count(*) as cnt , 'sch' as cntType, pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pt.PT_RMSC_SCENARIO =1
          group by 'sch',pa.PA_RHA_AGENTBAG
          UNION ALL 
          select count(*) as cnt , 'sch' as cntType, pd.PD_RHA_AGENTCI as agents from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pt.PT_RMSC_SCENARIO =1
          group by 'sch',pd.PD_RHA_AGENTCI
          UNION ALL 
          select count(*) as cnt , 'act' as cntType,  pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_aldt - 5/24,'yyyymmdd')='20170911'
          and pt.PT_RMSC_SCENARIO =1
          group by 'act',pa.PA_RHA_AGENTBAG
          UNION ALL 
          select count(*) as cnt , 'act' as cntType,pd.PD_RHA_AGENTCI from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_atot - 5/24,'yyyymmdd')='20170911'
          and pt.PT_RMSC_SCENARIO =1
          group by 'act',pd.PD_RHA_AGENTCI
          UNION ALL  
          select count(*) as cnt , 'ret' as cntType,pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rstc_servicetypecode = 'F/H'
          and pt.PT_RMSC_SCENARIO =1
          group by 'ret',pa.PA_RHA_AGENTBAG
          UNION ALL 
          select count(*) as cnt , 'ret' as cntType,pd.PD_RHA_AGENTCI as agents from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rstc_servicetypecode = 'F/H'
          and pt.PT_RMSC_SCENARIO =1
          group by 'ret',pd.PD_RHA_AGENTCI
          UNION ALL 
          select count(*) as cnt , 'cnl' as cntType, pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rrmk_remark = 'CNCL'
          and pt.PT_RMSC_SCENARIO =1
          group by 'cnl',pa.PA_RHA_AGENTBAG
          UNION ALL 
          select count(*) as cnt , 'cnl' as cntType,pd.PD_RHA_AGENTCI as agents from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rrmk_remark = 'CNCL'
          and pt.PT_RMSC_SCENARIO =1
          group by 'cnl',pd.PD_RHA_AGENTCI
          UNION ALL 
          select count(*) as cnt, 'cnlb' as cntType, pd.PD_RHA_AGENTCI as agents from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rrmk_remark = 'CNAL'
          and pt.PT_RMSC_SCENARIO =1
          group by 'cnlb',pd.PD_RHA_AGENTCI
          UNION ALL 
          select count(*) as cnt , 'divin' as cntType, pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and (pa.pa_rstc_servicetypecode = 'C/B' or pa.pa_rap_diversionairport='HAK')
          and pt.PT_RMSC_SCENARIO =1
          group by 'divin',pa.PA_RHA_AGENTBAG
          UNION ALL 
          select count(*) as cnt , 'divout' as cntType, pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rap_diversionairport is not null
          and pa.pa_rap_diversionairport !='HAK'
          and pt.PT_RMSC_SCENARIO =1
          group by 'divout',pa.PA_RHA_AGENTBAG
      )B group by B.cntType,DECODE(B.agents,'CSN','南航','CHH','海航','外航') 
)A group by A.agents;
----------------------------
select count(*), pa.PA_RAL_AIRLINE,pa.PA_RHA_AGENTBAG as agents from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
group by pa.PA_RAL_AIRLINE ,pa.PA_RHA_AGENTBAG;


select count(*) as cnt ,pd.pd_ral_airline airline,pd.PD_RHA_AGENTCI as agents from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
group by 'sch',pd.pd_ral_airline,pd.PD_RHA_AGENTBAG,pd.PD_RHA_AGENTCI ;
