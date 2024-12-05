package com.fpminput.mntr.linkStatus.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.egovapi.service.CommonApiLogService;
import com.egovapi.util.CommonApiUtil;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.trans.service.TsaleService;
import com.fpminput.mntr.linkStatus.service.LinkStatusLogService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class LinkStatusLogController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	LinkStatusLogService linkStatusLogService;
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;	
	@Autowired
	CommonApiLogService commonApiLogService;
	@Autowired
	TsaleService calService;
	
	// 연계현황 조회
	@RequestMapping(value="/linkStatus/linkStatusLog.do")
	public String linkStatusLog(HttpServletRequest pRequest, HttpServletResponse pResponse
	 		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();

		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/linkStatus/linkStatusLog";
	}
	
	
	// 연계현황 조회 :: List
	@RequestMapping(value="/mntr/linkStatus/selectLogList.json")
	public String selectLogList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		List<EgovMap> resultList;
		
		try{
			resultList  =  (List<EgovMap>)linkStatusLogService.selectLogList(pRequestParamMap);				

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
	
	// 시스템 구분 공통코드 조회
	@RequestMapping(value="/mntr/linkStatus/seelctSysGp.json")
	public String seelctSysGp(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session, ModelMap model){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;
		
		try{
			resultList = linkStatusLogService.selectSysGp(pRequestParamMap);
			model.addAttribute("list",resultList);
			
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
	
	@RequestMapping(value="/mntr/linkStatus/reProcessing.do")
	public void reProcessing(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam(value="logSeq") String param){
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("logSeq", param);
		EgovMap result = linkStatusLogService.selectLog(pRequestParamMap);
		
		String sysGp = result.get("sysGp").toString();
		String startDate = result.get("startDate").toString().substring(0, 8);

		try{
			// 개발환경
			//String url = "http://175.106.91.132:8280/fpdiAPI/";
			// 운영환경
			String url = "http://210.103.25.28:8082/";
			Map<String, Object> sendMap = new HashMap<String, Object>();
			
			//SYS_GP   : 1일일보고발송, 2행사일정, 3시험일정, 4경매실적, 5화훼수출입정보
			if(sysGp.equals("2")){
				System.out.println("================= 행사일정 API 재기동 ====================");
				url = url + "neisUpdate.do";
				sendMap.put("yyyymmdd", startDate);
			}
			else if(sysGp.equals("3")){
				System.out.println("================= 시험일정 API 재기동 ====================");
				url = url + "qnetUpdate.do";
				sendMap.put("yyyymmdd", startDate);
			}
			else if(sysGp.equals("4")){
				System.out.println("================= 식물검역통계 API 재기동 ====================");
				url = url + "plntUpdate.do";
				sendMap.put("yyyymmdd", startDate);
			}
			else if(sysGp.equals("5")){
				System.out.println("================= 품목별수출입실적 API 재기동 ====================");
				url = url + "custUpdate.do";
				sendMap.put("yyyymmdd", startDate);
			}
			else
				throw new Exception("SYS_GP 값이 잘못되었습니다.");
			
			RestTemplate client = new RestTemplate();
			HttpHeaders header = new HttpHeaders();
			header.set("Content-Type", "application/json;");
			header.set("charset", "UTF-8");
			HttpEntity<Map<String, Object>> request = new HttpEntity<>(sendMap, header);
			client.postForObject(url, request, Map.class);
		}catch (Exception e){
			System.out.println("================= 잘못된 재기동 요청입니다.====================");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
}
