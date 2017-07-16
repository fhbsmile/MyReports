 update REF_AIRPORT set RAP_RCTR_COUNTRY ='CN' where RAP_INTERNALCODE='BFJ';
 update REF_AIRPORT set RAP_RCTR_COUNTRY ='CN' where RAP_INTERNALCODE='BPE';
  update REF_AIRPORT set RAP_RCTR_COUNTRY ='CN' where RAP_INTERNALCODE='YIC';
 update REF_AIRPORT set RAP_RCTR_COUNTRY ='JP' where RAP_INTERNALCODE='OKA';
 update REF_AIRPORT set RAP_RCTR_COUNTRY ='JP' where RAP_INTERNALCODE='CTS';
 select RAP_INTERNALCODE from ref_airport where RAP_RCTR_COUNTRY is null;
 update REF_AIRPORT set RAP_RCTR_COUNTRY ='00' where RAP_INTERNALCODE in (select RAP_INTERNALCODE from ref_airport where RAP_RCTR_COUNTRY is null);
  
  SELECT * FROM (SELECT SyAlarm.SALM_IDSEQ, 
       SyAlarm.SALM_SALT_TYPE, 
       SyAlarm.SALM_REFID, 
       SyAlarm.SALM_REFTABLE, 
       SyAlarm.SALM_CONTENT, 
       SyAlarm.SALM_SYP_PROTOCOL, 
       SyAlarm.SALM_ADDINFO, 
       SyAlarm.SALM_OCCURED, 
       SyAlarm.SALM_ACKNOWLEDGED, 
       SyAlarm.SALM_RESOLVED, 
       SyAlarm.SALM_TRIGGEREDALERTS, 
       SyAlarm.SALM_MARK, 
       SyAlarm.SALM_CREATETIME, 
       SyAlarm.SALM_MODTIME, 
       SyAlarm.SALM_MODUSER, 
       SyAlarmtype.SALT_CODE, 
       SyAlarmtype.SALT_CATEGORY, 
       SyAlarmtype.SALT_SEVERITY, 
       SyAlarmtype.SALT_AREA, 
       SyAlarmtype.SALT_DESCRIPTION, 
       SyAlarmtype.SALT_RESOLVEDONALERTIND, 
       SyAlarmtype.SALT_QUERY, 
       SyAlarmtype.SALT_CONTENTTEMPLATE, 
       SyAlarmtype.SALT_ADDINFOTEMPLATE, 
       SyAlarmtype.SALT_REFIDCOLUMN, 
       SyAlarmtype.SALT_BATCHIND, 
       SyAlarmtype.SALT_CREATETIME, 
       SyAlarmtype.SALT_MODTIME, 
       SyAlarmtype.SALT_MODUSER, 
       SyProtocol.SYP_IDSEQ, 
       SyProtocol.SYP_TYP, 
       SyProtocol.SYP_INFO, 
       SyProtocol.SYP_CONTENT, 
       SyProtocol.SYP_CREATETIME, 
       SyProtocol.SYP_MODUSER, 
       SyProtocol.SYP_MODTIME, 
       SyAlarm.SALM_SUBJECT, 
       SyAlarm.SALM_HEADER
FROM SY_ALARM SyAlarm
LEFT OUTER JOIN SY_ALARMTYPE SyAlarmtype on (SyAlarm.SALM_SALT_TYPE = SyAlarmtype.SALT_CODE)
LEFT OUTER JOIN SY_PROTOCOL SyProtocol ON (SyAlarm.SALM_SYP_PROTOCOL = SyProtocol.SYP_IDSEQ)) 
QRSLT  WHERE (SALM_SALT_TYPE = ? AND SALM_REFID = ? AND SALM_REFTABLE = ? AND SALM_RESOLVED IS NULL) ORDER BY SALM_OCCURED DESC, SALM_SALT_TYPE, SALM_IDSEQ DESC; Params:  P0=(OPS02) P1=(39734) P2=(REF_AIRCRAFT)