package com.fpditrans.trans.main.controller;


import java.util.HashMap;
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

import com.fpditrans.base.mvc.BaseController;
import com.fpditrans.trans.main.service.TranMainService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : TransMainController.java
 * @Description : TransMainController Class
 *	 
 * @ 메인페이지  콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
@Controller
public class TransMainController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired  
	private TranMainService mainService;
	
	/**
	 * 메인폼 호출 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping(value="/tran/main.do")
	 public String transMainForm(
  			HttpServletRequest pRequest, 
 				HttpServletResponse pResponse, 
	  		@RequestParam Map<String, Object> pRequestParamMap,
	  		ModelMap model) throws Exception {		

		  	log.info("===========================================");
		  	log.info("======  transMainForm ======");
		  	log.info("===========================================");
		  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		  	printRequest(pRequest);
		  	log.info("===========================================");
		  	//----------------------------------------------------------------
		  	// Login check
		  	//----------------------------------------------------------------
		  	String url="";
		  	String userIp=pRequest.getRemoteHost();
		 	String returnUrl="/flowerMain/flowerMain";
		 	
		 	if(userIp!=null&&(userIp.equals("218.239.230.30")||userIp.equals("103.108.108.254")||userIp.equals("127.0.0.1")||userIp.equals("0:0:0:0:0:0:0:1"))){
		 		// 내부망 or 우림ip
		 		HttpSession  session = pRequest.getSession(true);
			  	if(session.getAttribute("CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN")!=null){
			  		url="/tran/mem01/Main";
			  	}else{
			  		url="/tran/mem01/Login";
			  	}
		 	}else{
		 		url="/tran/mem01/Login";
		 	//	return "redirect:/main/flowerMain.do";
		 	}
		 	
		  	
		  	
		  	
		  	 return url;
		  	
	 }
	 
	 /**
	  * 화훼공판장 자료전송 테스트 메소드 
	  * @param pRequest
	  * @param pResponse
	  * @param pRequestParamMap
	  * @param model
	  * @return
	  * @throws Exception
	  */
	 @RequestMapping(value="/tran/Test.do")
	 public String testAction(
  			HttpServletRequest pRequest, 
 				HttpServletResponse pResponse, 
	  		@RequestParam Map<String, Object> pRequestParamMap,
	  		ModelMap model) throws Exception {		

		  	log.info("===========================================");
		  	log.info("======  testAction ======");
		  	log.info("===========================================");
		  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		  	printRequest(pRequest);
		  	log.info("===========================================");
		  	//----------------------------------------------------------------
		  	// Login check
		  	//----------------------------------------------------------------
		  	String filename = pRequestParamMap.get("filename").toString();
			String recode = pRequestParamMap.get("recode").toString();
			log.info("===========================================");
		  	log.info(">>>>  1 filename : " +pRequestParamMap.get("filename").toString());
		  	log.info(">>>>  1 recode : " +pRequestParamMap.get("recode").toString());
		  	/**String a2 = new String(pRequestParamMap.get("recode").toString().getBytes("MS949"),"UTF-8"); 
		  	String a3 = new String(pRequestParamMap.get("recode").toString().getBytes("UTF-8"),"MS949"); 
		  	String a4 = new String(pRequestParamMap.get("recode").toString().getBytes("EUC-KR"),"UTF-8"); 
			String a5 = new String(pRequestParamMap.get("recode").toString().getBytes("ISO-8859-1"),"UTF-8"); 
		  	log.info(">>>>  1 a2 : " +a2);
		  	log.info(">>>>  1 a3 : " +a3);
			log.info(">>>>  1 a4 : " +a4);
			log.info(">>>>  1 a5 : " +a5);**/ 
				log.info("===========================================");
		  	
					 
				Map<String, Object> reqMap = new HashMap<String, Object>();
					reqMap.put("filename", filename);
					reqMap.put("recode", recode);
				log.info("===========================================");
		  	log.info(">>>>  2 reqMap : " +reqMap.toString());
				log.info("===========================================");
			log.info("===========================================");
		  	log.info(">>>>  2 reqMap filename : " +reqMap.get("filename").toString());
		  	log.info(">>>>  2 reqMap recode: " +reqMap.get("recode").toString());
				log.info("===========================================");	
				reqMap =	mainService.insertTest(reqMap);
					
				log.info("===========================================");
				log.info(">>>>  after reqMap : " +reqMap.toString());
				log.info("===========================================");
				
			model.addAttribute("filename",filename );
			model.addAttribute("recode",recode );
		  	
		  	 return "/tran/login/test";
		  	
	 }
	 
	
	 
	 
	 
	
	 
	 
	 
	
	
	
	
	
	
}
