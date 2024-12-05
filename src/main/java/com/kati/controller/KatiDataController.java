package com.kati.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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

import com.kati.service.KatiDataService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class KatiDataController {
	
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	KatiDataService katiDataService;
	
	@RequestMapping(value="/hga05/hga05.do")
	public String selectShippedInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		Calendar strDate = Calendar.getInstance();
		strDate.setTime(new Date());
		strDate.add(Calendar.MONTH, -3);
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM");
		model.addAttribute("searchStrDateM", sdf.format(strDate.getTime()));
		model.addAttribute("searchEndDateM", sdf.format(new Date()));
		
		return "/auction/Hga05";
	}
	
	
	//수출입데이터
	@RequestMapping(value="/kati/selectImportList.json")
	public String selectImportList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		List<EgovMap> resultList = (List<EgovMap>) katiDataService.selectImportList(pRequestParamMap);
		model.addAttribute("list",resultList);
		
		return "jsonView";
	}
	
	//품목리스트
	@RequestMapping(value="/search/selectImportPumList.json")
	public String selectImportPumList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		List<EgovMap> resultList = (List<EgovMap>) katiDataService.selectImportPumList(pRequestParamMap);
		model.addAttribute("list",resultList);
		

		return "jsonView";
	}
	
	//국가리스트
	@RequestMapping(value="/search/selectImportNatList.json")
	public String selectImportNatList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		List<EgovMap> resultList = (List<EgovMap>) katiDataService.selectImportNatList(pRequestParamMap);
		model.addAttribute("list",resultList);
		
		return "jsonView";
	}
}
