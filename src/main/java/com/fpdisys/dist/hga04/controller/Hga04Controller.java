package com.fpdisys.dist.hga04.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

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
import com.fpdisys.dist.hga04.service.Hga04Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;

@Controller
public class Hga04Controller extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	Hga04Service hga04Service;

	@RequestMapping(value = "/hga04/hga04.do")
	public String selectHga04(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){	
		Calendar strDate = Calendar.getInstance();
		Calendar strYear = Calendar.getInstance();
		
		strDate.setTime(new Date());
		strDate.add(Calendar.DATE, -7);
		strYear.add(Calendar.YEAR, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy");
		
		if(pRequestParamMap.get("searchStrDate") != null) {
			model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
		}else {
			model.addAttribute("searchStrDate", sdf.format(new Date()));
			model.addAttribute("searchStrDateM", sdf1.format(strDate.getTime()));
			//model.addAttribute("searchStrDateY", sdf2.format(strDate.getTime()));
			model.addAttribute("searchStrDateY", sdf2.format(strYear.getTime()));
			
		}
		
		if(pRequestParamMap.get("searchEndDate") != null) {
			model.addAttribute("searchEndDate", pRequestParamMap.get("searchEndDate"));
		}else {
			model.addAttribute("searchEndDate", sdf.format(new Date()));			
			model.addAttribute("searchEndDateM", sdf1.format(new Date()));
			//model.addAttribute("searchEndDateY", sdf2.format(new Date()));
			model.addAttribute("searchEndDateY", sdf2.format(strYear.getTime()));
		}

		return "/auction/Hga04";
	}
		
/*	// 조회조건 품목
	@RequestMapping(value="/hga04/selectGetItem.json")
	public String selectGetItem(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga04Service.selectGetItem(pRequestParamMap);
			model.addAttribute("list",list);
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
	}*/
	
	// 조회조건 개별 품목
	@RequestMapping(value="/hga04/selectGetItemEach.json")
	public String selectGetItemEach(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd2") String cmpCd2
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,  ModelMap model) {	
		
		try{			
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			List<EgovMap> list;
			pRequestParamMap.put("flowerCd", flowerCd);
			pRequestParamMap.put("cmpCd2", cmpCd2);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("searchEndDate", searchEndDate);
			pRequestParamMap.put("dateType", dateType);		

			list = hga04Service.selectGetItemEach(pRequestParamMap);
			model.addAttribute("list",list);
			
			return "jsonView";
		
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
			log.error(e.getMessage());
		}										  
		
		return "jsonView";		  	
	}
	
	// 조회조건 통합 품목
	@RequestMapping(value="/hga04/selectGetItemTotal.json")
	public String selectGetItemTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,  ModelMap model) {	
		
		try{			
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			List<EgovMap> list;
			pRequestParamMap.put("flowerCd", flowerCd);
			pRequestParamMap.put("cmpCd", cmpCd);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("searchEndDate", searchEndDate);
			pRequestParamMap.put("dateType", dateType);		

			list = hga04Service.selectGetItemTotal(pRequestParamMap);
			model.addAttribute("list",list);
			
			return "jsonView";
		
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
			log.error(e.getMessage());
		}										  
		
		return "jsonView";		  	
	}	
		
	// 조회조건 품종
	/*@RequestMapping(value="/hga04/selectGetItem2.json")
	public String selectGetItem2(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession  session,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		try {
			// 데이터 조회
			List<EgovMap> list = hga04Service.selectGetItem2(pRequestParamMap);
			model.addAttribute("list",list);
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
	}*/
	
	// 조회조건 개별 품종	
	@RequestMapping(value="/hga04/selectGetItem2Each.json")
	public String selectGetItem2Each(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd2") String cmpCd2
			,@RequestParam(value="itemCd") String itemCd			
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,  ModelMap model) {	
		
		try{			
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			List<EgovMap> list;
			pRequestParamMap.put("flowerCd", flowerCd);
			pRequestParamMap.put("cmpCd2", cmpCd2);
			pRequestParamMap.put("itemCd", itemCd);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("searchEndDate", searchEndDate);
			pRequestParamMap.put("dateType", dateType);		

			list = hga04Service.selectGetItem2Each(pRequestParamMap);
			model.addAttribute("list",list);
			
			return "jsonView";
		
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
			log.error(e.getMessage());
		}										  
		
		return "jsonView";		  	
	}
	
	// 조회조건 통합 품종
	@RequestMapping(value="/hga04/selectGetItem2Total.json")
	public String selectGetItem2Total(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,  ModelMap model) {	
		
		try{			
			Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
			List<EgovMap> list;
			pRequestParamMap.put("flowerCd", flowerCd);
			pRequestParamMap.put("cmpCd", cmpCd);
			pRequestParamMap.put("itemCd", itemCd);
			pRequestParamMap.put("searchStrDate", searchStrDate);
			pRequestParamMap.put("searchEndDate", searchEndDate);
			pRequestParamMap.put("dateType", dateType);		

			list = hga04Service.selectGetItem2Total(pRequestParamMap);
			model.addAttribute("list",list);
			
			return "jsonView";
		
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
			log.error(e.getMessage());
		}										  
		
		return "jsonView";		  	
	}	
	
	//우측상단 산지별집계(통합)
	//기간, 품목, 품종, 경매장
	@RequestMapping(value="/hga04/selectProdSearchTot.json")
	public String selectProdSearchTot(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			, ModelMap model){	
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("cmpCd", cmpCd);
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("dateType", dateType);		
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);
		pRequestParamMap.put("type2", type2);

		resultList = hga04Service.selectProdSearchTot(pRequestParamMap);
		
		model.addAttribute("selectProdSearchTot",resultList);
		
		return "jsonView";
	}
	
	//우측상단 산지별 집계(개별)
	//기간, 품목, 품종, 경매장
	@RequestMapping(value="/hga04/selectProdSearchEach.json")
	public String selectProdSearchEach(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd2") String cmpCd2
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			, ModelMap model){		 
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("cmpCd2", cmpCd2);
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("dateType", dateType);		
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);
		pRequestParamMap.put("type2", type2);

		resultList = hga04Service.selectProdSearchEach(pRequestParamMap);
		
		model.addAttribute("selectProdSearchEach",resultList);
		
		return "jsonView";
	}
	
	// 좌측 지도유통비율(통합)
	@RequestMapping(value="/hga04/selectMapSearchListTot.json")
	public String selectMapSearchListTot(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			, ModelMap model){		 						
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("cmpCd", cmpCd);
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("dateType", dateType);		
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);
		pRequestParamMap.put("type2", type2);

		resultList = hga04Service.selectMapSearchListTot(pRequestParamMap);
		
		model.addAttribute("selectMapSearchListTot",resultList);
		
		return "jsonView";
	}
	
	// 좌측 지도유통비율(개별)	
	@RequestMapping(value="/hga04/selectMapSearchListEach.json")
	public String selectMapSearchListEach(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="cmpCd2") String cmpCd2
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="dateType") String dateType
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			, ModelMap model){		
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("cmpCd2", cmpCd2);
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("dateType", dateType);		
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);
		pRequestParamMap.put("type2", type2);

		resultList = hga04Service.selectMapSearchListEach(pRequestParamMap);
		
		model.addAttribute("selectMapSearchListEach",resultList);
		
		return "jsonView";
	}
	
	// 우측 유통현황(동합)	
	@RequestMapping(value="/hga04/selectDistSearchTot.json")
	public String selectDistSearchTot(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrYear") String searchStrYear
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="sidoCode") String sidoCode
			,@RequestParam(value="dateType") String dateType
			, ModelMap model){		 						

		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		pRequestParamMap.put("searchStrYear", searchStrYear);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);
		pRequestParamMap.put("type2", type2);
		pRequestParamMap.put("sidoCode", sidoCode);
		pRequestParamMap.put("dateType", dateType);

		resultList = hga04Service.selectDistSearchTot(pRequestParamMap);
		
		model.addAttribute("selectDistSearchTot",resultList);
		
		return "jsonView";
	}
	
	// 우측 유통현황(개별)	
	@RequestMapping(value="/hga04/selectDistSearchEach.json")
	public String selectDistSearchEach(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="searchStrYear") String searchStrYear
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="itemNm") String itemNm
			,@RequestParam(value="kindCd") String kindCd
			,@RequestParam(value="kindNm") String kindNm
			,@RequestParam(value="type2") String type2
			,@RequestParam(value="sidoCode") String sidoCode
			,@RequestParam(value="dateType") String dateType
			, ModelMap model){		 						

		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		pRequestParamMap.put("flowerCd", flowerCd);
		pRequestParamMap.put("searchStrYear", searchStrYear);
		pRequestParamMap.put("searchStrDate", searchStrDate);
		pRequestParamMap.put("searchEndDate", searchEndDate);
		pRequestParamMap.put("itemCd", itemCd);
		pRequestParamMap.put("itemNm", itemNm);
		pRequestParamMap.put("kindCd", kindCd);
		pRequestParamMap.put("kindNm", kindNm);	
		pRequestParamMap.put("type2", type2);
		pRequestParamMap.put("sidoCode", sidoCode);
		pRequestParamMap.put("dateType", dateType);

		resultList = hga04Service.selectDistSearchEach(pRequestParamMap);
		
		model.addAttribute("selectDistSearchEach",resultList);
		
		return "jsonView";
	}
}
