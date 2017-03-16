SELECT DD.*,
  allCount,
  (allCount-DD.delayCount) AS normalCount
FROM
  (SELECT TO_CHAR(PL_DEPARTURE.pd_SRTD- 5/24,'yyyy-mm-dd') AS takeoffDate2,
    COUNT(1)                                         AS allCount
  FROM PL_DEPARTURE , pl_turn, pl_arrival
  WHERE pt_pd_departure=pd_idseq(+)
  and pt_pa_arrival=pa_idseq(+)
  AND (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
  AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
  GROUP BY TO_CHAR(PL_DEPARTURE.pd_SRTD- 5/24,'yyyy-mm-dd')


  )allCountView
LEFT JOIN
  ( SELECT D.takeOffDate AS takeOffDate1,
    SUM(NVL(SUM_FLIGHT,0))                                AS delayCount,
    SUM(DECODE(D.delayBigCode,'01',SUM_FLIGHT,0 )) AS Delay_code_01,
    SUM(DECODE(D.delayBigCode,'02',SUM_FLIGHT,0 )) AS Delay_code_02,
    SUM(DECODE(D.delayBigCode,'03',SUM_FLIGHT,0 )) AS Delay_code_03,
    SUM(DECODE(D.delayBigCode,'04',SUM_FLIGHT,0 )) AS Delay_code_04,
    SUM(DECODE(D.delayBigCode,'05',SUM_FLIGHT,0 )) AS Delay_code_05,
    SUM(DECODE(D.delayBigCode,'06',SUM_FLIGHT,0 )) AS Delay_code_06,
    SUM(DECODE(D.delayBigCode,'07',SUM_FLIGHT,0 )) AS Delay_code_07,
    SUM(DECODE(D.delayBigCode,'08',SUM_FLIGHT,0 )) AS Delay_code_08,
    SUM(DECODE(D.delayBigCode,'09',SUM_FLIGHT,0 )) AS Delay_code_09,
    SUM(DECODE(D.delayBigCode,'10',SUM_FLIGHT,0 )) AS Delay_code_10,
    SUM(DECODE(D.delayBigCode,'11',SUM_FLIGHT,0 )) AS Delay_code_11,
    SUM(DECODE(D.delayBigCode,'12',SUM_FLIGHT,0 )) AS Delay_code_12,
    SUM(DECODE(D.delayBigCode,NULL,SUM_FLIGHT,0 )) AS Delay_code_null
  FROM
    (SELECT takeOffDate,
      delayBigCode,
      COUNT(1) AS SUM_FLIGHT
    FROM
      ( select departure.pd_idseq,
        departure.pd_flightnumber,
        departure.pd_srtd,
        departure.delayTime,
        departure.pd_aobt,
        departure.pd_atot,
        departure.takeOffDate,
        departure.pd_rstc_servicetypecode,
        delayBigCode from (
      SELECT pd_idseq,
        pd_flightnumber,
        pd_srtd,
        ceil((PD_AOBT-PD_SRTD)*24*60) AS delayTime,
        pd_aobt,
        pd_atot,
        TO_CHAR(pd_SRTD- 5/24,'yyyy-mm-dd') AS takeOffDate,
        pd_rstc_servicetypecode
      FROM PL_DEPARTURE , pl_turn, pl_arrival
       WHERE pt_pd_departure=pd_idseq(+)
       and pt_pa_arrival=pa_idseq(+)
        and (TO_CHAR(pl_departure.pd_SRTD- 5/24 ,'yyyy-mm-dd') BETWEEN  to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd') AND to_char(to_date(?,'yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd'))
        AND PL_DEPARTURE.pd_rstc_servicetypecode    IN ('W/Z','C/B','L/W')
        AND PL_DEPARTURE.pd_atot is not null
        AND pl_arrival.pa_aldt is not null
        AND (
               (TRUNC(PD_SRTD-6/24) = TRUNC(PA_SRTA-6/24) AND  pd_atot > pd_srtd +25/1440 AND pd_atot>pa_aldt+(pd_srtd-pa_srta) +35/1440)
            OR (TRUNC(PD_SRTD-6/24) != TRUNC(PA_SRTA-6/24)  AND pd_atot>pd_srtd+25/1440)
        )
      )departure
      LEFT JOIN
        (select pd_idseq,
        delayCode,
        Decode(SUBSTR(rdlr_description,0,2),null,'06','对外','06',SUBSTR(rdlr_description,0,2)) as delayBigCode
        from (
        select pd_idseq
        from PL_DEPARTURE ) pp
        left join (
                     select pd_idseq          AS delay_idseq,
                      max(pdlr_rdlr_delayreason) AS delayCode
                      FROM
                        pl_delayreason,
                        PL_DEPARTURE
                      WHERE      PL_DEPARTURE.pd_idseq                  = PL_DELAYREASON.pdlr_pd_departure
                      group by pd_idseq
                      )dd on pp.pd_idseq = dd.delay_idseq
                      left join ref_delayreason on dd.delayCode = ref_delayreason.rdlr_codenumeric
        ) delayView
      ON departure.pd_idseq                                               = delayView.pd_idseq
      )
    GROUP BY takeOffDate,
      delayBigCode
    )D
  GROUP BY D.takeOffDate
  ORDER BY D.takeOffDate
  ) DD
ON takeOffDate1 = takeoffDate2
ORDER BY takeoffDate2