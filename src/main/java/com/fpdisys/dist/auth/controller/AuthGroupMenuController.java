package com.fpdisys.dist.auth.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.login.LoginInfo;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.JspPageInfo;
import com.fpdisys.dist.auth.service.AuthGroupMenuService;
import com.fpdisys.dist.auth.service.AuthGroupService;
import com.fpdisys.dist.login.mapper.LoginMapper;
import com.fpdisys.dist.menu.domain.AuthorizedMenu;
import com.fpdisys.dist.menu.domain.UserMenuInfo;
import com.fpdisys.dist.menu.service.MenuService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AuthGroupMenuController extends BaseController {
	
	@Autowired
	private LoginMapper loginMapper;
	
	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired  
	AuthGroupMenuService authGroupMenuService;
	
	@Autowired  
	AuthGroupService authGroupService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
  	private MenuService  menuService;
	
	@RequestMapping(value="/sys/group/sys_mng0400.do")
	public String authGroupForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  authGroupForm ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		//----------------------------------------------------------------
		// Login check
		//----------------------------------------------------------------
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		
		final String pageId = FilenameUtils.getBaseName(pRequest.getServletPath());
		log.info("====================================pageId : ["+pageId+"]" );
		//TODO 버튼 권한
		
		
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin2();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		/*log.info(">>>>userMenuInfo menuJson: " + userMenuInfo.getMainMenuJson());
 		log.info(">>>>userMenuInfo authorizedMenuMap : " + userMenuInfo.getAuthorizedMenuMap());
 		Map<String, AuthorizedMenu> authorizedMenuMap	= userMenuInfo.getAuthorizedMenuMap();
 		
 		AuthorizedMenu authorizedMenu = authorizedMenuMap.get(pageId);
 		JspPageInfo jspPageInfo = JspPageInfo.of(pageId, authorizedMenu);
		
 		log.info("====================================pageId : ["+jspPageInfo.toString()+"]" );
 		model.addAttribute("userMenuInfo",userMenuInfo );
 		model.addAttribute("jspPageInfo",jspPageInfo );*/
		
		return "/sys/auth/authGroupMenuForm";
		
	}
	
	@RequestMapping(value="/sys/menu/searchMenuPopup.do")
	public String searchMenuPopupForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  searchMenuPopup ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		//----------------------------------------------------------------
		// Login check
		//----------------------------------------------------------------
		LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
		loginInfo.putSessionToParameterMap(pRequestParamMap);
		
		
		
		//TODO 버튼 권한
		
		
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
		
 		//model.addAttribute("userMenuInfo",userMenuInfo );
		
		return "/sys/auth/searchMenuPop";
		
	}
	

}
