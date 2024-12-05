package com.fpdisys.dist.kind.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.ibatis.common.logging.LogFactory;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import com.fpdisys.dist.kind.service.AuctionKindService;

/**
 * @Class Name : KindController.java
 * @Description : 품종 경매정보 (일별/월별)
 *	 
 * @품종 경매정보 Controller
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2020.03.18             	최초생성
 *
 * @version 1.0
 */

@Controller
public class AuctionKindController extends BaseController {
//	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	AuctionKindService auctionKindService;
	
	@RequestMapping(value="/kind/kinddaily.do")
	public String selectKindDaily(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception{

		return "/kind/kindDaily";
	}

	@RequestMapping(value="/kind/kindmonthly.do")
	public String selectKindMonthly(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/kind/kindMonthly";
	}

	
	/** 일자별 품종 경매정보
	 * 기본 목록
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindDaily.json")
	public String selectKindDailyJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model)throws Exception{
 			 
 		try{
 			System.out.println("selectKindDaily.json : " + pRequestParamMap);
 			List<EgovMap> list = auctionKindService.selectKindDaily(pRequestParamMap);
 			
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
 	
	/** 일자별 품종 경매정보
	 * 2Depth 일자별 경매정보
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindDailyDate.json")
	public String selectKindDailyDateJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model)throws Exception{
 			 
 		try{
 			List<EgovMap> list = auctionKindService.selectKindDailyDate(pRequestParamMap);
 			
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
 
	/** 일자별 품종 경매정보
	 * 3Depth 일자별 레벨별 경매정보
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindDailyDateLevel.json")
	public String selectKindDailyDateLevelJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 			 
 		try{
 			List<EgovMap> list = auctionKindService.selectKindDailyDateLevel(pRequestParamMap);
 			
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
 	
	/** 월별 품종 경매정보
	 * 기본 목록
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindMonthly.json")
	public String selectKindMonthlyJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model)throws Exception{
 			 
 		try{
 			System.out.println("selectKindDaily.json : " + pRequestParamMap);
 			List<EgovMap> list = auctionKindService.selectKindMonthly(pRequestParamMap);
 			
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
 	
	/** 월별 품종 경매정보
	 * 2Depth 월별 경매정보
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindMonthlyMonth.json")
	public String selectKindMonthlyMonthJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model)throws Exception{
 			 
 		try{
 			List<EgovMap> list = auctionKindService.selectKindMonthlyMonth(pRequestParamMap);
 			
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
 
	/** 월별 품종 경매정보
	 * 3Depth 월별 레벨별 경매정보
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
 	@RequestMapping(value="/kind/selectKindMonthlyMonthLevel.json")
	public String selectKindMonthlyMonthLevelJson(HttpServletRequest pRequest,HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
 			 
 		try{
 			List<EgovMap> list = auctionKindService.selectKindMonthlyMonthLevel(pRequestParamMap);
 			
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
}
