package com.fpdisys.dist.user.controller;

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

import com.fpdisys.dist.menu.service.MenuService;
import com.fpdisys.dist.user.service.UserService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class UserController extends BaseController { 

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	@Autowired
		private MenuService  menuService;
	
	@Autowired
	private UserService userService;
	
	
	 @RequestMapping(value="/cmn/user/userCreateForm.do")
		public String userCreateForm(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  userCreateForm ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			
			
	 		
			return "/sys/user/userCreateForm";
			
		}
	 
	 @RequestMapping(value="/cmn/user/createProc.json")
	 public String createProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
			log.info("===========================================");
			log.info("======  createProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			log.info(">>>>userCd : " + pRequestParamMap.get("userCd").toString());
			//pRequestParamMap = 	UserService.createProc(pRequestParamMap);
			
			userService.createAdminAuthProc(pRequestParamMap);
			
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			
			model.addAttribute("id",pRequestParamMap.get("userCd") );	
			 return "jsonView";
		}
	 
	 @RequestMapping(value="/cmn/user/duplicateProc.json")
	 public String duplicateProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  duplicateProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			log.info(">>>>userCd : " + pRequestParamMap.get("userCd").toString());
			
			pRequestParamMap = 	userService.duplicateProc(pRequestParamMap);
			
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			
			model.addAttribute("id",pRequestParamMap.get("userCd") );
			model.addAttribute("dupCheck",pRequestParamMap.get("dupCheck") );
			model.addAttribute("message",pRequestParamMap.get("message") );
			
			return "jsonView";
		}
}
