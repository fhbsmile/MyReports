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
select SUM(NVL(cnt,0 )) AS All_cnt ,
       SUM(DECODE(T.airline,'HU',cnt,0 )) AS HU_cnt ,
       SUM(DECODE(T.airline,'CZ',cnt,0 )) AS CZ_cnt ,
       SUM(DECODE(T.airline,'JD',cnt,0 )) AS JD_cnt ,
       SUM(DECODE(T.airline,'GS',cnt,0 )) AS GS_cnt ,
       SUM(DECODE(T.airline,'ZH',cnt,0 )) AS ZH_cnt ,
       SUM(DECODE(T.airline,'SC',cnt,0 )) AS SC_cnt ,
       SUM(DECODE(T.airline,'GX',cnt,0 )) AS GX_cnt ,
       SUM(DECODE(T.airline,'AQ',cnt,0 )) AS AQ_cnt ,
       SUM(DECODE(T.airline,'8Y',cnt,0 )) AS YY_cnt ,
       SUM(DECODE(T.airline,'DZ',cnt,0 )) AS DZ_cnt ,
       SUM(DECODE(T.airline,'TTT',cnt,0 )) AS TTT_cnt 
from (
select count(*) cnt, pa.PA_RAL_AIRLINE airline from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
group by pa.PA_RAL_AIRLINE) T;

select pa.pa_flightnumber flightNumber, to_char(pa.pa_srta - 5/24,'yyyy-mm-dd hh24:mi') srta,pa.PA_RSTA_STAND as stand_A, pa.PA_RAL_AIRLINE airline,pd.pd_flightnumber flightNumber, to_char(pd.pd_srtd - 5/24,'yyyy-mm-dd hh24:mi') srtd,pd.PD_RSTA_STAND as stand_D from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
and pa.PA_RFST_FLIGHTSTATUS != 'X'
order by pa.PA_RAL_AIRLINE;
------------------------------------生产运营基本情况航班运行表-机型停场情况表
select SUM(NVL(cnt,0 )) AS All_cnt ,
       SUM(DECODE(T.airtype,'B787',cnt,0 )) AS B78_cnt ,
       SUM(DECODE(T.airtype,'B777',cnt,0 )) AS B777_cnt ,
       SUM(DECODE(T.airtype,'B767',cnt,0 )) AS B767_cnt ,
       SUM(DECODE(T.airtype,'B757',cnt,0 )) AS B757_cnt ,
       SUM(DECODE(T.airtype,'B737',cnt,0 )) AS B737_cnt ,
       SUM(DECODE(T.airtype,'A330',cnt,0 )) AS A330_cnt ,
       SUM(DECODE(T.airtype,'A321',cnt,0 )) AS A321_cnt ,
       SUM(DECODE(T.airtype,'A320',cnt,0 )) AS A320_cnt ,
       SUM(DECODE(T.airtype,'A319',cnt,0 )) AS A319_cnt ,
       SUM(DECODE(T.airtype,'E190',cnt,0 )) AS E190_cnt ,
       SUM(DECODE(T.airtype,'TTT',cnt,0 )) AS TTT_cnt 
from (
select count(*) cnt, ac.RACT_ICAOTYPE  airtype from pl_arrival pa, pl_turn pt , pl_departure pd, REF_AIRCRAFTTYPE ac
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+) and pa.PA_RACT_AIRCRAFTTYPE = ac.RACT_INTERNALCODE(+)
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
group by ac.RACT_ICAOTYPE) T;
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
select * from (
select SUM(NVL(cnt,0 )) AS All_cnt,
       SUM(DECODE(instr(rea,'流量控制'),5,cnt,0 )) AS A_cnt ,
       SUM(DECODE(instr(rea,'公司计划'),5,cnt,0 )) AS B_cnt ,
       SUM(DECODE(instr(rea,'机械故障'),5,cnt,0 )) AS C_cnt ,
       SUM(DECODE(instr(rea,'军事'),7,cnt,0 )) AS D_cnt ,
       SUM(DECODE(instr(rea,'天气'),7,cnt,0 )) AS E_cnt ,
       SUM(DECODE(instr(rea,'机场关闭'),5,cnt,0 )) AS F_cnt ,
       SUM(DECODE(instr(rea,'航行管制'),5,cnt,0 )) AS G_cnt ,
       SUM(DECODE(instr(rea,'旅客'),5,cnt,0 )) AS H_cnt ,
       SUM(NVL(cnt,0 )) -(SUM(DECODE(instr(rea,'流量控制'),5,cnt,0 )) + SUM(DECODE(instr(rea,'公司计划'),5,cnt,0 )) + SUM(DECODE(instr(rea,'机械故障'),5,cnt,0 )) +SUM(DECODE(instr(rea,'军事'),7,cnt,0 )) +SUM(DECODE(instr(rea,'天气'),7,cnt,0 ))+ SUM(DECODE(instr(rea,'机场关闭'),5,cnt,0 )) + SUM(DECODE(instr(rea,'航行管制'),5,cnt,0 )) +SUM(DECODE(instr(rea,'旅客'),5,cnt,0 ))) AS EL_cnt ,
       'delay' as reportType
from(
select count(*) as cnt,pa.PA_DELAYREASONS as rea from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) 
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.PA_DELAYREASONS like '%延误%' 
group by pa.PA_DELAYREASONS
union
select count(*)as cnt ,pd.PD_DELAYREASONS as rea from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.PD_DELAYREASONS like '%延误%'
group by pd.PD_DELAYREASONS)
union all
select SUM(NVL(cnt,0 )) AS All_cnt,
       SUM(DECODE(instr(rea,'流量控制'),5,cnt,0 )) AS A_cnt ,
       SUM(DECODE(instr(rea,'公司计划'),5,cnt,0 )) AS B_cnt ,
       SUM(DECODE(instr(rea,'机械故障'),5,cnt,0 )) AS C_cnt ,
       SUM(DECODE(instr(rea,'军事'),7,cnt,0 )) AS D_cnt ,
       SUM(DECODE(instr(rea,'天气'),7,cnt,0 )) AS E_cnt ,
       SUM(DECODE(instr(rea,'机场关闭'),5,cnt,0 )) AS F_cnt ,
       SUM(DECODE(instr(rea,'航行管制'),5,cnt,0 )) AS G_cnt ,
       SUM(DECODE(instr(rea,'旅客'),5,cnt,0 )) AS H_cnt ,
       SUM(NVL(cnt,0 )) -(SUM(DECODE(instr(rea,'流量控制'),5,cnt,0 )) + SUM(DECODE(instr(rea,'公司计划'),5,cnt,0 )) + SUM(DECODE(instr(rea,'机械故障'),5,cnt,0 )) +SUM(DECODE(instr(rea,'军事'),7,cnt,0 )) +SUM(DECODE(instr(rea,'天气'),7,cnt,0 ))+ SUM(DECODE(instr(rea,'机场关闭'),5,cnt,0 )) + SUM(DECODE(instr(rea,'航行管制'),5,cnt,0 )) +SUM(DECODE(instr(rea,'旅客'),5,cnt,0 ))) AS EL_cnt ,
       'cancel' as reportType
from(
select count(*) as cnt,pa.PA_DELAYREASONS as rea from pl_arrival pa, pl_turn pt 
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) 
and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
and pa.PA_DELAYREASONS like '%取消%' 
group by pa.PA_DELAYREASONS
union
select count(*)as cnt ,pd.PD_DELAYREASONS as rea from pl_departure pd, pl_turn pt 
where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
and pd.PD_DELAYREASONS like '%取消%'
group by pd.PD_DELAYREASONS));


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

select A.airline as airline,
    SUM(NVL(cnt,0))                                AS AllCount,
    SUM(DECODE(A.cntType,'sch',cnt,0 )) AS SCH,
    SUM(DECODE(A.cntType,'act',cnt,0 )) AS ACT,
    SUM(DECODE(A.cntType,'ret',cnt,0 )) AS RET,
    SUM(DECODE(A.cntType,'cnl',cnt,0 )) AS CNL,
    SUM(DECODE(A.cntType,'cnlb',cnt,0 )) AS CNLB,
    SUM(DECODE(A.cntType,'divin',cnt,0 )) AS DIVIN,
    SUM(DECODE(A.cntType,'divout',cnt,0 )) AS DIVOUT
from(
    select sum(NVL(B.cnt,0)) as cnt, B.cntType as cntType, DECODE(B.airline,'CZ','南航','HU','海航','外航') as airline from (
          select count(*) as cnt , 'sch' as cntType, DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          group by 'sch',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'sch' as cntType, DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) as airline from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          group by 'sch',DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'act' as cntType,  DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_aldt - 5/24,'yyyymmdd')='20170911'
          group by 'act',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'act' as cntType, DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) as airline from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_atot - 5/24,'yyyymmdd')='20170911'
          group by 'act',DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline)  
          UNION ALL  
          select count(*) as cnt , 'ret' as cntType, DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rstc_servicetypecode = 'F/H'
          group by 'ret',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'ret' as cntType, DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) as airline from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rstc_servicetypecode = 'F/H'
          group by 'ret',DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'cnl' as cntType, DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rrmk_remark = 'CNCL'
          group by 'cnl',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'cnl' as cntType, DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) as airline from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rrmk_remark = 'CNCL'
          group by 'cnl',DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) 
          UNION ALL 
          select count(*) as cnt, 'cnlb' as cntType, DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) as airline from pl_departure pd, pl_turn pt 
          where pt.pt_pd_departure = pd.PD_IDSEQ(+) 
          and to_char(pd.pd_srtd - 5/24,'yyyymmdd')='20170911'
          and pd.pd_rrmk_remark = 'CNAL'
          group by 'cnlb',DECODE(pd.pd_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pd.pd_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'divin' as cntType, DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and (pa.pa_rstc_servicetypecode = 'C/B' or pa.pa_rap_diversionairport='HAK')
          group by 'divin',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) 
          UNION ALL 
          select count(*) as cnt , 'divout' as cntType, DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline) as airline from pl_arrival pa, pl_turn pt
          where pt.pt_pa_arrival = pa.PA_IDSEQ(+)
          and to_char(pa.pa_srta - 5/24,'yyyymmdd')='20170911'
          and pa.pa_rap_diversionairport is not null
          and pa.pa_rap_diversionairport !='HAK'
          group by 'divout',DECODE(pa.pa_ral_airline,'GS','HU','JD','HU','GX','HU','8L','HU','9H','HU','PN','HU','FU','HU','HX','HU','UQ','HU',pa.pa_ral_airline)
      )B group by B.cntType,DECODE(B.airline,'CZ','南航','HU','海航','外航') 
)A group by A.airline;
----------------------------
select count(*), pa.PA_RAL_AIRLINE from pl_arrival pa, pl_turn pt , pl_departure pd
where pt.pt_pa_arrival = pa.PA_IDSEQ(+) and pt.pt_pd_departure= pd.PD_IDSEQ(+)
and to_char(pa.pa_srta - 5/24,'yyyy-mm-dd')='2017-09-11'
and (pd.pd_idseq is null or (pd.pd_idseq is not null and TRUNC(pd.PD_SRTD-5/24) != TRUNC(pa.PA_SRTA-5/24)))
group by pa.PA_RAL_AIRLINE;

