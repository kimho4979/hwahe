package com.fpdisys.admin.prog.contoller;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.prog.domain.ProgVO;
import com.fpdisys.admin.prog.service.AdminProgService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.mvc.PageableTO;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class AdminProgController extends BaseController { 

protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private AdminProgService adminProgService;
	
	 @RequestMapping(value="/admin/adminProgForm.do")
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
				  	
				  	
				  	 return "/admin/AdminProgForm";
				  	
			 }
	 
	 
	 @RequestMapping(value="/admin/saveProgProc.json")
		public String saveProgProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				@RequestBody String pJsonString,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  saveProgProc ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			log.info("===========================================");
			log.info(">>>>pJsonString : " + pJsonString);
			log.info("===========================================");
			printRequest(pRequest);
			log.info("===========================================");
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			try {
				
				if(!StringUtils.isBlank(pJsonString)){
					pJsonString ="{\"ALL\":"+pJsonString+"}";
				}
				
				List list = getVoFromMultiJson(pJsonString, "ALL", ProgVO.class );
				log.info(">>>>list.toString() : [" + list.toString()+"]");
				log.info("===========================================");
				for ( int idx = 0 ; idx < list.size(); idx++)
				{
					ProgVO rProgm =(ProgVO)list.get(idx);
					Map<String, Object> rMap = new HashMap<String, Object>();
					rMap.put("sysCd", rProgm.getSysCd());
					rMap.put("progCd", rProgm.getProgCd());
					rMap.put("progNm", rProgm.getProgNm());
					rMap.put("progPh", rProgm.getProgPh());
					rMap.put("userId", "admin");
					rMap.put("savAh", rProgm.getSavAh());
					rMap.put("schAh", rProgm.getSchAh());
					rMap.put("exlAh", rProgm.getExlAh());
					rMap.put("fn1Ah", rProgm.getFn1Ah());
					rMap.put("fn2Ah", rProgm.getFn2Ah());
					rMap.put("fn3Ah", rProgm.getFn3Ah());
					rMap.put("fn4Ah", rProgm.getFn4Ah());
					rMap.put("fn5Ah", rProgm.getFn5Ah());
					rMap.put("remark", rProgm.getRemark());
					rMap.put("useYn", rProgm.getUseYn());
					
					log.info("===================rMap====================");
					log.info("rMap.toString() ["+rMap.toString()+"]" );
					log.info("===========================================");
					adminProgService.getMergeProg(rMap);
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
			
			return "jsonView";
			
		}
	 
	 @RequestMapping(value="/admin/searchAdminProgList.json")
		public String searchAdminProgList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  searchAdminProgList ======");
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
				List<ProgVO> progList =(List<ProgVO>)adminProgService.selectProgSearch(pRequestParamMap);
	 		 
				log.info(">>>>progList.size() : " + progList.size());
	 		 	int total = progList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(progList.size()+"");
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
	 
	 
	 @RequestMapping(value="/admin/searchAdminActiveProgList.json")
		public String searchAdminActiveProgList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  searchAdminActiveProgList ======");
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
			
			log.info("===========================================");
			log.info(">>>>1 pageTo.toString() : " + pageTo.toString());
			log.info("===========================================");
			  	
			try{
				List<ProgVO> progList =(List<ProgVO>)adminProgService.getActiveProgSearch(pRequestParamMap);
	 		 
				log.info(">>>>progList.size() : " + progList.size());
	 		 	int total = progList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(progList.size()+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
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
	 @RequestMapping(value="/admin/menuAdminList.do")
		public String menuAdminList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
					 
			log.info("===========================================");
			log.info("======  searchAdminActiveProgList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
		
	 		return "/admin/adminMenu_Popup";
			
		}
}
