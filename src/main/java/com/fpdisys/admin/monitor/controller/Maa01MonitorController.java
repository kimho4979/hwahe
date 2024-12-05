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

import com.fpdisys.admin.monitor.service.Maa01MonitorService;
import com.fpdisys.base.mvc.BaseController;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Maa01MonitorController extends BaseController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Maa01MonitorService maa01MonitorService;

	@RequestMapping(value = "/maa01/maa01Monitor.do")
	public String selectCropInfoInput(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("==========pjhpjh==============");
		List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService
				.selectShipmntPrearngeVolm(pRequestParamMap);

		return "/admin/Maa01Monitor";
	}

	@RequestMapping(value = "/maa01/maa01Monitor.json")
	public String selectMonitorJson(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";
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
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService.selectShipmntPrearngeVolm(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/maa01Monitor_Date.json")
	public String selectmaa01Monitor_Date(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";
		if (pRequestParamMap.get("startCount") != null && !StringUtils.isBlank(pRequestParamMap.get("startCount")						.toString())) {
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
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService
					.selectmaa01Monitor_Date(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/maa01Monitor_predict.json")
	public String selectMonitorPredictJson(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String F_DATE = "";

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
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService
					.selectMonitorPredictJson(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/maa01MonitorDetail.json")
	public String selectMonitorDetail(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		String F_DATE = "";
		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String COMP_CODE = "";

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
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));
		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService.selectMonitorDetail(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/maa01MonitorPredictDetail.json")
	public String selectMonitorPredictDetail(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		String F_DATE = "";
		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
		String COMP_CODE = "";

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
		F_DATE = (String) pRequestParamMap.get("F_DATE");
		pRequestParamMap.put("F_DATE", F_DATE.replace("-", ""));

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorService.selectMonitorPredictDetail(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/deleteMonitorPredictDetail.json")
	public String deleteMonitorPredictDetail(HttpServletRequest pRequest,
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
					maa01MonitorService
							.deleteMonitorPredictDetail(pRequestParamMap);
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

	@RequestMapping(value = "/maa01/deleteMonitortDetail.json")
	public String deleteMonitortDetail(HttpServletRequest pRequest,
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
					maa01MonitorService.deleteMonitortDetail(pRequestParamMap);
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

	@RequestMapping(value = "/maa01/MonitorPredictDetail_Popup.do")
	public String MonitorPredictDetail_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/MonitorPredictDetail_Popup";

	}

	@RequestMapping(value = "/maa01/MonitorDetail_Popup.do")
	public String MonitorDetail_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/MonitorDetail_Popup";

	}

	@RequestMapping(value = "/maa01/updateMonitorPredictDetail_Popup.json")
	public String updateMonitorPredictDetail_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
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

		log.info("============ITEM_CD  update============"
				+ pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"
				+ pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============" + pRequestParamMap.get("QTY"));
		log.info("============MARKET_CD ============"
				+ pRequestParamMap.get("MARKET_CD"));
		log.info("============GUBN ============" + pRequestParamMap.get("GUBN"));
		if (pRequestParamMap.get("QTY") != null) {
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY = QTY2.replace(",", "");
			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorService.updateMonitorPredictDetail_Popup(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/updateMonitorDetail_Popup.json")
	public String updateMonitorDetail_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		/*
		 * if(pRequestParamMap.get("item_cd")!=null){
		 * session.setAttribute("SESSION_ITEM_CD",
		 * pRequestParamMap.get("item_cd").toString()); }
		 */

		log.info("============2222333444update============"+ pRequestParamMap.toString());
		if (pRequestParamMap.get("REG_MONTH") != null) {
			String REG_MONTH = pRequestParamMap.get("REG_MONTH").toString();
			REG_MONTH = REG_MONTH.replaceAll("-", "");
			log.info(">>>> :serchRegDtEnd" + REG_MONTH);
			pRequestParamMap.put("REG_MONTH", REG_MONTH);
		}

		log.info("============ITEM_CD  update============"+ pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+ pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============" + pRequestParamMap.get("QTY"));
		log.info("============MARKET_CD ============"+ pRequestParamMap.get("MARKET_CD"));
		log.info("============GUBN ============" + pRequestParamMap.get("GUBN"));
		if (pRequestParamMap.get("QTY") != null) {
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY = QTY2.replace(",", "");
			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorService.updateMonitorDetail_Popup(pRequestParamMap);

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

	@RequestMapping(value = "/admin/insertMonitorPredictDetail_Popup.json")
	public String insertShipmntPrearngeVolm(HttpServletRequest pRequest,
			HttpServletResponse pResponse, HttpSession session,
			@RequestParam Map<String, Object> pRequestParamMap,

			ModelMap model) {
		/*
		 * if(pRequestParamMap.get("item_cd")!=null){
		 * session.setAttribute("SESSION_ITEM_CD",
		 * pRequestParamMap.get("item_cd").toString()); }
		 */

		log.info("============2222333444============"
				+ pRequestParamMap.toString());
		/*
		 * if(pRequestParamMap.get("REG_MONTH")!= null){ String REG_MONTH
		 * =pRequestParamMap.get("REG_MONTH").toString(); REG_MONTH=
		 * REG_MONTH.replaceAll("-",""); log.info(">>>> :serchRegDtEnd"+
		 * REG_MONTH); pRequestParamMap.put("REG_MONTH", REG_MONTH); }
		 */

		log.info("============ITEM_CD ============"
				+ pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"
				+ pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============" + pRequestParamMap.get("QTY"));
		if (pRequestParamMap.get("QTY") != null) {
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY = QTY2.replace(",", "");
			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorService.insertMonitorPredictDetail_Popup(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/insertMonitorDetail_Popup.json")
	public String insertMonitorDetail_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse, HttpSession session,
			@RequestParam Map<String, Object> pRequestParamMap,

			ModelMap model) {

		log.info("============2222333444============"+ pRequestParamMap.toString());
		log.info("============ITEM_CD ============"+ pRequestParamMap.get("ITEM_CD"));
		log.info("============SIZE_CD ============"+ pRequestParamMap.get("SIZE_CD"));
		log.info("============QTY ============" + pRequestParamMap.get("QTY"));
		if (pRequestParamMap.get("QTY") != null) {
			String QTY2 = pRequestParamMap.get("QTY").toString();
			String QTY = QTY2.replace(",", "");
			pRequestParamMap.put("QTY", QTY);
		}

		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++" + resultMap);

		try {

			maa01MonitorService.insertMonitorDetail_Popup(pRequestParamMap);

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
