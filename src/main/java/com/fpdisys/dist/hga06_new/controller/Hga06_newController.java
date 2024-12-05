package com.fpdisys.dist.hga06_new.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.hga06_new.service.Hga06_newService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Hga06_newController extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hga06_newService hga06_newService;
	
	// 화훼 수출입 동향분석
	@RequestMapping(value = "/hga06_new/hga06_new.do")
	public String selectHfc01(HttpServletRequest pRequest,	HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
						
		return "/auction/Hga06_new";
	}
	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	@RequestMapping(value="/hga06_new/selectGetDate.json")
	public String selectGetDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga06_newService.selectGetDate(pRequestParamMap);
			model.addAttribute("list",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	@RequestMapping(value="/hga06_new/selectGetItem.json")
	public String selectGetItem(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga06_newService.selectGetItem(pRequestParamMap);
			model.addAttribute("list",list);
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		}
		
		return "jsonView";
	}
	
	// 화훼 수출입 동향분석 List
	@RequestMapping(value="/hga06_new/selectTrendAnalysisList.json")
	public String selectTrendAnalysisList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga06_newService.selectTrendAnalysisList(pRequestParamMap);
			model.addAttribute("list",list);
		} catch (ArithmeticException e) {
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		}
		
		return "jsonView";
	}
	
	// 수출/수입 금액/물량 조회
	@RequestMapping(value="/hga06_new/selectExpImpInfo.json")
	public String selectExpImpInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="type") String type
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="searchDateM") String searchDateM
			,@RequestParam(value="itemCd") String itemCd
			, ModelMap model){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("type", type);		// 수출/수입 구분
		pRequestParamMap.put("type2", type2);	// 금액/물량 구분
		pRequestParamMap.put("searchDateM", searchDateM);	// 기준년월
		pRequestParamMap.put("itemCd", itemCd);	// 품목코드

		if("sExp".equals(type)) {
			// 수출 금액/물량
			resultList = hga06_newService.selectExp(pRequestParamMap);
			model.addAttribute("expList",resultList);
		}
		else if("sImp".equals(type)) {
			// 수입 금액/물량
			resultList = hga06_newService.selectImp(pRequestParamMap);
			model.addAttribute("impList",resultList);
		}
		
		return "jsonView";	
	}
	
	// 수출/수입 월별 국가 수
	@RequestMapping(value="/hga06_new/selectNatCnt.json")
	public String selectNatCnt(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="type") String type
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="searchDateM") String searchDateM
			//,@RequestParam(value="itemCd[]") List<String> flowerCd
			, ModelMap model){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("searchDateM", searchDateM);	// 기준년월

		if("sExp".equals(type)) {
			// 수출 월별 국가 수
			resultList = hga06_newService.selectExpNatCnt(pRequestParamMap);
			model.addAttribute("list",resultList);
		}
		else if("sImp".equals(type)) {
			// 수입 월별 국가 수
			resultList = hga06_newService.selectImpNatCnt(pRequestParamMap);
			model.addAttribute("list",resultList);
		}

		return "jsonView";	
	}
	
//	// 차트 조회
//	@RequestMapping(value="/hga06_new/selectChartInfo.json")
//	public String selectChartInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
//			,@RequestParam(value="type") String type
//			,@RequestParam(value="type2") String type2
//			,@RequestParam(value="searchDateM") String searchDateM
//			//,@RequestParam(value="itemCd[]") List<String> flowerCd
//			, ModelMap model){
//		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
//		List<EgovMap> resultList;
//		
//		pRequestParamMap.put("type", type);		// 수출/수입 구분
//		pRequestParamMap.put("type2", type2);	// 금액/물량 구분
//		pRequestParamMap.put("searchDateM", searchDateM);	// 기준년월
//
//		String key_name = "";
//		if("sExp".equals(type)){
//			if("sPrc".equals(type2))
//				key_name = "expPrc";
//			else if("sQty".equals(type2))
//				key_name = "expQty";
//			resultList = hga06_newService.selectExp(pRequestParamMap);
//			
//			resultList = hga06_newService.selectExpChart(pRequestParamMap);
//			
//			Set<String> nation_set = new HashSet<String>();
//			for(EgovMap element : resultList){
//				for(Object key : element.keyList()){
//					if(key.toString().contains("natNm") && element.get(key) != null){
//						nation_set.add(element.get(key).toString());
//					}
//				}
//			}
//			
//			List<HashMap<String, Object>> sorted_result_list = new ArrayList<HashMap<String, Object>>();
//			for(EgovMap element : resultList){
//				HashMap<String, Object> sorted_result = new HashMap<String, Object>();
//				sorted_result.put("yyyymm", element.get("yyyymm").toString());
//				sorted_result.put("Gubun", "수출");
//	
//				
//				for(String nation : nation_set){
//					if(element.valueList().contains(nation) == false)
//						sorted_result.put(nation, null);
//					else{
//						for(Object key : element.keyList()){
//							if(element.get(key).toString().equals(nation)){
//								sorted_result.put(nation, element.get(key_name + key.toString().substring("natNm".length())));
//								break;
//							}
//						}
//					}
//				}
//				sorted_result_list.add(sorted_result);
//			}
//			model.addAttribute("expChartList",sorted_result_list);
//		}
//		else if("sImp".equals(type)){
//			if("sPrc".equals(type2))
//				key_name = "impPrc";
//			else if("sQty".equals(type2))
//				key_name = "impQty";
//			resultList = hga06_newService.selectImpChart(pRequestParamMap);
//			Set<String> nation_set = new HashSet<String>();
//			for(EgovMap element : resultList){
//				for(Object key : element.keyList()){
//					if(key.toString().contains("natNm") && element.get(key) != null){
//						nation_set.add(element.get(key).toString());
//					}
//				}
//			}
//			
//			List<HashMap<String, Object>> sorted_result_list = new ArrayList<HashMap<String, Object>>();
//			for(EgovMap element : resultList){
//				HashMap<String, Object> sorted_result = new HashMap<String, Object>();
//				sorted_result.put("yyyymm", element.get("yyyymm").toString());
//				sorted_result.put("Gubun", "수입");
//				for(String nation : nation_set){
//					if(element.valueList().contains(nation) == false)
//						sorted_result.put(nation, null);
//					else{
//						for(Object key : element.keyList()){
//							if(element.get(key).toString().equals(nation)){
//								sorted_result.put(nation, element.get(key_name + key.toString().substring("natNm".length())));
//								break;
//							}
//						}
//					}
//				}
//				sorted_result_list.add(sorted_result);
//			}
//			model.addAttribute("impChartList",sorted_result_list);
//		}
//		return "jsonView";	
//		
//	}
	@RequestMapping(value="/hga06_new/selectChartInfo.json")
	public String selectChartInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="type") String type
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="searchDateM") String searchDateM
			,@RequestParam(value="itemCd") String itemCd
			
			, ModelMap model){
		try{
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			List<EgovMap> resultList;
			
			pRequestParamMap.put("type", type);		// 수출/수입 구분
			pRequestParamMap.put("type2", type2);	// 금액/물량 구분
			pRequestParamMap.put("searchDateM", searchDateM);	// 기준년월
			pRequestParamMap.put("itemCd", itemCd);		// 품목코드
			String key_name = "";
			
			// 2022년 2월 ~ 2023년 2월에서 상위 5개의 나라 목록
			List<String> natNm_list_for_chart = new ArrayList<String>();
			
			if("sExp".equals(type)){
				if("sPrc".equals(type2)){
					key_name = "expPrc";
					natNm_list_for_chart =  Arrays.asList("미국", "일본", "대만", "네덜란드", "괌(미국)", "기타");
				}
				else if("sQty".equals(type2)){
					key_name = "expQty";
					natNm_list_for_chart =  Arrays.asList("일본", "미국", "중국", "대만", "괌(미국)", "기타");
				}
				resultList = hga06_newService.selectExp(pRequestParamMap);
	
				Map<String, List<Integer>> value_by_natNm = new HashMap<String, List<Integer>>();
				for(EgovMap element : resultList){
					List<Integer> value_list = new ArrayList<Integer>();
					for(int i=1; i<=12; i++){
						if(element.get(key_name+String.valueOf(i)).toString().equals(" "))
							value_list.add(null);
						else
							value_list.add(Integer.parseInt(element.get(key_name+String.valueOf(i)).toString()));
					}
					
					if(natNm_list_for_chart.contains(element.get("natNm").toString()))
						value_by_natNm.put(element.get("natNm").toString(), value_list);
					else{
						if(value_by_natNm.keySet().contains("기타") == false)
							value_by_natNm.put("기타", Arrays.asList(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
						
						List<Integer> sum_list = value_by_natNm.get("기타");
						for(int i=0; i<sum_list.size(); i++){
							if(value_list.get(i) != null)
								sum_list.set(i, sum_list.get(i) + value_list.get(i));
						}
						
						value_by_natNm.put("기타", sum_list);
					}
				}
	
	
		        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		        Date date = formatter.parse(searchDateM);
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(date);
				cal.add(Calendar.YEAR, -1);
				List<HashMap<String, Object>> sorted_result_list = new ArrayList<HashMap<String, Object>>();
				for(int i=0; i<12; i++){
					cal.add(Calendar.MONTH, 1);
					HashMap<String, Object> sorted_result = new HashMap<String, Object>();
					sorted_result.put("yyyymm", new SimpleDateFormat("yyyy-MM").format(cal.getTime()));
					sorted_result.put("Gubun", "수출");
					sorted_result.put("type2", type2);
		
					
					for(Map.Entry<String, List<Integer>> element : value_by_natNm.entrySet()){
						if(natNm_list_for_chart.contains(element.getKey())){
							sorted_result.put(element.getKey(), element.getValue().get(i));
						}
					}
					sorted_result_list.add(sorted_result);
				}
				model.addAttribute("expChartList",sorted_result_list);
			}
			else if("sImp".equals(type)){
				if("sPrc".equals(type2)){
					key_name = "impPrc";
					natNm_list_for_chart =  Arrays.asList("중국", "콜롬비아", "네덜란드", "베트남", "대만", "기타");
				}
				else if("sQty".equals(type2)){
					key_name = "impQty";
					natNm_list_for_chart =  Arrays.asList("중국", "네덜란드", "베트남", "콜롬비아", "태국", "기타");
				}
				resultList = hga06_newService.selectImp(pRequestParamMap);
	
				Map<String, List<Integer>> value_by_natNm = new HashMap<String, List<Integer>>();
				for(EgovMap element : resultList){
					List<Integer> value_list = new ArrayList<Integer>();
					for(int i=1; i<=12; i++)
						if(element.get(key_name+String.valueOf(i)).toString().equals(" "))
							value_list.add(null);
						else
							value_list.add(Integer.parseInt(element.get(key_name+String.valueOf(i)).toString()));
					if(natNm_list_for_chart.contains(element.get("natNm").toString()))
						value_by_natNm.put(element.get("natNm").toString(), value_list);
					else{
						if(value_by_natNm.keySet().contains("기타") == false)
							value_by_natNm.put("기타", Arrays.asList(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0));
						
						List<Integer> sum_list = value_by_natNm.get("기타");
						for(int i=0; i<sum_list.size(); i++){
							if(value_list.get(i) != null)
								sum_list.set(i, sum_list.get(i) + value_list.get(i));
						}
						
						value_by_natNm.put("기타", sum_list);
					}
				}
	
		        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM");
		        Date date = formatter.parse(searchDateM);
		        Calendar cal = Calendar.getInstance();
		        cal.setTime(date);
				cal.add(Calendar.YEAR, -1);
				List<HashMap<String, Object>> sorted_result_list = new ArrayList<HashMap<String, Object>>();
				for(int i=0; i<12; i++){
					cal.add(Calendar.MONTH, 1);
					HashMap<String, Object> sorted_result = new HashMap<String, Object>();
					sorted_result.put("yyyymm", new SimpleDateFormat("yyyy-MM").format(cal.getTime()));
					sorted_result.put("Gubun", "수입");
					sorted_result.put("type2", type2);
					
					for(Map.Entry<String, List<Integer>> element : value_by_natNm.entrySet()){
						if(natNm_list_for_chart.contains(element.getKey())){
							sorted_result.put(element.getKey(), element.getValue().get(i));
						}
					}
					sorted_result_list.add(sorted_result);
				}
				
	
				model.addAttribute("impChartList",sorted_result_list);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "jsonView";	
		
	}
}
