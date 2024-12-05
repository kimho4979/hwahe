package com.fpminput.mntr.mdc01.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpminput.mntr.login.service.LoginMntService;
import com.fpminput.mntr.mdc01.srevice.Mdc01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Mdc01Controller extends BaseController{
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Mdc01Service mdc01Service;
	
	@Autowired
	LoginMntService  loginService;
	
	@Autowired
	CustomInfoService custionInfoService;
	
	
	// 정산정보관리 정산내역 페이지 이동
	@RequestMapping("/mdc01/mdc01.do")
	public String cnsmpTrendInput(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mdc01/mdc01.do==============");
	
		Calendar cal = Calendar.getInstance();
		model.addAttribute("nowYear", cal.get(Calendar.YEAR) );
		String mon = (cal.get(Calendar.MONTH)+1)+"";
		if(mon.length() == 1) mon = "0" +mon;
	 	model.addAttribute("nowMon", mon);
	 		
		return "/mdc01/calculateInfo";
	}
	
	
	// 정산정보관리 정산내역 목록 조회
	@RequestMapping("/mntr/mdc01/gridList.json")
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
			List<EgovMap> resultList = (List<EgovMap>)mdc01Service.selectMdc01List(pRequestParamMap);
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
	
	
	// 정산정보관리 정산내역 프린트
	@RequestMapping("/mntr/mdc01/print.do")
	public String print( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mntr/mdc01/print.do==============");
		
		Calendar cal = Calendar.getInstance();
		model.addAttribute("nowYear", cal.get(Calendar.YEAR) );
		String mon = (cal.get(Calendar.MONTH)+1)+"";
		if(mon.length() == 1) mon = "0" +mon;
	 	model.addAttribute("nowMon", mon);
	 	
	 	model.addAttribute("searchFrm", pRequestParamMap);
	 	
	 	List<EgovMap> resultList = (List<EgovMap>)mdc01Service.selectMdc01FullList(pRequestParamMap);
		model.addAttribute("list", resultList);
	 		
		return "/mdc01/calculatePrintPopup";
	}

	// 정산정보관리 정산내역 프린트용 데이터 조회
	@RequestMapping("/mntr/mdc01/gridFullList.json")
	public String gridFullList(HttpServletRequest pRequest, HttpServletResponse pResponse,
				HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========gridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList = (List<EgovMap>)mdc01Service.selectMdc01FullList(pRequestParamMap);
			model.addAttribute("list", resultList);
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
	
	
	// 정산정보관리 정산내역 상세 모달 팝업
	@RequestMapping("/mntr/mdc01/calculateInfo.do")
	public String calculateInfo( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mntr/mdc01/calculateInfo.do==============");
		
		// 사용자 정보 조회
		Map<String, String> userInfo  = (Map<String, String>)mdc01Service.selectUserInfo(pRequestParamMap); 
		model.addAttribute("userInfo", userInfo);
		
		model.addAttribute("searchYear", String.valueOf(pRequestParamMap.get("searchYear")));
		model.addAttribute("searchMonth", String.valueOf(pRequestParamMap.get("searchMonth")));
	 	
		return "/mdc01/calculateModal";
	}
	
	// 정산정보관리 정산내역 특정유저의 정산 목록 조회
	@RequestMapping("/mntr/mdc01/getDataTable.do")
	public String gridList2(HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========/mntr/mdc01/getDataTable.do============="+pRequestParamMap.toString());
  		
		// P: 생산, C: 소비, A:공통
		String monitorType = String.valueOf(pRequestParamMap.get("MONITOR_TYPE"));
		model.addAttribute("monitorType", monitorType);
		
		if(monitorType != null && ( "P".equals(monitorType) || "A".equals(monitorType) ) ){
			List<Map<String, String>> shipmntEx = (List<Map<String, String>>)mdc01Service.mdc01ShipmntExOfUser(pRequestParamMap);
			model.addAttribute("shipmntEx", shipmntEx);	// 출하예정물량
			List<Map<String, String>> shipmnt = (List<Map<String, String>>)mdc01Service.mdc01ShipmntOfUser(pRequestParamMap);
			model.addAttribute("shipmnt", shipmnt);	// 출하물량
		}
		
		if(monitorType != null && "A".equals(monitorType) ){
			List<Map<String, String>> crop = (List<Map<String, String>>)mdc01Service.mdc01TypeCropOfUser(pRequestParamMap);
			model.addAttribute("crop", crop);	// 작황동향
			List<Map<String, String>> cult = (List<Map<String, String>>)mdc01Service.mdc01TypeCultOfUser(pRequestParamMap);
			model.addAttribute("cult", cult);	// 재배동향
		}
		
		if(monitorType != null && "C".equals(monitorType) ){
			List<Map<String, String>> consTrend = (List<Map<String, String>>)mdc01Service.mdc01TypeConsTrendOfUser(pRequestParamMap);
			model.addAttribute("consTrend", consTrend);	// 소비동향
			List<Map<String, String>> consPrice = (List<Map<String, String>>)mdc01Service.mdc01TypeConsPriceOfUser(pRequestParamMap);
			model.addAttribute("consPrice", consPrice);	// 소매가격
		}
			
		return "/mdc01/modalDataTable";
	}
	
	// 정산정보관리 화면내 맞춤정보 알림 요청 발송
	@RequestMapping("/mntr/mdc01/sendKakao.json")
	public String sendKakao( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		
		HashMap<String , Object> map = new HashMap<String, Object>();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("dd");
		String day = transFormat.format(new Date());
		
		List result = loginService.selectSso(map);
		
		for(int i=0; i<result.size(); i++){
			sendService("모니터요원 자료입력 ",day, (Map<String, String>) result.get(i));
		}
	
		return "jsonView";
	}
	
	public void sendService(String title,String  day, Map<String, String> resultTemp){
		SimpleDateFormat yearFormat = new SimpleDateFormat("YYYY");
		SimpleDateFormat transFormat = new SimpleDateFormat("MM");
		
		String ssoKey = resultTemp.get("SSO_KEY");
		String mob = resultTemp.get("MOB");
		String monitorType = resultTemp.get("MONITOR_TYPE");
		
		StringBuilder result = new StringBuilder();
		String lineEnter="\r\n";
		
		result.append("화훼유통정보시스템 모니터요원 자료 입력 안내");
		result.append(lineEnter);
		
		String cropInfo = "";
		
		if(monitorType.equals("A")){
			cropInfo="출하물량&출하예정물량&작황동향&재배동향";
		}else if(monitorType.equals("P")){
			cropInfo="출하물량&출하예정물량";
		}else if(monitorType.equals("C")){
			cropInfo="소비동향&소매가격";
		}
		result.append(transFormat.format(new Date())+"월 "+cropInfo+" 자료 입력기간입니다.");
		result.append(lineEnter);
		
		int lastDay = 0;										//마지막 날짜 변수
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(yearFormat.format(new Date())),Integer.parseInt(transFormat.format(new Date()))-1,1);
		lastDay = cal.getActualMaximum(Calendar.DATE);
		
		String endDate="";
		if(monitorType.equals("A")){
			if(Integer.parseInt(day)<10){
				endDate="10";
			}else if(Integer.parseInt(day)<20){
				endDate="20";
			}else if(Integer.parseInt(day)<32){
				endDate=lastDay+"";				
			}
		}else if(monitorType.equals("P")){
			if(Integer.parseInt(day)<10){
				endDate="10";
			}else if(Integer.parseInt(day)<20){
				endDate="20";
			}else if(Integer.parseInt(day)<32){
				endDate=lastDay+"";				
			}
		}else if(monitorType.equals("C")){
			endDate=lastDay+"";
		}
		result.append(transFormat.format(new Date())+"월 "+endDate+"까지 아래 링크에서 자료를 입력하여 주시면 감사하겠습니다.");
		result.append(lineEnter);
		
		result.append("https://flower.at.or.kr/login/loginSso.do?sso="+ssoKey);
		result.append(lineEnter);
		
		result.append("입력해주신 자료는 화훼농가 소득증대와 화훼산업 발전을 위한 소중한 자료로 활용됩니다.");
		result.append(lineEnter);
		
		sendSms(title, mob, result.toString());		
	}
	
	public boolean sendSms(String title, String userId, String content){
		
		HashMap<String , Object> map = new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("msgType", "6");
		map.put("sms", "LMS");
		map.put("template", "bizp_2017081816055910619873794");
		map.put("title", "모니터요원자료입력");
		map.put("subject", content);
			
		int result = custionInfoService.sendKakao(map);
		
		if(result > 0){
			return true;
		}else{
			return false;
		}
		
		
	}

	// 정산정보관리 정산내역 페이지 이동
	@RequestMapping("/mdc01/mdc02.do")
	public String deadLineManage(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		EgovMap result = mdc01Service.deadLineManage(pRequestParamMap);
		model.addAttribute("result", result);
	 		
		return "/mdc01/deadLineManage";
	}
	
	 @RequestMapping(value="/mdc01/updateDeadLineDate.json")
		public String updateDeadLineDate(
	 		HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){
		
		 int result = mdc01Service.updateDeadLineDate(pRequestParamMap);
		 model.addAttribute("result",result);
		 return "jsonView";
	 }
	 
	 @RequestMapping(value="/mdc01/selectDeadLineDate.json")
		public String selectDeadLineDate(
	 		HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){
		
		 EgovMap result = mdc01Service.deadLineManage(pRequestParamMap);
		 model.addAttribute("result", result);
		 return "jsonView";
	 }

	@ResponseBody
	@RequestMapping("/mdc01/test.json")
	public String test(){
		return "{\"result\":\"ok\"}";
	}

}
