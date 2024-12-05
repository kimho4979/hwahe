package com.egovapi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;

@Controller
public class JsonApiController {
	
	/*@Autowired
	KosisApiService kosisApiService;
	
	// json 데이터 입력
	@RequestMapping("/egov/api/jsonDataInput.json")
	public void jsonDataInput(@RequestParam Map<String, String> pRequestParamMap){
		//System.out.println("data \n" + pRequestParamMap.toString());
		
		String data = String.valueOf(pRequestParamMap.get("data"));
			
		try {
			
			if(data != null && !"".equals(data)){
				// 데이터 변환
				data ="{\"ALL\":"+data+"}";
				@SuppressWarnings("unchecked")
				List<Map<String, String>> list = (List<Map<String, String>>)getVoFromMultiJson(data, "ALL", Map.class);
				
				//System.out.println("list \n" + list);
				String type = String.valueOf(pRequestParamMap.get("type"));
				if(type != null && !"null".equals(type) && !"".equals(type) ){
					
					if("01".equals(type)){
						kosisType01(list, pRequestParamMap);
					}else if("02".equals(type)){
						kosisType02(list, pRequestParamMap);
					}else if("03".equals(type)){
						kosisType03(list, pRequestParamMap);
					}else if("04".equals(type)){
						kosisType04(list, pRequestParamMap);
					}else if("05".equals(type)){
						kosisType05(list, pRequestParamMap);
					}else if("06".equals(type)){
						kosisType06(list, pRequestParamMap);
					}else if("07".equals(type)){
						kosisType07(list, pRequestParamMap);
					}else if("08".equals(type)){
						kosisType08(list, pRequestParamMap);
					}else if("09".equals(type)){
						kosisType09(list, pRequestParamMap);
					}else if("10".equals(type)){
						kosisType10(list, pRequestParamMap);
					}else if("11".equals(type)){
						kosisType11(list, pRequestParamMap);
					}else if("12".equals(type)){
						kosisType12(list, pRequestParamMap);
					}else if("13".equals(type)){
						kosisType13(list, pRequestParamMap);
					}else if("14".equals(type)){
						kosisType14(list, pRequestParamMap);
					}else if("15".equals(type)){
						kosisType15(list, pRequestParamMap);
					}else if("16".equals(type)){
						kosisType16(list, pRequestParamMap);
					}else if("17".equals(type)){
						kosisType17(list, pRequestParamMap);
					}else if("18".equals(type)){
						kosisType18(list, pRequestParamMap);
					}else if("19".equals(type)){
						mafraType19(list, pRequestParamMap);
					}else if("20".equals(type)){
						mafraType20(list, pRequestParamMap);
					}else if("21".equals(type)){
						koreaBankType21(list, pRequestParamMap);
					}else if("22".equals(type)){
						kosisType22(list, pRequestParamMap);
					}else if("23".equals(type)){
						mafraType23(list, pRequestParamMap);
					}else if("24".equals(type)){
						theimcType24(list, pRequestParamMap);
					}else if("25".equals(type)){
						mafraType25(list, pRequestParamMap);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}			
		
	}
	
	// 통계청 마늘 주산지시군 재배면적
	private void kosisType01(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType01(list, pRequestParamMap);
	}
	// 통계청 고추 주산지시군 재배면적
	private void kosisType02(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType02(list, pRequestParamMap);
	}
	// 통계청 양파 주산지시군 재배면적
	private void kosisType03(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType03(list, pRequestParamMap);
	}
	// 통계청 노지 채소 재배면적
	private void kosisType04(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType04(list, pRequestParamMap);
	}
	// 통계청 고추 주산지시군 생산량
	private void kosisType05(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType05(list, pRequestParamMap);
	}
	// 통계청 품목별 소비자물가지수(품목성질별:2010＝100)
	private void kosisType06(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType06(list, pRequestParamMap);
	}
	// 통계청 가을배추 주산지시군 재배면적
	private void kosisType07(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType07(list, pRequestParamMap);
	}
	// 통계청 가을무 주산지시군 재배면적
	private void kosisType08(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType08(list, pRequestParamMap);
	}
	// 통계청 양파 생산비
	private void kosisType09(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType09(list, pRequestParamMap);
	}
	// 통계청 마늘 생산비
	private void kosisType10(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType10(list, pRequestParamMap);
	}
	// 통계청 고추 생산비
	private void kosisType11(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType11(list, pRequestParamMap);
	}
	// 통계청 채소생산량(엽채류)
	private void kosisType12(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType12(list, pRequestParamMap);
	}
	// 통계청 채소생산량(근채류)
	private void kosisType13(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType13(list, pRequestParamMap);
	}
	// 통계청 채소생산량(조미채소)
	private void kosisType14(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType14(list, pRequestParamMap);
	}
	// 통계청 고추 소득분석
	private void kosisType15(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType15(list, pRequestParamMap);
	}
	// 통계청 양파 소득분석
	private void kosisType16(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType16(list, pRequestParamMap);
	}
	// 통계청 마늘 소득분석
	private void kosisType17(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType17(list, pRequestParamMap);
	}
	// 통계청 농림생산지수
	private void kosisType18(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType18(list, pRequestParamMap);
	}
	// 통계청 생산자물가지수(품목별)(2010=100)
	private void kosisType22(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) kosisApiService.kosisType22(list, pRequestParamMap);
	}
	
	
	// 마프라 중국도매시장 가격정보
	private void mafraType19(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) mafraApiService.mafraType19(list, pRequestParamMap);
	}
	// 마프라 전국 농협산지공판장 경락가격 요약 정보
	private void mafraType20(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) mafraApiService.mafraType20(list, pRequestParamMap);
	}
	// 품목관측정보-월보
	private void mafraType23(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) mafraApiService.mafraType23(list, pRequestParamMap);
	}
		
	// 한국수출입은행 (환율정보)
	private void koreaBankType21(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) koreaBankApiService.koreaBankType21(list, pRequestParamMap);
	}
	// theimc 비정형데이터 연동
	private void theimcType24(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) theimcApiService.theimcType24(list, pRequestParamMap);
	}
	// 마프라 전국 농협산지공판장 경락가격 요약 정보(도매시장별)
	private void mafraType25(List<Map<String, String>> list, Map<String, String> pRequestParamMap) {
		if(list.size() > 0) mafraApiService.mafraType25(list, pRequestParamMap);
	}
	*/
	
	// json to list
	public static List getVoFromMultiJson(String pJsonString, String pNodeName, Class pClass) throws ParseException, JsonParseException, JsonMappingException, IOException, ParseException

	{
		//----------------------------------------------------------------
		// JSON STRING -> JSON OBJECT로 변환  ObjectMapper.configure( org.codehaus.jackson.map.SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		//----------------------------------------------------------------
		JSONObject jSONObject = new JSONObject();
		// jSONObject = (JSONObject) new JSONParser().parse(pJsonString.toString());
		jSONObject = (JSONObject) new JSONParser().parse(pJsonString);

		//----------------------------------------------------------------
		// data node 구함
		//----------------------------------------------------------------
		JSONArray lJsonArray = ((JSONArray)jSONObject.get(pNodeName));
		ArrayList lRtn = new ArrayList();


		ObjectMapper lObjectMapper = new ObjectMapper();
		lObjectMapper.configure(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

		for ( int inx = 0 ; inx < lJsonArray.size(); inx++)
		{
		  Object lClass = lObjectMapper.readValue(lJsonArray.get(inx).toString(), pClass);
		  lRtn.add(lClass);
		}

		return lRtn;
	}
	
	
}
