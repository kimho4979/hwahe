package com.fpdisys.dist.hab08.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.fpdisys.dist.hab08.domain.Hab08VO;
import com.fpdisys.dist.hab08.service.Hab08Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


/**
 * @Class Name : Hab08Controller.java
 * @Description : 공판장별 거래현황
 *	 
 * @로그인  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2020.03.05              최성호	최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */

@Controller
public class Hab08Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hab08Service hab08Service;
	
	/**
	 * 공판장별 거래현황  
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab08/hab08.do")
	public String selectHab08(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
				
		try{
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
		return "/auction/Hab08";
	}
	
	
	/**
	 * 물량비중 차트
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab08/hab08Chart1.json")
    public String hab08Chart1(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)hab08Service.hab08Chart1(pRequestParamMap);
			
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
	 * 일자별 평균단가 차트
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab08/hab08Chart2.json")
    public String hab08Chart2(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)hab08Service.hab08Chart2(pRequestParamMap);
			
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
	 * 일자별 품종
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab08/hab08Button.json")
    public String hab08Button(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)hab08Service.hab08Button(pRequestParamMap);
			
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
