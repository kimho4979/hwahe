package com.fpdisys.dist.hga01.controller;

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
import com.fpdisys.dist.hga01.service.Hga01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Hga01Controller extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hga01Service hga01Service;
	
	// 화훼 수출입 동향분석
	@RequestMapping(value = "/hga01/hga01.do")
	public String selectHfc01(HttpServletRequest pRequest,	HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
						
		return "/auction/Hga01";
	}
	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	@RequestMapping(value="/hga01/selectGetDate.json")
	public String selectGetDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga01Service.selectGetDate(pRequestParamMap);
			model.addAttribute("list",list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	// 화훼 수출입 동향분석 :: MAX 일자 가져오기
	@RequestMapping(value="/hga01/selectGetItem.json")
	public String selectGetItem(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga01Service.selectGetItem(pRequestParamMap);
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
	@RequestMapping(value="/hga01/selectTrendAnalysisList.json")
	public String selectTrendAnalysisList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga01Service.selectTrendAnalysisList(pRequestParamMap);
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
}
