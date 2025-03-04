package com.egovapi.controller;

import com.egovapi.mapper.DataGoCustMapper;
import com.egovapi.service.DataGoCustService;
import com.egovapi.service.DataGoForecastService;
import com.egovapi.service.DataGoPlntQrtService;
import com.fpdisys.base.util.JsonUtils;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class XMLApiController {
   protected Log log = LogFactory.getLog(this.getClass());
   @Autowired
   DataGoCustService dataGoCustService;
   @Autowired
   DataGoForecastService dataGoForecastService;
   @Autowired
   DataGoPlntQrtService dataGoPlntQrtService;
   @Autowired
   DataGoCustMapper dataGoCustMapper;
   private static final String pattern = "yyyy-MM-dd HH:mm:ss";
   private static final Locale currentLocale = new Locale("KOREAN", "KOREA");
   protected static final String domain = "https://flower.at.or.kr";

   @RequestMapping({"/egov/api/xmlDataInput.json"})
   public void xmlDataInput(@RequestParam Map<String, String> pRequestParamMap) {
      System.out.println((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", currentLocale)).format(new Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + pRequestParamMap);
      String parseStr = String.valueOf(pRequestParamMap);
      String plntStr = parseStr.substring(parseStr.indexOf("data=") + 5, parseStr.indexOf("&type"));
      Map<String, String> result = new HashMap();
      String[] arr$ = parseStr.substring(parseStr.indexOf("&type="), parseStr.length() - 1).split("&");
      int len$ = arr$.length;

      String yyyymmdd;
      for(int i$ = 0; i$ < len$; ++i$) {
         yyyymmdd = arr$[i$];
         String[] pair = yyyymmdd.split("=");
         if (pair.length > 1) {
            result.put(pair[0], pair[1]);
         } else {
            result.put(pair[0], "");
         }
      }

      pRequestParamMap.clear();
      String data = plntStr;
      System.out.println((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", currentLocale)).format(new Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + (String)result.get("data"));
      List<Map<String, String>> dataList = new ArrayList();
      Map<String, String> map = null;
      yyyymmdd = String.valueOf(result.get("yyyymmdd"));
      String type = String.valueOf(result.get("type"));
      JSONObject obj = null;

      try {
         obj = XML.toJSONObject(data);
         data = obj.toString();
      } catch (JSONException var16) {
         var16.printStackTrace();
      }

      if (data != null && !"".equals(data) && !"null".equals(data)) {
         try {
            JSONObject o1 = (JSONObject)obj.get("response");
            JSONObject o2 = (JSONObject)o1.get("body");
            JSONObject o3 = (JSONObject)o2.get("items");
            JSONArray o4 = (JSONArray)o3.get("item");
            dataList = (List)JsonUtils.fromJson(o4.toString(), List.class);

            for(int i = 0; i < ((List)dataList).size(); ++i) {
               ((Map)((List)dataList).get(i)).put("yyyymm", yyyymmdd);
            }
         } catch (JSONException var17) {
            var17.printStackTrace();
         }

         if (type != null && !"null".equals(type) && !"".equals(type)) {
            if (type.equals("1")) {
               this.dataType1((List)dataList, result);
            } else if (type.equals("2")) {
               this.dataType2((List)dataList, result);
            } else if (type.equals("3")) {
               String impExp = String.valueOf(result.get("impExp"));
               if (impExp.equals("imp")) {
                  this.dataType3Imp((List)dataList, result);
               } else {
                  this.dataType3Exp((List)dataList, result);
               }
            }
         }
      }

   }

   public void dataType1(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      if (dataList.size() > 0) {
         this.dataGoCustService.dataType1Insert(dataList, pRequestParamMap);
      }

   }

   public void dataType2(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      if (dataList.size() > 0) {
         this.dataGoForecastService.dataType2Insert(dataList, pRequestParamMap);
      }

   }

   public void dataType3Imp(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      if (dataList.size() > 0) {
         this.dataGoPlntQrtService.dataType3ImpInsert(dataList, pRequestParamMap);
      }

   }

   public void dataType3Exp(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap) {
      if (dataList.size() > 0) {
         this.dataGoPlntQrtService.dataType3ExpInsert(dataList, pRequestParamMap);
      }

   }

   @RequestMapping({"/egov/api/test.json"})
   public Map<String, List<String>> jsonDataInput(@RequestParam Map<String, String> pRequestParamMap) {
      List<String> NatCdList = this.dataGoPlntQrtService.selectNatCdList();
      List<String> HsCdList = this.dataGoPlntQrtService.selectHsCdList();
      Map<String, List<String>> map = new HashMap();
      map.put("NatCdList", NatCdList);
      map.put("HsCdList", HsCdList);
      return map;
   }

   @RequestMapping({"/egov/api/chkEventList.json"})
   public List<Map<String, Object>> chkEventList(@RequestParam Map<String, String> pRequestParamMap) {
      List<Map<String, Object>> eventList = this.dataGoPlntQrtService.chkEventList(pRequestParamMap);
      return eventList;
   }

   @RequestMapping({"/egov/api/insertImpExpRaw.json"})
   public void insertImpExpRaw(@RequestParam Map<String, String> pRequestParamMap) {
      String parseStr = String.valueOf(pRequestParamMap);
      String gwanse = parseStr.substring(parseStr.indexOf("data=") + 5, parseStr.indexOf("&type"));
      Map<String, String> result = new HashMap();
      String[] arr$ = parseStr.substring(parseStr.indexOf("&type="), parseStr.length() - 1).split("&");
      int len$ = arr$.length;

      for(int i$ = 0; i$ < len$; ++i$) {
         String param = arr$[i$];
         String[] pair = param.split("=");
         if (pair.length > 1) {
            result.put(pair[0], pair[1]);
         } else {
            result.put(pair[0], "");
         }
      }

      int BF_D_dataCount = 0;
      int AF_D_dataCount = 0;
      
      pRequestParamMap.clear();
      String data = gwanse;
      if (((String)result.get("hsCd")).toString().length() == 0 && ((String)result.get("natCd")).toString().length() == 0) {
    	  
    	 BF_D_dataCount = dataGoCustMapper.getDataCount_TbImpExpRaw(result);
    	 log.info("관세청 데이터 삭제 전: " + BF_D_dataCount);
    	 System.out.println("관세청 데이터 삭제 전: " + BF_D_dataCount);
    	 
         this.dataGoCustMapper.dataType1BeforeDelete(result);
         
         AF_D_dataCount = dataGoCustMapper.getDataCount_TbImpExpRaw(result);
         log.info("관세청 데이터 삭제 후: " + AF_D_dataCount);
    	 System.out.println("관세청 데이터 삭제 후: " + AF_D_dataCount);
    	 
    	 // BF_D_dataCount와 AF_D_dataCount 값을 result 맵에 추가
    	 result.put("BF_D_dataCount", String.valueOf(BF_D_dataCount)); // 정수를 문자열로 변환하여 추가
    	 result.put("AF_D_dataCount", String.valueOf(AF_D_dataCount));
      }

      List<Map<String, String>> dataList = new ArrayList();
      Map<String, String> map = null;
      JSONObject obj = null;

      try {
         obj = XML.toJSONObject(data);
         data = obj.toString();
      } catch (JSONException var14) {
         var14.printStackTrace();
      }

      if (data != null && !"".equals(data) && !"null".equals(data)) {
         try {
            JSONObject o1 = (JSONObject)obj.get("response");
            JSONObject o2 = (JSONObject)o1.get("body");
            JSONObject o3 = (JSONObject)o2.get("items");
            JSONArray o4 = (JSONArray)o3.get("item");
            dataList = (List)JsonUtils.fromJson(o4.toString(), List.class);
         } catch (JSONException var13) {
            var13.printStackTrace();
         }

         this.dataType1((List)dataList, result);
      }

   }

   @RequestMapping({"/egov/api/logInsert.json"})
   public void logInsert(@RequestParam Map<String, String> pRequestParamMap) {
      String parseStr = String.valueOf(pRequestParamMap);
      Map<String, String> result = new HashMap();
      String[] arr$ = parseStr.substring(parseStr.indexOf("&sysGp="), parseStr.length() - 1).split("&");
      int len$ = arr$.length;

      for(int i$ = 0; i$ < len$; ++i$) {
         String param = arr$[i$];
         String[] pair = param.split("=");
         if (pair.length > 1) {
            result.put(pair[0], pair[1]);
         } else {
            result.put(pair[0], "");
         }
      }

      pRequestParamMap.clear();
      System.out.println((new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", currentLocale)).format(new Date()) + "로그 프로시저 데이터 확인 \t : " + result);
      this.dataGoPlntQrtService.logInsertCall(result);
   }
}