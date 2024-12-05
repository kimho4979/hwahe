package com.fpdisys.dist.search.controller;

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
import com.fpdisys.dist.search.service.SearchService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class SearchController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	SearchService searchService;

	 @RequestMapping(value="/search/selectSaleDate.json")
		public String selectSaleDate(
				HttpServletRequest pRequest,
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)searchService.selectSaleDate(pRequestParamMap);

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

	@RequestMapping(value="/search/selectSaleMonth.json")
	public String getSaleMonth(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<EgovMap> list = (List<EgovMap>)searchService.selectSaleMonth(pRequestParamMap);

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

	@RequestMapping(value="/search/selectSaleYear.json")
	public String getSaleYear(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		try{
			List<EgovMap> list = (List<EgovMap>)searchService.selectSaleYear(pRequestParamMap);

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

	@RequestMapping(value="/search/selectSaleDateReal.json")
	public String getSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectSaleDateReal(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	@RequestMapping(value="/search/selectSaleDateYuchal.json")
	public String selectSaleDateYuchal(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectSaleDateYuchal(pRequestParamMap);
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
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		return "jsonView";

	}


	/**
	 * 품목검색-일별(T_SALE_DATE)
	 * */
	@RequestMapping(value="/search/selectPumNameDate.json")
	public String selectPumNameDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectPumNameDate(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품종검색-일별(T_SALE_DATE)
	 * */
	@RequestMapping(value="/search/selectGoodNameDate.json")
	public String selectGoodNameDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectGoodNameDate(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품목검색-월별(T_SALE_MONTH)
	 * */
	@RequestMapping(value="/search/selectPumNameMonth.json")
	public String gridListMokSubMonth(
			HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)searchService.selectPumNameMonth(pRequestParamMap);

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

	/**
	 * 품종검색-월별(T_SALE_MONTH)
	 * */
	@RequestMapping(value="/search/selectGoodNameMonth.json")
	public String selectGoodNameMonth(
			HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)searchService.selectGoodNameMonth(pRequestParamMap);

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

	/**
	 * 품목검색-실시간(T_REAL)
	 * */
	@RequestMapping(value="/search/selectPumNameReal.json")
	public String selectPumNameReal(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectPumNameReal(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품종검색-실시간(T_REAL)
	 * */
	@RequestMapping(value="/search/selectGoodNameReal.json")
	public String selectGoodNameReal(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectGoodNameReal(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품목검색-유찰(yuchal)
	 * */
	@RequestMapping(value="/search/selectPumNameYuchal.json")
	public String selectPumNameYuchal(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectPumNameYuchal(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품종검색-실시간(T_REAL)
	 * */
	@RequestMapping(value="/search/selectGoodNameYuchal.json")
	public String selectGoodNameYuchal(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try{
			List<EgovMap> list  =  (List<EgovMap>)searchService.selectGoodNameYuchal(pRequestParamMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}


	/**
	 * 공판장별 거래현황 - 구분별 요일 추가
	 * */
	@RequestMapping(value="/search/selectSaleDateWeekday.json")
	public String selectSaleDateWeekday(
			HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			HttpSession  session,
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model)
	{
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)searchService.selectSaleDateWeekday(pRequestParamMap);

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

	/**
	 * 품목검색-일별(T_SALE_DATE)
	 * */
	@RequestMapping(value="/search/selectPumNameCmpDate.json")
	public String selectPumNameCmpDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,  ModelMap model) {

		try{
			List<EgovMap> list = null;
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("searchStrDate",searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);

			if(type.equals("day")){
				list  =  (List<EgovMap>)searchService.selectPumNameCmpDate(paramMap);
			}else if(type.equals("month")){
				list  =  (List<EgovMap>)searchService.selectPumNameCmpMonth(paramMap);
			}else{
				list  =  (List<EgovMap>)searchService.selectPumNameCmpYear(paramMap);
			}

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품종검색-일별(T_SALE_DATE)
	 * */
	@RequestMapping(value="/search/selectGoodNameCmpDate.json")
	public String selectGoodNameCmpDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd") String cmpCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,ModelMap model) {
		try{
			List<EgovMap> list = null;
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("searchItemCd", itemCd);
			paramMap.put("searchStrDate",searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);

			if(type.equals("day")){
				list  =  (List<EgovMap>)searchService.selectGoodNameCmpDate(paramMap);
			}else if(type.equals("month")){
				list  =  (List<EgovMap>)searchService.selectGoodNameCmpMonth(paramMap);
			}else{
				list  =  (List<EgovMap>)searchService.selectGoodNameCmpYear(paramMap);
			}

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 통합품목검색-일별(T_INT_ITEM)
	 * */
	@RequestMapping(value="/search/selectPumNameCmpTotal.json")
	public String selectPumNameCmpTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,  ModelMap model) {

		try{
			List<EgovMap> list = null;
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("searchStrDate",searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("type", type);

			list  =  (List<EgovMap>)searchService.selectPumNameCmpTotal(paramMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}

	/**
	 * 품종검색-일별(T_INT_KIND)
	 * */
	@RequestMapping(value="/search/selectGoodNameCmpTotal.json")
	public String selectGoodNameCmpTotal(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="flowerCd[]") List<String> flowerCd
			,@RequestParam(value="cmpCd[]") List<String> cmpCd
			,@RequestParam(value="itemCd") String itemCd
			,@RequestParam(value="searchStrDate") String searchStrDate
			,@RequestParam(value="searchEndDate") String searchEndDate
			,@RequestParam(value="type") String type
			,ModelMap model) {
		try{
			List<EgovMap> list = null;
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("flowerCd", flowerCd);
			paramMap.put("cmpCd", cmpCd);
			paramMap.put("searchItemCd", itemCd);
			paramMap.put("searchStrDate",searchStrDate);
			paramMap.put("searchEndDate", searchEndDate);
			paramMap.put("itemCd", itemCd);
			paramMap.put("type", type);

			list  =  (List<EgovMap>)searchService.selectGoodNameCmpTotal(paramMap);

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
			log.error(e.getMessage());
		}

		return "jsonView";

	}
}
