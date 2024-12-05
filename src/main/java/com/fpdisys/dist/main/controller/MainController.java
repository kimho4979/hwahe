package com.fpdisys.dist.main.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fpdisys.admin.data.service.ConfigService;
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
import com.fpdisys.base.util.WoorimUtil;
import com.fpdisys.base.util.WoorimUtil.DATEPATTERN;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpdisys.dist.hba01.domain.Hba01VO;
import com.fpdisys.dist.hba01.service.Hba01Service;
import com.fpdisys.dist.hca02.domain.Hca02VO;
import com.fpdisys.dist.hca02.service.Hca02Service;
import com.fpdisys.dist.hca03.domain.Hca03VO;
import com.fpdisys.dist.hca03.service.Hca03Service;
import com.fpdisys.dist.hfa01.domain.Hfa01VO;
import com.fpdisys.dist.hfa01.service.Hfa01Service;
import com.fpdisys.dist.hfc01.service.Hfc01Service;
import com.fpdisys.dist.main.service.MainService;
import com.fpminput.mntr.menumgt.service.MenuMgtService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MainController extends BaseController {

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	private Hfa01Service hfa01Service;
	
	@Autowired
	private Hba01Service hba01Service;
	
	@Autowired
	private Hca03Service hca03Service;

	@Autowired
	private Hca02Service hca02Service;
	
	@Autowired
	private Hfc01Service hfc01Service;
	
	@Autowired
	private MenuMgtService menuMgtService;
	
	@Autowired
	private CustomInfoService customInfoService;

	@Autowired
	private ConfigService configService;

	/*
	@RequestMapping(value="/main/flowerMain.do")
	public String flowerMain(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){
		
		//추가 [2020.02.05]
		try{
			// 날짜 셋팅 
			String searchSaleDate = WoorimUtil.convertDateToString(new Date(),DATEPATTERN.YearToDay);
			if(pRequestParamMap.get("searchSaleDate")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchSaleDate").toString())){
				searchSaleDate  = pRequestParamMap.get("searchSaleDate").toString();
			}				
			pRequestParamMap.put("searchSaleDate", searchSaleDate);
			model.addAttribute("searchSaleDate", searchSaleDate);
			String [] date = searchSaleDate.split("-"); 
				 		
			model.addAttribute("searchYear", date[0]);
			model.addAttribute("searchMonth", date[1]);
			model.addAttribute("searchDate", date[2]);
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
		
		
		return "/flowerMain/flowerMain";
	}
	*/
	// 비로그인 메인메뉴
	@RequestMapping(value="/main/selectNoLoginMenuList.json")
	public String selectNoLoginMenuList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			
		log.info("============selectNoLoginMenuList============");
		
		try{
			if(pRequest.getSession().getAttribute("userId")!=null){
				String userId=pRequest.getSession().getAttribute("userId").toString();
				
				pRequestParamMap.put("userId", userId);
				List<EgovMap> selectMainSet = customInfoService.selectMainSet(pRequestParamMap);
				if(selectMainSet.size()>0){
					model.addAttribute("userList", selectMainSet );					
				}else{
					List<EgovMap> resultList  =  menuMgtService.selectNoLoginMenuList(pRequestParamMap);
					model.addAttribute("list",resultList);
				}
			}else{
				List<EgovMap> resultList  =  menuMgtService.selectNoLoginMenuList(pRequestParamMap);
				model.addAttribute("list",resultList);
			}
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
	
	@RequestMapping(value="/main/flowerMain_gongi.json")
	public String flowerMainBackUpGongi(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
			
		try{
			String startPageNo 	= (String) pRequestParamMap.get("startPageNo");
			String endPageNo 	= (String) pRequestParamMap.get("endPageNo");
			
			Hfa01VO hfa01vo = new Hfa01VO();
			
			hfa01vo.setStartPageNo(startPageNo);
			hfa01vo.setEndPageNo(endPageNo);
			
			List<Hfa01VO> result = (List<Hfa01VO>)hfa01Service.selectMainGongi(hfa01vo);
			
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
	
	@RequestMapping(value="/main/flowerMain_backup_sugup.json")
	public String flowerMainBackUpSugup(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
		log.info("========== sugup ==============");
			
		try{
			String startPageNo 	= (String) pRequestParamMap.get("startPageNo");
			String endPageNo 	= (String) pRequestParamMap.get("endPageNo");
			
			Hba01VO hba01vo = new Hba01VO();
			
			hba01vo.setStartPageNo(startPageNo);
			hba01vo.setEndPageNo(endPageNo);
			
			List<Hba01VO> result = (List<Hba01VO>)hba01Service.selectSugup(hba01vo);
			
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
	
	@RequestMapping(value="/main/flowerMain_backup_jakgwang.json")
	public String flowerMainBackUpJakgwang(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
		log.info("========== jakgwang ==============");
			
		try{
			String startPageNo 	= (String) pRequestParamMap.get("startPageNo");
			String endPageNo 	= (String) pRequestParamMap.get("endPageNo");
			
			Hca03VO hca03vo = new Hca03VO();
			
			hca03vo.setStartPageNo(startPageNo);
			hca03vo.setEndPageNo(endPageNo);
			
			List<Hca03VO> result = (List<Hca03VO>)hca03Service.selectJakgwangList(hca03vo);
			
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
	
	@RequestMapping(value="/main/flowerMain_backup_cropTrend.json")
	public String flowerMainBackUpCropTrend(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
		log.info("========== jakgwang ==============");
			
		try{
			String startPageNo 	= (String) pRequestParamMap.get("startPageNo");
			String endPageNo 	= (String) pRequestParamMap.get("endPageNo");
			
			Hca02VO hca02vo = new Hca02VO();
			
			hca02vo.setStartPageNo(startPageNo);
			hca02vo.setEndPageNo(endPageNo);
			
			List<Map<String, String>> result = (List<Map<String, String>>)hca02Service.selectCropTrendList(hca02vo);
			
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
	
	@RequestMapping(value="/main/flowerMain_backup_schedule.json")
	public String flowerMainBackUpSchedule(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
		log.info("========== jakgwang ==============");
			
		try{
			
			List<Map<String, String>> result = (List<Map<String, String>>)hfc01Service.flowerMainBackUpSchedule(pRequestParamMap);
			
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
	
	 @RequestMapping(value="/main/gridList.json")
		public String gridList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	/*  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} */
	  	log.info("gridListgridListgridListgridList++++++++"+pRequestParamMap.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectFlowerMain(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/gridListMok.json")
		public String gridListMok(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	/*  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} */
	  	log.info("gridListgridListgridListgridList++++++++"+pRequestParamMap.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridListMok(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/gridListJong.json")
		public String gridListJong(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  
	  		log.info("==========gridListJong=============="+pRequestParamMap.toString());
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridJong(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/gridListAnalysis.json")
		public String gridListAnalysis(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  		log.info("========================"+pRequestParamMap.toString());
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridListAnalysis(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/mainIndex.json")
		public String mainIndex(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
	  		log.info("========================"+pRequestParamMap.get("SALE_MONTH"));
	  		
	  		String SALE_YEAR = pRequestParamMap.get("SALE_MONTH").toString();
	  		SALE_YEAR=SALE_YEAR.substring(0,4);	  			  		
	  		String SALE_YEAR2 = pRequestParamMap.get("SALE_MONTH").toString();
	  		SALE_YEAR2=SALE_YEAR2.substring(5,7);
	  		log.info("==========bbbbbb============="+SALE_YEAR2);	  		  		
	  		int aaa= Integer.parseInt( SALE_YEAR);
	  		int bbb = aaa-1 ;
	  		log.info("==========bbbbbb============="+bbb);
	  		String ccc= String.valueOf(bbb);
	  		
	  		String AGO_SALE_MONTH= ccc+"-"+SALE_YEAR2;
	  			  			  	
	  		log.info("==========AGO_SALE_MONTH=============="+AGO_SALE_MONTH);
	  		
	  		pRequestParamMap.put("AGO_SALE_MONTH", AGO_SALE_MONTH);
	  		pRequestParamMap.put("SALE_YEAR", SALE_YEAR);
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{							
				
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectMainIndex(pRequestParamMap);				
				
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
	
	 @RequestMapping(value="/main/selectAuctionDate.json")
		public String selectAuctionDate(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
	  
	  		log.info("========================"+pRequestParamMap.toString());
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectAuctionDate(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/chartList.json")
		public String chartList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  		
		 String SALE_YEAR = pRequestParamMap.get("SALE_MONTH").toString();
	  		SALE_YEAR=SALE_YEAR.substring(0,4);	
		 log.info("=====chartList======SALE_YEAR========="+SALE_YEAR);
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
			pRequestParamMap.put("SALE_YEAR", SALE_YEAR);
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectChartListIndex(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/chartListChulHa.json")
		public String chartListChulHa(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	/*  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} */	  	  				
		 log.info("=====chartListChulHa=========");
	  		
			Map<String, Object> resultMap = new HashMap<String, Object>();
		
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectChartListChulHa(pRequestParamMap);				
				
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
	 
		@RequestMapping(value="/main/chartListChulHaShdul.json")
		public String chartListChulHaShdul(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
		
			Map<String, Object> resultMap = new HashMap<String, Object>();
		
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectChartListChulHaShdul(pRequestParamMap);				
				
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
		
		@RequestMapping(value="/main/selectSalePriceTrand.json")
		public String selectSalePriceTrand(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
		
				if(pRequestParamMap.get("SALE_MONTH2")!= null){					
			String SALE_MONTH2 =pRequestParamMap.get("SALE_MONTH2").toString();
			log.info(">>>> :serchRegDtEnd"+ SALE_MONTH2); 
			SALE_MONTH2= SALE_MONTH2.replaceAll("-",""); 
			log.info(">>>> :serchRegDtEnd"+ SALE_MONTH2); 
			pRequestParamMap.put("REG_MONTH", SALE_MONTH2);
		 }
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
		
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectSalePriceTrand(pRequestParamMap);				
				
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
		
	 @RequestMapping(value="/flowerMain/flowerMain_Search.do")
		public String flowerMain_Search(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){			  			  				
	  		log.info("=========flowerMain_Search==============="+pRequestParamMap.toString());			
				log.info("==========lmhlmh==============");
				model.addAttribute("FLOWER_CD", pRequestParamMap.get("flowerCd"));
				model.addAttribute("SALE_DATE", pRequestParamMap.get("SALE_DATE"));
				model.addAttribute("CMP_CD", pRequestParamMap.get("CMP_CD"));
			 
			 return "/flowerMain/flowerMain_Search";
		}
	 
	 
	 @RequestMapping(value="/flowerMain/flowerMain_SubSearch.do")
		public String flowerMain_SubSearch(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){			  			  				
	  		log.info("=========flowerMain_SubDateSearch==============="+pRequestParamMap.toString());			
				log.info("==========lmhlmh==============");		
			 
			 return "/flowerMain/flowerMain_SubDateSearch";
		}
	 
	 @RequestMapping(value="/flowerMain/flowerMain_SubYearSearch.do")
		public String flowerMain_SubYearSearch(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){			  			  				
	  		log.info("=========flowerMain_SubDateSearch==============="+pRequestParamMap.toString());			
				log.info("==========lmhlmh==============");
			 	
				model.addAttribute("flowerCd", pRequestParamMap.get("flowerCd"));
			 
			 return "/flowerMain/flowerMain_SubYearSearch";
		}
	 
	 
	 
	 
	 @RequestMapping(value="/main/gridListMokSub.json")
		public String gridListMokSub(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
		 
	  	log.info("gridListgridListgridListgridList++++++++"+pRequestParamMap.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridListMokSub(pRequestParamMap);				
				
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
	 
	 @RequestMapping(value="/main/gridListMokSubYear.json")
		public String selectGridListMokSubYear(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  		
			try{
				// 1년 품종 리스트 가져오기
				pRequestParamMap.put("searchItemCd", URLDecoder.decode(pRequestParamMap.get("searchItemCd").toString(),"utf-8"));

				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridListMokSubYear(pRequestParamMap);				
				
				model.addAttribute("list", resultList);
			
			} catch (IOException e) {
				log.debug("입출력 오류!!");
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
	 
	 
	 @RequestMapping(value="/flowerMain/flowerMain_SubSearchMonth.do")
		public String flowerMain_SubSearchMonth(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){			  			  				
	  		log.info("=========flowerMain_SubSearchMonth==============="+pRequestParamMap.toString());			
				log.info("==========lmhlmh==============");
			 
			 
			 return "/flowerMain/flowerMain_SubMonthSearch";
		}
	 
	 
	 @RequestMapping(value="/main/gridListMokSubMonth.json")
		public String gridListMokSubMonth(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  	
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectGridListMokSubMonth(pRequestParamMap);				
				
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
				log.error(e.getMessage());
			}														
			 return "jsonView";
		}
	 
	 @RequestMapping(value="/main/saleTrend.json")
		public String selectSaleTrend(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	/*  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} */
	  	log.info("gridListgridListgridListgridList++++++++"+pRequestParamMap.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)mainService.selectSaleTrend(pRequestParamMap);				
				
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
	 
	// 품목별 경매정보 분석
	@RequestMapping(value="/main/getPumInfo.json")
	public String getPumInfo(
			HttpServletRequest pRequest, 
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{		 			
	Map<String, Object> resultMap = new HashMap<String, Object>();
	
	try{
		List<EgovMap> resultList  =  (List<EgovMap>)mainService.getPumInfo(pRequestParamMap);				
		
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
	
	@RequestMapping(value="/main/situationNew.do")
	public String situationNew(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {


		String userIp=pRequest.getRemoteHost();

		if (userIp.equals("0:0:0:0:0:0:0:1")) {
			userIp = "127.0.0.1";
		}

		Map<String,Object> pRequestParam = new HashMap<String,Object>();
		pRequestParam.put("IP", "상황판IP");
		List<Map<String,Object>> configIpList =  configService.selectConfig(pRequestParam);
		boolean ipcnt = false;
		for(Map<String,Object> map : configIpList) {
			if (userIp != null && (userIp.equals(map.get("CONFIG_VAL").toString()))) {
				return "/situation/situationNew";
			} else {

			}
		}

		return "redirect:/main/flowerMain.do";
		  	
	 }
	
	@RequestMapping(value="/main/situationNewChart1.json")
	public String situationNewChart1(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.situationNewChart1(pRequestParamMap);
			
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
	
	@RequestMapping(value="/main/situationNewChart2.json")
	public String situationNewChart2(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.situationNewChart2(pRequestParamMap);
			List<EgovMap> list2 = (List<EgovMap>)mainService.situationNewTable2(pRequestParamMap);
			
			
			model.addAttribute("list", list);
			model.addAttribute("list2", list2);
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
	
	@RequestMapping(value="/main/situationNewChart3.json")
	public String situationNewChart3(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.situationNewChart3(pRequestParamMap);
			
			
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
	
	@RequestMapping(value="/main/situationNewChart4.json")
	public String situationNewChart4(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.situationNewChart4(pRequestParamMap);
			
			
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
	
	@RequestMapping(value="/main/situationNewChart5.json")
	public String situationNewChart5(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.situationNewChart5(pRequestParamMap);
			
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
	
	// siteMap 연결
	@RequestMapping(value="/main/siteMap.do")
	public String siteMap(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		 return "/inc/IncSiteMap";
	}
	
	// 이용약관 연결
	@RequestMapping(value="/main/accessTerms.do")
	public String accessTerms(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		 return "/inc/IncAccessTerms";
	}
	 
	
	/**
	 * 일자별 경매정보 보기 : 물량비중
	 * @author 최성호
	 * @since 2020.02.05
	 * @version 1.0
	 */
	@RequestMapping(value="/main/hab01Chart1.json")
    public String hab01Chart1(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.hab01Chart1(pRequestParamMap);
			
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
	 * 일자별 경매정보 보기 : 일자별 평균단가
	 * @author 최성호
	 * @since 2020.02.05
	 * @version 1.0
	 */
	@RequestMapping(value="/main/hab01Chart2.json")
    public String hab01Chart2(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.hab01Chart2(pRequestParamMap);
			
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
	 * 일자별 품종 버튼
	 * @author 최성호
	 * @since 2020.02.05
	 * @version 1.0
	 */
	@RequestMapping(value="/main/hab01Button.json")
    public String hab01Button(HttpServletRequest pRequest, HttpServletResponse pResponse
    		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 		
		try{
			List<EgovMap> list = (List<EgovMap>)mainService.hab01Button(pRequestParamMap);
			
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
	
	@RequestMapping(value="/main/flowerMainTest.do")
	public String flowerMainTest(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){
		
		//추가 [2020.02.05]
		try{
			// 날짜 셋팅 
			String searchSaleDate = WoorimUtil.convertDateToString(new Date(),DATEPATTERN.YearToDay);
			if(pRequestParamMap.get("searchSaleDate")!=null && !StringUtils.isBlank(pRequestParamMap.get("searchSaleDate").toString())){
				searchSaleDate  = pRequestParamMap.get("searchSaleDate").toString();
			}				
			pRequestParamMap.put("searchSaleDate", searchSaleDate);
			model.addAttribute("searchSaleDate", searchSaleDate);
			String [] date = searchSaleDate.split("-"); 
				 		
			model.addAttribute("searchYear", date[0]);
			model.addAttribute("searchMonth", date[1]);
			model.addAttribute("searchDate", date[2]);
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
		
		
		return "/flowerMain/flowerMainTest";
	}
	
	@RequestMapping(value="/main/selectFlowerMainMonth.json")
	public String selectFlowerMainMonth(
 			HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap,
 			ModelMap model){			  			  				
			
		try{
			
			List<EgovMap> list = (List<EgovMap>)mainService.selectFlowerMainMonth(pRequestParamMap);
			
			model.addAttribute("result", list);
			
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
	
	/*
	 * 2021.09.07~ 추가
	 */
	@RequestMapping(value="/main/flowerMain.do")
	public String flowerMain(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){

		try{
			// 거래동향
			// 1:절화, 2:관엽, 3:난
			List<EgovMap> trendList1 = mainService.selectDealTrendList(1);
			List<EgovMap> trendList2 = mainService.selectDealTrendList(2);
			List<EgovMap> trendList3 = mainService.selectDealTrendList(3);
			model.addAttribute("trendList1", trendList1);
			model.addAttribute("trendList2", trendList2);
			model.addAttribute("trendList3", trendList3);

			// 공지사항
			pRequestParamMap.put("START", 1);
			pRequestParamMap.put("END", 4);
			List<Hfa01VO> noticeList = (List<Hfa01VO>)mainService.selectMainGongi(pRequestParamMap);
			
			model.addAttribute("noticeList", noticeList);
			
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
		
		return "/flowerMain/flowerMain_2021";
	}
	
	@RequestMapping(value="/main/getRealSaleDate.json")
	public String getRealSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				

		List<EgovMap> list  =  (List<EgovMap>)mainService.selectRealSaleDate(pRequestParamMap);
		model.addAttribute("list",list);
		 
		return "jsonView";
	}
	
	@RequestMapping(value="/main/getSaleDate.json")
	public String getSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				

		List<EgovMap> list  =  (List<EgovMap>)mainService.selectSaleDate(pRequestParamMap);
		model.addAttribute("list",list);
		 
		return "jsonView";
	}
	
	@RequestMapping(value="/main/getPumMokSaledate.json")
	public String getPumMokSaledate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				

		List<EgovMap> list  =  (List<EgovMap>)mainService.selectPumMokSaledate(pRequestParamMap);
		model.addAttribute("list",list);
		 
		return "jsonView";
	}
	
	@RequestMapping(value="/main/getAreaSaleDate.json")
	public String getAreaSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				

		List<EgovMap> list  =  (List<EgovMap>)mainService.selectAreaSaleDate(pRequestParamMap);
		model.addAttribute("list",list);
		 
		return "jsonView";
	}
	
	@RequestMapping(value="/main/getRealData.json")
	public String getRealData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = mainService.selectRealData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/main/getSaleData.json")
	public String getSaleData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = mainService.selectSaleData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/main/getPumMokData.json")
	public String getPumMokData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = mainService.selectPumMokData(pRequestParamMap);
		model.addAttribute("list",list);
		
		List<EgovMap> totalInfo = mainService.selectPumMokTotalInfo(pRequestParamMap);
		model.addAttribute("totalInfo", totalInfo);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/main/getAreaChartData.json")
	public String getAreaChartData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		if(pRequestParamMap.get("searchAreaCode") == null) {
			List<EgovMap> list = mainService.selectAreaChartData(pRequestParamMap);
			model.addAttribute("list",list);
			
		}else {
			String searchAreaKeyword = null;
			String searchAreaKeyword2 = null;
			
			switch(pRequestParamMap.get("searchAreaCode").toString()) {
				case "100": searchAreaKeyword = "강원"; break;
				case "200": searchAreaKeyword = "경기"; break;
				case "300": searchAreaKeyword = "경상남도"; searchAreaKeyword2 = "경남"; break;
				case "400": searchAreaKeyword = "경상북도"; searchAreaKeyword2 = "경북"; break;
				case "500": searchAreaKeyword = "광주"; break;
				case "600": searchAreaKeyword = "대구"; break;
				case "700": searchAreaKeyword = "대전"; break;
				case "800": searchAreaKeyword = "부산"; break;
				case "90000": searchAreaKeyword = "서울"; break;
				case "1000": searchAreaKeyword = "울산"; break;
				case "1100": searchAreaKeyword = "인천"; break;
				case "1200": searchAreaKeyword = "전라남도"; searchAreaKeyword2 = "전남"; break;
				case "1300": searchAreaKeyword = "전라북도"; searchAreaKeyword2 = "전북"; break;
				case "1400": searchAreaKeyword = "제주"; break;
				case "1500": searchAreaKeyword = "충청남도"; searchAreaKeyword2 = "충남"; break;
				case "1600": searchAreaKeyword = "충청북도"; searchAreaKeyword2 = "충북"; break;
				case "1700": searchAreaKeyword = "세종"; break;
			}
			
			pRequestParamMap.put("searchAreaKeyword", searchAreaKeyword);
			pRequestParamMap.put("searchAreaKeyword2", searchAreaKeyword2);
			
			List<EgovMap> list = mainService.selectDetailAreaChartData(pRequestParamMap);
			model.addAttribute("list",list);
		}
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/main/getAreaMapData.json")
	public String getAreaMapData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = mainService.selectAreaMapData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
}
