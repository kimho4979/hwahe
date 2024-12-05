package com.fpminput.mntr.mbb01.controller;

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

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.mbb01.domain.Mbb01VO;
import com.fpminput.mntr.mbb01.service.Mbb01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mbb01Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Mbb01Service mbb01Service;
	
	@RequestMapping(value="/mbb01/mbb01.do")
	public String cnsmpPcInput(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========lmhlmh==============");
			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				
				return "redirect:/mnt/mem01/mem01Form.do";
			}
		 
		 
		 return "/mbb01/cnsmpPcInput";
	}
	
	@RequestMapping(value="/mbb11/mbb11.do")
	public String mobileCnsmpPcInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "/mobile/maa11/cnsmpPcInput";
	}
	
	
	@RequestMapping(value="/mntr/mbb01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  		
		log.info("========================"+pRequestParamMap.get("gridUpdate"));
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)mbb01Service.selectCnsmpPcInput(pRequestParamMap);				
			
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
	
	@RequestMapping(value="/mntr/mbb01/gridListAll.json")
	public String gridListAll(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
  		log.info("========================"+pRequestParamMap.get("gridUpdate"));
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<?> resultListAll  =  (List<?>)mbb01Service.selectCnsmpPcInputAll(pRequestParamMap);				
			
			model.addAttribute("list", resultListAll);
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
	
	@RequestMapping(value="/mntr/mbb01/gridListSeq.json")
	public String gridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		
		try{
			String seqNo = (String)pRequestParamMap.get("seqNo");
			
			Mbb01VO mbb01vo = new Mbb01VO();
			mbb01vo.setSeqNo(seqNo);
			
			Mbb01VO result  =  (Mbb01VO)mbb01Service.selectCnsmpPcInputSeq(mbb01vo);				
			model.addAttribute("result", result);
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
	
	@RequestMapping(value="/mbb01/cnsmpPcInput_popup.do")
	public String cnsmpPcInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
	
		log.info("===========================================");
	  	log.info("======  maa01 ======");
	  	log.info("===========================================");		  	
	 	log.info("maa01+++++++++ : " + pRequestParamMap.toString());
	 
		return "/mbb01/cnsmpPcInput_popup";
		
	}
	
	@RequestMapping(value="/mntr/mbb01/insertCnsmpPcInput.json")
	public String insertCnsmpPcInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============2222333444============"+pRequestParamMap.toString());

		log.info("============SALE_PRICE ============"+pRequestParamMap.get("SALE_PRICE"));
		if(pRequestParamMap.get("SALE_PRICE")!= null){	
			String SALE_PRICE2 = pRequestParamMap.get("SALE_PRICE").toString();
			String SALE_PRICE= SALE_PRICE2.replace(",","");
			pRequestParamMap.put("SALE_PRICE", SALE_PRICE);
		}	  	 
  	 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			
			mbb01Service.insertCnsmpPcInput(pRequestParamMap);							
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
	
	@RequestMapping(value="/mntr/mbb01/updateCnsmpPcInput.json")
	public String updateCnsmpPcInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============updateCnsmpPcInput============"+pRequestParamMap.toString());

		if(pRequestParamMap.get("SALE_PRICE")!= null){	
			String SALE_PRICE2 = pRequestParamMap.get("SALE_PRICE").toString();
			String SALE_PRICE= SALE_PRICE2.replace(",","");
			pRequestParamMap.put("SALE_PRICE", SALE_PRICE);
		}  	  		  	 
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			mbb01Service.updateCnsmpPcInput(pRequestParamMap);							
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
	
	@RequestMapping(value="/mntr/mbb01/deleteCnsmpPcInput.json")
	public String deleteCnsmpPcInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
		 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		String D1 ="";
		String D2 ="";
		String D3 ="";
		String D4 ="";
		String D5 ="";
			
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
					pRequestParamMap.put("REG_DATE",D1);
					pRequestParamMap.put("CHUL_NO",D2);	 
					pRequestParamMap.put("PUM_NAME",D3);	
					pRequestParamMap.put("GOOD_NAME",D4); 
					pRequestParamMap.put("SEQ_NO",D5);
					mbb01Service.deleteCnsmpPcInput(pRequestParamMap);
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
