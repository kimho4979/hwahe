package com.fpdisys.admin.notice.controller;

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

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.notice.domain.AdminNoticeFileVO;
import com.fpdisys.admin.notice.domain.AdminNoticeVO;
import com.fpdisys.admin.notice.service.AdminNoticeService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminNoticeController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private AdminNoticeService adminNoticeService; 
	
	
	
	 @RequestMapping(value="/admin/adminNoticeForm.do")
	public String adminNoticeForm(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

			  	log.info("===========================================");
			  	log.info("======  adminNoticeForm ======");
			  	log.info("===========================================");
			  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			  	printRequest(pRequest);
			  	log.info("===========================================");
			  	//----------------------------------------------------------------
			  	// Login check
			  	//----------------------------------------------------------------
			  	
			  	
			  	 return "/admin/ad001";
			  	
		 }
	 @RequestMapping(value="/admin/noticeInsert_popup.do")
		public String noticeInsert_popup(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminNoticeForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/noticeInsert_popup";
				  	
			 }
	 @RequestMapping(value="/admin/noticeUpdate_popup.do")
		public String noticeUpdate_popup(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminNoticeForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/noticeUpdate_popup";
				  	
			 }
	 
	 
	 @RequestMapping(value="/admin/insertAdminNotice.json")
		public String insertAdminNotice(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 	
		 		ModelMap model)
		{		 						
	  
	  		log.info("============2222333444============"+pRequestParamMap.toString());
	  		
	  log.info("============CONTENT ============"+pRequestParamMap.get("CONTENT"));
	  log.info("============TITLE ============"+pRequestParamMap.get("TITLE"));
	  
			Map<String, Object> resultMap = new HashMap<String, Object>();
			log.info("resultMap++++++++++++"+resultMap);
			
			try{				
				
				adminNoticeService.insertAdminNotice(pRequestParamMap);							
			
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
	 
	 @RequestMapping(value="/admin/updateAdminNotice.json")
		public String updateAdminNotice(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 	
		 		ModelMap model)
		{		 						
	  
	  		log.info("============2222333444============"+pRequestParamMap.toString());
	  		
	  log.info("============CONTENT ============"+pRequestParamMap.get("CONTENT"));
	  log.info("============TITLE ============"+pRequestParamMap.get("TITLE"));
	  log.info("============SEQ ============"+pRequestParamMap.get("SEQ"));
			Map<String, Object> resultMap = new HashMap<String, Object>();
			log.info("resultMap++++++++++++"+resultMap);
			
			try{				
				adminNoticeService.updateAdminNotice(pRequestParamMap);							
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
	 
	 
	 @RequestMapping(value="/admin/adminNoticeList.json")
		public String getCodeCodeList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			JSONObject obj= new JSONObject();
			String startCount = "";
			String endCount = "";
			String F_DATE="";
			if(pRequestParamMap.get("startCount")!=null &&
					!StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
				startCount =pRequestParamMap.get("startCount").toString();
				pRequestParamMap.put("startCount", startCount);
			}else{
				startCount ="1";
				pRequestParamMap.put("startCount", startCount);
			}
			if(pRequestParamMap.get("endCount")!=null &&
					!StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
				endCount =pRequestParamMap.get("endCount").toString();
				pRequestParamMap.put("endCount", endCount);
			}else{
				endCount ="15";
				pRequestParamMap.put("endCount", endCount);
			}

			String pageNo2= "";
			if(pRequestParamMap.get("pageNo2")!=null &&
					!StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
				pageNo2 =pRequestParamMap.get("pageNo2").toString();
				obj.put("pageNo2", pageNo2);
			}else{
				obj.put("pageNo2", "1");
			}
			log.info("obj+++++++++ : " + obj.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<?> resultList = (List<?>)adminNoticeService.selectAdminNoticeSearch(pRequestParamMap);			


				model.addAttribute("list2", obj);
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
	 
	 @RequestMapping(value="/admin/regNoticePopup.do")
		public String regNoticePopupForm(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  regNoticePopup ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			//LoginInfo loginInfo = new LoginInfo(pRequest, pResponse);
			//loginInfo.putSessionToParameterMap(pRequestParamMap);
			
			//TODO 버튼 권한
			/*UserMenuInfo userMenuInfo= null;
	 		if(StringUtils.isBlank(loginInfo.getUserId())){
	 			userMenuInfo = menuService.getUserMenuInfoNoLogin();
	 		}else{
	 			userMenuInfo = menuService.getUserMenuInfo(loginInfo.getUserId());
	 		}
	 		log.info(">>>>userMenuInfo : " + userMenuInfo.getMainMenuJson());
			
	 		model.addAttribute("userMenuInfo",userMenuInfo );*/
			
			return "/admin/ad001Popup";
			
		}
	 
	 
	 @RequestMapping(value="/admin/adminNotice.json")
		public String getNotice(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 log.info("===========================================");
			log.info("======  notice ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			
			AdminNoticeVO notice = adminNoticeService.findNoticeOne(pRequestParamMap);
			
			List<AdminNoticeFileVO> fileList = (List<AdminNoticeFileVO>)adminNoticeService.selectAdminNoticeFileSearch(pRequestParamMap);
			
			notice.setFileList(fileList);
			model.addAttribute("data",notice );
		 
		 return "jsonView";
		}
	 @RequestMapping(value="/admin/deleteAdminNotice.json")
		public String deleteAdminNotice(
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
						
							pRequestParamMap.put("SEQ_NO",D1);
							pRequestParamMap.put("CONTENT",D2);	 
							pRequestParamMap.put("TITLE",D3);
							adminNoticeService.deleteAdminNotice(pRequestParamMap);			
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
