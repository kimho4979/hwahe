package com.fpdisys.admin.user.controller;

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
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.prog.domain.ProgVO;
import com.fpdisys.admin.user.service.AdminUserService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.mvc.PageableTO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminUserController extends BaseController {
protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private AdminUserService adminUserService;
	
	 @RequestMapping(value="/admin/adminUserForm.do")
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
				  	
				  	
				  	 return "/admin/AdminUserForm";
				  	
			 }
	 
	 @RequestMapping(value="/admin/searchAdminUserList.json")
		public String searchAdminUserList(
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
				
				List<ProgVO> resultList =(List<ProgVO>)adminUserService.selectAdminUserSearch(pRequestParamMap);			


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
	 		 
	 @RequestMapping(value="/admin/adminUserInsertPopup.do")
		public String adminUserInsertPopup(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminUserInsertPopupForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/adminUserInsertPopup";
				  	
		}
	 
	 
	 @RequestMapping(value="/admin/checkedUserId.json")
		public String checkedUserId(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  checkedUserId ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			
			
			//TODO 버튼 권한
			
			
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			
			
			
			  	
			try{
				String msg = adminUserService.checkedUserId(pRequestParamMap);
				log.debug("msg ============["+msg+"]");
				
	 			String dupCheck ="OK";
	 		 	int iCnt = adminUserService.selectAdminUserDuplicated(pRequestParamMap);
	 		 	log.debug("iCnt ============["+iCnt+"]");
	 			
	 		 	if(iCnt>0){
	 				dupCheck="NG";
	 			}
	 			
	 		 	log.debug("dupCheck ============["+dupCheck+"]");
				
				model.addAttribute("dupCheck",dupCheck);
	 			model.addAttribute("msg",msg ); 			
	 		
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
	 
	 @RequestMapping(value="/admin/adminSearchSanCdPopup.do")
		public String adminSearchSanCdPopupForm(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminSearchSanCdPopupForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/adminSearchSanCdPopupForm";
				  	
		}
	 
	 
	 @RequestMapping(value="/admin/searchAdminSanCdList.json")
		public String searchAdminSanCdList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  searchAdminSanCdList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			
			
			//TODO 버튼 권한
			
			
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PageableTO pageTo = new PageableTO();
			int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
		
			int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
			
			pageTo.setCurrentPage(currentPage);
			pageTo.setPageSize(pageSize);
			
			
			
			log.info("===========================================");
			log.info(">>>>1 pageTo.toString() : " + pageTo.toString());
			log.info("===========================================");
			  	
			try{
				List<ProgVO> progList =(List<ProgVO>)adminUserService.selectAdminSanCdPageAble(pRequestParamMap);
	 		 
				log.info(">>>>progList.size() : " + progList.size());
	 		 	int total =	adminUserService.selectCntAdminSanCd(pRequestParamMap);
	 		 	log.info(">>>>total : " + total);
	 		  	Long totalLong = Long.parseLong(total+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
	 		  	int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			
	 		 	pageTo.setTotalPages(totalPage);
			 
	 			model.addAttribute("list",progList );
	 		
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
			log.info("===========================================");
		 	log.info(">>>>pageTo.toString() : " + pageTo.toString());
		 	log.info("===========================================");
			model.addAttribute("page",pageTo );
	 		return "jsonView";
			
		}
	 @RequestMapping(value="/admin/saveInsertUserProc.json")
		public String saveInsertUserProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  saveInsertUserProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			log.info("===========================================");
			
			log.info("===========================================");
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			try {
					Map<String, Object> rMap = new HashMap<String, Object>();
					
					rMap.put("userId",pRequestParamMap.get("userId"));
					rMap.put("userType",pRequestParamMap.get("userType"));
					rMap.put("useYn",pRequestParamMap.get("useYn"));
					
					if(pRequestParamMap.get("userType").toString().equals("M")){
						rMap.put("compCode",pRequestParamMap.get("compCode"));
						rMap.put("grpAuthCode","M0001");
						rMap.put("remark",pRequestParamMap.get("remark2"));
					
					}else if(pRequestParamMap.get("userType").toString().equals("S")){
						rMap.put("compCode1",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","S0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("A")){
						rMap.put("compCode1",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","A0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("F")){
						rMap.put("compCode1",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","MA0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("D")){
						rMap.put("compCode1",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","D0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}
					
					log.info("===================rMap====================");
					log.info("rMap.toString() ["+rMap.toString()+"]" );
					log.info("===========================================");
					adminUserService.saveInsertUserProc(rMap);
				
				model.addAttribute("message","" );
				
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
	 
	 @RequestMapping(value="/admin/adminUserUpdatePopup.do")
		public String adminUserUpdatePopup(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  adminUserUpdatePopup ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	
				  	
				  	 return "/admin/adminUserUpdatePopup";
				  	
		}
	 
	 @RequestMapping(value="/admin/saveUpdateUserProc.json")
		public String saveUpdateUserProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  saveUpdateUserProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			log.info("===========================================");
			
			log.info("===========================================");
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			try {
					Map<String, Object> rMap = new HashMap<String, Object>();
					
					rMap.put("userId",pRequestParamMap.get("userId"));
					rMap.put("userType",pRequestParamMap.get("userType"));
					rMap.put("oldUserType",pRequestParamMap.get("oldUserType"));
					rMap.put("oldCompCode",pRequestParamMap.get("oldCompCode"));
					rMap.put("useYn",pRequestParamMap.get("useYn"));
					
					if(pRequestParamMap.get("userType").toString().equals("M")){
						rMap.put("compCode",pRequestParamMap.get("compCode"));
						rMap.put("grpAuthCode","M0001");
						rMap.put("remark",pRequestParamMap.get("remark2"));
					
					}else if(pRequestParamMap.get("userType").toString().equals("S")){
						rMap.put("compCode",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","S0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("A")){
						rMap.put("compCode",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","A0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("F")){
						rMap.put("compCode",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","MA0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}else if(pRequestParamMap.get("userType").toString().equals("D")){
						rMap.put("compCode",pRequestParamMap.get("compCode1"));
						rMap.put("grpAuthCode","D0001");
						rMap.put("remark",pRequestParamMap.get("remark"));
					}
					
					if(pRequestParamMap.get("oldUserType").toString().equals("M")){
						rMap.put("oldGrpAuthCode","M0001");
					}else if(pRequestParamMap.get("oldUserType").toString().equals("S")){
						rMap.put("oldGrpAuthCode","A0001");
					}else if(pRequestParamMap.get("oldUserType").toString().equals("A")){
						rMap.put("oldGrpAuthCode","A0001");
					}else if(pRequestParamMap.get("oldUserType").toString().equals("F")){
						rMap.put("oldGrpAuthCode","MA0001");
					}else if(pRequestParamMap.get("oldUserType").toString().equals("D")){
						rMap.put("oldGrpAuthCode","D0001");
					}
					
					log.info("===================rMap====================");
					log.info("rMap.toString() ["+rMap.toString()+"]" );
					log.info("===========================================");
					adminUserService.saveUpdateUserProc(rMap);
				
				model.addAttribute("message","" );
				
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
