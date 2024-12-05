package com.egovapi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.egovapi.mapper.DataGoCustMapper;
import com.egovapi.service.DataGoCustService;
import com.egovapi.service.DataGoForecastService;
import com.egovapi.service.DataGoPlntQrtService;
import com.fpdisys.base.util.JsonUtils;

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
	
	private final static String pattern = "yyyy-MM-dd HH:mm:ss";
	private final static java.util.Locale currentLocale = new java.util.Locale("KOREAN", "KOREA");
	// 운영
	protected final static String domain = "https://http://210.103.25.28:8082/";
	// 개발
	//protected final static String domain = "http://175.106.91.132:8180/fpdiAPI/";
	
	// XML 파싱 후 DB 저장
	@RequestMapping("/egov/api/xmlDataInput.json")
	public void xmlDataInput(@RequestParam Map<String, String> pRequestParamMap){
		
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + pRequestParamMap);
		
		String parseStr = String.valueOf(pRequestParamMap);
		String plntStr = parseStr.substring(parseStr.indexOf("data=")+5, parseStr.indexOf("&type"));
		
		
		Map<String, String> result = new HashMap<String, String>();
	    for (String param : parseStr.substring(parseStr.indexOf("&type="), parseStr.length()-1 ).split("&")) {
	        String pair[] = param.split("=");
	        if (pair.length>1) {
	            result.put(pair[0], pair[1]);
	        }else{
	            result.put(pair[0], "");
	        }
	    }
	    pRequestParamMap.clear();
	    pRequestParamMap = result;
		
		
		String data = plntStr;//String.valueOf(pRequestParamMap.get("data"));
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "식물검역 디비로 넣기전 데이터 확인 \t : " + pRequestParamMap.get("data"));
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> map = null;
		
		String yyyymmdd = String.valueOf(pRequestParamMap.get("yyyymmdd"));
		String type = String.valueOf(pRequestParamMap.get("type"));
		
		org.json.JSONObject obj = null;
		try {
			obj = org.json.XML.toJSONObject(data);
			
			data = obj.toString();
		}catch (org.json.JSONException e) {
			e.printStackTrace();
		}
		
		if(data != null && !"".equals(data) && !"null".equals(data)){
			try {
				
				org.json.JSONObject o1  = (org.json.JSONObject) obj.get("response");
				org.json.JSONObject o2  = (org.json.JSONObject) o1.get("body");
				org.json.JSONObject o3  = (org.json.JSONObject) o2.get("items");
				org.json.JSONArray o4  = (org.json.JSONArray) o3.get("item");
				
				dataList = JsonUtils.fromJson(o4.toString(), List.class);
				
				for(int i=0;i<dataList.size();i++) {
					
					dataList.get(i).put("yyyymm",yyyymmdd);
				}
				
			} catch (org.json.JSONException  e) {
				e.printStackTrace();
			}
			
			if(type != null && !"null".equals(type) && !"".equals(type) ){
				if(type.equals("1")) {
					dataType1(dataList, pRequestParamMap);
				}else if(type.equals("2")) {
					dataType2(dataList, pRequestParamMap);
				}else if(type.equals("3")) {
					String impExp = String.valueOf(pRequestParamMap.get("impExp"));
					if(impExp.equals("imp")){
						dataType3Imp(dataList, pRequestParamMap);
					}else{
						dataType3Exp(dataList, pRequestParamMap);
					}
					
					
				}
			}
		}
		
	}
	
	// 관세청 데이터 최신화
	public void dataType1(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap){
		if(dataList.size() > 0) dataGoCustService.dataType1Insert(dataList, pRequestParamMap);
	}
	
	// 기상청 데이터(동네예보 기상조회) 최신화
	public void dataType2(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap){
		if(dataList.size() > 0) dataGoForecastService.dataType2Insert(dataList, pRequestParamMap);
	}
	
	// 식물검역통계 수입 최신화
	public void dataType3Imp(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap){
		if(dataList.size() > 0) dataGoPlntQrtService.dataType3ImpInsert(dataList, pRequestParamMap);
	}
	
	// 식물검역통계 수출 최신화
	public void dataType3Exp(List<Map<String, String>> dataList, Map<String, String> pRequestParamMap){
		if(dataList.size() > 0) dataGoPlntQrtService.dataType3ExpInsert(dataList, pRequestParamMap);
	}
	

	@RequestMapping("/egov/api/test.json")
	public Map<String, List<String>> jsonDataInput(@RequestParam Map<String, String> pRequestParamMap){
		List<String> NatCdList = dataGoPlntQrtService.selectNatCdList();
		List<String> HsCdList = dataGoPlntQrtService.selectHsCdList();
		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("NatCdList", NatCdList);
		map.put("HsCdList", HsCdList);

		return map;
	}
	
	@RequestMapping("/egov/api/chkEventList.json")
	public List<Map<String, Object>> chkEventList(@RequestParam Map<String, String> pRequestParamMap){
		List<Map<String, Object>> eventList = dataGoPlntQrtService.chkEventList(pRequestParamMap);
		
		return eventList;
	}
	
	@RequestMapping("/egov/api/insertImpExpRaw.json")
	public void insertImpExpRaw(@RequestParam Map<String, String> pRequestParamMap){
		
		String parseStr = String.valueOf(pRequestParamMap);
		
		String gwanse = parseStr.substring(parseStr.indexOf("data=")+5, parseStr.indexOf("&type"));
		
		
		Map<String, String> result = new HashMap<String, String>();
	    for (String param : parseStr.substring(parseStr.indexOf("&type="), parseStr.length()-1 ).split("&")) {
	        String pair[] = param.split("=");
	        if (pair.length>1) {
	            result.put(pair[0], pair[1]);
	        }else{
	            result.put(pair[0], "");
	        }
	    }
	    pRequestParamMap.clear();
	    pRequestParamMap = result;
		String data = gwanse;//String.valueOf(pRequestParamMap.get("data"));
		
		if(pRequestParamMap.get("hsCd").toString().length() == 0 && pRequestParamMap.get("natCd").toString().length() == 0) dataGoCustMapper.dataType1BeforeDelete(pRequestParamMap);
		
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		Map<String, String> map = null;
		org.json.JSONObject obj = null;
		try {
			obj = org.json.XML.toJSONObject(data);
			
			data = obj.toString();
		}catch (org.json.JSONException e) {
			e.printStackTrace();
		}
		
		if(data != null && !"".equals(data) && !"null".equals(data)){
			try {
				
				org.json.JSONObject o1  = (org.json.JSONObject) obj.get("response");
				org.json.JSONObject o2  = (org.json.JSONObject) o1.get("body");
				org.json.JSONObject o3  = (org.json.JSONObject) o2.get("items");
				org.json.JSONArray o4  = (org.json.JSONArray) o3.get("item");
				
				dataList = JsonUtils.fromJson(o4.toString(), List.class);
				
			} catch (org.json.JSONException  e) {
				e.printStackTrace();
			}
			
			dataType1(dataList, pRequestParamMap);
		}
	}
	
	
	
	
	// 에러시 로그 이력
	@RequestMapping("/egov/api/logInsert.json")
	public void logInsert(@RequestParam Map<String, String> pRequestParamMap){
		
		//로그 프로시저 데이터 확인     : {&sysGp=2&rsltGp=E&startDate=20230817020503&procMsg=예외발생&pgmId=QnetGetExam&pgmNm=시험일정=}
		String parseStr = String.valueOf(pRequestParamMap);
		Map<String, String> result = new HashMap<String, String>();
	    for (String param : parseStr.substring(parseStr.indexOf("&sysGp="), parseStr.length()-1 ).split("&")) {
	        String pair[] = param.split("=");
	        if (pair.length>1) {
	            result.put(pair[0], pair[1]);
	        }else{
	            result.put(pair[0], "");
	        }
	    }
	    pRequestParamMap.clear();
	    pRequestParamMap = result;
		System.out.println(new java.text.SimpleDateFormat(pattern,currentLocale).format(new java.util.Date()) + "로그 프로시저 데이터 확인 \t : " + pRequestParamMap);
		dataGoPlntQrtService.logInsertCall(pRequestParamMap);
	}
}
