select query.*, to_date(substr(?, 1, 8), 'yyyymmdd') as query_date
from ((select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment,pa.pa_rha_agentbag as arr_agent,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent,to_char(pd.PD_EOBTATC, 'hh24:mi') as cobt,
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
where to_char(pa.pa_srta - 5/24, 'yyyymmdd') = substr(?, 1, 8)
and to_char(pd.pd_srtd - 5/24, 'yyyymmdd') = substr(?, 1, 8)
and pd.pd_rmsc_scenario = 1
and pa.pa_rmsc_scenario = 1)
union (select '' as arr_date, '' as pa_idseq, '' as pa_flightnumber, '' as arr_servicetype,
       '' as arr_status, '' as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       '' as orig_airport, '' as stotout, '' as srta,
       '' as eldt, '' as aldt, '' as prev_airport,
       '' as arr_comment, '' as arr_agent,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent,to_char(pd.PD_EOBTATC, 'hh24:mi') as cobt,
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
where ((to_char(pa.pa_srta - 5/24, 'yyyymmdd') <> substr(?, 1, 8)) or (pa.pa_srta is null))
and to_char(pd.pd_srtd - 5/24, 'yyyymmdd') = substr(?, 1, 8)
and pd.pd_rmsc_scenario = 1)
union (select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pa.pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment, pa.pa_rha_agentbag as arr_agent,
       '' as dep_date, '' as pd_idseq, '' as pd_flightnumber, '' as dep_servicetype,
       '' as dep_status, '' as pd_delayreasons, '' as srtd, '' as etot,
       '' as asbt, '' as dest_airport, '' as atot,
       '' as next_airport, '' as dep_comment, '' as dep_agent,'' as cobt,'' as dep_gate
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
where (to_char(pa.pa_srta - 5/24, 'yyyymmdd') = substr(?, 1, 8))
and ((to_char(pd.pd_srtd - 5/24, 'yyyymmdd') <> substr(?, 1, 8)) or (pd.pd_srtd is null))
and pa.pa_rmsc_scenario = 1)
) query
order by atot, srtd, aldt, srta;

-----------------------------

select query.*, to_date(substr('20170516', 1, 8), 'yyyymmdd') as query_date
from ((select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment,pa.pa_rha_agentbag as arr_agent,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent,to_char(pd.PD_EOBTATC, 'hh24:mi') as cobt,
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
where to_char(pa.pa_srta - 5/24, 'yyyymmdd') = substr('20170516', 1, 8)
and to_char(pd.pd_srtd - 5/24, 'yyyymmdd') = substr('20170516', 1, 8)
and pd.pd_rmsc_scenario = 1
and pa.pa_rmsc_scenario = 1)
union (select '' as arr_date, '' as pa_idseq, '' as pa_flightnumber, '' as arr_servicetype,
       '' as arr_status, '' as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       '' as orig_airport, '' as stotout, '' as srta,
       '' as eldt, '' as aldt, '' as prev_airport,
       '' as arr_comment, '' as arr_agent,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent,to_char(pd.PD_EOBTATC, 'hh24:mi') as cobt,
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
where ((to_char(pa.pa_srta - 5/24, 'yyyymmdd') <> substr('20170516', 1, 8)) or (pa.pa_srta is null))
and to_char(pd.pd_srtd - 5/24, 'yyyymmdd') = substr('20170516', 1, 8)
and pd.pd_rmsc_scenario = 1)
union (select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pa.pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment, pa.pa_rha_agentbag as arr_agent,
       '' as dep_date, '' as pd_idseq, '' as pd_flightnumber, '' as dep_servicetype,
       '' as dep_status, '' as pd_delayreasons, '' as srtd, '' as etot,
       '' as asbt, '' as dest_airport, '' as atot,
       '' as next_airport, '' as dep_comment, '' as dep_agent,'' as cobt,'' as dep_gate
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
where (to_char(pa.pa_srta - 5/24, 'yyyymmdd') = substr('20170516', 1, 8))
and ((to_char(pd.pd_srtd - 5/24, 'yyyymmdd') <> substr('20170516', 1, 8)) or (pd.pd_srtd is null))
and pa.pa_rmsc_scenario = 1)
) query
order by atot, srtd, aldt, srta;
---------------minus
-----------------------------------------------
select distinct to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') as arr_date, to_char(pa.pa_idseq) as pa_idseq, pa.pa_flightnumber, rstca.rstc_description as arr_servicetype,
       rfsa.rfst_code3l as arr_status, replace(replace(pa.pa_delayreasons,'[',''),']','') as pa_delayreasons, pa.pa_ract_aircrafttype, pa.pa_registration, pd.pd_rsta_stand as pa_rsta_stand,
       rap_origin.rap_name3 as orig_airport, to_char(pa.pa_stotoutstation, 'hh24:mi') as stotout, to_char(pa.pa_srta, 'hh24:mi') as srta,
       to_char(pa.pa_eldt, 'hh24:mi') as eldt, to_char(pa.pa_aldt, 'hh24:mi') as aldt, rap_prev.rap_name3 as prev_airport,
       '' as arr_comment,pa.pa_rha_agentbag as arr_agent,
       to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') as dep_date, to_char(pd.pd_idseq) as pd_idseq, pd.pd_flightnumber, rstcd.rstc_description as dep_servicetype,
       rfsd.rfst_code3l as dep_status, replace(replace(pd.pd_delayreasons,'[',''),']','') as pd_delayreasons, to_char(pd.pd_srtd, 'hh24:mi') as srtd, to_char(pd.pd_etot, 'hh24:mi') as etot,
       to_char(pd.pd_asbt, 'hh24:mi') as asbt, rap_dest.rap_name3 as dest_airport, to_char(pd.pd_atot, 'hh24:mi') as atot,
       rap_next.rap_name3 as next_airport, '' as dep_comment, pd.pd_rha_agentci as dep_agent,to_char(pd.PD_EOBTATC, 'hh24:mi') as cobt,
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
where (to_char(pa.pa_srta - 5/24, 'yyyy-mm-dd') between  TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  and TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  or to_char(pd.pd_srtd - 5/24, 'yyyy-mm-dd') between TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  and TO_CHAR(TO_DATE(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')  )
and pt.pt_rmsc_scenario = 1
order by atot, srtd, aldt, srta;