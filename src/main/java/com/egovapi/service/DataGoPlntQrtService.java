  package com.egovapi.service;

import com.egovapi.mapper.DataGoPlntQrtMapper;
import com.egovapi.util.CommonApiUtil;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataGoPlntQrtService {
   protected Log log = LogFactory.getLog(this.getClass());
   @Autowired
   DataGoPlntQrtMapper dataGoPlntQrtMapper;
   @Autowired
   CommonApiLogService commonApiLogService;

   public void dataType3ImpInsert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      String logStat = "1";
      String errorDetail = "";
      String jobId = (String)pRequestParamMap.get("jobId");
      String logSeq = (String)pRequestParamMap.get("logSeq");
      String idx = (String)pRequestParamMap.get("idx");
      Map<String, String> map = new HashMap();
      map.put("yyyymm", (String)pRequestParamMap.get("yyyymm"));
      int BF_dataCount = 0;
      int AF_dataCount = 0;
      if (idx != null && idx.equals("1")) {
         BF_dataCount = this.dataGoPlntQrtMapper.getDataCount_Imp(map);
         this.log.info("Delete 과정 - [수입현황] 삭제 되기 전 해당 월 데이터 건수: " + BF_dataCount);
         System.out.println("Delete 과정 - [수입현황] 삭제 되기 전 해당 월 데이터 건수: " + BF_dataCount);
         this.dataGoPlntQrtMapper.dataType3ImpBeforeDelete(map);
         AF_dataCount = this.dataGoPlntQrtMapper.getDataCount_Imp(map);
         this.log.info("[수입현황] 최종 삭제 후(Insert 전) 해당 월 데이터 건수: " + AF_dataCount);
         System.out.println("[수입현황] 최종 삭제 후(Insert 전) 해당 월 데이터 건수: " + AF_dataCount);
      }
      
      boolean flag = false;

      for(int i = 0; i < dataList.size(); ++i) {
         try {
            this.dataGoPlntQrtMapper.dataType3ImpInsert(dataList.get(i));
            
            if (dataList.size() != 999) {
                flag = true;
            }
            
         } catch (Exception var14) {
            if (var14.toString().indexOf("ORA-00001") < 0) {
               logStat = "2";
               errorDetail = CommonApiUtil.getSqlErrorMessage(var14.toString());
               this.commonApiLogService.insertFailLog(errorDetail, dataList.get(i), jobId, logSeq);
            }
         }
      }

      int I_dataCount = this.dataGoPlntQrtMapper.getDataCount_Imp(map);
      this.log.info("[식물검역정보 수입현황] Insert 완료 후 건수: " + I_dataCount);
      System.out.println("[식물검역정보 수입현황] Insert 완료 후 건수: " + I_dataCount);
      
      if(flag) {
	      Map<String, String> map2 = new HashMap<>();
	      map2.put("sysGp", "4");
	      map2.put("rsltGp", "S");
	      map2.put("startDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
	      map2.put("procMsg", "삭제 전: " + BF_dataCount + ",삭제 후(Insert 되기 전): " + AF_dataCount + ", Insert 완료: " + I_dataCount);
	      map2.put("pgmId", "Plant");
	      map2.put("pgmNm", "식물검역정보(수입)");
	      System.out.println("삭제 전: " + BF_dataCount + ",삭제 후(Insert 되기 전): " + AF_dataCount + ", Insert 완료: " + I_dataCount);
	      this.logInsertCall(map2);
      }
      
      if (!"1".equals(logStat)) {
         this.commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);
      }

      this.commonApiLogService.updateJobList(jobId, logStat);
   }

   public void dataType3ExpInsert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      String logStat = "1";
      String errorDetail = "";
      String jobId = (String)pRequestParamMap.get("jobId");
      String logSeq = (String)pRequestParamMap.get("logSeq");
      String idx = (String)pRequestParamMap.get("idx");
      Map<String, String> map = new HashMap();
      map.put("yyyymm", (String)pRequestParamMap.get("yyyymm"));
      int BF_dataCount = 0;
      int AF_dataCount = 0;
      if (idx != null && idx.equals("1")) {
         BF_dataCount = this.dataGoPlntQrtMapper.getDataCount_Exp(map);
         this.log.info("Delete 과정 - [수출현황] 삭제 되기 전 해당 월 데이터 건수: " + BF_dataCount);
         System.out.println("Delete 과정 - [수출현황] 삭제 되기 전 해당 월 데이터 건수: " + BF_dataCount);
         this.dataGoPlntQrtMapper.dataType3ExpBeforeDelete(map);
         AF_dataCount = this.dataGoPlntQrtMapper.getDataCount_Exp(map);
         this.log.info("[수출현황] 최종 삭제 후(Insert 전) 해당 월 데이터 건수: " + AF_dataCount);
         System.out.println("[수출현황] 최종 삭제 후(Insert 전) 해당 월 데이터 건수: " + AF_dataCount);
      }
      
      boolean flag = false;

      for(int i = 0; i < dataList.size(); ++i) {
         try {
            this.dataGoPlntQrtMapper.dataType3ExpInsert(dataList.get(i));
            
            if (dataList.size() != 999) {
                flag = true;
            }
            
         } catch (Exception var14) {
            if (var14.toString().indexOf("ORA-00001") < 0) {
               logStat = "2";
               errorDetail = CommonApiUtil.getSqlErrorMessage(var14.toString());
               this.commonApiLogService.insertFailLog(errorDetail, dataList.get(i), jobId, logSeq);
            }
         }
      }

      int I_dataCount = this.dataGoPlntQrtMapper.getDataCount_Exp(map);
      this.log.info("[식물검역정보 수출현황] - Insert 완료 후 건수: " + I_dataCount);
      System.out.println("[식물검역정보 수출현황] - Insert 완료 후 건수: " + I_dataCount);
      
      if(flag) {
	      Map<String, String> map2 = new HashMap<>();
	      map2.put("sysGp", "4");
	      map2.put("rsltGp", "S");
	      map2.put("startDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
	      map2.put("procMsg", "삭제 전: " + BF_dataCount + ",삭제 후(Insert 되기 전): " + AF_dataCount + ", Insert 완료: " + I_dataCount);
	      map2.put("pgmId", "Plant");
	      map2.put("pgmNm", "식물검역정보(수출)");
	      System.out.println("삭제 전: " + BF_dataCount + ",삭제 후(Insert 되기 전): " + AF_dataCount + ", Insert 완료: " + I_dataCount);
	      this.logInsertCall(map2);
      }
      
      if (!"1".equals(logStat)) {
         this.commonApiLogService.updateResultLog(logStat, errorDetail, jobId, logSeq);
      }

      this.commonApiLogService.updateJobList(jobId, logStat);
   }

   public List<String> selectNatCdList() {
      return this.dataGoPlntQrtMapper.selectNatCdList();
   }

   public List<String> selectHsCdList() {
      return this.dataGoPlntQrtMapper.selectHsCdList();
   }

   public void logInsertCall(Map<String, String> map) {
      this.dataGoPlntQrtMapper.logInsertCall(map);
   }

   public List<Map<String, Object>> chkEventList(Map<String, String> map) {
      return this.dataGoPlntQrtMapper.chkEventList(map);
   }
}