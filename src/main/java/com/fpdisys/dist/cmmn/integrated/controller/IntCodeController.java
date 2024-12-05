package com.fpdisys.dist.cmmn.integrated.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.cmmn.integrated.domain.ItemVO;
import com.fpdisys.dist.cmmn.integrated.service.IntCodeService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class IntCodeController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	/* 통합품목/품종 코드 서비스 */
	@Autowired
	IntCodeService intCodeService;
	
	
	@RequestMapping(value="/intCode/selectIntItemList.json")
	public String selectIntItemList(HttpServletRequest pRequest, HttpServletResponse pResponse,
		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception	{
		try {
			System.out.println("selectItem : " + pRequestParamMap);
			List<Map<String, Object>> item = intCodeService.selectIntItemList(pRequestParamMap);
			model.addAttribute("list", item);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "jsonView";
	}

	@RequestMapping(value="/intCode/selectIntKindList.json")
	public String selectIntKindList(HttpServletRequest pRequest, HttpServletResponse pResponse,
		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception	{
		try {
			System.out.println("selectKind : " + pRequestParamMap);
			List<Map<String, Object>> item = intCodeService.selectIntKindList(pRequestParamMap);
			model.addAttribute("list", item);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "jsonView";
	}

}