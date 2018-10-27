
select * from (
select pa_idseq, 
pa_ral_airline as airline_a,
pa.pa_flightnumber,
pa.pa_srta,decode(to_char(pa.pa_srta - 5/24, 'yyyymmdd'),to_char(pd.pd_srtd - 5/24, 'yyyymmdd'),'G','BA') as aindicator,
pa_rsta_stand as arrivalstand ,
s1.standCategory1 as astandtype,
pd_idseq,
pd_ral_airline as airline_d,
pd.pd_flightnumber,
pd.pd_srtd,
pd_rsta_stand as departurestand,
s2.standCategory2 as dstandtype,
decode(to_char(pa.pa_srta - 5/24, 'yyyymmdd'),to_char(pd.pd_srtd - 5/24, 'yyyymmdd'),'G','BA') as dindicator,
substr('20181026', 1, 8) as startDate,
substr('20181026', 1, 8) as endDate
from pl_turn pt
left join pl_arrival pa on pt.pt_pa_arrival = pa.pa_idseq
left join pl_departure pd on pt.pt_pd_departure = pd.pd_idseq
left join (SELECT 
     ref_stand.RSTA_CODE             AS standcode1 ,
      ref_standversion.RSV_CATEGORY AS standCategory1
    FROM ref_stand ,ref_standversion 
where ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND(+)
and ref_stand.RSTA_RMSC_SCENARIO =1) s1 on pa.pa_rsta_stand = s1.standcode1
left join (SELECT 
     ref_stand.RSTA_CODE             AS standcode2 ,
      ref_standversion.RSV_CATEGORY AS standCategory2
    FROM ref_stand ,ref_standversion 
where ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND(+)
and ref_stand.RSTA_RMSC_SCENARIO =1) s2 on pd.pd_rsta_stand = s2.standcode2
where (to_char(pa.pa_srta,'yyyymmdd') between substr('20181026', 1, 8) and substr('20181026', 1, 8) or  to_char(pd.pd_srtd,'yyyymmdd')  between substr('20181026', 1, 8) and substr('20181026', 1, 8))
and NVL(pa.PA_RFST_FLIGHTSTATUS , pd.Pd_RFST_FLIGHTSTATUS) <>'X'
and pt.pt_rmsc_scenario = 1)
where NVL(astandtype,dstandtype) in ('C')
and NVL(aindicator,dindicator) in ('G','BA')
 order by pa_flightnumber,pd_flightnumber,pa_srta,pd_srtd;

--select * from pl_stand;

SELECT 
     ref_stand.RSTA_CODE             AS standcode ,
      ref_standversion.RSV_CATEGORY AS standCategory
    FROM ref_stand,ref_standversion
where ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND(+)
and ref_stand.RSTA_RMSC_SCENARIO =1;

