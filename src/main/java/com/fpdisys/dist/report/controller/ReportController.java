package com.fpdisys.dist.report.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.report.service.ReportService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ReportController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	ReportService reportService;
	
	/*
	 * 일별 품목별 경매실적 및 동향
	 */
	@RequestMapping(value="/report/dayPumAuc.do")
	public String selectDayPumAuc (HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("==========KKKKK==============" + pRequestParamMap.toString());
		
		Calendar strDate = Calendar.getInstance();
		strDate.setTime(new Date());
		strDate.add(Calendar.DATE, -7);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(pRequestParamMap.get("searchStrDate") != null) {
			model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
		}else {
			model.addAttribute("searchStrDate", sdf.format(strDate.getTime()));
		}
		
		if(pRequestParamMap.get("searchEndDate") != null) {
			model.addAttribute("searchEndDate", pRequestParamMap.get("searchEndDate"));
		}else {
			model.addAttribute("searchEndDate", sdf.format(new Date()));
		}

		return "/report/dayPumAuc";
	}

	@RequestMapping(value = "/report/selectDayPumAuc.json")
	public String selectDayPumAucJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			pRequestParamMap.put("searchStrDate", pRequestParamMap.get("searchStrDate").toString().replaceAll("-", ""));
			pRequestParamMap.put("searchEndDate", pRequestParamMap.get("searchEndDate").toString().replaceAll("-", ""));
			
			System.out.println("selectItemDaily.json : " + pRequestParamMap);
			List<EgovMap> list = reportService.selectDayPumAucList(pRequestParamMap);

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
	
	/*
	 * 주요 절화류 도매가격 동향
	 */
	@RequestMapping(value="/report/mainFlowerAuc.do")
	public String MainFlowerAuc (HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("==========KKKKK==============" + pRequestParamMap.toString());
		
		Calendar strDate = Calendar.getInstance();
		strDate.setTime(new Date());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		if(pRequestParamMap.get("searchStrDate") != null) {
			model.addAttribute("searchStrDate", pRequestParamMap.get("searchStrDate"));
		}else {
			model.addAttribute("searchStrDate", sdf.format(strDate.getTime()));
		}
		
		return "/report/mainFlowerAuc";
	}
	
	@RequestMapping(value = "/report/selectMainFlowerAuc.json")
	public String selectMainFlowerAuc(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			Calendar strDate = Calendar.getInstance();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			Date to = sdf.parse(pRequestParamMap.get("searchStrDate").toString());
			int iday = Integer.parseInt(pRequestParamMap.get("searchStrDate").toString().substring(8,10));
			
			String check = "";
	        if(iday < 11){
	            check = "1";
	        }else if(10 < iday && iday < 21){
	            check = "2";
	        }else{
	            check = "3";
	        }
				
	        pRequestParamMap.put("sCheck", check);
	        List<EgovMap> list;
	        if(pRequestParamMap.get("cmpCd").toString().equals("0000000001")){
	        	list = reportService.selectMainFlowerAucAt(pRequestParamMap);
	        }else{
	        	list = reportService.selectMainFlowerAucAll(pRequestParamMap);
	        }
	        
			strDate.setTime(to);
			strDate.add(Calendar.YEAR, -1);
			strDate.add(Calendar.MONTH, -1);
			String preYear = sdf.format(strDate.getTime()).substring(0,4);
			String preMonth = sdf.format(strDate.getTime()).substring(5,7);
			
//			List<EgovMap> list = reportService.selectMainFlowerAuc(pRequestParamMap);
			String yesterDay = reportService.selectYesterDay(pRequestParamMap);
			
			model.addAttribute("list", list);
			model.addAttribute("check", check);
			model.addAttribute("preYear", preYear);
			model.addAttribute("preMonth", preMonth);
			model.addAttribute("yesterDay", yesterDay);
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
	
	/*
	 * 일별 경매실적
	 */
	@RequestMapping(value="/report/dayAuc.do")
	public String dayAuc(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		log.info("==========KKKKK==============" + pRequestParamMap.toString());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		Calendar date = Calendar.getInstance();
		String thisYear = sdf.format(date.getTime());
		
		if(pRequestParamMap.get("searchYear") != null) {
			model.addAttribute("searchYear", pRequestParamMap.get("searchYear"));
		}else {
			model.addAttribute("searchYear", thisYear);
		}
		
		return "/report/dayAuc";
	}
	
	@RequestMapping(value = "/report/selectDayAuc.json")
	public String selectDayAucJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			pRequestParamMap.put("searchYear", pRequestParamMap.get("searchYear").toString());
			
			System.out.println("selectDayAuc.json : " + pRequestParamMap);
			List<EgovMap> list = reportService.selectDayAucList(pRequestParamMap);

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

	@RequestMapping(value = "/report/excel.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void dayPumExcel(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam Map<String, Object> pRequestParamMap) throws Exception {
		
		try {
			reportService.selectDayAucListExcel(pRequestParamMap, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
