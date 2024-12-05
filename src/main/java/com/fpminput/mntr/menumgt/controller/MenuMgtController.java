package com.fpminput.mntr.menumgt.controller;

import java.util.HashMap;
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
import com.fpdisys.base.tags.MenuTag;
import com.fpdisys.dist.menu.domain.MenuVO;
import com.fpdisys.dist.menu.service.MenuService;
import com.fpminput.mntr.menumgt.service.MenuMgtService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MenuMgtController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	MenuMgtService menuMgtService;
	@Autowired
	MenuService menuService;
	
	// 메뉴관리
	@RequestMapping(value="/menuMgt/menuManageMent.do")
	public String menuManageMent(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/menuMgt/menuManagement/menumgt";
	}
	
	// 메뉴관리:: List 조회
	@RequestMapping(value="/menuMgt/selectMenuMgtList_root.json")
	public String selectMenuMgtList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============selectMenuMgtList============"+pRequestParamMap.toString());	
	  	
		List<EgovMap> resultList = null;
		
		try{
			resultList  =  menuMgtService.selectMenuMgtList();
			
			model.addAttribute("list",resultList);
			
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
	
	// 메뉴관리:: useYn List 조회
	@RequestMapping(value="/menuMgt/selectMenuMgtUseYnList.json")
	public String selectMenuMgtUseYnList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============selectMenuMgtUseYnList============"+pRequestParamMap.toString());	
	  	
		List<EgovMap> resultList = null;
		
		try{
			resultList  =  menuMgtService.selectMenuMgtUseYnList(pRequestParamMap);
			
			model.addAttribute("list",resultList);
			
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
	
	// 메뉴관리:: 등록
	@RequestMapping(value="/menuMgt/insertMenuInput.json")
	public String insertMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============insertMenuInput============"+pRequestParamMap.toString());	
	  	 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			menuMgtService.insertMenuInput(pRequestParamMap);
			
			String requestURI = "/main/flowerMain.do";
			menuService.setCacheMenuAliasUpdate();
			MenuVO currentMenuVO = menuService.getCacheByUrl(requestURI);
	 		MenuVO currentMenuInfo = this.menuService.getByMenuIdUpdate(currentMenuVO.getMenuId());
	 		pRequest.setAttribute("currentMenuInfo",  currentMenuInfo); //jsp 참조 변수 currentMenuInfo
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
	
	// 메뉴관리 :: 수정
	@RequestMapping(value="/menuMgt/updateMenuInput.json")
	public String updateMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============updateMenuInput============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		//String requestURI = request.getRequestURI(); 현재 uri가 DB에 없어서 명시적으로 정의
		String requestURI = "/main/flowerMain.do";
		try{				
			menuMgtService.updateMenuInput(pRequestParamMap);
			
			//update가 되었을 때 메뉴를 새로 reLoad
			menuService.setCacheMenuAliasUpdate();
			MenuVO currentMenuVO = menuService.getCacheByUrl(requestURI);
	 		MenuVO currentMenuInfo = this.menuService.getByMenuIdUpdate(currentMenuVO.getMenuId());
	 		pRequest.setAttribute("currentMenuInfo",  currentMenuInfo); //jsp 참조 변수 currentMenuInfo
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
	
	// 그룹관리 LIST
	@RequestMapping(value="/menuMgt/deleteMenuInput.json")
	public String deleteMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
	  		
		//log.info("========================"+pRequestParamMap.get("gridUpdate"));
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			menuMgtService.deleteMenuCdInput(pRequestParamMap);
			menuMgtService.deleteMenuUpCdInput(pRequestParamMap);
			menuMgtService.deleteGroupMenuJoinInput(pRequestParamMap);
			
			//메뉴 삭제후 front 단 메뉴 화면 재로딩
			String requestURI = "/main/flowerMain.do";
			menuService.setCacheMenuAliasUpdate();
			MenuVO currentMenuVO = menuService.getCacheByUrl(requestURI);
	 		MenuVO currentMenuInfo = this.menuService.getByMenuIdUpdate(currentMenuVO.getMenuId());
	 		pRequest.setAttribute("currentMenuInfo",  currentMenuInfo); //jsp 참조 변수 currentMenuInfo
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
	
	// 메뉴관리:: List 조회
	@RequestMapping(value="/menuMgt/selectMenuMgtList_child.json")
	public String selectMenuMgtList_child(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============selectMenuMgtList_child============"+pRequestParamMap.toString());	
	  	 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{
			Map<String, String> resultList  =  (Map<String, String>)menuMgtService.selectMenuUnderMgtList(pRequestParamMap);
			model.addAttribute("list", resultList);
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
	
	// 그룹관리
	@RequestMapping(value="/menuMgt/groupManageMent.do")
	public String groupManageMent(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/menuMgt/groupManagement/groupmgt";
	}
	
	// 그룹관리 LIST
	@RequestMapping(value="/menuMgt/groupManageMentList.json")
	public String groupManageMentList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
	  		
		//log.info("========================"+pRequestParamMap.get("gridUpdate"));
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			List<EgovMap> resultList  =  (List<EgovMap>)menuMgtService.selectGroupMgtList(pRequestParamMap);				

			model.addAttribute("list", resultList);
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
	
	// 그룹관리 팝업
	@RequestMapping(value="/menuMgt/groupManageMent_popup.do")
	public String ctvtTrendInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("===========================================");
	  	log.info("======  groupManageMent_popup ======");
	  	log.info("===========================================");		  	
	 	log.info("groupManageMent_popup+++++++++ : " + pRequestParamMap.toString());
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}		 
		return "/menuMgt/groupManagement/groupmgt_popup";
	}
	
	// 그룹관리 팝업 :: 등록
	@RequestMapping(value="/menuMgt/insertGroupMenuInput.json")
	public String insertGroupMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============insertGroupMenuInput============"+pRequestParamMap.toString());	
	  	 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			menuMgtService.insertGroupMenuInput(pRequestParamMap);
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
	
	// 그룹관리 팝업 :: 수정
	@RequestMapping(value="/menuMgt/updateGroupMenuInput.json")
	public String updateGroupMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============updateGroupMenuInput============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{				
			menuMgtService.updateGroupMenuInput(pRequestParamMap);
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
	
	// 그룹관리 팝업 :: 삭제
	@RequestMapping(value="/menuMgt/deleteGroupMenuInput.json")
	public String deleteGroupMenuInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============deleteGroupMenuInput============"+pRequestParamMap.toString());
		
		String gridResult = pRequestParamMap.toString();
		 
		log.info("gridResult:++++======"+gridResult);
		log.info("gridResult:++++======"+gridResult.length());
		 
		String s2 = gridResult.replace("{","");
		String s3 = s2.replace("}","");
		String s4 = s3.replace("=","");
		  
		log.info("gridResult:++++======"+s2);
		log.info("gridResult:++++======"+s3);
		log.info("gridResult:++++======"+s4);
		 
		String[] result = s4.split("!");
		 
		log.info("result:++++======"+result.length);		 

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		String D1 ="";
		
		try{		
			for( int x = 0; x < result.length; x++ ){
				String R1= result[x];
				String[] R2= R1.split(",");
				log.info("R2++++++++++++"+R2.length);
				for(int i = 0; i < R2.length;i++){
					if(i == 0){
						D1=R2[0];
					}
					pRequestParamMap.put("groupCd",D1);
					menuMgtService.deleteGroupMenuInput(pRequestParamMap);
					menuMgtService.deleteGroupMenuJoinInput(pRequestParamMap);
				}
			};
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
	
	// 그룹메뉴관리
	@RequestMapping(value="/menuMgt/groupMenuManageMent.do")
	public String groupMenuManageMent(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/menuMgt/groupMenuManagement/groupMenumgt";
	}
	
	// 그룹메뉴관리 List
	@RequestMapping(value="/menuMgt/selectGroupList.json")
	public String selectGroupMenuMgtList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============selectGroupList============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{				
			List<EgovMap> list = menuMgtService.selectGroupList(pRequestParamMap);
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		} 													
		return "jsonView";
	}
	
	// 그룹 & 메뉴 Join List
	@RequestMapping(value="/menuMgt/selectGroupMenuJoinList.json")
	public String selectGroupMenuJoinList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============selectGroupMenuJoinList============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{				
			List<EgovMap> list = menuMgtService.selectGroupMenuJoinList(pRequestParamMap);
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		} 													
		return "jsonView";
	}
	
	// 그룹 & 메뉴 Join Insert
	@RequestMapping(value="/menuMgt/insertGroupMenuJoinInput.json")
	public String insertGroupMenuJoinInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============insertGroupMenuJoinInput============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{
			//menuMgtService.deleteGroupMenuJoinInputGroupCd(pRequestParamMap);
			//menuMgtService.deleteGroupMenuJoinInput(pRequestParamMap);
			menuMgtService.insertGroupMenuJoinInput(pRequestParamMap);
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
	
	// 그룹 & 메뉴 Join Insert
	@RequestMapping(value="/menuMgt/deleteGroupMenuJoinInput.json")
	public String deleteGroupMenuJoinInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============deleteGroupMenuJoinInput============"+pRequestParamMap.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{
			menuMgtService.deleteGroupMenuJoinInputGroupCd(pRequestParamMap);
			menuMgtService.deleteGroupMenuJoinInput(pRequestParamMap);
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
 
}
