package com.fpdisys.dist.haa05.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Comparator;

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
import com.fpdisys.dist.haa05.service.Haa05_Service;
import com.fpdisys.dist.search.service.SearchService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class Haa05_Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private Haa05_Service haa05_Service;


	@RequestMapping(value="/haa05/haa05.do")
	public String selectHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){

		try{
			Calendar strDate = Calendar.getInstance();
			strDate.setTime(new Date());
			strDate.add(Calendar.DATE, -7);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");
	
			if(pRequestParamMap.get("searchStrDate") != null) {
				model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
			}else {
				//model.addAttribute("searchStrDate", sdf.format(new Date()));
				model.addAttribute("searchStrDate", sdf.format(strDate.getTime()));
				model.addAttribute("searchStrDateM", sdf1.format(strDate.getTime()));
				model.addAttribute("searchStrDateY", sdf2.format(strDate.getTime()));
			}
	
			if(pRequestParamMap.get("searchEndDate") != null) {
				model.addAttribute("searchEndDate", pRequestParamMap.get("searchEndDate"));
			}else {
				model.addAttribute("searchEndDate", sdf.format(new Date()));
				model.addAttribute("searchEndDateM", sdf1.format(new Date()));
				model.addAttribute("searchEndDateY", sdf2.format(new Date()));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/auction/Haa05";
	}

	@RequestMapping(value="/haa05/selectMultiAuctionList.json")
	public String selectMultiAuctionList(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			, ModelMap model) {
		try{
			logger.debug(">>>>>>>>>>> /haa05/selectMultiAuctionList.json");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
	
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			paramMap.put("itemList", itemList);
			paramMap.put("itemDtlList", itemDtlList);
	
			if("day".equals(type)){
				list = haa05_Service.selectAuctionDayList(paramMap);
			}else if("month".equals(type)){
				list = haa05_Service.selectAuctionMonthList(paramMap);
			}else{
				searchStrDate += "-01";
				searchEndDate += "-12";
				paramMap.put("searchStrDate", searchStrDate);
				paramMap.put("searchEndDate", searchEndDate);
				list = haa05_Service.selectAuctionYearList(paramMap);
			}
	
			model.addAttribute("list",list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "jsonView";

	 }

	@RequestMapping(value="/haa05/selectAuctionList.json")
	public String selectAuctionList(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="gubn[]") List<String> gubn
			, ModelMap model) {
		try{
			logger.debug(">>>>>>>>>>> /haa05/selectAuctionList.json");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
	
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("itemCd", itemCd);
			paramMap.put("itemCd2", itemCd2);
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);
	
			if(type.equals("day")){
				list = haa05_Service.selectAuctionDayList(paramMap);
			}else if(type.equals("month")){
				list = haa05_Service.selectAuctionMonthList(paramMap);
			}else{
				searchStrDate += "-01";
				searchEndDate += "-12";
				paramMap.put("searchStrDate", searchStrDate);
				paramMap.put("searchEndDate", searchEndDate);
				list = haa05_Service.selectAuctionYearList(paramMap);
			}



			model.addAttribute("list",list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "jsonView";

	 }

	@RequestMapping(value="/haa05/selectAuctionListTotal.json")
	public String selectAuctionListTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			, ModelMap model) {
		try{
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<EgovMap> list;
			
			if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
				itemList.add("6002");
			}
	
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);
			paramMap.put("gubn", gubn);
			paramMap.put("flowerCtgrList", flowerCtgrList);
			paramMap.put("marketList", marketList);
			paramMap.put("itemList", itemList);
			paramMap.put("itemDtlList", itemDtlList);
	
			list = haa05_Service.selectAuctionListTotal(paramMap);
			
			model.addAttribute("list",list);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "jsonView";

	 }

	/**
 	 * 등급정보 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00LvJson.json")
	public String selectHaa00LvJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap
			, ModelMap model){
 		try{

 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
	 			if(type.equals("day")){
	 				list = haa05_Service.selectHaaLvDate00(pRequestParamMap);
	 			}else if(type.equals("month")){
	 				list = haa05_Service.selectHaaLvMonth00(pRequestParamMap);
	 			}else{
	 				list = haa05_Service.selectHaaLvYear00(pRequestParamMap);
	 			}
 			}

 			model.addAttribute("list", list);

		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			e.printStackTrace();
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			e.printStackTrace();
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}

 		return "jsonView";
	}

 	/**
 	 * 통합 등급정보 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00LvJsonTotal.json")
	public String selectHaa00LvJsonTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="flowerCd") String flowerCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="cmpCdList[]") List<String> cmpCdList
			, ModelMap model){
 		try{

 			List<EgovMap> list =null;
 			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
 			pRequestParamMap.put("cmpCd", cmpCd);
 			pRequestParamMap.put("flowerCd", flowerCd);
 			pRequestParamMap.put("itemCd", itemCd);
 			pRequestParamMap.put("itemCd2", itemCd2);
 			pRequestParamMap.put("searchStrDate", searchStrDate);
 			pRequestParamMap.put("searchEndDate", searchEndDate);
 			pRequestParamMap.put("type", type);
 			pRequestParamMap.put("cmpCdList", cmpCdList);

 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
 				list = haa05_Service.selectHaa00LvTotal(pRequestParamMap);
 			}

 			model.addAttribute("list", list);

		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
			log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
		} catch (NoSuchMethodError e) {
			e.printStackTrace();
			log.error("오류발생 메서드를 찾을수 없습니다!!");
		} catch (NoClassDefFoundError e) {
			e.printStackTrace();
			log.error("오류발생 클래스를 찾을 수 없습니다!!");
		} catch (Exception e) {
			log.error(e.getMessage());
		}

 		return "jsonView";
	}


	/**
 	 * 거래금액분포도 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00InfoJson.json")
	public String selectHab01InfoJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		log.info("====== Haa00InfoJSON ======");

 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa05_Service.selectHaaInfoDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa05_Service.selectHaaInfoMonth00(pRequestParamMap);
 			}else{
 				list = haa05_Service.selectHaaInfoYear00(pRequestParamMap);
 			}


 			model.addAttribute("list", list);
		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}

 	/**
 	 * 통합 거래금액분포도 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00InfoJsonTotal.json")
	public String selectHaa00InfoJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		log.info("====== Haa00InfoJSON ======");

 		try{
 			List<EgovMap> list = haa05_Service.selectHaaInfoTotal00(pRequestParamMap);
 			model.addAttribute("list", list);
		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}


 	/**
 	 * 거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00ChartJson.json")
	public String selectHaa00ChartJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa05_Service.selectHaaChartDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa05_Service.selectHaaChartMonth00(pRequestParamMap);
 			}else{
 				list = haa05_Service.selectHaaChartYear00(pRequestParamMap);
 			}

 			model.addAttribute("list", list);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}
 	
 	/**
 	 * 거래동향 호출2
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00ChartJson2.json")
 	public String selectHaa00ChartJson2(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			, ModelMap model) {
 		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		
		if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
			itemList.add("6002");
		}

		paramMap.put("searchStrDate", searchStrDate);
		paramMap.put("searchEndDate", searchEndDate);
		paramMap.put("flowerCtgrList", flowerCtgrList);
		paramMap.put("marketList", marketList);
		paramMap.put("itemList", itemList);
		paramMap.put("itemDtlList", itemDtlList);
		
 		try{

			list = haa05_Service.selectHaaChartYear002(paramMap);
			int intYYYY = Integer.parseInt(searchEndDate.toString().substring(0,4));
 			List<Map<String, Object>> chartList = new ArrayList<>();
 			List<Map<String, Object>> chartList2 = new ArrayList<>();
 			List<Map<String, Object>> chartList3 = new ArrayList<>();

			for(int j=1; j<=12; j++){
 				for(String sun : Arrays.asList("상순", "중순", "하순")){
					String date = String.format("%d", j) + "월-" + sun;
					
	 				Map<String, Object> row = new HashMap<String, Object>();
	 				Map<String, Object> row2 = new HashMap<String, Object>();
	 				Map<String, Object> row3 = new HashMap<String, Object>();

	 				
	 				row.put("date", date);
	 				row2.put("date", date);
	 				row3.put("date", date);
	 				
	 				for(int yyyy : Arrays.asList(intYYYY-3, intYYYY-2, intYYYY-1, intYYYY)){
		 				row.put(Integer.toString(yyyy), 0);
		 				row2.put(Integer.toString(yyyy), 0);
		 				row3.put(Integer.toString(yyyy), 0);
	 				}
	 				chartList.add(row);
	 				chartList2.add(row2);
	 				chartList3.add(row3);
				}
			}
			
			List<Map<String, Object>> fristSale = new ArrayList<>();
			for(int i=0; i<4; i++){
				Map<String, Object> init = new HashMap<String, Object>();
				init.put("startValue", "");
				init.put("endValue", "");
				init.put("verticalStartValue", 0);
				init.put("verticalEndValue", 0);
				init.put("dateDtl", "");
				fristSale.add(init);
			}
			
 			for(EgovMap e : list){
 				

 				int mm = Integer.parseInt(e.get("mm").toString());
 				int sun = Integer.parseInt(e.get("sun").toString());
 				int idx = (mm-1)*3 + (sun-1);
 				
 				Map<String, Object> fristSaleMap = fristSale.get(Integer.parseInt(e.get("yyyy").toString())-(intYYYY-3));
 				if(Integer.parseInt(fristSaleMap.get("verticalEndValue").toString()) == 0){
 					fristSaleMap.put("startValue", chartList.get(idx).get("date"));
 					fristSaleMap.put("endValue", chartList.get(idx).get("date"));
 					fristSaleMap.put("verticalEndValue", e.get("totqty"));
 					fristSaleMap.put("dateDtl", Integer.toString(Integer.parseInt(e.get("mm").toString()))+"월 "+Integer.toString(Integer.parseInt(e.get("dd").toString()))+"일");
 				}
 				
 				chartList.get(idx).put(e.get("yyyy").toString(), e.get("totqty"));
 				chartList2.get(idx).put(e.get("yyyy").toString(), e.get("totamt"));
 				chartList3.get(idx).put(e.get("yyyy").toString(), e.get("avgamt"));
 			}


 			List<List<Map<String, Object>>> resultList = new ArrayList<List<Map<String, Object>>>();
 			resultList.add(chartList);
 			resultList.add(chartList2);
 			resultList.add(chartList3);
 			resultList.add(fristSale);
 			model.addAttribute("list", resultList);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}
 		
 		return "jsonView";
 	}
 	
 	/**
 	 * 품종 Top5
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectTop5.json")
 	public String selectTop5(HttpServletRequest pRequest, HttpServletResponse pResponse
 			,@RequestParam(value="searchStrDate") String searchStrDate
 			,@RequestParam(value="searchEndDate") String searchEndDate
 			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
 			,@RequestParam(value="item[]", required=false) List<String> itemList
 			, ModelMap model) {
 		
 		Map<String, Object> paramMap = new HashMap<String, Object>();
 		List<EgovMap> list;
 		
 		if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
 			itemList.add("6002");
 		}
 		
 		paramMap.put("searchStrDate", searchStrDate);
 		paramMap.put("searchEndDate", searchEndDate);
 		paramMap.put("flowerCtgrList", flowerCtgrList);
 		paramMap.put("itemList", itemList);
 		
 		try{

 			list = haa05_Service.selectTop5(paramMap);
 			model.addAttribute("list", list);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
 	@RequestMapping(value="/haa05/selectHaa00ChartJsonTotal.json")
	public String selectHaa00ChartJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa05_Service.selectHaaChartTotal00(pRequestParamMap);
 			model.addAttribute("list", list);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}

 	/**
 	 * 공판장비중 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00QtyPerJson.json")
	public String selectHaa00QtyPerJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa05_Service.selectHaa00QtyPerJson(pRequestParamMap);

 			model.addAttribute("list", list);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}

 	/**
 	 * 통합공 판장비중 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa05/selectHaa00QtyPerJsonTotal.json")
	public String selectHaa00QtyPerJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa05_Service.selectHaa00QtyPerJsonTotal(pRequestParamMap);

 			model.addAttribute("list", list);
 		} catch (ArithmeticException e) {
			e.printStackTrace();
			log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		} catch (NumberFormatException e) {
			e.printStackTrace();
			log.error("오류발생 숫자로 변환 할 수 없습니다!!");
		} catch (ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			log.error("오류발생 배열인텍스에서 벗어났습니다!!");
		} catch (NegativeArraySizeException e) {
			e.printStackTrace();
			log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
		} catch (NullPointerException e) {
			e.printStackTrace();
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
			log.error("오류발생!!");
		}

 		return "jsonView";
	}


}
