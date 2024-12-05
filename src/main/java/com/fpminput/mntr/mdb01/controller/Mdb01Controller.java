package com.fpminput.mntr.mdb01.controller;

import java.util.HashMap;
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
import com.fpdisys.base.mvc.PageableTO;
import com.fpminput.mntr.mdb01.service.Mdb01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mdb01Controller extends BaseController{
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Mdb01Service mdb01Service;
	
	// 정산정보관리 모니터요원 관리 페이지 이동
	@RequestMapping("/mdb01/mdb01.do")
	public String cnsmpTrendInput(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mdb01/mdb01.do==============");
	
		
		return "/mdb01/userInput";
	}

	// 정산정보관리 모니터요원 목록 조회
	@RequestMapping("/mntr/mdb01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========gridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PageableTO pageTo = new PageableTO();
		int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
		int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
		pageTo.setCurrentPage(currentPage);
		pageTo.setPageSize(pageSize);
		
		
		try{
			List<EgovMap> resultList = (List<EgovMap>)mdb01Service.selectUserList(pRequestParamMap);
			model.addAttribute("list", resultList);
			
			int total = 0;
			if(resultList != null && resultList.size() > 0){
				Map<String, String> result = (Map<String, String>)resultList.get(0);
				if(result.get("TOTAL_COUNT") != null){
					total= Integer.parseInt((String)result.get("TOTAL_COUNT"));
				}
			}
			log.info("pageNo : " + currentPage);
			Long totalLong = Long.parseLong(resultList.size()+"");
			pageTo.setTotalElements(totalLong);
			int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			pageTo.setTotalPages(totalPage);
			
			model.addAttribute("page",pageTo );
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
	
	
	// 정산정보관리 모니터요원 등록
	// 1:아이디 중복, 2: 정상등록
	@RequestMapping("/mntr/mdb01/UserInputProc.json")
	public String UserInputProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========UserInputProc============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "3");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		// 등록전 아이디 체크 
		int beforeChk = mdb01Service.checkUserId(pRequestParamMap);
		if(beforeChk > 0){
			resultMap.put("stat", "1");
			resultMap.put("message", "기간이 중복됩니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		
		
		try{
			// 모니터요원 등록
			mdb01Service.insertUserInput(pRequestParamMap);
			resultMap.put("stat", "2");
			resultMap.put("message", "등록 되었습니다.");
			log.error("오류발생 메서드를 찾을수 없습니다!!");
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
	
	// 정산정보관리 모니터요원 수정 form 호출
	@RequestMapping("/mntr/mdb01/updateUserInput.do")
	public String updateUserInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========updateUserInput============="+pRequestParamMap.toString());
	
		// 상세 내용 조회
		Map<String,String> detail = mdb01Service.detailUserInput(pRequestParamMap);
		model.addAttribute("detail",detail );
		
		return "/mdb01/updateUserInput";
	}	
	
	
	// 정산정보관리 모니터요원 수정 처리
	// 2: 정상등록, 3:오류
	@RequestMapping("/mntr/mdb01/UserUpdateProc.json")
	public String UserUpdateProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========UserUpdateProc============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "3");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		try{
			// 모니터요원 수정
			mdb01Service.updateUserInput(pRequestParamMap);
			resultMap.put("stat", "2");
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
	
	// 정산정보관리 모니터요원 삭제 처리
	@RequestMapping("/mntr/mdb01/deleteUserInput.json")
	// 1: 삭제완료, 2:오류 
	public String deleteUserInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========deleteUserInput============="+pRequestParamMap.toString());
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
			// 데이터 삭제
			mdb01Service.deleteUserInput(pRequestParamMap);
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
	
	
	// 정보산정보관리 모니터요원 사용자정보 변경이력 모달 오픈
	@RequestMapping("/mntr/mda01/userInfoLogView.do")
	public String userInfoLogView( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/userInfoLogView.do==============");
	
		return "/mdb01/userInfoLogView";
	}
	
	// 정산정보관리 모니터요원 사용자정보 변경이력 조회
	@RequestMapping("/mntr/mdb01/gridList2.json")
	public String gridList2(HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========gridList2============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PageableTO pageTo = new PageableTO();
		int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
		int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
		pageTo.setCurrentPage(currentPage);
		pageTo.setPageSize(pageSize);
		
		
		try{
			List<EgovMap> resultList = (List<EgovMap>)mdb01Service.selectUserInfoLogList(pRequestParamMap);
			model.addAttribute("list", resultList);
			
			int total = 0;
			if(resultList != null && resultList.size() > 0){
				Map<String, String> result = (Map<String, String>)resultList.get(0);
				if(result.get("TOTAL_COUNT") != null){
					total= Integer.parseInt((String)result.get("TOTAL_COUNT"));
				}
			}
			log.info("pageNo : " + currentPage);
			Long totalLong = Long.parseLong(resultList.size()+"");
			pageTo.setTotalElements(totalLong);
			int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			pageTo.setTotalPages(totalPage);
			
			model.addAttribute("page",pageTo );
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
