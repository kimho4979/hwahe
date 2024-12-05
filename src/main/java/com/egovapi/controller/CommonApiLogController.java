package com.egovapi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.egovapi.service.CommonApiLogService;
import com.egovapi.service.DataGoForecastService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class CommonApiLogController {

	@Autowired
	CommonApiLogService commonApiLogService;
	
	@Autowired
	DataGoForecastService forecastService;
	
	/**
	 * 스케쥴러 실행시 스케쥴러 로그 등록
	 * @param pRequestParamMap
	 * @return
	 */
	@RequestMapping("/egov/api/getJobLogSeq.json")
	public Map<String, String> jsonDataInput(@RequestParam Map<String, String> pRequestParamMap){
		////////////////////작업 필요///////////////////////
		System.out.println("original value : "+pRequestParamMap);
		System.out.println("extract value : "+pRequestParamMap.get("jobId"));
		
		String parseStr = String.valueOf(pRequestParamMap);
		
		Map<String, String> result = new HashMap<String, String>();
		 for (String param : parseStr.substring(parseStr.indexOf("jobId"), parseStr.length()-1 ).split("&")) {
	        String pair[] = param.split("=");
	        if (pair.length>1) {
	            result.put(pair[0], pair[1]);
	        }else{
	            result.put(pair[0], "");
	        }
	    }
	    pRequestParamMap.clear();
	    pRequestParamMap = result;
		
		String jobId = (String)pRequestParamMap.get("jobId");
		String logGubun = (String)pRequestParamMap.get("logGubun");
		Map<String, String> map = new HashMap<String, String>();
		map.put("jobId", jobId);
		map.put("logGubun", logGubun);
		map.put("logSeq", "");
		
		// 스케쥴러 로그 등록 및 로그 순번 조회
		commonApiLogService.startJobLog(map);
		
		return map;
	}
	
	/**
	 * 동네예보기상조회 :: NX, NY 좌표 송신
	 * @param pRequestParamMap
	 * @return
	 */
	@RequestMapping("/egov/api/getForecastList.json")
	public Map<String, Object> DataInput(@RequestParam Map<String, Object> pRequestParamMap){
		Map<String, Object> map = new HashMap<String, Object>();
		List<EgovMap> list = forecastService.ForecastList(pRequestParamMap);
		map.put("data", list);
		return map;
	}
	
	/**
	 * 동네예보기상조회 :: 프로시저 실행
	 * @param pRequestParamMap
	 * @return
	 */
	@RequestMapping("/egov/api/execForecast.json")
	public void execForecast(@RequestParam Map<String, Object> pRequestParamMap){
			forecastService.execForecast(pRequestParamMap);
	}
	
}
