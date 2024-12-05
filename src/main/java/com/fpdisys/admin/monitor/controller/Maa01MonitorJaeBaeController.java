package com.fpdisys.admin.monitor.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.admin.monitor.service.Maa01MonitorJaeBaeService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Maa01MonitorJaeBaeController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Maa01MonitorJaeBaeService maa01MonitorJaeBaeService;

	@RequestMapping(value = "/maa01/maa01MonitorJaeBae.do")
	public String maa01MonitorJaeBae(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("==========pjhpjh==============");
		List<EgovMap> resultList = (List<EgovMap>) maa01MonitorJaeBaeService.maa01MonitorJaeBae(pRequestParamMap);

		return "/admin/Maa01MonitorJaeBae";
	}

	@RequestMapping(value = "/maa01/maa01MonitorJaeBae.json")
	public String maa01MonitorJaeBaeList(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));

		if (pRequestParamMap.get("startCount") != null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())) {
			startCount = pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		} else {
			startCount = "1";
			pRequestParamMap.put("startCount", startCount);
		}
		if (pRequestParamMap.get("endCount") != null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())) {
			endCount = pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		} else {
			endCount = "15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo2 = "";
		if (pRequestParamMap.get("pageNo2") != null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())) {
			pageNo2 = pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		} else {
			obj.put("pageNo2", "1");
		}
		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorJaeBaeService.maa01MonitorJaeBaeList(pRequestParamMap);

			model.addAttribute("list2", obj);
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

	@RequestMapping(value = "/maa01/maa01MonitorJaeBaeDetail.json")
	public String maa01MonitorJaeBaeDetail(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String COMP_CODE = "";
		String F_DATE = "";
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		if (pRequestParamMap.get("startCount") != null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())) {
			startCount = pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		} else {
			startCount = "1";
			pRequestParamMap.put("startCount", startCount);
		}
		if (pRequestParamMap.get("endCount") != null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())) {
			endCount = pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		} else {
			endCount = "15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo2 = "";
		if (pRequestParamMap.get("pageNo2") != null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())) {
			pageNo2 = pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		} else {
			obj.put("pageNo2", "1");
		}
		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorJaeBaeService.maa01MonitorJaeBaeDetail(pRequestParamMap);

			model.addAttribute("list2", obj);
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

	@RequestMapping(value = "/maa01/Maa01MonitorJaeBaePopup.do")
	public String Maa01MonitorJakHwangPopup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/Maa01MonitorJaeBae_Popup";

	}

	@RequestMapping(value = "/maa01/updateMaa01MonitorJaeBaePopup.json")
	public String updateCtvtTrendInput(HttpServletRequest pRequest,
			HttpServletResponse pResponse, HttpSession session,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		/*
		 * if(pRequestParamMap.get("item_cd")!=null){
		 * session.setAttribute("SESSION_ITEM_CD",
		 * pRequestParamMap.get("item_cd").toString()); }
		 */

		log.info("============2222333444update============"
				+ pRequestParamMap.toString());
		if (pRequestParamMap.get("REG_MONTH") != null) {
			String REG_MONTH = pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH = REG_MONTH.replaceAll("-", "");
			log.info(">>>> :serchRegDtEnd" + REG_MONTH);
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		}

		if (pRequestParamMap.get("AREA") != null) {
			String AREA2 = pRequestParamMap.get("AREA").toString();
			String AREA = AREA2.replace(",", "");
			pRequestParamMap.put("AREA", AREA);
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorJaeBaeService.updateMaa01MonitorJaeBaePopup(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/maa01MonitorJaeBaegDate.json")
	public String maa01MonitorJaeBaegDate(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		if (pRequestParamMap.get("startCount") != null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())) {
			startCount = pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		} else {
			startCount = "1";
			pRequestParamMap.put("startCount", startCount);
		}
		if (pRequestParamMap.get("endCount") != null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())) {
			endCount = pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		} else {
			endCount = "15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo2 = "";
		if (pRequestParamMap.get("pageNo2") != null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())) {
			pageNo2 = pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		} else {
			obj.put("pageNo2", "1");
		}
		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorJaeBaeService.maa01MonitorJaeBaegDate(pRequestParamMap);

			model.addAttribute("list2", obj);
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

	@RequestMapping(value = "/maa01/deleteMonitorJaeBaetDetail.json")
	public String deleteMonitorJaeBaetDetail(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		String gridResult = pRequestParamMap.toString();

		log.info("gridResult:++++======" + gridResult);
		log.info("gridResult:++++======" + gridResult.length());

		String s2 = gridResult.replace("{", "");
		String s3 = s2.replace("}", "");
		String s4 = s3.replace("=", "");

		log.info("gridResult:++++======" + s2);
		log.info("gridResult:++++======" + s3);
		log.info("gridResult:++++======" + s4);

		String[] result = s4.split("!");

		log.info("result:++++======" + result.length);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);
		String D1 = "";
		String D2 = "";
		String D3 = "";
		String D4 = "";
		String D5 = "";
		String D6 = "";
		String D7 = "";
		try {

			for (int x = 0; x < result.length; x++) {
				String R1 = result[x];
				String[] R2 = R1.split(",");
				log.info("R2++++++++++++" + R2.length);
				for (int i = 0; i < R2.length; i++) {
					if (i == 0) {
						D1 = R2[0];
					}
					if (i == 1) {
						D2 = R2[1];
					}
					if (i == 2) {
						D3 = R2[2];
					}
					if (i == 3) {
						D4 = R2[3];
					}
					if (i == 4) {
						D5 = R2[4];
					}
					if (i == 5) {
						D6 = R2[5];
					}
					if (i == 6) {
						D7 = R2[6];
					}
					pRequestParamMap.put("REG_DATE", D1);
					pRequestParamMap.put("PUM_NAME", D2);
					pRequestParamMap.put("GOOD_NAME", D3);
					pRequestParamMap.put("CHUL_NO", D4);
					pRequestParamMap.put("GUBN", D5);
					pRequestParamMap.put("MARKET_CD", D6);
					pRequestParamMap.put("SEQ_NO", D7);
					maa01MonitorJaeBaeService.deleteMonitorJaeBaetDetail(pRequestParamMap);
				}
			};
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

	@RequestMapping(value = "/maa01/maa01MonitorJaeBae_Date.json")
	public String maa01MonitorJaeBae_Date(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		if (pRequestParamMap.get("startCount") != null && !StringUtils.isBlank(pRequestParamMap.get("startCount").toString())) {
			startCount = pRequestParamMap.get("startCount").toString();
			pRequestParamMap.put("startCount", startCount);
		} else {
			startCount = "1";
			pRequestParamMap.put("startCount", startCount);
		}
		if (pRequestParamMap.get("endCount") != null && !StringUtils.isBlank(pRequestParamMap.get("endCount").toString())) {
			endCount = pRequestParamMap.get("endCount").toString();
			pRequestParamMap.put("endCount", endCount);
		} else {
			endCount = "15";
			pRequestParamMap.put("endCount", endCount);
		}

		String pageNo2 = "";
		if (pRequestParamMap.get("pageNo2") != null && !StringUtils.isBlank(pRequestParamMap.get("pageNo2").toString())) {
			pageNo2 = pRequestParamMap.get("pageNo2").toString();
			obj.put("pageNo2", pageNo2);
		} else {
			obj.put("pageNo2", "1");
		}
		log.info("obj+++++++++ : " + obj.toString());
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorJaeBaeService.maa01MonitorJaeBae_Date(pRequestParamMap);

			model.addAttribute("list2", obj);
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

	@RequestMapping(value = "/maa01/Maa01MonitorJaeBaePopupInsert.json")
	public String insertCtvtTrendInput(HttpServletRequest pRequest,
			HttpServletResponse pResponse, HttpSession session,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		/*
		 * if(pRequestParamMap.get("item_cd")!=null){
		 * session.setAttribute("SESSION_ITEM_CD",
		 * pRequestParamMap.get("item_cd").toString()); }
		 */

		log.info("============insertCtvtTrendInput============"
				+ pRequestParamMap.toString());

		log.info("============AREA ============" + pRequestParamMap.get("AREA"));
		if (pRequestParamMap.get("AREA") != null) {
			String AREA2 = pRequestParamMap.get("AREA").toString();
			String AREA = AREA2.replace(",", "");
			pRequestParamMap.put("AREA", AREA);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorJaeBaeService.Maa01MonitorJaeBaePopupInsert(pRequestParamMap);

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