package com.fpdisys.dist.hca01.controller;

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
import com.fpdisys.base.util.JsonUtils;
import com.fpdisys.dist.hca01.domain.Hca01VO;
import com.fpdisys.dist.hca01.service.Hca01Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Hca01Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Hca01Service hca01Service;
	
	
	 @RequestMapping(value="/hca01/hca01.do")
	 public String selectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			 , @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  					  							 			
			
		 try{			 	
			 // 월 셋팅 
				String regMonth="";
				if(pRequestParamMap.get("datepicker")!=null && !StringUtils.isBlank(pRequestParamMap.get("datepicker").toString())){
					regMonth = pRequestParamMap.get("datepicker").toString();
				}else{
					regMonth = hca01Service.selectFastDay();
				}
				model.addAttribute("regMonth", regMonth);
				
				pRequestParamMap.put("REG_MONTH", regMonth);
				pRequestParamMap.put("GUBN", "2");
				List<Hca01VO> selectTop = hca01Service.selectTop(pRequestParamMap);	
				
				pRequestParamMap.put("REG_MONTH", regMonth);
				pRequestParamMap.put("GUBN", "1");
				List<Hca01VO> selectBottom  = hca01Service.selectTop(pRequestParamMap);				
				
				String jsonList =  JsonUtils.toJson(selectTop);
				String jsonList2 =  JsonUtils.toJson(selectBottom);
								
				model.addAttribute("selectTop", selectTop);
				model.addAttribute("selectBottom", selectBottom);
				
				model.addAttribute("list", jsonList);
				model.addAttribute("list2", jsonList2);
			
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
		 
	 	 return "/auction/Hca01";
	 			 
	 }
	 
	 
	 @RequestMapping(value="/hca01/selectMainChulChart.json")
		public String selectMainChulChart(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			 		
			try{
				List<Hca01VO> list = (List<Hca01VO>)hca01Service.selectMainChulChart(pRequestParamMap);
				
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
