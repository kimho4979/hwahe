package com.fpdisys.dist.haa06.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.haa06.service.Haa06_Service;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class Haa06_Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private Haa06_Service haa06_Service;

	@RequestMapping(value="/haa06/haa06.do")
	public String selectHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){
		return "/auction/Haa06";
	}
 	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa06/selectHaa06ChartJson1.json")
	public String selectHaa06ChartJson1(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<Map> list = haa06_Service.selectHaa06ChartJson1(pRequestParamMap);
 			
 			List<Map<String, Object>> resList = new ArrayList<>();
 			for(int i=1; i<=12; i++){
 				Map<String, Object> map = new HashMap<>();
 				map.put("date", Integer.toString(i)+"월");
 				map.put(pRequestParamMap.get("searchEndDate").toString(), 0);
 				map.put(pRequestParamMap.get("searchStrDate").toString(), 0);
 				resList.add(map);
 			}
 			
 			for(Map e : list){
 				int idx = Integer.parseInt(e.get("SALE_MONTH").toString().substring(5))-1;
 				String key = e.get("SALE_MONTH").toString().substring(0,4);
 				
 				resList.get(idx).put(key, e.get("TOT_QTY"));
 			}
 			model.addAttribute("list", resList);
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
 	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa06/selectHaa06ChartJson2.json")
 	public String selectHaa06ChartJson2(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<Map> list = haa06_Service.selectHaa06ChartJson2(pRequestParamMap);
 			
 			List<Set<String>> pumNmSet = new ArrayList<>();
 			List<List<Map<String, Object>>> resultList = new ArrayList<List<Map<String, Object>>>();
			
 			for(int i=0; i<3; i++){
 				pumNmSet.add(new HashSet<String>());
 				resultList.add(new ArrayList<Map<String, Object>>());
 			}
 			
 			for(Map e : list){
 				pumNmSet.get(Integer.parseInt(e.get("MEJANG").toString())-1).add(e.get("PUM_NAME").toString());
 			}
 			
 			List<List<String>> pumNmList = new ArrayList<>();
 			for(int i=0; i<3; i++){
 				pumNmList.add(new ArrayList<String>(pumNmSet.get(i)));
	 			for(String pumNm : pumNmList.get(i)){
	 				Map<String, Object> map = new HashMap<>();
	 				map.put("pumNm", pumNm);
	 				map.put(pRequestParamMap.get("strYear").toString(), 0);
	 				map.put(pRequestParamMap.get("endYear").toString(), 0);
	 				resultList.get(i).add(map);
	 			}
 			}

 			for(Map e : list){
 				int gubnIdx = Integer.parseInt(e.get("MEJANG").toString())-1;
 				List<Map<String, Object>> GUBN = resultList.get(gubnIdx);
 				int idx = pumNmList.get(gubnIdx).indexOf(e.get("PUM_NAME").toString());
 				String key = e.get("YYYY").toString();
 				GUBN.get(idx).put(key, Integer.parseInt(GUBN.get(idx).get(key).toString())+Integer.parseInt(e.get("TOT_QTY").toString()));
 			}
 			
 			for(int j=0; j<3; j++){
	 			for(int i=0; i<resultList.get(j).size(); i++){
	 				if(resultList.get(j).get(i).get("pumNm").toString().equals("기타")){
	 					Map<String, Object> etc = new HashMap<>();
	 					for(String k : resultList.get(j).get(i).keySet()){
	 						etc.put(k, resultList.get(j).get(i).get(k));
	 					}
	 					resultList.get(j).remove(i);
	 					resultList.get(j).add(0, etc);
	 					break;
	 				}
	 			}
 			}
 			
 			for(int j=0; j<3; j++){
	 			for(int i=1; i<resultList.get(j).size()-1; i++){
	 				for(int k=i+1; k<resultList.get(j).size(); k++){
	 					if (Integer.parseInt(resultList.get(j).get(i).get(pRequestParamMap.get("endYear").toString()).toString()) > Integer.parseInt(resultList.get(j).get(k).get(pRequestParamMap.get("endYear").toString()).toString())){
	 						Map<String, Object> temp = resultList.get(j).get(i);
	 						resultList.get(j).set(i, resultList.get(j).get(k));
	 						resultList.get(j).set(k, temp);
	 					}
	 				}
	 			}
 			}
 			model.addAttribute("list", resultList);
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
 			e.printStackTrace();
 			log.error("오류발생 메서드를 찾을수 없습니다!!");
 		} catch (NoClassDefFoundError e) {
 			e.printStackTrace();
 			log.error("오류발생 클래스를 찾을 수 없습니다!!");
 		} catch (RuntimeException e) {
 			e.printStackTrace();
 			log.error("오류발생 런타임!!");
 		} catch (Exception e) {
 			e.printStackTrace();
 			log.error("오류발생!!");
 		}
 		
 		return "jsonView";
 	}
 	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa06/selectHaa06ChartJson3.json")
 	public String selectHaa06ChartJson3(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<Map> list2 = haa06_Service.selectHaa06ChartJson3(pRequestParamMap);
 			List<Map<String, Object>> list = new ArrayList<>();
 			for (Map e : list2){
 				list.add(e);
 			}
 			Collections.sort(list, new Comparator<Object>() {
 				@Override
 				public int compare(Object s1, Object s2) {
 					return Integer.parseInt(String.valueOf(((Map<String,Object>)s2).get("TOT_QTY"))) - Integer.parseInt(String.valueOf(((Map<String,Object>)s1).get("TOT_QTY")));
 				}
 			});
 			 
 			List<List<String>> pumNmList = new ArrayList<>();
 			List<Map<String, String>> pallet = new ArrayList<>();
 			for(int i=0; i<3; i++){
 				pumNmList.add(new ArrayList<String>());
 				pallet.add(new HashMap<String, String>());
 			}
 			
 			List<Double> SUM_QTY = Arrays.asList(0.0, 0.0, 0.0);
 			
 			for(Map e : list){
 				int idx = Integer.parseInt(e.get("MEJANG").toString())-1;
 				double TOT_QTY = new Double(e.get("TOT_QTY").toString());
 				pumNmList.get(idx).add(e.get("PUM_NAME").toString());
 				SUM_QTY.set(idx, SUM_QTY.get(idx) + TOT_QTY);
 			}
 			
 			
 			List<List<Map<String, Object>>> items = new ArrayList<>();
 			for(int i=0; i<3; i++){
 				List<Map<String, Object>> item = new ArrayList<>();
 				for(String pumNm : pumNmList.get(i)){
 					Map<String, Object> e = new HashMap<>();
 					e.put("pumNm", pumNm);
 					e.put("TOT_QTY", 0);
 					e.put("rate", 0.0);
 					e.put("rgb", null);
 					item.add(e);
 				}
 				items.add(item);
 			}
 			
 			String defaultColor = "#57B443";
 			
 			for(Map e : list){
 				int gubnIdx = Integer.parseInt(e.get("MEJANG").toString())-1;
 				List<Map<String, Object>> item = items.get(gubnIdx);
 				int idx = pumNmList.get(gubnIdx).indexOf(e.get("PUM_NAME").toString());
 				item.get(idx).put("TOT_QTY", e.get("TOT_QTY"));
 				item.get(idx).put("rate", new Double(e.get("TOT_QTY").toString())/SUM_QTY.get(gubnIdx)*100);
 				if(e.get("RGB_CODE") != null){
 					String t1 = e.get("RGB_CODE").toString();
 					String t2 = t1.substring(4, t1.length()-1);
 					String rgb = "#";
 					for(String t3 : t2.split(", ")){
 						String t4 = Integer.toHexString(Integer.parseInt(t3));
 						if (t4.length() < 2)
 							t4 = "0" + t4;
 						rgb += t4;
 					}
 					item.get(idx).put("rgb", rgb);
 					pallet.get(gubnIdx).put(e.get("PUM_NAME").toString(), rgb);
 				}
 				else{
 					item.get(idx).put("rgb", defaultColor);
 					pallet.get(gubnIdx).put(e.get("PUM_NAME").toString(), defaultColor);
 				}
 			}
 			
 			List<List<Map<String, Object>>> resList = new ArrayList<>();
 			List<Map<String, Object>> resList1 = new ArrayList<>();
 			List<Map<String, Object>> resList2 = new ArrayList<>();
 			List<Map<String, Object>> resList3 = new ArrayList<>();
 			
 			String dateRange = "(" + pRequestParamMap.get("searchStrDate").toString() + " ~ " + pRequestParamMap.get("searchEndDate").toString() + ")";
			Map<String, Object> e = new HashMap<>();
			e.put("name", Arrays.asList("절화", "관엽", "난").get(0) + dateRange);
			e.put("items", items.get(0));
			resList1.add(e);
			e = new HashMap<>();
			e.put("name", Arrays.asList("절화", "관엽", "난").get(1) + dateRange);
			e.put("items", items.get(1));
			resList2.add(e);
			e = new HashMap<>();
			e.put("name", Arrays.asList("절화", "관엽", "난").get(2) + dateRange);
			e.put("items", items.get(2));
			resList3.add(e);
			
			resList.add(resList1);
			resList.add(resList2);
			resList.add(resList3);
 			
			List<List<List<Map<String, Object>>>> result = new ArrayList<>();
			result.add(resList);
			pRequestParamMap.put("searchStrDate", pRequestParamMap.get("searchPreStrDate"));
			pRequestParamMap.put("searchEndDate", pRequestParamMap.get("searchPreEndDate"));
			result.add(preYearchart3(pRequestParamMap, pallet));
 			model.addAttribute("list", result);
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
 	
 	public List<List<Map<String, Object>>> preYearchart3(Map<String, Object> pRequestParamMap, List<Map<String, String>> pallet){
 		List<List<Map<String, Object>>> resList = new ArrayList<>();
 		try{
 			List<Map> list2 = haa06_Service.selectHaa06ChartJson3(pRequestParamMap);
 			List<Map<String, Object>> list = new ArrayList<>();
 			for (Map e : list2){
 				list.add(e);
 			}
 			Collections.sort(list, new Comparator<Object>() {
 				@Override
 				public int compare(Object s1, Object s2) {
 					return Integer.parseInt(String.valueOf(((Map<String,Object>)s2).get("TOT_QTY"))) - Integer.parseInt(String.valueOf(((Map<String,Object>)s1).get("TOT_QTY")));
 				}
 			});
 			
 			List<List<String>> pumNmList = new ArrayList<>();
 			for(int i=0; i<3; i++)
 				pumNmList.add(new ArrayList<String>());
 			
 			List<Double> SUM_QTY = Arrays.asList(0.0, 0.0, 0.0);
 			
 			for(Map e : list){
 				int idx = Integer.parseInt(e.get("MEJANG").toString())-1;
 				double TOT_QTY = new Double(e.get("TOT_QTY").toString());
 				pumNmList.get(idx).add(e.get("PUM_NAME").toString());
 				SUM_QTY.set(idx, SUM_QTY.get(idx) + TOT_QTY);
 			}
 			
 			
 			List<List<Map<String, Object>>> items = new ArrayList<>();
 			for(int i=0; i<3; i++){
 				List<Map<String, Object>> item = new ArrayList<>();
 				for(String pumNm : pumNmList.get(i)){
 					Map<String, Object> e = new HashMap<>();
 					e.put("pumNm", pumNm);
 					e.put("TOT_QTY", 0);
 					e.put("rate", 0.0);
 					e.put("rgb", null);
 					item.add(e);
 				}
 				items.add(item);
 			}
 			
 			String defaultColor = "#238883";
 			
 			for(Map e : list){
 				int gubnIdx = Integer.parseInt(e.get("MEJANG").toString())-1;
 				List<Map<String, Object>> item = items.get(gubnIdx);
 				int idx = pumNmList.get(gubnIdx).indexOf(e.get("PUM_NAME").toString());
 				item.get(idx).put("TOT_QTY", e.get("TOT_QTY"));
 				item.get(idx).put("rate", new Double(e.get("TOT_QTY").toString())/SUM_QTY.get(gubnIdx)*100);
 				if(pallet.get(gubnIdx).containsKey(e.get("PUM_NAME").toString())){
 					item.get(idx).put("rgb", pallet.get(gubnIdx).get(e.get("PUM_NAME").toString()));
 				}
 				else{
 					item.get(idx).put("rgb", defaultColor);
 				}
 			}
 			
 			
 			List<Map<String, Object>> resList1 = new ArrayList<>();
 			List<Map<String, Object>> resList2 = new ArrayList<>();
 			List<Map<String, Object>> resList3 = new ArrayList<>();
 			
 			String dateRange = "(" + pRequestParamMap.get("searchStrDate").toString() + " ~ " + pRequestParamMap.get("searchEndDate").toString() + ")";
 			Map<String, Object> e = new HashMap<>();
 			e.put("name", Arrays.asList("절화", "관엽", "난").get(0) + dateRange);
 			e.put("items", items.get(0));
 			resList1.add(e);
 			e = new HashMap<>();
 			e.put("name", Arrays.asList("절화", "관엽", "난").get(1) + dateRange);
 			e.put("items", items.get(1));
 			resList2.add(e);
 			e = new HashMap<>();
 			e.put("name", Arrays.asList("절화", "관엽", "난").get(2) + dateRange);
 			e.put("items", items.get(2));
 			resList3.add(e);
 			
 			resList.add(resList1);
 			resList.add(resList2);
 			resList.add(resList3);
 			
 			
 			
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
 		
 		return resList;
 	}
 	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	
 	@RequestMapping(value="/haa06/selectHaa06ChartJson4.json")
 	public String selectHaa06ChartJson4(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<Map> list2 = haa06_Service.selectHaa06ChartJson4(pRequestParamMap);
 			List<Map<String, Object>> list = new ArrayList<>();
 			for (Map e : list2){
 				list.add(e);
 			}
 			 
 			List<String> pumNmList = new ArrayList<>();
 			
 			Double SUM_QTY = 0.0;
 			
 			for(Map e : list){
 				pumNmList.add(e.get("PUM_NAME").toString());
 				SUM_QTY += new Double(e.get("TOT_QTY").toString());
 			}
 			
			List<Map<String, Object>> item = new ArrayList<>();
			for(String pumNm : pumNmList){
				Map<String, Object> e = new HashMap<>();
				e.put("pumNm", pumNm);
				e.put("TOT_QTY", 0);
				e.put("rate", 0.0);
				e.put("rgb", "#238883");
				item.add(e);
			}
 			
 			for(Map e : list){
 				int idx = Integer.parseInt(e.get("ROWNUM").toString()) - 1;
 				item.get(idx).put("pumNm", e.get("PUM_NAME2") + "(" + item.get(idx).get("pumNm") + ")");
 				item.get(idx).put("TOT_QTY", e.get("TOT_QTY"));
 				item.get(idx).put("rate", new Double(e.get("TOT_QTY").toString())/SUM_QTY*100);
 				if(e.get("RGB_CODE") != null){
 					String t1 = e.get("RGB_CODE").toString().replaceAll("[\\s]+", "");
 					String t2 = t1.substring(4, t1.length()-1);
 					String rgb = "#"; 
 					String[] rgbArr = t2.split(",");
					try{
					 for(int i = 0 ; i < rgbArr.length && i != 3; i++){
						 String t4 = Integer.toHexString(Integer.parseInt(rgbArr[i]));
						 if(Integer.parseInt(rgbArr[i]) <= 16){
							 t4 = "0"+t4;
						 }
						 rgb += t4;
					 }
					}catch(IndexOutOfBoundsException ie){
						log.error("index err");
					}
 					item.get(idx).put("rgb", rgb);
 				}
 			}
 			

 			List<Map<String, Object>> resList = new ArrayList<>();

 			
 			String dateRange = "(" + pRequestParamMap.get("searchStrDate").toString() + " ~ " + pRequestParamMap.get("searchEndDate").toString() + ")";
			Map<String, Object> e = new HashMap<>();
			e.put("name", Arrays.asList("절화", "관엽", "난").get(0) + dateRange);
			e.put("items", item);
			resList.add(e);
 			model.addAttribute("list", resList);
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
}
