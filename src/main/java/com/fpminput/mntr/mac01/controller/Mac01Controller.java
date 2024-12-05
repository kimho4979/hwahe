package com.fpminput.mntr.mac01.controller;

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
import com.fpminput.mntr.mac01.domain.Mac01VO;
import com.fpminput.mntr.mac01.service.Mac01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mac01Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Mac01Service mac01Service;
	
	@RequestMapping(value="/mac01/mac01.do")
	public String selectCtvtTrendInput(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========lmhlmh==============");
			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				
				return "redirect:/mnt/mem01/mem01Form.do";
			}
		 
		 return "/mac01/ctvtTrendInput";
	}
	
	@RequestMapping(value="/mac11/mac11.do")
	public String mobileSelectCtvtTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}		 
		
		return "/mobile/maa11/ctvtTrendInput";
	}
	
	@RequestMapping(value="/mntr/mac01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){	  
	  		
		log.info("========================"+pRequestParamMap.get("gridUpdate"));
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			List<EgovMap> resultList  =  (List<EgovMap>)mac01Service.selectCtvtTrendInput(pRequestParamMap);				

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
	 
	@RequestMapping(value="/mntr/mac01/gridListAll.json")
	public String gridListAll(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("========================"+pRequestParamMap.get("gridUpdate"));
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try{
			List<?> resultListAll  =  (List<?>)mac01Service.selectCtvtTrendInputAll(pRequestParamMap);				
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
	 
	@RequestMapping(value="/mntr/mac01/gridListSeq.json")
	public String gridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		try{
			String seqNo = (String)pRequestParamMap.get("seqNo");
		
			Mac01VO mac01vo = new Mac01VO();
			mac01vo.setSeqNo(seqNo);
		
			Mac01VO result =  mac01Service.selectCtvtTrendInputSeq(mac01vo);				
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
	 
	@RequestMapping(value="/mac01/ctvtTrendInput_popup.do")
	public String ctvtTrendInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("===========================================");
	  	log.info("======  maa01 ======");
	  	log.info("===========================================");		  	
	 	log.info("maa01+++++++++ : " + pRequestParamMap.toString());
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}		 
		return "/mac01/ctvtTrendInput_popup";
	}
	 
	@RequestMapping(value="/mntr/mac01/insertCtvtTrendInput.json")
	public String insertCtvtTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============insertCtvtTrendInput============"+pRequestParamMap.toString());	
		log.info("============AREA ============"+pRequestParamMap.get("AREA"));
	  
		if(pRequestParamMap.get("AREA")!= null){	
			String AREA2 = pRequestParamMap.get("AREA").toString();
			String AREA= AREA2.replace(",","");
			pRequestParamMap.put("AREA", AREA);
		}	  	 
	  	 
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			mac01Service.insertCtvtTrendInput(pRequestParamMap);							
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
	 
	@RequestMapping(value="/mntr/mac01/updateCtvtTrendInput.json")
	public String updateCtvtTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {		 						

		log.info("============2222333444update============"+pRequestParamMap.toString());
		if(pRequestParamMap.get("REG_MONTH")!= null){
			String REG_MONTH =pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH= REG_MONTH.replaceAll("-",""); 
			log.info(">>>> :serchRegDtEnd"+ REG_MONTH); 
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		}
	  			 
		if(pRequestParamMap.get("AREA")!= null){	
			String AREA2 = pRequestParamMap.get("AREA").toString();
			String AREA= AREA2.replace(",","");
			pRequestParamMap.put("AREA", AREA);
		}	  	  		  	 
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
			
		try{				
			mac01Service.updateCtvtTrendInput(pRequestParamMap);							
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
	 
	@RequestMapping(value="/mntr/mac01/deleteCtvtTrendInput.json")
	public String deleteCtvtTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
					pRequestParamMap.put("PUM_NAME",D2);	 
					pRequestParamMap.put("GOOD_NAME",D3);	
					pRequestParamMap.put("CHUL_NO",D4);	
					pRequestParamMap.put("SEQ_NO",D5);
					mac01Service.deleteCtvtTrendInput(pRequestParamMap);
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
