select to_char(plarrival.pa_srta,'yyyy-mm-dd') as Adate,
plarrival.pa_flightnumber as Aflightnumber,
to_char(pldeparture.pd_srtd,'yyyy-mm-dd') as Ddate,
pldeparture.pd_flightnumber as Dflightnumber,
plturn.PT_ROUTING as routing,
plarrival.PA_RSTC_SERVICETYPECODE as Aservicetype,
pldeparture.PD_RSTC_SERVICETYPECODE as Dservicetype,
plarrival.PA_REGISTRATION as registration,
plarrival.PA_RACT_AIRCRAFTTYPE as AIRCRAFTTYPE,
 to_char(plarrival.pa_srta,'yyyy-mm-dd hh24mi') as srta,
  to_char(pldeparture.pd_srtd,'yyyy-mm-dd hh24mi') as srtd,
   to_char(plarrival.pa_aldt,'yyyy-mm-dd hh24mi') as aldt,
  to_char(pldeparture.pd_atot,'yyyy-mm-dd hh24mi') as atot,
  plarrival.PA_RSTA_STAND as Astand,
   pldeparture.PD_RSTA_STAND as Dstand,
   plarrival.PA_RFST_FLIGHTSTATUS as  Astatus,
   pldeparture.PD_RFST_FLIGHTSTATUS as Dstatus
from PL_TURN plturn, PL_ARRIVAL plarrival, PL_DEPARTURE pldeparture
where plturn.PT_PA_ARRIVAL = plarrival.PA_IDSEQ(+)
and plturn.PT_PD_DEPARTURE = pldeparture.PD_IDSEQ(+)
and (plarrival.pa_srta between  to_date('2017-06-01 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-06-30 00:00:00','yyyy-mm-dd hh24:mi:ss') 
or pldeparture.pd_srtd between  to_date('2017-06-01 00:00:00','yyyy-mm-dd hh24:mi:ss') AND to_date('2017-06-30 23:59:59','yyyy-mm-dd hh24:mi:ss'));