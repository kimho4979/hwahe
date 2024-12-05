package com.fpdisys.dist.code.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.login.LoginInfo;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.mvc.PageableTO;
import com.fpdisys.base.util.JspPageInfo;
import com.fpdisys.dist.code.domain.BasicCode;
import com.fpdisys.dist.code.service.BaseCodeService;
import com.fpdisys.dist.menu.domain.AuthorizedMenu;
import com.fpdisys.dist.menu.domain.UserMenuInfo;
import com.fpdisys.dist.menu.service.MenuService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class BasicCodeController extends BaseController { 

protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
  	private MenuService  menuService;
	
	@Autowired
	private BaseCodeService baseCodeService;
	
	@RequestMapping(value = "/sys/base/sys_mng0300.do" )
	public String baseCodeForm( ModelMap model,
		HttpServletRequest pRequest,
		HttpServletResponse pResponse,
		@RequestParam Map<String, Object> pRequestParamMap){
		
		log.info("===========================================");
		log.info("======  baseCodeForm ======");
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
		final String pageId = FilenameUtils.getBaseName(pRequest.getServletPath());
		
		UserMenuInfo userMenuInfo= null;
 		if(StringUtils.isBlank(loginInfo.getUserId())){
 			userMenuInfo = menuService.getUserMenuInfoNoLogin2();
 		}else{
 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
 		}
 		
 		if(userMenuInfo != null){
 			Map<String, AuthorizedMenu> authorizedMenuMap	= userMenuInfo.getAuthorizedMenuMap();
 			AuthorizedMenu authorizedMenu = authorizedMenuMap.get(pageId);
 	 		JspPageInfo jspPageInfo = JspPageInfo.of(pageId, authorizedMenu);
 			
 	 		model.addAttribute("userMenuInfo",userMenuInfo );
 	 		model.addAttribute("jspPageInfo",jspPageInfo );
 		}
 		
		return "/sys/code/codeForm"; 
	}
	
	
	 
	 @RequestMapping(value="/sys/base/baseCodeList.json")
		public String baseCodeList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  baseCodeList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PageableTO pageTo = new PageableTO();
			int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
			int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
			pageTo.setCurrentPage(currentPage);
			pageTo.setPageSize(pageSize);
			
			
			try{
				
				List<EgovMap> resultList  =  (List<EgovMap>)baseCodeService.findByBasicCdOrderBySortAsc(pRequestParamMap);
				int total = resultList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(resultList.size()+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
	 		  	int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			
	 		 	pageTo.setTotalPages(totalPage);
				
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
			
			model.addAttribute("page",pageTo );
		 return "jsonView";
		}
	
	
	 @RequestMapping(value="/sys/base/baseCodeSaveProc.json" )
		public String baseCodeSaveProc(			
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
				@RequestBody String pJsonString,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model
		 		)
		{
		 log.info("===========================================");
			log.info("======  baseCodeSaveProc ======");
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
				
				List list = getVoFromMultiJson(pJsonString, "ALL", BasicCode.class );
				log.info(">>>>list.toString() : [" + list.toString()+"]");
				log.info("===========================================");
				for ( int idx = 0 ; idx < list.size(); idx++)
				{
					BasicCode rBasicCode = (BasicCode)list.get(idx);
					Map<String, Object> rMap = new HashMap<String, Object>();
					rMap.put("basicCd",rBasicCode.getBasicCd());
					rMap.put("code",rBasicCode.getCode());
					rMap.put("basicNm",rBasicCode.getBasicNm());
					rMap.put("name",rBasicCode.getName());					
					rMap.put("data1",rBasicCode.getData1());
					rMap.put("data2",rBasicCode.getData2());
					rMap.put("data3",rBasicCode.getData3());
					rMap.put("data4",rBasicCode.getData4());
					rMap.put("data5",rBasicCode.getData5());					
					rMap.put("posUseYn",rBasicCode.getPosUseYn());
					rMap.put("remark",rBasicCode.getRemark());
					rMap.put("sort",rBasicCode.getSort());
					rMap.put("useYn",rBasicCode.getUseYn());
					rMap.put("userId","admin");
					log.info("===================rMap====================");
					log.info("rMap.toString() ["+rMap.toString()+"]" );
					log.info("===========================================");
					baseCodeService.mergeBasicCode(rMap);
					
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
	
	 @RequestMapping(value="/sys/base/baseCodeComboBoxList.json")
		public String findComboBoxBaseCodeList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		@RequestParam(required = false, defaultValue = "0") List<String> basicCds,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  findComboBoxBaseCodeList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			log.info(">>>>basicCds.toString() : " + basicCds.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
			
			try{
				 for(String basicCd : basicCds) {
					 Map<String, Object> paramMap = new HashMap<String, Object>();
					 
					 paramMap.put("basicCd",basicCd); 
				
				 List<Map<String, Object>> resultList  =  ( List<Map<String, Object>>)baseCodeService.findComboBoxBaseCodeList(paramMap);
					
				 resultMap.put(basicCd, resultList);
				 
				 }
				model.addAttribute("map", resultMap);
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
	 
	 
	 
	 @RequestMapping(value="/sys/base/baseCodeComboBoxList2.json")
		public String findComboBoxBaseCodeList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  findComboBoxBaseCodeList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
			
			try{
				 List<Map<String, Object>> resultList  =  ( List<Map<String, Object>>)baseCodeService.findComboBoxBaseCodeList(pRequestParamMap);
				model.addAttribute("resultList", resultList);
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
