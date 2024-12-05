package com.fpdisys.dist.hab06.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.JsonUtils;
import com.fpdisys.base.util.WoorimUtil;
import com.fpdisys.base.util.WoorimUtil.DATEPATTERN;
import com.fpdisys.dist.hab06.domain.Hab06VO;
import com.fpdisys.dist.hab06.service.Hab06Service;

import egovframework.rte.fdl.property.EgovPropertyService;
@Controller
public class Hab06Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Hab06Service hab06Service;


	@RequestMapping(value="/hab06/hab06_backup.do")
	public String selectHab06Bak(
 			HttpServletRequest pRequest,
				HttpServletResponse pResponse,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {


		log.info("===========output=============");
 		log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
 		printRequest(pRequest);



	 	 Map<String, Object> resultMap = new HashMap<String, Object>();
	 	 List<Hab06VO> hab06List = null;

		try{


				// 화훼 구분 셋팅
				String searchProductGubun ="";
				if(pRequestParamMap.get("searchProductGubun")!=null &&
					!StringUtils.isBlank(pRequestParamMap.get("searchProductGubun").toString())){
					searchProductGubun =pRequestParamMap.get("searchProductGubun").toString();
					pRequestParamMap.put("searchProductGubun", searchProductGubun);
				}else{
					searchProductGubun ="1";
					pRequestParamMap.put("searchProductGubun", searchProductGubun);
				}

				model.addAttribute("searchProductGubun", searchProductGubun);

				// 공판장 셋팅
				String cmpCd ="0000000001";
				if(pRequestParamMap.get("searchCmpCd")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchCmpCd").toString())){

					cmpCd = pRequestParamMap.get("searchCmpCd").toString();
				}
				pRequestParamMap.put("searchCmpCd", cmpCd);
				model.addAttribute("searchCmpCd", cmpCd);

				// 날짜 셋팅
				String searchYear = WoorimUtil.convertDateToString(new Date(),DATEPATTERN.YearToDay).substring(0,4);
				if(pRequestParamMap.get("searchYear")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchYear").toString())){
					searchYear  = pRequestParamMap.get("searchYear").toString();


				}
				pRequestParamMap.put("searchYear", searchYear);
				model.addAttribute("searchYear", searchYear);

				List<Hab06VO> resultList = (List<Hab06VO>)hab06Service.selectHab06Bak(pRequestParamMap);

				List<Hab06VO> resultHapList = (List<Hab06VO>)hab06Service.selectHab06HapBak(pRequestParamMap);

				List <Hab06VO> resultChartList = (List<Hab06VO>)hab06Service.selectHab06ChartBak(pRequestParamMap);

			String jsonList =  JsonUtils.toJson(resultChartList);

			model.addAttribute("resultList", resultList);
			model.addAttribute("resultHapList", resultHapList);
			model.addAttribute("jsonList", jsonList);


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


		  	return "/auction/Hab06Old";

	 }

	@RequestMapping(value="/hab06/hab06.do")
	public String selectHab06(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap
			, @RequestParam(value="year", required=false) String year
			, ModelMap model) {

		model.addAttribute("year", year);
		return "/auction/Hab06";

	}

	@RequestMapping(value="/hab06/hab06ChartData.json")
	public String selectHab06Chart(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<Hab06VO> list = (List<Hab06VO>)hab06Service.selectHab06Chart(pRequestParamMap);

			model.addAttribute("list", list);
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

	@RequestMapping(value="/hab06/hab06SaleDate.json")
	public String hab06SaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<Hab06VO> list = (List<Hab06VO>)hab06Service.getSaleDate(pRequestParamMap);

			model.addAttribute("list", list);
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

	@RequestMapping(value="/hab06/hab06Data.json")
	public String hab06Data(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<Hab06VO> list = (List<Hab06VO>)hab06Service.selectHab06(pRequestParamMap);

			model.addAttribute("list", list);
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

	@RequestMapping(value="/hab06/selectHab06Hap.json")
	public String selectHab06Hap(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<Hab06VO> list = (List<Hab06VO>)hab06Service.selectHab06Hap(pRequestParamMap);

			model.addAttribute("list", list);
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
