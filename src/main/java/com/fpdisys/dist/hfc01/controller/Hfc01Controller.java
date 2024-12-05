package com.fpdisys.dist.hfc01.controller;

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
import com.fpdisys.dist.hfc01.service.Hfc01Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Hfc01Controller extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hfc01Service hfc01Service;
	
	// 열린광장 행사안내 페이지 이동
	@RequestMapping(value = "/hfc01/hfc01.do")
	public String selectHfc01(HttpServletRequest pRequest,	HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
						
		return "/auction/Hfc01";
	}
	
	// 열린광장 행사안내 달력 데이터 조회
	@RequestMapping(value="/hfc01/selectMainList.json")
	public String selectMainList(	HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		// 데이터 조회
		List<Map<String, String>> resultList = hfc01Service.selectEventCalendarList(pRequestParamMap);

		model.addAttribute("resultList",resultList );
		return "jsonView";
	}
	
	
	// 열린광장 행사안내 연별행사 팝업 출력(인쇄도 하나 넣어야함)
	@RequestMapping(value="/hfc01/yearEventModal.do")
	public String yearEventModal(HttpServletRequest pRequest,	HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		List<Map<String, String>> dataRow = hfc01Service.selectYearEventCnt(pRequestParamMap);
		pRequestParamMap.put("eventType", "1");
		List<Map<String, String>> criData = hfc01Service.selectYearEventOfType(pRequestParamMap);
		pRequestParamMap.put("eventType", "2");
		List<Map<String, String>> buData = hfc01Service.selectYearEventOfType(pRequestParamMap);
		pRequestParamMap.put("eventType", "3");
		List<Map<String, String>> caData = hfc01Service.selectYearEventOfType(pRequestParamMap);
		pRequestParamMap.put("eventType", "4");
		List<Map<String, String>> weekData = hfc01Service.selectYearEventOfType(pRequestParamMap);
		pRequestParamMap.put("eventType", "5");
		List<Map<String, String>> etcData = hfc01Service.selectYearEventOfType(pRequestParamMap);
		
		model.addAttribute("dataRow", dataRow);
		model.addAttribute("criData", criData);
		model.addAttribute("buData", buData);
		model.addAttribute("caData", caData);
		model.addAttribute("weekData", weekData);
		model.addAttribute("etcData", etcData);
		model.addAttribute("searchYear", String.valueOf(pRequestParamMap.get("searchYear")));
		
		return "/auction/Hfc01Modal";
	}
	
}
