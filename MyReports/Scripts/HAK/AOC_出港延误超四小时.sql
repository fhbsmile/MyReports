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
and ceil((departure.PD_ATOT-departure.PD_SRTD)*24*60) >=240