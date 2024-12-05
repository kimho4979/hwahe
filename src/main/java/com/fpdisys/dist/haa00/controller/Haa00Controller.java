package com.fpdisys.dist.haa00.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.fpdisys.dist.haa00.service.Haa00Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class Haa00Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private Haa00Service haa00Service;
	
	
	@RequestMapping(value="/haa00/haa00.do")
	public String selectHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){
				
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

		return "/auction/Haa00";
	}
	
	@RequestMapping(value="/haa00/selectAuctionList.json")
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
			list = haa00Service.selectAuctionDayList(paramMap);
		}else if(type.equals("month")){
			list = haa00Service.selectAuctionMonthList(paramMap);
		}else{
			searchStrDate += "-01";
			searchEndDate += "-12";
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			list = haa00Service.selectAuctionYearList(paramMap);
		}

		
		
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	 }
	
	@RequestMapping(value="/haa00/selectAuctionListTotal.json")
	public String selectAuctionListTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="gubn[]") List<String> gubn
			, ModelMap model) {  
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		
		paramMap.put("flowerCd", flowerCd);
		paramMap.put("cmpCd", cmpCd);
		paramMap.put("itemCd", itemCd);
		paramMap.put("itemCd2", itemCd2);
		paramMap.put("type", type);
		paramMap.put("gubn", gubn);
		paramMap.put("searchStrDate", searchStrDate);
		paramMap.put("searchEndDate", searchEndDate);
	
		list = haa00Service.selectAuctionListTotal(paramMap);

		model.addAttribute("list",list);
		
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
 	@RequestMapping(value="/haa00/selectHaa00LvJson.json")
	public String selectHaa00LvJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap
			, ModelMap model){
 		try{
 			
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
	 			if(type.equals("day")){
	 				list = haa00Service.selectHaaLvDate00(pRequestParamMap);
	 			}else if(type.equals("month")){
	 				list = haa00Service.selectHaaLvMonth00(pRequestParamMap);
	 			}else{
	 				list = haa00Service.selectHaaLvYear00(pRequestParamMap);
	 			}
 			}
 			
 			model.addAttribute("list", list);
 			
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
 	@RequestMapping(value="/haa00/selectHaa00LvJsonTotal.json")
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
 				list = haa00Service.selectHaa00LvTotal(pRequestParamMap);
 			}
 			
 			model.addAttribute("list", list);
 			
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
 	@RequestMapping(value="/haa00/selectHaa00InfoJson.json")
	public String selectHab01InfoJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		log.info("====== Haa00InfoJSON ======");
 		
 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa00Service.selectHaaInfoDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa00Service.selectHaaInfoMonth00(pRequestParamMap);
 			}else{
 				list = haa00Service.selectHaaInfoYear00(pRequestParamMap);
 			}
 			
 			
 			model.addAttribute("list", list);
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
 	 * 통합 거래금액분포도 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 
 	@RequestMapping(value="/haa00/selectHaa00InfoJsonTotal.json")
	public String selectHaa00InfoJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		log.info("====== Haa00InfoJSON ======");
 		
 		try{
 			List<EgovMap> list = haa00Service.selectHaaInfoTotal00(pRequestParamMap);
 			model.addAttribute("list", list);
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
 	 * 거래동향 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 
 	@RequestMapping(value="/haa00/selectHaa00ChartJson.json")
	public String selectHaa00ChartJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa00Service.selectHaaChartDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa00Service.selectHaaChartMonth00(pRequestParamMap);
 			}else{
 				list = haa00Service.selectHaaChartYear00(pRequestParamMap);
 			}
 			
 			
 			model.addAttribute("list", list);
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
 	@RequestMapping(value="/haa00/selectHaa00ChartJsonTotal.json")
	public String selectHaa00ChartJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<EgovMap> list = haa00Service.selectHaaChartTotal00(pRequestParamMap);
 			model.addAttribute("list", list);
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
 	 * 공판장비중 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 
 	@RequestMapping(value="/haa00/selectHaa00QtyPerJson.json")
	public String selectHaa00QtyPerJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<EgovMap> list = haa00Service.selectHaa00QtyPerJson(pRequestParamMap);
 			
 			model.addAttribute("list", list);
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
 	 * 통합공 판장비중 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 
 	@RequestMapping(value="/haa00/selectHaa00QtyPerJsonTotal.json")
	public String selectHaa00QtyPerJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		try{
 			List<EgovMap> list = haa00Service.selectHaa00QtyPerJsonTotal(pRequestParamMap);
 			
 			model.addAttribute("list", list);
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
