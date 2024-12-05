package com.fpminput.mntr.mda01.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.mvc.PageableTO;
import com.fpminput.mntr.mda01.service.Mda01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mda01Controller extends BaseController{
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Mda01Service mda01Service;
	
	// 정보산정보관리 계량/비게량 설정
	@RequestMapping("/mda01/mda01.do")
	public String cnsmpTrendInput(	HttpServletRequest pRequest, HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/mda01/mda01.do==============");
	
		return "/mda01/kpiInput";
	}
	
	// 정보산정보관리 계량/비게량 설정 그리드 데이터 조회
	@RequestMapping("/mntr/mda01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("==========gridListgridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		PageableTO pageTo = new PageableTO();
		int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
		int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
		pageTo.setCurrentPage(currentPage);
		pageTo.setPageSize(pageSize);
		
		
		try{
			List<EgovMap> resultList = (List<EgovMap>)mda01Service.selectkpiList(pRequestParamMap);
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
	
	// 정보산정보관리 계량/비게량 등록 처리
	// 1: 등록불가(기간겹침), 2:등록완료, 3:오류 
	@RequestMapping("/mntr/mda01/kpiInputProc.json")
	public String kpiInputProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========kpiInputProc============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "3");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		
		// 생산정보선택항목 데이터 핸들링
		String productType = String.valueOf(pRequestParamMap.get("productType"));
		if(productType != null && !"".equals(productType)){
			if(productType.indexOf("1") >= 0) pRequestParamMap.put("typeShipmntEx", "Y");
			if(productType.indexOf("2") >= 0) pRequestParamMap.put("typeShipmnt", "Y");
			if(productType.indexOf("3") >= 0) pRequestParamMap.put("typeCrop", "Y");
			if(productType.indexOf("4") >= 0) pRequestParamMap.put("typeCult", "Y");
			if(productType.indexOf("5") >= 0) pRequestParamMap.put("typeConsTrend", "Y");
			if(productType.indexOf("6") >= 0) pRequestParamMap.put("typeConsPrice", "Y");
		}
		
		// 등록전 기간겹침 체크
		int beforeChk = mda01Service.checkInsertBefore(pRequestParamMap);
		if(beforeChk > 0){
			resultMap.put("stat", "1");
			resultMap.put("message", "기간이 중복됩니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		
		try{
			// 데이터 등록
			mda01Service.insertKpiInput(pRequestParamMap);
			resultMap.put("stat", "2");
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
	
	//  정보산정보관리 계량/비게량 삭제 처리
	// 1: 삭제완료, 2:오류 
	@RequestMapping("/mntr/mda01/deleteKpiInput.json")
	public String deleteKpiInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========deleteKpiInput============="+pRequestParamMap.toString());
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
			mda01Service.deleteKpiInput(pRequestParamMap);
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
	
	// 정보산정보관리 계량/비게량 수정페이지 호출
	@RequestMapping("/mntr/mda01/updateKpiInput.do")
	public String updateKpiInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========updateKpiInput============="+pRequestParamMap.toString());
	
		// 상세 내용 조회
		Map<String,String> detail = mda01Service.detailKpiInput(pRequestParamMap);
		model.addAttribute("detail",detail );
		
		return "/mda01/updateKpiInput";
	}	
	
	
	// 정보산정보관리 계량/비게량 수정 처리
	// 1: 수정불가(기간겹침), 2:수정완료, 3:오류 
	@RequestMapping("/mntr/mda01/kpiUpdateProc.json")
	public String kpiUpdateProc(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		log.info("==========kpiUpdateProc============="+pRequestParamMap.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		HttpSession httpSession = pRequest.getSession();
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			resultMap.put("stat", "3");
			resultMap.put("message", "로그인시에만 사용 할 수 있습니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		pRequestParamMap.put("SESSION_USER_ID", httpSession.getAttribute("SESSION_USER_ID"));
		
		
		// 생산정보선택항목 데이터 핸들링
		String productType = String.valueOf(pRequestParamMap.get("productType"));
		if(productType != null && !"".equals(productType)){
			if(productType.indexOf("1") >= 0) pRequestParamMap.put("typeShipmntEx", "Y");
			if(productType.indexOf("2") >= 0) pRequestParamMap.put("typeShipmnt", "Y");
			if(productType.indexOf("3") >= 0) pRequestParamMap.put("typeCrop", "Y");
			if(productType.indexOf("4") >= 0) pRequestParamMap.put("typeCult", "Y");
			if(productType.indexOf("5") >= 0) pRequestParamMap.put("typeConsTrend", "Y");
			if(productType.indexOf("6") >= 0) pRequestParamMap.put("typeConsPrice", "Y");
		}
		
		// 등록전 기간겹침 체크
		int beforeChk = mda01Service.checkInsertBefore(pRequestParamMap);
		if(beforeChk > 0){
			resultMap.put("stat", "1");
			resultMap.put("message", "기간이 중복됩니다.");
			model.addAttribute("result",resultMap );
			return "jsonView";
		}
		
		try{
			// 데이터 수정
			mda01Service.updateKpiInput(pRequestParamMap);
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
	
	// 정보산정보관리 계량/비게량 설정 변경이력 조회
	@RequestMapping("/mntr/mda01/kpiLogView.do")
	public String KpiLogView( HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========/KpiLogView.do==============");
	
		return "/mda01/kpiLogView";
	}
		
		
	
	// 정보산정보관리 계량/비게량 설정 변경이력 데이터 출력
	@RequestMapping("/mntr/mda01/gridList2.json")
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
			List<EgovMap> resultList = (List<EgovMap>)mda01Service.selectKpiLogList(pRequestParamMap);
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
