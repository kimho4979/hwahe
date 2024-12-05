package com.fpdisys.dist.hab02.controller;

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
import com.fpdisys.dist.hab02.domain.Hab02VO;
import com.fpdisys.dist.hab02.service.Hab02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Hab02Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hab02Service hab02Service;
	
	/**
	 * 월별 품종별 종합 경매정보  
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value="/hab02/hab02.do")
	public String selectHab02(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		return "/auction/Hab02";
	}
	
	
	/** 월별 경매정보-품종별 종합경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/hab02/selectHab02Json.json")
 	public String selectHab02Json(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		try{
	 		List<EgovMap> list = (List<EgovMap>)hab02Service.selectHab02(pRequestParamMap);
	 		
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
		}  catch (Exception e) {
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
 	@RequestMapping(value="/hab02/selectHab02LvJson.json")
	public String selectHab02LvJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 		
 		try{
 			List<EgovMap> list = (List<EgovMap>)hab02Service.selectHabLv02(pRequestParamMap);
 			
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
		}  catch (Exception e) {
			log.error(e.getMessage());
		}
 		return "jsonView";
	}
 	
 @RequestMapping(value="/hab02/selectHab02ChartJson.json")
 public String selectHab02ChartJson( HttpServletRequest pRequest, HttpServletResponse pResponse
		 , @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
	 
	 log.info("======== selectHab02ChartJson ========");
	 
	 try{
		 List<Hab02VO> list = (List<Hab02VO>)hab02Service.selectHabChart02(pRequestParamMap);
		 
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
