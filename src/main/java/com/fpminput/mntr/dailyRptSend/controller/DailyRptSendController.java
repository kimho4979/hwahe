package com.fpminput.mntr.dailyRptSend.controller;

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
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;
import com.fpminput.mntr.dailyRptSend.service.DailyRptSendService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class DailyRptSendController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	DailyRptSendService dailyRptSendService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	//private static final String filePath = "D:\\work\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	// 화면 open
	@RequestMapping(value="/dailyRptSend/dailyRptSend.do")
	public String SelectEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/dailyRptSend/dailyRptSend";
	}
	
	// 팝업 open
	@RequestMapping(value="/dailyRptSend/dailyRptSend_popup.do")
	public String mcd02_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/dailyRptSend/dailyRptSend.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
			
		
		return "/dailyRptSend/dailyRptSend_popup";
			
	}
	
	// 조회
	@RequestMapping(value="/mntr/dailyRptSend/gridList.json")
	public String selectGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session
			,@RequestParam(value="searchNm") String searchNm
			, ModelMap model){		 						
  		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;

		pRequestParamMap.put("searchNm", searchNm);
		
		try{
			resultList = dailyRptSendService.selectGridList(pRequestParamMap);
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
		
	// 팝업 조회
	@RequestMapping(value="/mntr/dailyRptSend/selectDailtRptSendPopup.json")
	public String selectDailtRptSendPopup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session
			,@RequestParam(value="emailAdrs") String emailAdrs
			, ModelMap model){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;

		pRequestParamMap.put("emailAdrs", emailAdrs);
		
		try{
			resultList = dailyRptSendService.selectDailtRptSendPopup(pRequestParamMap);
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
	// 팝업 일일보고자료 발송 등록
	@RequestMapping(value="/mntr/dailyRptSend/insertDailtRptSend.json")
	public String insertDailtRptSend(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){	
		try {
			dailyRptSendService.insertDailtRptSend(pRequestParamMap);
			
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
	@RequestMapping(value="/mntr/dailyRptSend/deleteDailtRptSend.json")
	public String deleteDailtRptSend(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
				
		try{
			for( int i = 0; i < result.length; i++ ){
				String R1= result[i];
				String[] R2= R1.split(",");
				log.info("R2 length++++++++++++"+R2.length);
				
				for(int j = 0; j < R2.length; j++){
					if(j == 0){
						S1=R2[0];
					}
				}
					log.info("S1 gridResult:++++======"+S1);
					
					pRequestParamMap.put("emailAdrs",S1);
					
					dailyRptSendService.deleteDailtRptSend(pRequestParamMap);
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
	
	// 수정	
	@RequestMapping(value="/mntr/dailyRptSend/updateDailtRptSend.json")
	public String updateDailtRptSend(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		try {
			dailyRptSendService.updateDailtRptSend(pRequestParamMap);
			
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
