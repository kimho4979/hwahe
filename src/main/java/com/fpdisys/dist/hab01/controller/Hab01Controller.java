package com.fpdisys.dist.hab01.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.WoorimUtil;
import com.fpdisys.base.util.WoorimUtil.DATEPATTERN;
import com.fpdisys.dist.hab01.domain.Hab01VO;
import com.fpdisys.dist.hab01.service.Hab01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @Class Name : Hab01Controller.java
 * @Description : Hab01Controller Class
 *	 
 * @로그인  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.08.18			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Controller
public class Hab01Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hab01Service hab01Service;
	
	/**
	 * 품종별 종합 경매정보  
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab01/hab01.do")
	public String selectHab01(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "redirect:/real/real2.do";
		/*
		if(pRequestParamMap.get("searchRegDtStart")!= null){
			String searchRegDtStart =pRequestParamMap.get("searchRegDtStart").toString();
			searchRegDtStart= searchRegDtStart.replaceAll("-",""); 
			log.info(">>>> :searchRegDtStart"+ searchRegDtStart); 
			
			pRequestParamMap.put("searchRegDtStart", searchRegDtStart);
		}
		 	
		Map<String, Object> resultMap = new HashMap<String, Object>();
		  
		try{
			//화훼 구분 셋팅 
			String searchProductGubun ="";
			if(pRequestParamMap.get("searchProductGubun")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchProductGubun").toString())){
				searchProductGubun =pRequestParamMap.get("searchProductGubun").toString();
				pRequestParamMap.put("searchProductGubun", searchProductGubun);
			}else{
				searchProductGubun ="1";
				pRequestParamMap.put("searchProductGubun", searchProductGubun);
			}
			model.addAttribute("searchProductGubun", searchProductGubun);
	 		  
	 		// 공판장 셋팅 
			String cmpCd ="0000000001";
			if(pRequestParamMap.get("searchCmpCd")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchCmpCd").toString())){
				cmpCd = pRequestParamMap.get("searchCmpCd").toString();
			}
			pRequestParamMap.put("searchCmpCd", cmpCd);
			model.addAttribute("searchCmpCd", cmpCd);
	 			
	 		// 날짜 셋팅 
			String searchSaleDate = WoorimUtil.convertDateToString(new Date(),DATEPATTERN.YearToDay);
			if(pRequestParamMap.get("searchSaleDate")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchSaleDate").toString())){
				searchSaleDate  = pRequestParamMap.get("searchSaleDate").toString();
			}				
			pRequestParamMap.put("searchSaleDate", searchSaleDate);
			model.addAttribute("searchSaleDate", searchSaleDate);
			String [] date = searchSaleDate.split("-"); 
	 		
			model.addAttribute("searchYear", date[0]);
			model.addAttribute("searchMonth", date[1]);
			model.addAttribute("searchDate", date[2]);
				
			log.debug("searchSaleMonth length"+searchSaleDate.length());
			log.debug("searchSaleMonth substr(0,4)"+date[0]);
			log.debug("searchSaleMonth substr(5,2)"+date[1]);
			log.debug("searchSaleMonth substr(5,2)"+date[2]);
			
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
		return "/auction/Hab01";

		 */
	}
	
	/** 품종별 종합경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	
 	@RequestMapping(value="/hab01/selectHab01Json.json")
	public String selectHab01Json(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 			 
 		try{
 			List<EgovMap> list = hab01Service.selectHab01(pRequestParamMap);
 			
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
 	 * 등급정보 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 	
 	@RequestMapping(value="/hab01/selectHab01LvJson.json")
	public String selectHab01LvJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 		try{
 			
 			List<EgovMap> list =null;
 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
 				list = hab01Service.selectHabLv01(pRequestParamMap);
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
 	 * 등급정보 호출 
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */ 	
 	@RequestMapping(value="/hab01/selectHab01LvCntJson.json")
	public String selectHab01LvCntJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 		try{
 			
 			List<EgovMap> list =null;
 			String lvCnt = "0";
 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
 				lvCnt = hab01Service.selectHabLv01Cnt(pRequestParamMap);
 			}
 			model.addAttribute("lvCnt",lvCnt);
 			
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
 	
 	
 	@RequestMapping(value="/hab01/selectHab01InfoJson.json")
	public String selectHab01InfoJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		
 		log.info("====== Hab01InfoJSON ======");
 		
 		try{
 			List<EgovMap> list = (List<EgovMap>)hab01Service.selectHabInfo01(pRequestParamMap);
 			
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
 	
 	@RequestMapping(value="/hab01/selectHab01ChartJson.json")
	public String selectHab01ChartJson( HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 		
 		try{
 			List<Hab01VO> list = (List<Hab01VO>)hab01Service.selectHabChart01(pRequestParamMap);
 			
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
 	 * 경매일자 가져오기 (selectBox용)
 	 * @param pRequest
 	 * @param pResponse
 	 * @param session
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	 @RequestMapping(value="/hab01/selectGetSaleDate.json")
		public String selectGetSaleDate(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	/*  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} */
	  
	  		log.info("========================"+pRequestParamMap.toString());
	  /*	if(pRequestParamMap.get("serchRegDtEnd")!= null){
		String serchRegDtEnd =pRequestParamMap.get("serchRegDtEnd").toString();
		serchRegDtEnd= serchRegDtEnd.replaceAll("-",""); 
		log.info(">>>> :serchRegDtEnd"+ serchRegDtEnd); 
		pRequestParamMap.put("serchRegDtEnd", serchRegDtEnd);
	 }*/
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<Hab01VO> resultList  =  (List<Hab01VO>)hab01Service.selectGetSaleDate(pRequestParamMap);				
				
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
 	 
 	@RequestMapping(value="/hab01/selectGetSaleDate_bak.json")
	public String selectGetSaleDateBak(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{		 						
/*  if(pRequestParamMap.get("item_cd")!=null){
			session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
		} */
  
  		log.info("========================"+pRequestParamMap.toString());
  /*	if(pRequestParamMap.get("serchRegDtEnd")!= null){
	String serchRegDtEnd =pRequestParamMap.get("serchRegDtEnd").toString();
	serchRegDtEnd= serchRegDtEnd.replaceAll("-",""); 
	log.info(">>>> :serchRegDtEnd"+ serchRegDtEnd); 
	pRequestParamMap.put("serchRegDtEnd", serchRegDtEnd);
 }*/
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<Hab01VO> resultList  =  (List<Hab01VO>)hab01Service.selectGetSaleDate(pRequestParamMap);				
			
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
 	 * 정산데이터 테스트
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/hab01/selectTestData.json")
	public String selectTestData(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
	 
 		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<?> resultList  =  (List<?>)hab01Service.selectTestData(pRequestParamMap);				
			
			model.addAttribute("list", resultList);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return "jsonView";
	}	
 	
}
