SELECT * FROM(
SELECT ss.standCode,
  ss.standCategory,
  cnt,
  st.ststandCode as stand,
  st.standCategory as category，
  ratio_to_report(cnt) over() as rate
FROM
  (SELECT standCode,
    standCategory,
    COUNT(*) AS cnt
  FROM
      (SELECT pd.pd_idseq,
        pd.pd_flightNUmber,
        pd.Pd_RSTA_STAND              AS standCode ,
        ref_standversion.RSV_CATEGORY AS standCategory
      FROM pl_departure pd
      LEFT JOIN ref_stand
      ON (pd.Pd_RSTA_STAND = ref_stand.RSTA_CODE)
      LEFT JOIN ref_standversion
      ON (ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND)
      WHERE pd.pd_atot         IS NOT NULL
      AND (pd.pd_atot BETWEEN TO_DATE('2017-03-06 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND  TO_DATE('2017-03-06 00:00:00', 'yyyy-mm-dd hh24:mi:ss'))
      )
  GROUP BY standCode,standCategory
  ORDER BY standCode
  ) ss
RIGHT JOIN
  (SELECT ref_stand.RSTA_CODE     AS ststandCode,
    ref_standversion.RSV_CATEGORY AS standCategory
  FROM ref_stand
  LEFT JOIN ref_standversion ON ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND
  ) st ON st.ststandCode  = ss.standCode order by category,stand
  ) where category = 'C'
  
  ------------new
    select st.ststandCode,st.standCategory,NVL(cnttmp,0) as cnt ,allcnt.allcnt from (
  SELECT ref_stand.RSTA_CODE     AS ststandCode,
    ref_standversion.RSV_CATEGORY AS standCategory,
    'ALLCNTROW' as allrow
  FROM ref_stand
  LEFT JOIN ref_standversion ON ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND
  where RSV_CATEGORY='C' )st
  left join
  (SELECT pd.Pd_RSTA_STAND as standCode,
         COUNT(*) AS cnttmp
  from pl_departure pd
   WHERE pd.pd_atot         IS NOT NULL
   AND pd.pd_atot BETWEEN TO_DATE('2017-03-06 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND  TO_DATE('2017-03-07 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
   GROUP BY pd.Pd_RSTA_STAND) ss on st.ststandCode = ss.standCode 
   left join
   (select 'ALLCNTROW' as allrow ,count(*) as allcnt from PL_DEPARTURE
    left join REF_AIRCRAFTTYPE ON PL_DEPARTURE.PD_RACT_AIRCRAFTTYPE = REF_AIRCRAFTTYPE.RACT_INTERNALCODE
    where PL_DEPARTURE.pd_atot BETWEEN TO_DATE('2017-03-06 00:00:00', 'yyyy-mm-dd hh24:mi:ss') AND  TO_DATE('2017-03-07 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
    and PL_DEPARTURE.PD_RSTC_SERVICETYPECODE !='H/Z'
    and PL_DEPARTURE.PD_RSTC_SERVICETYPECODE !='U/Z'
    and REF_AIRCRAFTTYPE.RACT_SIZECATEGORY IN ('C','D','E','F')
    and PL_DEPARTURE.PD_RACT_AIRCRAFTTYPE !='190'
    and PL_DEPARTURE.PD_RACT_AIRCRAFTTYPE !='E90'
    and PL_DEPARTURE.PD_ATOT is not null
    and PL_DEPARTURE.PD_PD_MAINFLIGHT is null
    GROUP by 'ALLCNTROW') allcnt on st.allrow=allcnt.allrow;
  