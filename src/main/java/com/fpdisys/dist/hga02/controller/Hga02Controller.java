package com.fpdisys.dist.hga02.controller;

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
import com.fpdisys.dist.hga02.service.Hga02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Hga02Controller extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hga02Service hga02Service;
	
	// 기상 동향분석
	@RequestMapping(value = "/hga02/hga02.do")
	public String selectHfc01(HttpServletRequest pRequest,	HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
						
		return "/auction/Hga02";
	}
	
	// 기상 동향분석 :: 시도명 가져오기
	@RequestMapping(value="/hga02/selectGetSido.json")
	public String selectGetSido(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga02Service.selectGetSido(pRequestParamMap);

			if(pRequestParamMap.get("sidoNm")==null||pRequestParamMap.get("sidoNm").equals("")){
				pRequestParamMap.put("sidoNm","서울특별시");				
			}
			List<EgovMap> gugun = hga02Service.selectGetGugun(pRequestParamMap);
			model.addAttribute("list",list);
			model.addAttribute("gugun",gugun);
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
	
	// 기상 동향분석 :: 시도명 가져오기
		@RequestMapping(value="/hga02/selectGetGugun.json")
		public String selectGetGugun(HttpServletRequest pRequest, HttpServletResponse pResponse
				, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){			
			try {
				List<EgovMap> gugun = hga02Service.selectGetGugun(pRequestParamMap);
				model.addAttribute("gugun",gugun);
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
	
	// 기상 동향분석 List
	@RequestMapping(value="/hga02/selectGetItemList.json")
	public String selectGetItemList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga02Service.selectGetItemList(pRequestParamMap);
			List<EgovMap> list1 = hga02Service.selectGetItemListBefore(pRequestParamMap);
			
			model.addAttribute("list",list);
			model.addAttribute("list1",list1);
			
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
