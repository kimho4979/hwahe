package com.fpminput.mntr.mba01.controller;

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
import com.fpminput.mntr.mba01.domain.Mba01VO;
import com.fpminput.mntr.mba01.service.Mba01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mba01Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Mba01Service mba01Service;

	@RequestMapping(value="/mba01/mba01.do")
	public String cnsmpTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		
		return "/mba01/cnsmpTrendInput";
	}
	
	@RequestMapping(value="/mba11/mba11.do")
	public String mobileCnsmpTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");

		return "/mobile/maa11/cnsmpTrendInput";
	}

	@RequestMapping(value="/mntr/mba01/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
  		log.info("========================"+pRequestParamMap.get("gridUpdate"));
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)mba01Service.selectCnsmpTrendInput(pRequestParamMap);				
			
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
	
	@RequestMapping(value="/mntr/mba01/gridListAll.json")
	public String gridListAll(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
  		log.info("========================"+pRequestParamMap.get("gridUpdate"));
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<?> resultListAll  =  (List<?>)mba01Service.selectCnsmpTrendInputAll(pRequestParamMap);				
			
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
	
	@RequestMapping(value="/mntr/mba01/gridListSeq.json")
	public String gridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
		
		try{
			String seqNo = (String)pRequestParamMap.get("seqNo");
			
			Mba01VO mba01vo = new Mba01VO();
			mba01vo.setSeqNo(seqNo);
			
			Mba01VO result  =  mba01Service.selectCnsmpTrendInputSeq(mba01vo);				
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
	
	@RequestMapping(value="/mba01/cnsmpTrendInput_popup.do")
	public String ctvtTrendInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
	 
		log.info("===========================================");
	  	log.info("======  maa01 ======");
	  	log.info("===========================================");		  	
	 	log.info("maa01+++++++++ : " + pRequestParamMap.toString());
	 
		return "/mba01/cnsmpTrendInput_popup";
	}
	
	@RequestMapping(value="/mntr/mba01/insertCnsmpTrendInput.json")
	public String insertCnsmpTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============insertCnsmpTrendInput============"+pRequestParamMap.toString());
  		log.info("============insertCnsmpTrendInput============"+pRequestParamMap.toString());
  		log.info("============QTY ============"+pRequestParamMap.get("QTY"));
  
  		if(pRequestParamMap.get("QTY")!= null){	
  			String QTY2 = pRequestParamMap.get("QTY").toString();
  			String QTY= QTY2.replace(",","");
  			pRequestParamMap.put("QTY", QTY);
  		}	  	 
  	 	  
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			mba01Service.insertCnsmpTrendInput(pRequestParamMap);							
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
	
	@RequestMapping(value="/mntr/mba01/updateCnsmpTrendInput.json")
	public String updateCnsmpTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		log.info("============updateCnsmpTrendInput============"+pRequestParamMap.toString());
  			 
		if(pRequestParamMap.get("QTY")!= null){	
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY= QTY2.replace(",","");
			pRequestParamMap.put("QTY", QTY);
		}	  	  		  	 
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		
		try{				
			mba01Service.updateCnsmpTrendInput(pRequestParamMap);							
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
	
	@RequestMapping(value="/mntr/mba01/deleteCnsmpTrendInput.json")
	public String deleteCnsmpTrendInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
					mba01Service.deleteCnsmpTrendInput(pRequestParamMap);
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
