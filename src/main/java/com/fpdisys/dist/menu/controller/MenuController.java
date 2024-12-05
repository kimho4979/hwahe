package com.fpdisys.dist.menu.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpdisys.base.login.LoginInfo;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.menu.domain.Menu;
import com.fpdisys.dist.menu.domain.UserMenuInfo;
import com.fpdisys.dist.menu.service.MenuService;
import com.fpdisys.dist.prog.service.ProgService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class MenuController extends BaseController { 
	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired  
	private ProgService progService;  
	
	@Autowired
  	private MenuService  menuService;
	
	@RequestMapping(value="/sys/menu/sys_mng0200.do")
	public String menuForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  menuForm ======");
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
		
		//TODO 버튼 권한
		
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin2();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		//log.info(">>>>userMenuInfo menuJson: " + userMenuInfo.getMainMenuJson());
 		//log.info(">>>>userMenuInfo authorizedMenuMap : " + userMenuInfo.getAuthorizedMenuMap());
 		//Map<String, AuthorizedMenu> authorizedMenuMap	= userMenuInfo.getAuthorizedMenuMap();
 		
 		//AuthorizedMenu authorizedMenu = authorizedMenuMap.get(pageId);
 		//JspPageInfo jspPageInfo = JspPageInfo.of(pageId, authorizedMenu);
		
 		//log.info("====================================pageId : ["+jspPageInfo.toString()+"]" );
 		//model.addAttribute("userMenuInfo",userMenuInfo );
 		//model.addAttribute("jspPageInfo",jspPageInfo );
		return "/sys/menu/menuForm";
		
	}
	
	@RequestMapping(value="/sys/menu/menuProgmList.json")
	public String menuProgmList(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		
		log.info("===========================================");
		log.info("======  menuProgmList ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		//----------------------------------------------------------------
		// Login check
		//----------------------------------------------------------------
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			List<Menu> menusList = menuService.getFindAllByOrderByMnuLvAscMnuIxAsc();
			model.addAttribute("list", menusList);
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
	
	
	@RequestMapping(value="/sys/menu/searchProgPopup.do")
	public String searchProgPopupForm(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
				 
		log.info("===========================================");
		log.info("======  searchProgPopup ======");
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
		
		return "/sys/menu/searchProgPopup";
		
	}
	
	@RequestMapping(value="/sys/menu/activeMenumList.json")
	public String activeMenumList(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		
		log.info("===========================================");
		log.info("======  activeMenumList ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		printRequest(pRequest);
		log.info("===========================================");
		//----------------------------------------------------------------
		// Login check
		//----------------------------------------------------------------
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			List<Menu> menusList = menuService.findActiveMenus();
			model.addAttribute("list", menusList);

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
	
	
	//TODO 등록수정처리 
	@RequestMapping(value="/sys/menu/menuProc.json" )
	public String menuProc(			
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestBody String pJsonString,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model
	 		)
	{
	 log.info("===========================================");
		log.info("======  menuProc ======");
		log.info("===========================================");
		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		log.info(">>>>pJsonString : [" + pJsonString+"]");
		log.info("===========================================");
		log.info("================= request =================");
		//printRequest(pRequest);
		
		log.info("===========================================");
		
		try {
			
			if(!StringUtils.isBlank(pJsonString)){
				pJsonString ="{\"ALL\":"+pJsonString+"}";
			}
			List list = getVoFromMultiJson(pJsonString, "ALL", Menu.class);
			log.info(">>>>list.toString() : [" + list.toString()+"]");
			log.info("===========================================");
			for ( int idx = 0 ; idx < list.size(); idx++)
			{
				Menu rMenu =(Menu)list.get(idx);
				Map<String, Object> rMap = new HashMap<String, Object>();
				rMap.put("mnuCd", rMenu.getMnuCd());				
				rMap.put("userId", "admin");
				rMap.put("icon", rMenu.getIcon());
				rMap.put("mnuIx", rMenu.getMnuIx());
				rMap.put("mnuLv", rMenu.getMnuLv());
				rMap.put("mnuNm", rMenu.getMnuNm());
				rMap.put("mnuUpCd", rMenu.getMnuUpCd());
				rMap.put("progCd", rMenu.getProgCd());
				rMap.put("useYn", rMenu.getUseYn());
				rMap.put("remark", rMenu.getRemark());
				
				menuService.getMargeMenu(rMap);
				
			}
			
				
		
		model.addAttribute("message","" );
		
		} catch (InterruptedIOException  e) {
			log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
		} catch (FileNotFoundException e) {
			log.error("입출력 오류 파일을 찾을 수 없습니다!!");
		} catch (IOException e) {
			log.debug("입출력 오류!!");
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
	
	//log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
	
	
	 return "jsonView";
}
	@RequestMapping("/sys/menu/auth-config.do")
	public String authconfig(HttpServletRequest pRequest) {
		try {
		
			HttpSession httpSession = pRequest.getSession();
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "redirect:/mnt/mem01/mem01Form.do";
			}
		
		
	//} catch (InterruptedIOException  e) {
		//log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
	//} catch (FileNotFoundException e) {
		//log.error("입출력 오류 파일을 찾을 수 없습니다!!");
	//} catch (IOException e) {
		//log.debug("입출력 오류!!");
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
		return "/admin/menuAcl";
	}
	@RequestMapping("/sys/menu/auth-config.json")
	public String authconfigresult(ModelMap model, @RequestParam Map pMap) {
		try {
			model.addAttribute("list",menuService.getCustomInfo(pMap));
			//} catch (InterruptedIOException  e) {
				//log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
			//} catch (FileNotFoundException e) {
				//log.error("입출력 오류 파일을 찾을 수 없습니다!!");
			//} catch (IOException e) {
				//log.debug("입출력 오류!!");
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
	
	@RequestMapping("/sys/menu/updateAcsYn.json")
	public String authconfigupdate(ModelMap model, @RequestBody String pstr) {
		try {
			
			System.out.println(pstr);
			ObjectMapper obj = new ObjectMapper(); 
			List<Map<String,String>> params = obj.readValue(pstr, List.class);
			for(Map<String,String> o : params) {
				System.out.println(o);
				model.addAttribute("list",menuService.updateAcsYn(o));
			}
			
			} catch (Exception e) {
				model.addAttribute("msg","처리중오류발생.");
				e.printStackTrace();
				return "jsonView";
			}
		model.addAttribute("msg","업로드성공");
		return "jsonView";
	}
	
}
