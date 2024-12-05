package com.fpdisys.dist.haa00_new.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.image.service.CommonService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.haa00_new.service.Haa00_newService;
import com.fpdisys.dist.search.service.SearchService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class Haa00_newController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private Haa00_newService haa00_newService;

	
	@Autowired
	private CommonService commonService;

	@RequestMapping(value="/haa00_new/haa00_new.do")
	public String selectHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){

		Calendar strDate = Calendar.getInstance();
		strDate.setTime(new Date());
		strDate.add(Calendar.DATE, -7);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");

		if(pRequestParamMap.get("searchStrDate") != null) {
			model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
		}else {
			//model.addAttribute("searchStrDate", sdf.format(new Date()));
			model.addAttribute("searchStrDate", sdf.format(strDate.getTime()));
			model.addAttribute("searchStrDateM", sdf1.format(strDate.getTime()));
			model.addAttribute("searchStrDateY", sdf2.format(strDate.getTime()));
		}

		if(pRequestParamMap.get("searchEndDate") != null) {
			model.addAttribute("searchEndDate", pRequestParamMap.get("searchEndDate"));
		}else {
			model.addAttribute("searchEndDate", sdf.format(new Date()));
			model.addAttribute("searchEndDateM", sdf1.format(new Date()));
			model.addAttribute("searchEndDateY", sdf2.format(new Date()));
		}

		return "/auction/Haa00_new";
	}

	@RequestMapping(value="/haa00_new/selectMultiAuctionList.json")
	public String selectMultiAuctionList(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			, ModelMap model) {

		logger.debug(">>>>>>>>>>> /haa00_new/selectMultiAuctionList.json");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;

		paramMap.put("searchStrDate", searchStrDate);
		paramMap.put("searchEndDate", searchEndDate);
		paramMap.put("type", type);
		paramMap.put("gubn", gubn);
		paramMap.put("flowerCtgrList", flowerCtgrList);
		paramMap.put("marketList", marketList);
		paramMap.put("itemList", itemList);
		paramMap.put("itemDtlList", itemDtlList);

		if("day".equals(type)){
			list = haa00_newService.selectAuctionDayList(paramMap);
		}else if("month".equals(type)){
			list = haa00_newService.selectAuctionMonthList(paramMap);
		}else{
			searchStrDate += "-01";
			searchEndDate += "-12";
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			list = haa00_newService.selectAuctionYearList(paramMap);
		}

		model.addAttribute("list",list);
		paramMap.clear();
		paramMap.put("type", "all");
		paramMap.put("isGallery", "true");
		List<Map<String,Object>> _list = new LinkedList<>(); 
		_list = commonService.getImgList(paramMap);
		for (Map<String,Object> egov : list) {
			
			for(Map<String,Object> map : _list) {
				if(null != egov && null != egov.get("GOODNAME") && egov.get("GOODNAME").equals(map.get("P_JONG_NAME")) ) {
					//System.out.println("품종이 같음");
					//System.out.println(map.get("FILE_ID"));
					egov.put("FILEPATH", "/admin/img/loc/".concat(map.get("FILE_ID").toString()));
				} else {
					///////////egov.put("FILEPATH","");
				}
			}
			//System.out.println("이미지랑 그리드 조합가능여부조사 : ");
			//System.out.println(o);
		}
		
		return "jsonView";

	 }

	@RequestMapping(value="/haa00_new/selectAuctionList.json")
	public String selectAuctionList(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="gubn[]") List<String> gubn
			, ModelMap model) {

		logger.debug(">>>>>>>>>>> /haa00_new/selectAuctionList.json");
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;

		paramMap.put("flowerCd", flowerCd);
		paramMap.put("cmpCd", cmpCd);
		paramMap.put("itemCd", itemCd);
		paramMap.put("itemCd2", itemCd2);
		paramMap.put("searchStrDate", searchStrDate);
		paramMap.put("searchEndDate", searchEndDate);
		paramMap.put("type", type);
		paramMap.put("gubn", gubn);

		if(type.equals("day")){
			list = haa00_newService.selectAuctionDayList(paramMap);
		}else if(type.equals("month")){
			list = haa00_newService.selectAuctionMonthList(paramMap);
		}else{
			searchStrDate += "-01";
			searchEndDate += "-12";
			paramMap.put("searchStrDate", searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			list = haa00_newService.selectAuctionYearList(paramMap);
		}



		model.addAttribute("list",list);

		return "jsonView";

	 }

	@RequestMapping(value="/haa00_new/selectAuctionListTotal.json")
	public String selectAuctionListTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="gubn[]") List<String> gubn
			,@RequestParam(value="flower[]", required=false) List<String> flowerCtgrList
			,@RequestParam(value="market[]", required=false) List<String> marketList
			,@RequestParam(value="item[]", required=false) List<String> itemList
			,@RequestParam(value="itemDtl[]", required=false) List<String> itemDtlList
			, ModelMap model) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<EgovMap> list;
		
		if(itemList != null && itemList.size() > 0 && itemList.indexOf("6043") > -1){
			itemList.add("6002");
		}

		paramMap.put("searchStrDate", searchStrDate);
		paramMap.put("searchEndDate", searchEndDate);
		paramMap.put("type", type);
		paramMap.put("gubn", gubn);
		paramMap.put("flowerCtgrList", flowerCtgrList);
		paramMap.put("marketList", marketList);
		paramMap.put("itemList", itemList);
		paramMap.put("itemDtlList", itemDtlList);

		list = haa00_newService.selectAuctionListTotal(paramMap);
		
		model.addAttribute("list",list);

		return "jsonView";

	 }

	/**
 	 * 등급정보 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00LvJson.json")
	public String selectHaa00LvJson(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap
			, ModelMap model){
 		try{

 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
	 			if(type.equals("day")){
	 				list = haa00_newService.selectHaaLvDate00(pRequestParamMap);
	 			}else if(type.equals("month")){
	 				list = haa00_newService.selectHaaLvMonth00(pRequestParamMap);
	 			}else{
	 				list = haa00_newService.selectHaaLvYear00(pRequestParamMap);
	 			}
 			}

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
		} catch (Exception e) {
			log.error(e.getMessage());
		}

 		return "jsonView";
	}

 	/**
 	 * 통합 등급정보 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00LvJsonTotal.json")
	public String selectHaa00LvJsonTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="flowerCd") String flowerCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemCd2") String itemCd2
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,@RequestParam(value="cmpCdList[]") List<String> cmpCdList
			, ModelMap model){
 		try{

 			List<EgovMap> list =null;
 			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
 			pRequestParamMap.put("cmpCd", cmpCd);
 			pRequestParamMap.put("flowerCd", flowerCd);
 			pRequestParamMap.put("itemCd", itemCd);
 			pRequestParamMap.put("itemCd2", itemCd2);
 			pRequestParamMap.put("searchStrDate", searchStrDate);
 			pRequestParamMap.put("searchEndDate", searchEndDate);
 			pRequestParamMap.put("type", type);
 			pRequestParamMap.put("cmpCdList", cmpCdList);

 			if(pRequestParamMap.get("itemCd")!=null&&!pRequestParamMap.get("itemCd").equals("")){
 				list = haa00_newService.selectHaa00LvTotal(pRequestParamMap);
 			}

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
		} catch (Exception e) {
			log.error(e.getMessage());
		}

 		return "jsonView";
	}


	/**
 	 * 거래금액분포도 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00InfoJson.json")
	public String selectHab01InfoJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		log.info("====== Haa00InfoJSON ======");

 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa00_newService.selectHaaInfoDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa00_newService.selectHaaInfoMonth00(pRequestParamMap);
 			}else{
 				list = haa00_newService.selectHaaInfoYear00(pRequestParamMap);
 			}


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

 	/**
 	 * 통합 거래금액분포도 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00InfoJsonTotal.json")
	public String selectHaa00InfoJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		log.info("====== Haa00InfoJSON ======");

 		try{
 			List<EgovMap> list = haa00_newService.selectHaaInfoTotal00(pRequestParamMap);
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


 	/**
 	 * 거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00ChartJson.json")
	public String selectHaa00ChartJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list =null;
 			String type = pRequestParamMap.get("type").toString();
 			if(type.equals("day")){
 				list = haa00_newService.selectHaaChartDate00(pRequestParamMap);
 			}else if(type.equals("month")){
 				list = haa00_newService.selectHaaChartMonth00(pRequestParamMap);
 			}else{
 				list = haa00_newService.selectHaaChartYear00(pRequestParamMap);
 			}


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

 	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00ChartJsonTotal.json")
	public String selectHaa00ChartJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa00_newService.selectHaaChartTotal00(pRequestParamMap);
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

 	/**
 	 * 공판장비중 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00QtyPerJson.json")
	public String selectHaa00QtyPerJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa00_newService.selectHaa00QtyPerJson(pRequestParamMap);

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

 	/**
 	 * 통합공 판장비중 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/haa00_new/selectHaa00QtyPerJsonTotal.json")
	public String selectHaa00QtyPerJsonTotal(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){

 		try{
 			List<EgovMap> list = haa00_newService.selectHaa00QtyPerJsonTotal(pRequestParamMap);

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
