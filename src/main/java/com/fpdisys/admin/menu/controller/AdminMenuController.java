package com.fpdisys.admin.menu.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.fpdisys.admin.menu.domain.AdminMenuVO;
import com.fpdisys.admin.menu.service.AdminMenuService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminMenuController extends BaseController {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private AdminMenuService adminMenuService;
	
	
	
	 @RequestMapping(value="/admin/adminMenuForm.do")
		public String adminMenuForm(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminMenuForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/AdminMenuForm";
				  	
			 }
	
	 @RequestMapping(value="/admin/activeAdminMenuList.json")
		public String activeAdminMenuList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			
			log.info("===========================================");
			log.info("======  activeAdminMenuList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			try{
			List<AdminMenuVO> menusList = (List<AdminMenuVO>)adminMenuService.activeAdminMenus(pRequestParamMap);
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
		
	 @RequestMapping(value="/admin/adminMenuList.json")
		public String adminMenuList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			
			log.info("===========================================");
			log.info("======  adminMenuList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			try{
			List<AdminMenuVO> menusList = (List<AdminMenuVO>)adminMenuService.getFindAllByOrderByMnuLvAscMnuIxAsc(pRequestParamMap);
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
		@RequestMapping(value="/admin/adminMenuProc.json" )
		public String adminMenuProc(			
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
				@RequestBody String pJsonString,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model
		 		)
		{
		 log.info("===========================================");
			log.info("======  adminMenuProc ======");
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
				List list = getVoFromMultiJson(pJsonString, "ALL", AdminMenuVO.class);
				log.info(">>>>list.toString() : [" + list.toString()+"]");
				log.info("===========================================");
				for ( int idx = 0 ; idx < list.size(); idx++)
				{
					AdminMenuVO rMenu =(AdminMenuVO)list.get(idx);
					Map<String, Object> rMap = new HashMap<String, Object>();
					rMap.put("sysCd", rMenu.getSysCd());
					rMap.put("grpAuthCd", rMenu.getGrpAuthCd());	
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
					
					adminMenuService.getAdminMargeMenu(rMap);
					
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
		@RequestMapping(value="/admin/deleteAdminMenuProc.json")
		public String deleteAdminMenuProc(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){			  			  				
		  					
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
				String D2 ="";
				String D3 ="";
				String D4 ="";
				String D5 ="";
				String D6 ="";
				String D7 ="";
				try{		
					
					 for( int x = 0; x < result.length; x++ ){
							String R1= result[x];
							String[] R2= R1.split(",");
							log.info("R2++++++++++++"+R2.length);
						  for(int i = 0; i < R2.length;i++){
							if(i == 0){
								D1=R2[0];
								
							}
							if(i == 1){
								D2=R2[1];
								
							}
							if(i == 2){
								D3=R2[2];
							
							}
							if(i == 3){
								D4=R2[3];
							
							}
							if(i == 4){
								D5=R2[4];
							
							}
							if(i == 5){
								D6=R2[5];
							
							}
							if(i == 6){
								D7=R2[6];
							
							}
							pRequestParamMap.put("sysCd",D1);
							pRequestParamMap.put("progCd",D2);	 
							pRequestParamMap.put("mnuCd",D3);
							pRequestParamMap.put("grpAuthCd",D4);
							
							
							adminMenuService.deleteAdminMenuProc(pRequestParamMap);			
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

}
