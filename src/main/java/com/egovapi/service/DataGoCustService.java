   package com.egovapi.service;

import com.egovapi.mapper.DataGoCustMapper;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataGoCustService {
   protected Log log = LogFactory.getLog(this.getClass());
   @Autowired
   DataGoCustMapper dataGoCustMapper;
   @Autowired
   CommonApiLogService commonApiLogService;

   public void dataType1Insert(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      Locale currentLocale = new Locale("KOREAN", "KOREA");
      String pattern = "yyyy-MM-dd HH:mm:ss";
      System.out.println((new SimpleDateFormat(pattern, currentLocale)).format(new Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + (String)pRequestParamMap.get("natCd"));
      System.out.println((new SimpleDateFormat(pattern, currentLocale)).format(new Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + (String)pRequestParamMap.get("hsCd"));
      System.out.println((new SimpleDateFormat(pattern, currentLocale)).format(new Date()) + "와스에서 디비로 가기전 데이터 확인 \t : " + (String)pRequestParamMap.get("yyyymm"));
      
      Map<String, String> data = dataList.get(0);
      data.put("yyyymm", (String)pRequestParamMap.get("yyyymm"));
      data.put("hsCd", (String)pRequestParamMap.get("hsCd"));
      data.put("statCd", (String)pRequestParamMap.get("natCd"));
      
      String BF_Dd = (String)pRequestParamMap.get("BF_D_dataCount");
      String AF_Dd = (String)pRequestParamMap.get("AF_D_dataCount");
      
      int BF_I_dataCount = this.dataGoCustMapper.getDataCount_TbImpExpRaw(data);
      this.dataGoCustMapper.dataType1Insert(data);
      int AF_I_dataCount = this.dataGoCustMapper.getDataCount_TbImpExpRaw(data);
      Map<String, String> map2 = new HashMap<>();
      
      map2.put("sysGp", "5");
      map2.put("rsltGp", "S");
      map2.put("startDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
      map2.put("procMsg", (String)pRequestParamMap.get("yyyymm") + "Delete 전:" + BF_Dd + ", 후:" + AF_Dd + " Insert 전: " + BF_I_dataCount + ", 후: " + AF_I_dataCount);
      map2.put("pgmId", "customsData");
      map2.put("pgmNm", "화훼수출입정보");
      this.logInsertCall(map2);
      this.log.info("TB_IMPEXP_RAW 테이블: " + (String)pRequestParamMap.get("yyyymm") + "Delete 전:" + BF_Dd + ", 후:" + AF_Dd + " Insert 전: " + BF_I_dataCount + ", 후: " + AF_I_dataCount);
      System.out.println("TB_IMPEXP_RAW 테이블: " + (String)pRequestParamMap.get("yyyymm") + "Delete 전:" + BF_Dd + ", 후:" + AF_Dd + " Insert 전: " + BF_I_dataCount + ", 후: " + AF_I_dataCount);
   }

   public void logInsertCall(Map<String, String> map) {
      this.dataGoCustMapper.logInsertCall(map);
   }
}