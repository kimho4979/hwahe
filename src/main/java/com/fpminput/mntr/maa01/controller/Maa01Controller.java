package com.fpminput.mntr.maa01.controller;

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

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.maa01.service.Maa01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Maa01Controller extends BaseController {

protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Maa01Service maa01Service;
	
	@RequestMapping(value="/maa01/maa01.do")
	public String selectShippedInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/maa01/shipmntPrearngeVolm";
	}
	
	// 출하물량
	@RequestMapping(value="/maa02/maa02.do")
	public String selectShipmentInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				

		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/maa02/shipmntPrearngeVolm";
	}
	
	@RequestMapping(value="/maa11/maa11.do")
	public String mobileSelectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "/mobile/maa11/chulhayejung";
	}
	
	@RequestMapping(value="/maa22/maa22.do")
	public String mobileSelectCropInfoInput1(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
			
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}	
		
		return "/mobile/maa11/chulhamulrynag";
	}
	
	@RequestMapping(value="/maa01/maa01_02.do")
	public String selectCropInfoInput2(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========lmhlmh==============");

			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				
				return "redirect:/mnt/mem01/mem01Form.do";
			}	
		 
		 return "/maa01/shipmntPrearngeVolm2";
	}
	
	@RequestMapping(value="/mntr/maa01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  
		 log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());
			JSONObject obj= new JSONObject();
			String startCount = "";
			String endCount = "";
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
				List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm(pRequestParamMap);				
			
				
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
	 
	@RequestMapping(value="/mntr/maa02/gridList.json")
	public String gridList02(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	
		log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());
		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";

		if(pRequestParamMap.get("startCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
			startCount =pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}
		if(pRequestParamMap.get("endCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
			endCount =pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="15";
			pRequestParamMap.put("endCount", endCount);
		}
		
		String pageNo2= "";
		if(pRequestParamMap.get("pageNo2")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
			pageNo2 =pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		}else{
			obj.put("pageNo2", "1");
		}

		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm2(pRequestParamMap);				

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
	 
	@RequestMapping(value="/mntr/maa01/gridListMobile.json")
	public String gridListMobile(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());
		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";

		if(pRequestParamMap.get("startCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
			startCount =pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}
		
		if(pRequestParamMap.get("endCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
			endCount =pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="3";
			pRequestParamMap.put("endCount", endCount);
		}
			
		String pageNo2= "";
		if(pRequestParamMap.get("pageNo2")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
			pageNo2 =pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		}else{
			obj.put("pageNo2", "1");
		}

		log.info("obj+++++++++ : " + obj.toString());
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm(pRequestParamMap);				

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
	 
	 
	@RequestMapping(value="/mntr/maa11/gridList.json")
	public String mobileGridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());
		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())){
			startCount =pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			pRequestParamMap.put("startCount", startCount.trim());
		}

		if(pRequestParamMap.get("endCount")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())){
			endCount =pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			pRequestParamMap.put("endCount", endCount.trim());
		}
			
		String pageNo2= "";
		
		if(pRequestParamMap.get("pageNo2")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())){
			pageNo2 =pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		}else{
			obj.put("pageNo2", "1");
		}

		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm(pRequestParamMap);				

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
	 
	
	 
	@RequestMapping(value="/maa01/shipmntPrearngeVolm_popup.do")
	public String shipmntPrearngeVolm_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 
		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");		  	
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());
		log.info("============CHANGE_NO ============ "+pRequestParamMap.get("CHANGE_NO"));

		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}	

		String changeNo = (String) pRequestParamMap.get("CHANGE_NO");
		model.addAttribute("CHANGE_NO",changeNo);

		return "/maa01/shipmntPrearngeVolm_popup";
	}
	
	@RequestMapping(value="/mntr/maa01/insertShipmntPrearngeVolm.json")
	public String insertShipmntPrearngeVolm(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 			
	
		log.info("============2222333444============"+pRequestParamMap.toString());
		log.info("============ITEM_CD ============"+pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============"+pRequestParamMap.get("QTY"));
		log.info("============CHANG_NO========"+pRequestParamMap.get("CHANGE_NO"));

		if(pRequestParamMap.get("QTY") != null){	
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY= QTY2.replace(",","");
			pRequestParamMap.put("QTY", QTY);
		}
	  
		if(pRequestParamMap.get("CHANGE_NO") != null){
			String CHANGE_NO2 = pRequestParamMap.get("CHANGE_NO").toString();
			String CHANGE_NO = CHANGE_NO2.replace(",", "");
			pRequestParamMap.put("CHANGE_NO", CHANGE_NO);
		}

		String SESSION_USER_ID = pRequestParamMap.get("SESSION_USER_ID").toString();
		pRequestParamMap.put("SESSION_USER_ID", SESSION_USER_ID);
	  
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		// 출하물량 등록
		// biz
		try{				
			log.info("---------------------------------" + pRequestParamMap);
			maa01Service.insertShipmntPrearngeVolm(pRequestParamMap);							
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
	 
	@RequestMapping(value="/mntr/maa11/mobileInsertShipmntPrearngeVolm.json")
	public String mobileInsertShipmntPrearngeVolm(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  		
		log.info("============2222333444============"+pRequestParamMap.toString());
		log.info("============ITEM_CD ============"+pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============"+pRequestParamMap.get("QTY"));
	  

		if(pRequestParamMap.get("QTY")!= null){	
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY= QTY2.replace(",","");
			pRequestParamMap.put("QTY", QTY);
		}
	  
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);

		try{				
			maa01Service.insertShipmntPrearngeVolm(pRequestParamMap);							
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
	 
	@RequestMapping(value="/mntr/maa01/updateShipmntPrearngeVolm.json")
	public String updateShipmntPrearngeVolm(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		
		log.info("============2222333444update============"+pRequestParamMap.toString());
	  
		if(pRequestParamMap.get("REG_MONTH")!= null){
			String REG_MONTH =pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH= REG_MONTH.replaceAll("-",""); 

			log.info(">>>> :serchRegDtEnd"+ REG_MONTH); 
			
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		}
	  
		log.info("============ITEM_CD  update============"+pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============"+pRequestParamMap.get("QTY"));
		log.info("============MARKET_CD ============"+pRequestParamMap.get("MARKET_CD"));
		log.info("============GUBN ============"+pRequestParamMap.get("GUBN"));

		if(pRequestParamMap.get("QTY")!= null){	
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY= QTY2.replace(",","");
			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{				
			maa01Service.updateShipmntPrearngeVolm(pRequestParamMap);							
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
	 
	@RequestMapping(value="/mntr/maa01/updateShipmntPrearngeVolmMobile.json")
	public String updateShipmntPrearngeVolmMobile(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  
		log.info("============2222333444update============"+pRequestParamMap.toString());
	  
		if(pRequestParamMap.get("REG_MONTH")!= null){
			String REG_MONTH =pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH= REG_MONTH.replaceAll("-",""); 

			log.info(">>>> :serchRegDtEnd"+ REG_MONTH); 
			
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		}
	  		
	  
		log.info("============ITEM_CD  update============"+pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============"+pRequestParamMap.get("QTY"));
		log.info("============MARKET_CD ============"+pRequestParamMap.get("MARKET_CD"));
		log.info("============GUBN ============"+pRequestParamMap.get("GUBN"));

		if(pRequestParamMap.get("QTY")!= null){	
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY= QTY2.replace(",","");

			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			maa01Service.updateShipmntPrearngeVolmMobile(pRequestParamMap);							
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
	
	@RequestMapping(value="/mntr/maa01/deleteShipmntPrearngeVolm.json")
	public String deleteShipmntPrearngeVolm(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		 
		String gridResult = pRequestParamMap.toString();
		 
		
		String s2 = gridResult.replace("{","");
		String s3 = s2.replace("}","");
		String s4 = s3.replace("=","");		  
		String[] result = s4.split("!");
		

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
					pRequestParamMap.put("REG_DATE",D1);
					pRequestParamMap.put("PUM_NAME",D2);	 
					pRequestParamMap.put("GOOD_NAME",D3);	
					pRequestParamMap.put("CHUL_NO",D4);	
					pRequestParamMap.put("GUBN",D5);
					pRequestParamMap.put("MARKET_CD",D6);
					pRequestParamMap.put("SEQ_NO",D7);
					
					maa01Service.deleteShipmntPrearngeVolm(pRequestParamMap);
					
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

	@RequestMapping(value="/mntr/maa11/deleteShipmntPrearngeVolm.json")
	public String mobileDeleteShipmntPrearngeVolm(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  		
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
		 // for debug

		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 log.info("resultMap++++++++++++"+resultMap);
		
		 String D1 ="";
		 String D2 ="";
		 String D3 ="";
		 String D4 ="";
		 String D5 ="";
		 String D6 ="";

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
					 pRequestParamMap.put("REG_DATE",D1);
					 pRequestParamMap.put("PUM_NAME",D2);	 
					 pRequestParamMap.put("GOOD_NAME",D3);	
					 pRequestParamMap.put("CHUL_NO",D4);	
					 pRequestParamMap.put("GUBN",D5);
					 pRequestParamMap.put("MARKET_CD",D6);
					
					 maa01Service.deleteShipmntPrearngeVolm(pRequestParamMap);			
				 }					 
			 };
		} catch (ArithmeticException e) {
			 log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
		}catch (NumberFormatException e) {
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
	 
	@RequestMapping(value="/mntr/maa01/gridList2.json")
	public String gridList2(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount2").toString())){
			startCount =pRequestParamMap.get("startCount2").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}
		
		if(pRequestParamMap.get("endCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount2").toString())){
			endCount =pRequestParamMap.get("endCount2").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo3= "";
		
		if(pRequestParamMap.get("pageNo3")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo3").toString())){
			pageNo3 =pRequestParamMap.get("pageNo3").toString();
			obj.put("pageNo3", pageNo3);
		}else{
			obj.put("pageNo3", "1");
		}

		log.info("obj+++++++++ : " + obj.toString());											
		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm2(pRequestParamMap);	
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
	 
	@RequestMapping(value="/mntr/maa01/gridList2Mobile.json")
	public String gridList2Mobile(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount2").toString())){
			startCount =pRequestParamMap.get("startCount2").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}
		
		if(pRequestParamMap.get("endCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount2").toString())){
			endCount =pRequestParamMap.get("endCount2").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="3";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo3= "";
		if(pRequestParamMap.get("pageNo3")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo3").toString())){
			pageNo3 =pRequestParamMap.get("pageNo3").toString();
			obj.put("pageNo3", pageNo3);
		}else{
			obj.put("pageNo3", "1");
		}

		log.info("gridList2Mobile+++pageNo3pageNo3pageNo3+++++++++ : " + obj.toString());											
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm2(pRequestParamMap);	
			
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
	 
	@RequestMapping(value="/mntr/maa11/gridList2.json")
	public String mobileGridList2(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount2").toString())){
			startCount =pRequestParamMap.get("startCount2").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			pRequestParamMap.put("startCount", startCount);
		}

		if(pRequestParamMap.get("endCount2")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount2").toString())){
			endCount =pRequestParamMap.get("endCount2").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo3= "";
		
		if(pRequestParamMap.get("pageNo3")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo3").toString())){
			pageNo3 =pRequestParamMap.get("pageNo3").toString();
			obj.put("pageNo3", pageNo3);
		}else{
			obj.put("pageNo3", "1");
			log.info("obj+++++++++ : " + obj.toString());											
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectShipmntPrearngeVolm2(pRequestParamMap);	
				
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
		}
		return "jsonView";
	}

	@RequestMapping(value="/maa02/shipmntPrearngeVolm_popup.do")
	public String shipmntPrearngeVolm_popup2(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");		  	
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}	
		return "/maa02/shipmntPrearngeVolm_popup";
	}
	 
	@RequestMapping(value="/mntr/maa01/gridListTotal.json")
	public String gridListTotal(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());

		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount3")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount3").toString())){
			startCount =pRequestParamMap.get("startCount3").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}
		
		if(pRequestParamMap.get("endCount3")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount3").toString())){
			endCount =pRequestParamMap.get("endCount3").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo4= "";
		
		if(pRequestParamMap.get("pageNo4")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo4").toString())){
			pageNo4 =pRequestParamMap.get("pageNo4").toString();
			obj.put("pageNo4", pageNo4);
		}else{
			obj.put("pageNo4", "1");
		}
		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectTotalVolm(pRequestParamMap);				
				
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
	 
	@RequestMapping(value="/mntr/maa01/gridListTotal2.json")
	public String gridListTotal2(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		log.info("gridListgridListgridList+++++++++ : " + pRequestParamMap.toString());

		JSONObject obj= new JSONObject();
		String startCount = "";
		String endCount = "";
		if(pRequestParamMap.get("startCount4")!=null && !StringUtils.isBlank(pRequestParamMap.get("startCount4").toString())){
			startCount =pRequestParamMap.get("startCount4").toString();
			pRequestParamMap.put("startCount", startCount);
		}else{
			startCount ="1";
			pRequestParamMap.put("startCount", startCount);
		}

		if(pRequestParamMap.get("endCount4")!=null && !StringUtils.isBlank(pRequestParamMap.get("endCount4").toString())){
			endCount =pRequestParamMap.get("endCount4").toString();
			pRequestParamMap.put("endCount", endCount);
		}else{
			endCount ="15";
			pRequestParamMap.put("endCount", endCount);
		}
			
		String pageNo5= "";
		if(pRequestParamMap.get("pageNo5")!=null && !StringUtils.isBlank(pRequestParamMap.get("pageNo5").toString())){
			pageNo5 =pRequestParamMap.get("pageNo5").toString();
			obj.put("pageNo5", pageNo5);
		}else{
			obj.put("pageNo5", "1");
		}

		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			List<EgovMap> resultList  =  (List<EgovMap>)maa01Service.selectTotalVolm2(pRequestParamMap);				

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
