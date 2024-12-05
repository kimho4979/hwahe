package com.fpdisys.dist.api.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.fpdisys.dist.api.domain.ApiViewVO;
import com.fpdisys.dist.api.service.ApiViewService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class ApiViewController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private ApiViewService apiViewService;
	
	// 공공데이터 개방 정보
	@RequestMapping(value="/api/apiOpenInfo.do")
	public String apiOpenInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			 
		
		return "/auction/apiOpenInfo";
	}
	
	// 공공데이터 개방 신청 :: 신청한 공공데이터가 있는 경우
	@RequestMapping(value="/api/apiOpenInfoExsist.do")
	public String apiOpenInfoExsist(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		if(pRequest.getSession().getAttribute("userId")==null){
			pRequest.getSession().invalidate();
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		String pParam = pRequest.getQueryString().toString();
		model.addAttribute("pParam",pParam);
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectExsistList(pRequestParamMap);
			model.addAttribute("dataList", list);
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
		
		 return "/auction/apiOpenInfoExsist";
	}
	
	// 공공데이터 신청 사용자 입력
	@RequestMapping(value="/api/insertApiUser.json")
	public String saveCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		String serviceKey = UUID.randomUUID().toString().toUpperCase().replace("-", "");
		pRequestParamMap.put("serviceKey", serviceKey);
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		try{
			apiViewService.insertApiUser(pRequestParamMap);
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
	
	// 공공데이터 개방 신청
	@RequestMapping(value="/api/apiOpenApply.do")
	public String apiOpenApply(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		
		
		if(pRequest.getSession().getAttribute("userId")==null){
			pRequest.getSession().invalidate();
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectDetailFunctionList(pRequestParamMap);
			model.addAttribute("dataList", list);
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
		
		 return "/auction/apiOpenApply";
	}
	
	// 공공데이터 개방 신청 :: 신청한 공공데이터가 있는 경우
	@RequestMapping(value="/api/apiOpenApplyExsist.do")
	public String apiOpenApplyExsist(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		if(pRequest.getSession().getAttribute("userId")==null){
			pRequest.getSession().invalidate();
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectExsistList(pRequestParamMap);
			model.addAttribute("dataList", list);
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
		
		 return "/auction/apiOpenApplyExsist";
	}
	
	// 공공데이터 개방 신청 자동승인, 활용기간, 트래픽 조회
	@RequestMapping(value="/api/selectSettingList.json")
	public String selectSettingList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<ApiViewVO> list = null;
		
		try{
			list = apiViewService.selectSettingList(pRequestParamMap);
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
	
	// 공공데이터 개방 신청 :: 상세기능 정보
	@RequestMapping(value="/api/selectDetailFunctionList.json")
	public String selectDetailFunctionList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectDetailFunctionList(pRequestParamMap);
			model.addAttribute("datalist", list);
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
	
	// 공공데이터 개방 신청 자동승인, 활용기간, 트래픽 조회
	@RequestMapping(value="/api/insertApiData.json")
	public String insertApiData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		try{
			apiViewService.insertApiData(pRequestParamMap);
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
	
	// 공공데이터 개방 신청 자동승인, 활용기간, 트래픽 조회
	@RequestMapping(value="/api/selectMemberList.json")
	public String selectMemberList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		if(pRequest.getSession().getAttribute("userId")==null||pRequest.getSession().getAttribute("userId").toString().equals("")){
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectMemberList(pRequestParamMap);
			model.addAttribute("list",list);
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
	
	// 공공데이터 개방 신청 :: 존재 유무
	@RequestMapping(value="/api/selectExsistList.json")
	public String selectExsistList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		if(pRequest.getSession().getAttribute("userId")==null||pRequest.getSession().getAttribute("userId").toString().equals("")){
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		List<EgovMap> list = null;
		
		try{
			list = apiViewService.selectExsistList(pRequestParamMap);
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
	
	// 공공데이터 개방 신청 :: 신청 데이터 존재 유무
	@RequestMapping(value="/api/selectExsistApplyList.json")
	public String selectExsistList1(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		if(pRequest.getSession().getAttribute("userId")==null||pRequest.getSession().getAttribute("userId").toString().equals("")){
			model.addAttribute("msg","로그인 후 이용하실 수 있습니다.");
			return "redirect:/customInfo/mainLoginForm.do";
		}
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		List<EgovMap> list = null;
		
		try{
			pRequestParamMap.put("delYnGubn", "1");
			list = apiViewService.selectExsistList(pRequestParamMap);
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
	
	// 공공데이터 개방 재신청 정보 입력
	@RequestMapping(value="/api/updateApiData.json")
	public String updateApiData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		try{
			apiViewService.updateApiData(pRequestParamMap);
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
	
	// 공공데이터 개방 재신청 정보 입력
	@RequestMapping(value="/api/updateApiDataInUser.json")
	public String updateApiDataInUser(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		pRequestParamMap.put("userId", pRequest.getSession().getAttribute("userId").toString());
		
		try{
			apiViewService.updateApiDataInUser(pRequestParamMap);
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
	
	// 공공데이터 개방 정보 setting Data
	@RequestMapping(value="/api/selectDataOpenPageSetting.json")
	public String selectDataOpenPageSetting(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<ApiViewVO> list = null;
		
		try{
			list = apiViewService.selectSettingList(pRequestParamMap);
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