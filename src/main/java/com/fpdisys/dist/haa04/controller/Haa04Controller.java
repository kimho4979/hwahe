package com.fpdisys.dist.haa04.controller;

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
import com.fpdisys.dist.haa04.service.Haa04Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Haa04Controller extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private Haa04Service haa04Service;

	/**
	 * 공판장별 주요 거래 지표
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = "/haa04/haa04.do")
	public String selectHaa04(HttpServletRequest pRequest,
			HttpServletResponse pRes,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
						
		return "/auction/Haa04";
	}
	
	@RequestMapping(value="/haa04/selectMainList.json")
	public String selectMainList(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){
	  		
	  	String SALE_YEAR = pRequestParamMap.get("SALE_MONTH").toString();
	  	SALE_YEAR=SALE_YEAR.substring(0,4);	  			  		
	  	String SALE_YEAR2 = pRequestParamMap.get("SALE_MONTH").toString();
	  	SALE_YEAR2=SALE_YEAR2.substring(5,7);
	  	
	  	int aaa= Integer.parseInt( SALE_YEAR);
	  	int bbb = aaa-1 ;
	  	
	  	String AGO_SALE_YEAR= String.valueOf(bbb);	  	
	  	String AGO_SALE_MONTH= AGO_SALE_YEAR+"-"+SALE_YEAR2;

	  	pRequestParamMap.put("AGO_SALE_YEAR", AGO_SALE_YEAR);
	  	pRequestParamMap.put("AGO_SALE_MONTH", AGO_SALE_MONTH);
	  	pRequestParamMap.put("SALE_YEAR", SALE_YEAR);
	  	
	  	String[] searchFlower = pRequestParamMap.get("searchFlower").toString().split(",");
	  	pRequestParamMap.put("searchFlower", searchFlower);
	  		  	
		try{
				List<EgovMap> resultList  =  (List<EgovMap>)haa04Service.selectMainList(pRequestParamMap);		
				List<EgovMap> resultList2  =  (List<EgovMap>)haa04Service.graphMainAmtList(pRequestParamMap);		

				model.addAttribute("searchCmpCd", pRequestParamMap.get("CMP_CD"));
				model.addAttribute("list", resultList);
				model.addAttribute("list2", resultList2);
			
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
			e.printStackTrace();
		} catch (Exception e) {
			log.error("오류발생!!");
		}													
		return "jsonView";
	}
}
