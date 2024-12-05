package com.fpdisys.admin.monitor.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.admin.monitor.service.Maa01MonitorResportService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.CommonUtils;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Ma001MonitorReportController extends BaseController {
	protected Log log = LogFactory.getLog(this.getClass());
	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	@Autowired
	Maa01MonitorResportService maa01MonitorResportService;
	/*private static final String filePath = "C:\\java\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\file";*/
	private static final String filePath = "/usr/webapps/upload/";

	@RequestMapping(value = "/maa01/sugeupReport.do")
	public String startReport(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/admin/sugeupReport";
	}

	@RequestMapping(value = "/admin/sugepReportList.json")
	public String sugeupReport(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		JSONObject obj = new JSONObject();
		String startCount = "";
		String endCount = "";
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
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			List<EgovMap> resultList = (List<EgovMap>) maa01MonitorResportService.selectHba01(pRequestParamMap);

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

	@RequestMapping(value = "/admin/Maa01MonitorReportInsert.json")
	@ResponseBody
	public String Maa01MonitorReportInsert(HttpServletRequest pRequest,
			HttpServletResponse pResponse, HttpSession session,
			@RequestParam Map<String, Object> pRequestParamMap,
			MultipartHttpServletRequest request, ModelMap model) {

		Iterator<String> iterator = request.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;

		File file = new File(filePath);

		if (iterator.hasNext()) {
			multipartFile = request.getFile(iterator.next());
			System.out.println(multipartFile.getOriginalFilename()
					+ " uploaded!");

			log.info("------------- file start -------------");
			log.info("name : " + multipartFile.getName());
			log.info("filename : " + multipartFile.getOriginalFilename());
			log.info("size : " + multipartFile.getSize());
			log.info("-------------- file end --------------\n");

			originalFileName = multipartFile.getOriginalFilename();
			originalFileExtension = originalFileName.substring(originalFileName
					.lastIndexOf("."));
			storedFileName = CommonUtils.getRandomString()
					+ originalFileExtension;

			file = new File(filePath + storedFileName);

			try {
				multipartFile.transferTo(file);

				maa01MonitorResportService
						.Maa01MonitorReportInsert(pRequestParamMap);

				String boardIdx = (String) pRequestParamMap.get("IDX");

				pRequestParamMap.put("FORECAST_SEQ", boardIdx);
				pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());

				maa01MonitorResportService.Maa01MonitorReportFileInsert(pRequestParamMap);

			} catch (InterruptedIOException  e) {
				log.error("입출력 오류 입출력 도중에 알수없는 인터럽트가 발생하였습니다!!");
			} catch (FileNotFoundException e) {
				log.error("입출력 오류 파일을 찾을 수 없습니다!!");
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
		} else {
			// return false;
		}
		return "jsonView";
	}

	@RequestMapping(value = "/maa01/Maa01MonitorReport_Popup.do")
	public String Maa01MonitorReport_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/admin/Maa01MonitorReport_Popup";
	}

	@RequestMapping(value = "/maa01/deleteMonitorReport.json")
	public String deleteMonitorJakHwangtDetail(HttpServletRequest pRequest,
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
					pRequestParamMap.put("SEQ_NO", D1);
					pRequestParamMap.put("GUBN", D2);
					maa01MonitorResportService.deleteMonitorReport(pRequestParamMap);
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

	@RequestMapping(value = "/maa01/tradeReport.do")
	public String tradeReport(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		return "/admin/tradeReport";
	}

	@RequestMapping(value = "/maa01/Maa01MonitortradeReport_Popup.do	")
	public String Maa01MonitortradeReport_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/Maa01MonitorTradeReport_Popup";
	}

	@RequestMapping(value = "/maa01/Maa01MonitorSugeupUpdate_Popup.do	")
	public String Maa01MonitorSugeupUpdate_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/Maa01MonitorSugeup_Popup";
	}

	@RequestMapping(value = "/maa01/updateMaa01MonitorSugeupPopup.json	")
	public String updateMaa01MonitorSugeupPopup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("============2222333444update============"+ pRequestParamMap.toString());
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

			maa01MonitorResportService.Maa01MonitorSugeupUpdate_Popup(pRequestParamMap);

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

	@RequestMapping(value = "/maa01/Maa01MonitorTradeUpdate_Popup.do	")
	public String Maa01MonitorTradeUpdate_Popup(HttpServletRequest pRequest,
			HttpServletResponse pResponse,
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {

		log.info("===========================================");
		log.info("======  maa01 ======");
		log.info("===========================================");
		log.info("maa01+++++++++ : " + pRequestParamMap.toString());

		return "/admin/Maa01MonitorTradeUpdate_Popup";
	}

}
