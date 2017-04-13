select takeOffDate,
          allcnt,
         NVL(delcntt,0) as delcnt,
         allcnt-NVL(delcntt,0) as okcnt,
         (allcnt-NVL(delcntt,0))/allcnt as rate
      from(
        SELECT
        TO_CHAR(pd.pd_srtd- 5/24,'yyyy-mm-dd') AS takeOffDate,
        count(1) as allcnt
        FROM  pl_turn pt
        LEFT JOIN pl_departure pd ON pt.pt_pd_departure = pd.pd_idseq
        WHERE
        TO_CHAR(pd.pd_srtd- 5/24 ,'yyyy-mm-dd')=  to_char(to_date('2017-03-24 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
        AND pd.PD_RSTC_SERVICETYPECODE    IN ('W/Z','C/B','L/W')
         AND pd.PD_RFST_FLIGHTSTATUS !='X'
        group by  TO_CHAR(pd.pd_srtd- 5/24,'yyyy-mm-dd')     
       ) allView left join    
        (
        SELECT
        TO_CHAR(pd.pd_srtd- 5/24,'yyyy-mm-dd') AS takeOffDate2,
        count(1) as delcntt
        FROM  pl_turn pt
        LEFT JOIN pl_departure pd ON pt.pt_pd_departure = pd.pd_idseq
        WHERE
        TO_CHAR(pd.pd_srtd- 5/24 ,'yyyy-mm-dd') =  to_char(to_date('2017-03-24 00:00:00','yyyy-mm-dd hh24:mi:ss'),'yyyy-mm-dd')
        AND pd.PD_RSTC_SERVICETYPECODE    IN ('W/Z','C/B','L/W')
        AND pd.PD_RFST_FLIGHTSTATUS !='X'
        AND pd.pd_atot is null
        AND pd_rrmk_remark in ('DELNT','DELET')
        group by  TO_CHAR(pd.pd_srtd- 5/24,'yyyy-mm-dd') ) delView on allView.takeOffDate = delView.takeOffDate2;