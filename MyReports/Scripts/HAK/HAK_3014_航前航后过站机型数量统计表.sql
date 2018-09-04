select query.*, to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd') as start_date, to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd') as end_date
from ((select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment,pa.pa_rha_agentbag as arr_agent, to_char(pa.pa_srta,'yyyymmddhh24miss') as pa_srta, to_char(pa.pa_aldt,'yyyymmddhh24miss') as pa_aldt,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent, to_char(pd.pd_srtd,'yyyymmddhh24miss') as pd_srtd, to_char(pd.pd_atot, 'yyyymmddhh24miss') as pd_atot,
       (select to_char(wmsys.wm_concat(pdg.pdg_rgt_gate))
        from pl_departuregate pdg
        where pdg.pdg_pd_departure = pd.pd_idseq
        and pdg.pdg_rmsc_scenario = 1
        group by pdg.pdg_pd_departure) as dep_gate
from pl_turn pt
left join pl_arrival pa on pa.pa_idseq = pt.pt_pa_arrival
left join pl_departure pd on pd.pd_idseq = pt.pt_pd_departure
left join ref_servicetypecode rstca on rstca.rstc_code = pa.pa_rstc_servicetypecode
left join ref_servicetypecode rstcd on rstcd.rstc_code = pd.pd_rstc_servicetypecode
left join ref_flightstatus rfsa on rfsa.rfst_code = pa.pa_rfst_flightstatus
left join ref_flightstatus rfsd on rfsd.rfst_code = pd.pd_rfst_flightstatus
left join ref_airport rap_origin on rap_origin.rap_internalcode = pa.pa_rap_originairport
left join ref_airport rap_prev on rap_prev.rap_internalcode = pa.pa_rap_previousairport
left join ref_airport rap_dest on rap_dest.rap_internalcode = pd.pd_rap_destinationairport
left join ref_airport rap_next on rap_next.rap_internalcode = pd.pd_rap_nextairport
where to_char(pa.pa_srta - 5/24, 'yyyymmdd') = to_char(pd.pd_srtd - 5/24, 'yyyymmdd')
and pd.pd_rmsc_scenario = 1
and pa.pa_rmsc_scenario = 1
and (pd.pd_rrmk_remark <> 'CNCL' or pd.pd_rrmk_remark is null)
and (pa.pa_rrmk_remark <> 'CNCL' or pa.pa_rrmk_remark is null))
union (select '' as arr_date, '' as pa_idseq, '' as pa_flightnumber, '' as arr_servicetype,
       '' as arr_status, '' as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       '' as orig_airport, '' as stotout, '' as srta,
       '' as eldt, '' as aldt, '' as prev_airport,
       '' as arr_comment, '' as arr_agent, '' as pa_srta, '' as pa_aldt,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent, to_char(pd.pd_srtd,'yyyymmddhh24miss') as pd_srtd, to_char(pd.pd_atot, 'yyyymmddhh24miss') as pd_atot,
       (select to_char(wmsys.wm_concat(pdg.pdg_rgt_gate))
        from pl_departuregate pdg
        where pdg.pdg_pd_departure = pd.pd_idseq
        and pdg.pdg_rmsc_scenario = 1
        group by pdg.pdg_pd_departure) as dep_gate
from pl_turn pt
left join pl_arrival pa on pa.pa_idseq = pt.pt_pa_arrival
left join pl_departure pd on pd.pd_idseq = pt.pt_pd_departure
left join ref_servicetypecode rstca on rstca.rstc_code = pa.pa_rstc_servicetypecode
left join ref_servicetypecode rstcd on rstcd.rstc_code = pd.pd_rstc_servicetypecode
left join ref_flightstatus rfsa on rfsa.rfst_code = pa.pa_rfst_flightstatus
left join ref_flightstatus rfsd on rfsd.rfst_code = pd.pd_rfst_flightstatus
left join ref_airport rap_origin on rap_origin.rap_internalcode = pa.pa_rap_originairport
left join ref_airport rap_prev on rap_prev.rap_internalcode = pa.pa_rap_previousairport
left join ref_airport rap_dest on rap_dest.rap_internalcode = pd.pd_rap_destinationairport
left join ref_airport rap_next on rap_next.rap_internalcode = pd.pd_rap_nextairport
where ((to_char(pa.pa_srta - 5/24, 'yyyymmdd') <> to_char(pd.pd_srtd - 5/24, 'yyyymmdd')) or (pa.pa_srta is null))
and pd.pd_rmsc_scenario = 1
and (pd.pd_rrmk_remark <> 'CNCL' or pd.pd_rrmk_remark is null))
union (select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pa.pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment, pa.pa_rha_agentbag as arr_agent, to_char(pa.pa_srta,'yyyymmddhh24miss') as pa_srta, to_char(pa.pa_aldt,'yyyymmddhh24miss') as pa_aldt,
       '' as dep_date, '' as pd_idseq, '' as pd_flightnumber, '' as dep_servicetype,
       '' as dep_status, '' as pd_delayreasons, '' as srtd, '' as etot,
       '' as asbt, '' as dest_airport, '' as atot,
       '' as next_airport, '' as dep_comment, '' as dep_agent, '' as pd_srtd, '' as pd_atot,'' as dep_gate
from pl_turn pt
left join pl_arrival pa on pa.pa_idseq = pt.pt_pa_arrival
left join pl_departure pd on pd.pd_idseq = pt.pt_pd_departure
left join ref_servicetypecode rstca on rstca.rstc_code = pa.pa_rstc_servicetypecode
left join ref_servicetypecode rstcd on rstcd.rstc_code = pd.pd_rstc_servicetypecode
left join ref_flightstatus rfsa on rfsa.rfst_code = pa.pa_rfst_flightstatus
left join ref_flightstatus rfsd on rfsd.rfst_code = pd.pd_rfst_flightstatus
left join ref_airport rap_origin on rap_origin.rap_internalcode = pa.pa_rap_originairport
left join ref_airport rap_prev on rap_prev.rap_internalcode = pa.pa_rap_previousairport
left join ref_airport rap_dest on rap_dest.rap_internalcode = pd.pd_rap_destinationairport
left join ref_airport rap_next on rap_next.rap_internalcode = pd.pd_rap_nextairport
where ((to_char(pd.pd_srtd - 5/24, 'yyyymmdd') <> to_char(pa.pa_srta - 5/24, 'yyyymmdd')) or (pd.pd_srtd is null))
and pa.pa_rmsc_scenario = 1
and (pa.pa_rrmk_remark <> 'CNCL' or pa.pa_rrmk_remark is null))
) query
where ((arr_date between to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd') and to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd')) or arr_date is null)
and ((dep_date between to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd') and to_char(to_date(substr(?, 1, 8), 'yyyymmdd'), 'yyyy-mm-dd')) or dep_date is null)
order by decode(pd_atot,null,pa_aldt,pd_atot), decode(pd_srtd,null,pa_srta,pd_srtd), pa_aldt, pa_srta;

----------------------------------------------------------(RY,OQ,MF,CZ,9C,KY,TV)
select airline,indicator,aircrafttype,Count(*) as cnt,'2018-08-02' as startDate,'D' as endDate from 
(
select pa_idseq, pa_ral_airline as airline,'A' as indicator,ra.RACT_ICAOTYPE as aircrafttype,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd,REF_AIRCRAFTTYPE ra
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and pa.PA_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and pd.PD_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and (to_char(pa.pa_sibt,'yyyymmdd') between ('20180801') and ('20180924') or  to_char(pd.pd_sobt,'yyyymmdd')  between ('20180801') and ('20180924'))
--and (to_char(pa.pa_sibt,'yyyymm')='201808' or  to_char(pd.pd_sobt,'yyyymm')='201808')
and ((to_char(pa.pa_sibt - 5/24, 'yyyymmdd') <> to_char(pd.pd_sobt - 5/24, 'yyyymmdd')) or pd.pd_sobt is null)
and pa.PA_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1
union
select pa_idseq, pd_ral_airline as airline,'C' as indicator,ra.RACT_ICAOTYPE as aircrafttype,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd,REF_AIRCRAFTTYPE ra
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and pa.PA_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and pd.PD_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and (to_char(pa.pa_sibt,'yyyymmdd') between ('20180801') and ('20180924') or  to_char(pd.pd_sobt,'yyyymmdd')  between ('20180801') and ('20180924'))
--and (to_char(pa.pa_sibt,'yyyymm')='201808' or  to_char(pd.pd_sobt,'yyyymm')='201808')
and ((to_char(pa.pa_sibt - 5/24, 'yyyymmdd') <> to_char(pd.pd_sobt - 5/24, 'yyyymmdd')) or pa.pa_sibt is null)
and pd.Pd_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1
union
select pa_idseq, pd_ral_airline as airline,'B' as indicator,ra.RACT_ICAOTYPE as aircrafttype ,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd,REF_AIRCRAFTTYPE ra
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and pa.PA_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and pd.PD_RACT_AIRCRAFTTYPE = ra.RACT_INTERNALCODE(+)
and (to_char(pa.pa_sibt,'yyyymmdd') between ('20180801') and ('20180924') or  to_char(pd.pd_sobt,'yyyymmdd')  between '20180801' and '20180924')
--and (to_char(pa.pa_sibt,'yyyymm')='201808' or  to_char(pd.pd_sobt,'yyyymm')='201808')
and ((to_char(pa.pa_sibt - 5/24, 'yyyymmdd') = to_char(pd.pd_sobt - 5/24, 'yyyymmdd')))
and pd.Pd_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1
) query where airline not in ('GA','OQ','MF','CZ','9C','KY','TV') group by airline,indicator,aircrafttype order by airline,indicator,aircrafttype;

---------------------------------------------
select *, decode(to_char(pd.pd_srtd - 5/24, 'yyyymmdd'),to_char(pa.pa_srta - 5/24, 'yyyymmdd'),'Y','N') as indcator 
from pl_turn pt,pl_arrival pa,pl_departure pd
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt_pt_pd_departure = pd.pd_idseq(+)
and (to_char(pa.srta,'yyyymm')='201806' or  to_char(pd.srtd,'yyyymm')='201806')
and pa.PA_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1;

select decode(to_char(sysdate, 'yyyymmdd'),null,'前','后') as res from dual;


select airline,indicator,aircrafttype,Count(*) as cnt, substr(?, 1, 8) as startDate,substr(?, 1, 8) as endDate from 
(
select pa_idseq, pa_ral_airline as airline,'A' as indicator,pa_ract_aircrafttype as aircrafttype,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and (to_char(pa.pa_srta,'yyyymmdd') between substr(?, 1, 8) and substr(?, 1, 8) or  to_char(pd.pd_srtd,'yyyymmdd')  between substr(?, 1, 8) and substr(?, 1, 8))
and ((to_char(pa.pa_srta - 5/24, 'yyyymmdd') <> to_char(pd.pd_srtd - 5/24, 'yyyymmdd')) or pd.pd_srtd is null)
and pa.PA_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1 
union 
(select pa_idseq, pd_ral_airline as airline,'C' as indicator,pd_ract_aircrafttype as aircrafttype,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and (to_char(pa.pa_srta,'yyyymmdd') between substr(?, 1, 8) and substr(?, 1, 8) or  to_char(pd.pd_srtd,'yyyymmdd')  between substr(?, 1, 8) and substr(?, 1, 8))
and ((to_char(pa.pa_srta - 5/24, 'yyyymmdd') <> to_char(pd.pd_srtd - 5/24, 'yyyymmdd')) or pa.pa_srta is null)
and pd.Pd_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1) 
union 
(select pa_idseq, pd_ral_airline as airline,'B' as indicator,pa_ract_aircrafttype as aircrafttype ,pd_idseq
from pl_turn pt,pl_arrival pa,pl_departure pd
where pt.pt_pa_arrival = pa.pa_idseq(+)
and pt.pt_pd_departure = pd.pd_idseq(+)
and (to_char(pa.pa_srta,'yyyymmdd') between substr(?, 1, 8) and substr(?, 1, 8) or  to_char(pd.pd_srtd,'yyyymmdd')  between substr(?, 1, 8) and substr(?, 1, 8))
and to_char(pa.pa_srta - 5/24, 'yyyymmdd') = to_char(pd.pd_srtd - 5/24, 'yyyymmdd')
and pd.Pd_RFST_FLIGHTSTATUS <> 'X'
and pt.pt_rmsc_scenario = 1) 
) query where airline not in ('GA','OQ','MF','CZ','9C','KY','TV') group by airline,indicator,aircrafttype order by airline,indicator,aircrafttype;