package com.fpdisys.dist.hab07.controller;

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
import com.fpdisys.dist.hab07.domain.Hab07VO;
import com.fpdisys.dist.hab07.service.Hab07Service;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class Hab07Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hab07Service hab07Service;
	
	@RequestMapping(value="/hab07/hab07.do")
	public String selectHab07(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		 
		return "/auction/Hab07";
	}
	
	@RequestMapping(value="/hab07/selectHab07Json.json")
	public String selectHab07Json(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		try{
			List<Hab07VO> list = (List<Hab07VO>)hab07Service.selectHab07(pRequestParamMap);
			
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
}