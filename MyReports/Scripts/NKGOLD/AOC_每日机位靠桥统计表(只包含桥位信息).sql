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
    (SELECT pa.pa_idseq,
      pa.pa_flightNUmber,
      pa.PA_RSTA_STAND              AS standcode ,
      ref_standversion.RSV_CATEGORY AS standCategory
    FROM pl_arrival pa
    LEFT JOIN ref_stand
    ON (pa.PA_RSTA_STAND = ref_stand.RSTA_CODE)
    LEFT JOIN ref_standversion
    ON (ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND)
    WHERE pa.pa_aldt         IS NOT NULL
    AND (pa.pa_aldt BETWEEN TO_DATE(?, 'yyyy-mm-dd hh24:mi:ss') AND  TO_DATE(?, 'yyyy-mm-dd hh24:mi:ss'))
    UNION
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
      AND (pd.pd_atot BETWEEN TO_DATE(?, 'yyyy-mm-dd hh24:mi:ss') AND  TO_DATE(?, 'yyyy-mm-dd hh24:mi:ss'))
      )
    )
  GROUP BY standCode,
    standCategory
  ORDER BY standCode
  ) ss
RIGHT JOIN
  (SELECT ref_stand.RSTA_CODE     AS ststandCode,
    ref_standversion.RSV_CATEGORY AS standCategory
  FROM ref_stand
  LEFT JOIN ref_standversion
  ON ref_stand.RSTA_IDCODE = ref_standversion.RSV_RSTA_STAND
  ) st ON (st.ststandCode  = ss.standCode) order by category,stand
  ) where category = 'C'