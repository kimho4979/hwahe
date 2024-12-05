package com.fpdisys.dist.haa01.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.haa01.service.Haa01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class Haa01Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private Haa01Service haa01Service;
	
	
	@RequestMapping(value="/haa01/haa01.do")
	public String selectHaa01(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){	
		 			  
		/*try{				
			// 공판장 셋팅 
			String cmpCd ="0000000001";
			if(pRequestParamMap.get("searchCmpCd")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchCmpCd").toString())){
					cmpCd = pRequestParamMap.get("searchCmpCd").toString();
			}
			pRequestParamMap.put("searchCmpCd", cmpCd);
			model.addAttribute("searchCmpCd", cmpCd);
				
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}*/
		return "/auction/Haa01";
	 }

	@RequestMapping(value="/haa01/getData.json")
	public String getData(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){	
	 			  
		try{				
			// 공판장 셋팅 
			String cmpCd ="0000000001";
			if(pRequestParamMap.get("searchCmpCd")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchCmpCd").toString())){
					cmpCd = pRequestParamMap.get("searchCmpCd").toString();
			}
			
			pRequestParamMap.put("searchCmpCd", cmpCd);
			model.addAttribute("searchCmpCd", cmpCd);
			
			// 절화
			pRequestParamMap.put("flowerGubun", "1");
			String strText = "시베리아,비탈,백선,포드,카시오피아,거베라,거베라1";
			String[] flowerText = strText.split(",");
			pRequestParamMap.put("flowerText", flowerText);
			
			List<EgovMap> flowerList = haa01Service.selectListFlower(pRequestParamMap);
			List<EgovMap> graphList = haa01Service.selectListCombineGraph(pRequestParamMap);
			
			model.addAttribute("cutFlowertList", flowerList);
			model.addAttribute("listGraph", graphList);
			
			// 난
			pRequestParamMap.put("flowerGubun", "3");
			strText = "만천홍,엘사쿨,골드스타,철골소심,청금";
			flowerText = strText.split(",");
			pRequestParamMap.put("flowerText", flowerText);
			flowerList = haa01Service.selectListFlower(pRequestParamMap);
			graphList = haa01Service.selectListCombineGraph(pRequestParamMap);
			
			model.addAttribute("orchidFlowerList", flowerList);
			model.addAttribute("listGraph2", graphList);
			
			// 관엽
			pRequestParamMap.put("flowerGubun", "2");
			strText = "카랑코에3.5\", 베고니아6\",시클라멘5\",알라바마6\",미니장미3.5\",미니아이비3.5\",카랑코에(일반),아이비(일반),카랑코에,베고니아,안스륨(알라바마),미니장미,아이비(드림캣츠)";
			flowerText = strText.split(",");
			pRequestParamMap.put("flowerText", flowerText);
			flowerList = haa01Service.selectListFlower(pRequestParamMap);
			graphList = haa01Service.selectListCombineGraph(pRequestParamMap);
			
			model.addAttribute("foliagePlantList", flowerList);
			model.addAttribute("listGraph3", graphList);
			
			// 춘란
			pRequestParamMap.put("flowerGubun", "4");
			pRequestParamMap.put("flowerText", "");
			flowerList = haa01Service.selectListFlower(pRequestParamMap);
			graphList = haa01Service.selectListCombineGraph(pRequestParamMap);
			
			model.addAttribute("chunranPlantList", flowerList);
			model.addAttribute("listGraph4", graphList);
				
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}
		return "jsonView";
	 }
		
}
