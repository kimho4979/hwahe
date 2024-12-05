package com.fpminput.mntr.mcd02.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.FileUtils;
import com.fpminput.base.util.CommonUtils;
import com.fpminput.mntr.mcd02.domain.Mcd02VO;
import com.fpminput.mntr.mcd02.service.Mcd02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mcd02Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	Mcd02Service mcd02Service;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	// 화면 open
	@RequestMapping(value="/mcd02/mcd02.do")
	public String SelectEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/mcd02/mcd02";
	}
	
	// 팝업 open
	@RequestMapping(value="/mcd02/mcd02_popup.do")
	public String mcd02_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mcd02/mcd02.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
			
		
		return "/mcd02/mcd02_popup";
			
	}
	
	// 팝업 시 공통코드 조회
	@RequestMapping(value="/mntr/mcd02/selectAreaNm.json")
	public String selectAreaNm(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		List<EgovMap> resultList;
		
		try{
			resultList = mcd02Service.selectAreaNm(pRequestParamMap);
			model.addAttribute("list",resultList);
			
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
		
	
	// 조회
	@RequestMapping(value="/mntr/mcd02/gridList.json")
	public String selectGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session,@RequestParam(value="searchDate") String searchDate, ModelMap model){		 						
  		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;

		pRequestParamMap.put("searchDate", searchDate);	// 기준년월
		
		try{
			resultList = mcd02Service.selectGridList(pRequestParamMap);
			model.addAttribute("list",resultList);
			
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
	
	// 팝업 행사일정 등록
	@RequestMapping(value="/mntr/mcd02/insertEventSch.json")
	public String insertEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){	
		try {
			mcd02Service.insertEventSch(pRequestParamMap);
			
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
	
	// 삭제
	@RequestMapping(value="/mntr/mcd02/deleteEventSch.json")
	public String deleteEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		String gridResult = pRequestParamMap.toString();

		log.info("gridResult:++++======"+gridResult);
		log.info("gridResult:++++======"+gridResult.length());
	  
		String s2 = gridResult.replace("{","");
		String s3 = s2.replace("}","");
		String s4 = s3.replace("=","");
	  
		log.info("s2 gridResult:++++======"+s2);
		log.info("s3 gridResult:++++======"+s3);
		log.info("s4 gridResult:++++======"+s4);
	 
		String[] result = s4.split("!");
	 
		log.info("result length:++++======"+result.length);		 		
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		String S1 ="";
		String S2 ="";
		String S3 ="";
		String S4 ="";
		String S5 ="";
		String S6 ="";
		String S7 ="";
				
		try{
			for( int i = 0; i < result.length; i++ ){
				String R1= result[i];
				String[] R2= R1.split(",");
				log.info("R2 length++++++++++++"+R2.length);
				
				for(int j = 0; j < R2.length; j++){
					if(j == 0){
						S1=R2[0];
					}
					if(j == 1){
						S2=R2[1];
					}
					if(j == 2){
						S3=R2[2];
					}
					if(j == 3){
						S4=R2[3];
					}
					if(j == 4){
						S5=R2[4];
					}
					if(j == 4){
						S6=R2[5];
					}
					if(j == 4){
						S7=R2[6];
					}
				}
					log.info("S1 gridResult:++++======"+S1);
					log.info("S2 gridResult:++++======"+S2);
					log.info("S3 gridResult:++++======"+S3);
					log.info("S4 gridResult:++++======"+S4);
					log.info("S5 gridResult:++++======"+S5);
					log.info("S6 gridResult:++++======"+S6);
					log.info("S7 gridResult:++++======"+S7);
					
					pRequestParamMap.put("eventGp",S1);
					pRequestParamMap.put("eventNm",S2);	 
					pRequestParamMap.put("eventYmd",S3);	
					pRequestParamMap.put("eventTim",S4);
					pRequestParamMap.put("siNm",S5);
					pRequestParamMap.put("addr",S6);
					pRequestParamMap.put("eventPls",S7);
					
					mcd02Service.deleteEventSch(pRequestParamMap);
			};
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
	
	// 팝업 수정
	
	@RequestMapping(value="/mntr/mcd02/updateEventSch.json")
	public String updateEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		try {
			mcd02Service.updateEventSch(pRequestParamMap);
			
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
