package com.fpdisys.dist.item.controller;

import java.util.ArrayList;
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

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.cmmn.integrated.service.IntCodeService;
import com.fpdisys.dist.item.service.AuctionItemService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * @Class Name : ItemController.java
 * @Description : 품목 경매정보 (일별/월별)
 * 
 * @품목 경매정보 Controller @ 수정일 수정자 수정내용 @ --------- ---------
 * ------------------------------- @ 2020.03.18 최초생성
 *
 * @version 1.0
 */

@Controller
public class AuctionItemController extends BaseController {
//	protected Log log = LogFactory.getLog(this.getClass());	
	protected Log log = LogFactory.getLog(this.getClass());
	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	AuctionItemService auctionItemService;

	/* 통합품목/품종 코드 서비스 */
	@Autowired
	IntCodeService intCodeService;

	@RequestMapping(value = "/item/itemdaily.do")
	public String selectItemDaily(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		return "/item/itemDaily";
	}

	@RequestMapping(value = "/item/itemmonthly.do")
	public String selectItemMonthly(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		return "/item/itemMonthly";
	}

	@RequestMapping(value = "/item/itempopular.do")
	public String selectItemPopular(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		return "/item/itemPopular";
	}

	/**
	 * 일자별 품목 경매정보 기본 목록
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemDaily.json")
	public String selectItemDailyJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			System.out.println("selectItemDaily.json : " + pRequestParamMap);
			List<EgovMap> list = auctionItemService.selectItemDaily(pRequestParamMap);

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
	 * 일자별 품목 경매정보 2Depth 일자별 경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemDailyDate.json")
	public String selectItemDailyDateJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			List<EgovMap> list = auctionItemService.selectItemDailyDate(pRequestParamMap);

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
	 * 일자별 품목 경매정보 3Depth 일자별 레벨별 경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemDailyDateLevel.json")
	public String selectItemDailyDateLevelJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try {
			List<EgovMap> list = auctionItemService.selectItemDailyDateLevel(pRequestParamMap);

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
	 * 월별 품목 경매정보 기본 목록
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemMonthly.json")
	public String selectItemMonthlyJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			System.out.println("selectItemDaily.json : " + pRequestParamMap);
			List<EgovMap> list = auctionItemService.selectItemMonthly(pRequestParamMap);

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
	 * 월별 품목 경매정보 2Depth 월별 경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemMonthlyMonth.json")
	public String selectItemMonthlyMonthJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) throws Exception {

		try {
			List<EgovMap> list = auctionItemService.selectItemMonthlyMonth(pRequestParamMap);

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
	 * 월별 품목 경매정보 3Depth 월별 레벨별 경매정보
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemMonthlyMonthLevel.json")
	public String selectItemMonthlyMonthLevelJson(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try {
			List<EgovMap> list = auctionItemService.selectItemMonthlyMonthLevel(pRequestParamMap);

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
	 * 금주(월)의 인기품목 금주(월)의 인기품목 목록
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemPopularList.json")
	public String selectItemPopularList(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try {
			List<EgovMap> list = auctionItemService.selectItemPopularList(pRequestParamMap);

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
	 * 금주(월)의 인기품목 금주(월)의 인기품목 CHART
	 * 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/item/selectItemPopularChart.json")
	public String selectItemPopularChart(HttpServletRequest pRequest, HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		try {

			System.out.println("chkCode==== " + pRequestParamMap.get("qryItemCd").toString());

			String strText = pRequestParamMap.get("qryItemCd").toString();
			String[] qryItemCd = strText.split(",");

			System.out.println(qryItemCd[0]);

			String itemOne	= qryItemCd[0];
			String itemTwo	= qryItemCd[1];
			String itemThree= qryItemCd[2];
			String itemFour	= qryItemCd[3];
			String itemFive	= qryItemCd[4];
			String itemSix	= qryItemCd[5];

			pRequestParamMap.put("qryItemCd", qryItemCd);
			List<EgovMap> list = auctionItemService.selectItemPopularChart(pRequestParamMap);
			List<EgovMap> chartList = new ArrayList<EgovMap>();
			
			String strDate = "";
			
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).get("itemCd").equals("A")){
					strDate = strDate + "," + list.get(i).get("saleDate").toString();
				}
			}
			
			String[] arrDate = strDate.split(",");

			for (int i = 1; i < arrDate.length; i++) {
				System.out.println(arrDate[i]);
				EgovMap chartMap = new EgovMap();
				
				chartMap.put("SALE_DATE", arrDate[i]);
				chartMap.put("QTY_ONE", 0);
				chartMap.put("QTY_TWO", 0);
				chartMap.put("QTY_THREE", 0);
				chartMap.put("QTY_FOUR", 0);
				chartMap.put("QTY_FIVE", 0);
				chartMap.put("QTY_SIX", 0);
				chartMap.put("AMT_ONE", 0);
				chartMap.put("AMT_TWO", 0);
				chartMap.put("AMT_THREE", 0);
				chartMap.put("AMT_FOUR", 0);
				chartMap.put("AMT_FIVE", 0);
				chartMap.put("AMT_SIX", 0);
				
				for(int j = 0; j < list.size(); j++) {
					if(list.get(j).get("saleDate").equals(arrDate[i])) {
						if(list.get(j).get("itemCd").equals(itemOne)) {
							chartMap.put("QTY_ONE", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_ONE", list.get(j).get("maxAmt").toString());
						}else if(list.get(j).get("itemCd").equals(itemTwo)) {
							chartMap.put("QTY_TWO", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_TWO", list.get(j).get("maxAmt").toString());
						}else if(list.get(j).get("itemCd").equals(itemThree)) {
							chartMap.put("QTY_THREE", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_THREE", list.get(j).get("maxAmt").toString());
						}else if(list.get(j).get("itemCd").equals(itemFour)) {
							chartMap.put("QTY_FOUR", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_FOUR", list.get(j).get("maxAmt").toString());
						}else if(list.get(j).get("itemCd").equals(itemFive)) {
							chartMap.put("QTY_FIVE", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_FIVE", list.get(j).get("maxAmt").toString());
						}else if(list.get(j).get("itemCd").equals(itemSix)) {
							chartMap.put("QTY_SIX", list.get(j).get("maxQty").toString());
							chartMap.put("AMT_SIX", list.get(j).get("maxAmt").toString());
						} 
					}
				}
				
				chartList.add(chartMap);
			}

			System.out.println("list.size() ============= " + list.size());

			model.addAttribute("list", chartList);
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
			e.printStackTrace();
		}

		return "jsonView";
	}

}
