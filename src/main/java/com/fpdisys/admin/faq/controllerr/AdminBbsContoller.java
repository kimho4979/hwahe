package com.fpdisys.admin.faq.controllerr;

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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.faq.domain.AdminBbsFileVO;
import com.fpdisys.admin.faq.domain.AdminBbsVO;
import com.fpdisys.admin.faq.service.AdminBbsService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.mvc.PageableTO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminBbsContoller extends BaseController {
protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private AdminBbsService adminBbsService;
	
	 @RequestMapping(value="/admin/adminFaqForm.do")
		public String adminFaqForm(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminFaqForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/ad002";
				  	
			 }
	 @RequestMapping(value="/admin/faqUpdate_popup.do")
		public String faqUpdate_popup(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminFaqForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/faqUpdate_popup";
				  	
			 }

		 
		 @RequestMapping(value="/admin/adminFaqList.json")
			public String getAdminFaqList(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 		ModelMap model)
			{
			 
			 log.info("===========================================");
				log.info("======  getAdminFaqList ======");
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
					
					List<?> resultList = (List<?>)adminBbsService.selectAdminBbsSearch(pRequestParamMap); 
					
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
		 
		 @RequestMapping(value="/admin/faqInsert_popup.do")
			public String regFaqPopupForm(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 		ModelMap model)
			{
						 
				log.info("===========================================");
				log.info("======  regFaqPopupForm ======");
				log.info("===========================================");
				log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				printRequest(pRequest);
				log.info("===========================================");
				
				
				return "/admin/faqInsert_popup";
				
			}
		 
		 
		 @RequestMapping(value="/admin/adminFaq.json")
			public String getFaq(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 		ModelMap model)
			{
			 log.info("===========================================");
				log.info("======  getFaq ======");
				log.info("===========================================");
				log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				printRequest(pRequest);
				log.info("===========================================");
				
				AdminBbsVO notice = adminBbsService.findBbsOne(pRequestParamMap);
				
				List<AdminBbsFileVO> fileList = (List<AdminBbsFileVO>)adminBbsService.selectAdminBbsFileSearch(pRequestParamMap);
				
				notice.setFileList(fileList);
				model.addAttribute("data",notice );
			 
			 return "jsonView";
			}
		 @RequestMapping(value="/admin/faqInsert_popup.json")
			public String insertAdminFaq(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse,
					HttpSession  session,
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 	
			 		ModelMap model)
			{		 						
		/*  if(pRequestParamMap.get("item_cd")!=null){
					session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
				} */
		  
		  		log.info("============2222333444============"+pRequestParamMap.toString());
		 /* if(pRequestParamMap.get("REG_MONTH")!= null){
			String REG_MONTH =pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH= REG_MONTH.replaceAll("-",""); 
			log.info(">>>> :serchRegDtEnd"+ REG_MONTH); 
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		 }*/
		  		
		  log.info("============CONTENT ============"+pRequestParamMap.get("CONTENT"));
		  log.info("============TITLE ============"+pRequestParamMap.get("TITLE"));
		  
				Map<String, Object> resultMap = new HashMap<String, Object>();
				log.info("resultMap++++++++++++"+resultMap);
				
				try{				
					
					adminBbsService.insertAdminFaq(pRequestParamMap);							
				
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
		 @RequestMapping(value="/admin/updateAdminFaq.json")
			public String updateAdminNotice(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse,
					HttpSession  session,
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 	
			 		ModelMap model)
			{		 						
		/*  if(pRequestParamMap.get("item_cd")!=null){
					session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
				} */
		  
		  		log.info("============2222333444============"+pRequestParamMap.toString());
		 /* if(pRequestParamMap.get("REG_MONTH")!= null){
			String REG_MONTH =pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH= REG_MONTH.replaceAll("-",""); 
			log.info(">>>> :serchRegDtEnd"+ REG_MONTH); 
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		 }*/
		  		
		  log.info("============CONTENT ============"+pRequestParamMap.get("CONTENT"));
		  log.info("============TITLE ============"+pRequestParamMap.get("TITLE"));
		  log.info("============SEQ ============"+pRequestParamMap.get("SEQ"));
				Map<String, Object> resultMap = new HashMap<String, Object>();
				log.info("resultMap++++++++++++"+resultMap);
				
				try{				
					
					adminBbsService.updateAdminFaq(pRequestParamMap);							
				System.err.println("ddddddddddddddddd");
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
		 
		 @RequestMapping(value="/admin/deleteAdminFaq.json")
			public String deleteAdminFaq(
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
								adminBbsService.deleteAdminFaq(pRequestParamMap);			
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
