package com.fpdisys.dist.hab09.controller;

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

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.WoorimUtil;
import com.fpdisys.base.util.WoorimUtil.DATEPATTERN;
import com.fpdisys.dist.hab01.domain.Hab01VO;
import com.fpdisys.dist.hab01.service.Hab01Service;
import com.fpdisys.dist.hab09.service.Hab09Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Hab09Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hab09Service hab09Service;
	
	/*
	 * 일자별 경매동황
	 */
	@RequestMapping(value="/hab09/hab09.do")
	public String selectHab09(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("==========KKKKK==============" + pRequestParamMap.toString());
		
		PaginationInfo paginationInfo = new PaginationInfo();  
		
		Calendar strDate = Calendar.getInstance();
		strDate.setTime(new Date());
		strDate.add(Calendar.DATE, -10);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(pRequestParamMap.get("searchStrDate") != null) {
			model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
		}else {
			model.addAttribute("searchStrDate", sdf.format(strDate.getTime()));
			pRequestParamMap.put("searchStrDate", sdf.format(strDate.getTime()));
		}
		
		if(pRequestParamMap.get("searchEndDate") != null) {
			model.addAttribute("searchEndDate", pRequestParamMap.get("searchEndDate"));
		}else {
			model.addAttribute("searchEndDate", sdf.format(new Date()));
			pRequestParamMap.put("searchEndDate", sdf.format(new Date()));
		}
		
		
		List<EgovMap> list = hab09Service.getAucBbsList(pRequestParamMap, paginationInfo);
		
		if(!list.isEmpty()) {
			if(paginationInfo != null) {
				EgovMap data = list.get(0);
				paginationInfo.setTotalRecordCount(Integer.parseInt(String.valueOf(data.get("totalCount"))));
			}
		}else {
			paginationInfo.setTotalRecordCount(0);
		}

		 
		model.addAttribute("pRequestParamMap", pRequestParamMap);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("list", list);
		model.addAttribute("mobCmpCd", pRequestParamMap.get("mobCmpCd"));
		
		return "/auction/Hab09";
	}
	
	/*
	 * 조회수 업데이트
	 */
	@RequestMapping(value="/hab09/updateClickCnt.json")
	public String updateClickCnt(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		hab09Service.updateClickCnt(pRequestParamMap);
		 
		return "jsonView";
	}
	 
	 /*
	  * 팝업
	  */
 	@RequestMapping(value="/hab09/getHab09Seq.json")
 	public String selectHab09Detail(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
 		
 		Map<String, Object> detail = hab09Service.selectHab09Detail(pRequestParamMap);
 		model.addAttribute("detail", detail);
 		
 		return "jsonView";
 	}
 	
}
