package com.fpdisys.dist.hfc02.controller;

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
import com.fpdisys.dist.hfc02.service.Hfc02Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Hfc02Controller extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Hfc02Service hfc02Service;

	// 행사일정켈린더조회(홈/모바일)
	@RequestMapping(value = "/hfc02/hfc02.do")
	public String selectHfc01(HttpServletRequest pRequest,	HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/auction/Hfc02";
	}

	// 열린광장 행사안내 달력 데이터 조회
	@RequestMapping(value="/hfc02/selectEventCalendarList.json")
	public String selectEventCalendarList(	HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		// 데이터 조회
		List<Map<String, String>> calendarList = hfc02Service.selectEventCalendarList(pRequestParamMap);

		List<Map<String, String>> eventList = hfc02Service.selectEventList(pRequestParamMap);

		model.addAttribute("calendarList", calendarList );
		model.addAttribute("eventList", eventList);

		return "jsonView";
	}

	// 주요행사일정 GRID 조회
	@RequestMapping(value="/hfc02/selectEventList.json")
	public String selectEventList(	HttpServletRequest pRequest, HttpServletResponse pResponse,
			HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		// 데이터 조회
		List<Map<String, String>> eventList = hfc02Service.selectEventList(pRequestParamMap);

		model.addAttribute("eventList", eventList);
		return "jsonView";
	}

}
