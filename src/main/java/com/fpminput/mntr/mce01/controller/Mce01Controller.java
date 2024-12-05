package com.fpminput.mntr.mce01.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.mce01.service.Mce01Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Mce01Controller extends BaseController{
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Mce01Service mce01Service;
	

	// 게시판관리 행사일정관리 페이지이동
	@RequestMapping("/mce01/mce01.do")
	public String cnsmpTrendInput(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mce01/mce01.do==============");
	
		Calendar cal = Calendar.getInstance();
		model.addAttribute("nowYear", cal.get(Calendar.YEAR) );
		String mon = (cal.get(Calendar.MONTH)+1)+"";
		if(mon.length() == 1) mon = "0" +mon;
	 	model.addAttribute("nowMon", mon);
	 		
		return "/mce01/eventCalendar";
	}
	
	@RequestMapping("/mntr/mce01/getEventCalendar.json")
	public String getEventCalendar(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws JsonGenerationException, JsonMappingException, IOException{
		log.info("==========kpiInputProc============="+pRequestParamMap.toString());
		
		// 데이터 조회
		List<Map<String, String>> resultList = mce01Service.selectEventCalendarList(pRequestParamMap);
		//ObjectMapper mapper = new ObjectMapper();
		//String result = mapper.writeValueAsString(resultList);
		
		/*JSONArray jArray = new JSONArray();//배열이 필요할때
		
		for (int i = 0; i < resultList.size(); i++)//배열
		{
			JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
			sObject.put("EVENT_SEQ", resultList.get(i).get("EVENT_SEQ"));
			
			sObject.put("EVENT_TYPE", resultList.get(i).get("EVENT_TYPE"));
			sObject.put("REMARKS", resultList.get(i).get("REMARKS"));
			sObject.put("color", resultList.get(i).get("color"));
			sObject.put("end", resultList.get(i).get("end"));
			sObject.put("start", resultList.get(i).get("start"));
			sObject.put("title", resultList.get(i).get("title"));
			
			jArray.add(sObject);
		}
		
		model.addAttribute("list", jArray.toJSONString());		*/
		model.addAttribute("resultList",resultList );
		return "jsonView";
	}
	
	// 게시판관리 행상일정관리 등록처리
	// 1:등록완료, 2:오류 
	@RequestMapping("/mntr/mce01/inputEventProc.json")
	public String inputEventProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========/mntr/mce01/inputEventProc.json============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "2");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		
		try{
			// 데이터 등록
			mce01Service.inputEventProc(pRequestParamMap);
			resultMap.put("stat", "1");
			resultMap.put("message", "등록 되었습니다.");
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
		
		model.addAttribute("result",resultMap );
		return "jsonView";
	}

	// 게시판관리 행사일정관리 수정폼 호출
	@RequestMapping("/mntr/mce01/updateEventForm.do")
	public String updateEventForm(	HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mntr/mce01/updateEventForm.do==============");
		
		// 상세 내용 조회
		Map<String, String> detail = mce01Service.selectEventDetail(pRequestParamMap);
		model.addAttribute("detail", detail);
		
		return "/mce01/updateEventInput";
	}
	
	// 게시판관리 행사일정관리 수정처리
	// 1:수정완료, 2:오류 
	@RequestMapping("/mntr/mce01/updateEventProc.json")
	public String updateEventProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========/mntr/mce01/updateEventProc.json============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "2");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		try{
			// 이벤트 수정
			mce01Service.updateEventProc(pRequestParamMap);
			resultMap.put("stat", "1");
			resultMap.put("message", "수정 되었습니다.");
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
		
		model.addAttribute("result",resultMap );
		return "jsonView";
	}
	
	// 게시판관리 행사일정관리 행사삭제처리
	// 1:삭제완료, 2:오류 
	@RequestMapping("/mntr/mce01/deleteEventProc.json")
	public String deleteEventProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========/mntr/mce01/deleteEventProc.json============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "2");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		try{
			// 이벤트 삭제
			mce01Service.deleteEventProc(pRequestParamMap);
			resultMap.put("stat", "1");
			resultMap.put("message", "삭제 되었습니다.");
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
		
		model.addAttribute("result",resultMap );
		return "jsonView";
	}
	
	
	
	
}
