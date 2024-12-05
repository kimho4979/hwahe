package com.fpminput.mntr.cmmn.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.login.domain.UserVO;
import com.fpminput.mntr.login.mapper.LoginMapper;
import com.fpminput.mntr.login.service.LoginMntService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class CmmnController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	private LoginMapper loginMapper;	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private LoginMntService  loginService;
	
	@RequestMapping(value="/cmmn/manual.do")
	public String manual(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		return "/cmmn/manual";
	}
	@RequestMapping(value="/cmmn/userIp.do")
	public String userIp(
			HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model)
	{
		List<UserVO> list = new ArrayList<UserVO>();
		 list = loginService.selectIpList();
		 ObjectMapper objectMapper = new ObjectMapper();
		 String voListJSON = null;
		 try {
		     voListJSON = objectMapper.writeValueAsString(list);
		 } catch (Exception e) {
		     e.printStackTrace();
		 }
	
		model.addAttribute("userList", voListJSON);
		return "/cmmn/accessIp";
	}
	
	@RequestMapping(value="/cmmn/mobileManual.do")
	public String mobileManual(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
 
		return "/mobile/common/mobileManual";
	}
	

}
