package com.fpdisys.admin.log.controller;

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

import com.fpdisys.admin.log.service.UserLogService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class UserLogController extends BaseController {
protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private UserLogService userLogService;
	
	 @RequestMapping(value="/admin/userLogForm.do")
		public String userLogForm(
		  			HttpServletRequest pRequest, 
		 				HttpServletResponse pResponse, 
			  		@RequestParam Map<String, Object> pRequestParamMap,
			  		ModelMap model) throws Exception {		

				  	log.info("===========================================");
				  	log.info("======  userLogForm ======");
				  	log.info("===========================================");
				  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
				  	printRequest(pRequest);
				  	log.info("===========================================");
				  	//----------------------------------------------------------------
				  	// Login check
				  	//----------------------------------------------------------------
				  	 return "/admin/ad003";
			 }
	 
	 @RequestMapping(value="/admin/userLogList.json")
		public String getUserLogList(
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
				List<EgovMap> resultList=(List<EgovMap>) userLogService.userLogList(pRequestParamMap);				


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

}
