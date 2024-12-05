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
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.at.domain.AtMarketVO;
import com.at.service.aTService;
import com.egovapi.service.CommonApiLogService;
import com.egovapi.util.CommonApiUtil;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.trans.service.TsaleService;
import com.fpminput.mntr.linkStatus.service.LinkStatusService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class LinkStatusController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	LinkStatusService linkStatusService;
	@Autowired
	TsaleService tsaleService;
	@Autowired
	aTService aTService;	
	@Autowired
	CommonApiLogService commonApiLogService;
	@Autowired
	TsaleService calService;
	
	// 연계현황 조회
	@RequestMapping(value="/linkStatus/linkStatusCheck.do")
	public String linkStatusCheck(HttpServletRequest pRequest, HttpServletResponse pResponse
	 		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();

		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/linkStatus/linkStatusCheck";
	}
	
	// 연계현황 조회
	@RequestMapping(value="/linkStatus/linkStatusCheckDetail.do")
	public String linkStatusCheckDetail(HttpServletRequest pRequest, HttpServletResponse pResponse
	 		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();

		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/linkStatus/linkStatusCheckDetail";
	}
	
	// 연계현황 조회 :: List
	@RequestMapping(value="/mntr/linkStatus/linkStatusCheckList.json")
	public String selectCheckList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		//log.info("========================"+pRequestParamMap.get("gridUpdate"));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)linkStatusService.selectCheckList(pRequestParamMap);				
			
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
	
	// 연계현황 상세조회 :: 로그조회
	@RequestMapping(value="/mntr/linkStatus/selectCheckListDetailLog.json")
	public String selectCheckListDetailLog(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		//log.info("========================"+pRequestParamMap.get("gridUpdate"));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)linkStatusService.selectCheckListDetailLog(pRequestParamMap);				
			
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
		} catch (Exception e) {
			log.error(e.getMessage());
			e.printStackTrace();
		}	 			
		return "jsonView";
	}
	
		// 연계실패 상세조회 :: 로그조회
		@RequestMapping(value="/linkStatus/selectFailList.do")
		public String selectFailList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			
			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "redirect:/mnt/mem01/mem01Form.do";
			}
			
 			return "/linkStatus/linkStatusFail_popup";
		}
		
		// 연계실패 상세조회 :: 로그조회
		@RequestMapping(value="/mntr/linkStatus/selectFailList.json")
		public String selectFailListJson(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			
			//log.info("========================"+pRequestParamMap.get("gridUpdate"));
			//Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)linkStatusService.selectFailList(pRequestParamMap);				
				
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
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			return "jsonView";
		}
	
	// 수동배치 실행/mntr/linkStatus/runManualBatchList.json
	@RequestMapping(value="/linkStatus/runManualBatch.do")
	public String runManualBatch(HttpServletRequest pRequest, HttpServletResponse pResponse
	 		, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();

		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		return "/linkStatus/runManualBatch";
	}
	
	// 수동배치 실행 :: API 수동배치 로직
	@RequestMapping(value="/mntr/linkStatus/runManualBatchList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  		
		//log.info("========================"+pRequestParamMap.get("gridUpdate"));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> resultList  =  (List<EgovMap>)linkStatusService.selectRunManualBatchList(pRequestParamMap);				
			
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

	@SuppressWarnings("unchecked")
	@RequestMapping("/dataUpdate/linkStatus/updateProc.json")
	// 0 잘못된접근, 1 정상완료, 2 오류발생, 4 api 서버 오류
	public Map<String, String> updateProc(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){
		System.out.println("================= Ajax list load : /dataUpdate/linkStatus/updateProc.do ====================");
		Map<String, String> resultMap = new HashMap<String, String>();
		
		String startDt = (String)pRequestParamMap.get("startDt");
		String jobId = (String)pRequestParamMap.get("jobId");
		String type = "";
		
		if(jobId == null || "".equals(jobId)){
			resultMap.put("result", "0");
			resultMap.put("message", "잘못된 접근입니다.");
			return resultMap;
		}

		Map<String, String> mapReturn = new HashMap<String, String>();
		
		if("1".equals(jobId) || "2".equals(jobId)|| "3".equals(jobId)){
			type = "DATAGO";
		
		
			DataOutputStream out = null;
			BufferedReader reader = null;
			
			// 개발환경
			//String url = "http://localhost:8080/egov/api/json/updateUtilData.do";
			// 운영환경
			String url = "http://210.103.25.107:8082/egov/api/json/updateUtilData.do";
			url = url + "?type="+type+"&subType="+jobId+"&stDt="+startDt+"&enDt="+startDt;
			try {			 
				URL url2 = new URL(url);
				HttpURLConnection httpConnection = (HttpURLConnection) url2.openConnection();
				httpConnection.setConnectTimeout(30*1000);
				httpConnection.setRequestMethod("POST");
				httpConnection.setDoOutput(true);
				httpConnection.setDoInput(true);
				
				out = new DataOutputStream(httpConnection.getOutputStream());
				
				
				//out.writeBytes(param);
				out.flush();
				BufferedReader br = null;
				StringBuffer sb = new StringBuffer();
				if(httpConnection.getResponseCode() == HttpURLConnection.HTTP_OK){
					br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
					String inputLine = "";
					while ((inputLine = br.readLine()) != null) {
						sb.append(inputLine);
					}
					String result = sb.toString();
					mapReturn = new ObjectMapper().readValue(result, HashMap.class);
					//log.info("map stirng : " + map.toString());
				}else{
					mapReturn = new HashMap<String, String>();
					mapReturn.put("result", "0");
					mapReturn.put("message", "잘못된 접근입니다.");
				}
	
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (out != null) {
					try {
						out.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (reader != null) {
					try {
						reader.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		// 정산자료 업데이트
		if("4".equals(jobId)){
			
			String logStat="1";
			String errorDetail="";
			
			Map<String, String> mapLog = new HashMap<String, String>();
			mapLog.put("jobId", jobId);
			mapLog.put("logGubun", "2");
			mapLog.put("logSeq", "");
			
			// 스케쥴러 로그 등록 및 로그 순번 조회
			 commonApiLogService.startJobLog(mapLog);
			
			String year = null;
			String month = null;
			String day = null;
			String deletedate = null;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			
			try {

					Date d = sdf.parse(startDt);
					
					String s = sdf.format(d);
					String en = sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 3) );
					String hipenS = sdf1.format(d);
					
					int sint = Integer.parseInt(s);
					int enint = Integer.parseInt(en);
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("yyyymm", startDt);
					
					for(int i = enint; i<=sint; i++){
					year = Integer.toString(i).substring(0,4);
					month = Integer.toString(i).substring(4,6);
					day = Integer.toString(i).substring(6,8);
					deletedate = year + "-" + month + "-" + day ;
					map.put("saleDate", deletedate);	 
					
					if(Integer.parseInt(day)<32){
					 try {
	  					  tsaleService.calculateWebserviceTestDelete(map);
	  				} catch(Exception e) {
	  					  e.printStackTrace();
	  					mapReturn = new HashMap<String, String>();
						mapReturn.put("result", "0");
						commonApiLogService.insertFailLog("삭제실패", mapLog, jobId, mapLog.get("logSeq"));
	  				}
					}
				}			
				
				map.put("saleDate", sdf.format(d));
				map.put("strDate", sdf.format(d.getTime() - ( (long) 1000 * 60 * 60 * 24 * 30) ));
				
				List<AtMarketVO> atMarketData = aTService.atMarketData(map);		  
						
					try {				
						 for(int i=0; i<atMarketData.size(); i++){				 
							 AtMarketVO rs = atMarketData.get(i);
							// 테스트 요망
							String sFilename = "0000000001" + rs.getPAN_DAY() + ".txt";
							String sRecode = ";";
							  sRecode += ";";
							  sRecode += rs.getPAN_DAY() + ";";
							  sRecode += ";";
							  sRecode += "0000000001" + ";";
							  sRecode += rs.getPAN_NO().replaceAll(" ", "") + ";";
							  sRecode += rs.getPAN_SERIAL().replaceAll(" ", "") + ";";
							  sRecode += ";";
							  sRecode += rs.getMEJANG().replaceAll(" ", "") + ";";
							  sRecode += "000000" + ";";
							  sRecode += rs.getPUM_CODE().replaceAll(" ", "") + ";";
						  sRecode += rs.getMOK_NAME().replaceAll(" ", "") + ";";
						  sRecode += rs.getJONG_NAME().replaceAll(" ", "") + ";";
							  sRecode += "1" + ";";
							  sRecode += "120000" + ";";
							  sRecode += rs.getSTRCODE_LEVEL().replaceAll(" ", "") + ";";
							  sRecode += rs.getSOK_CNT().replaceAll(" ", "") + ";";
							  sRecode += rs.getKM_P_NEW().replaceAll(" ", "") + ";";
							  sRecode += ";";
							  sRecode += "3" + ";";
							  sRecode += ";";
							  sRecode += ";";
							  sRecode += rs.getCHUL_CODE().replaceAll(" ", "") + ";";
							  sRecode += ";";
							  sRecode += ";";
							  sRecode += "5" + ";";
							  sRecode += rs.getSTRCODE_LOCAL().replaceAll(" ", "") + ";";
							  sRecode += rs.getREGION_CODE().replaceAll(" ", "") + ";";
							  sRecode += rs.getREGION_NAME().replaceAll(" ", "")+ ";";
							  sRecode += rs.getF_SONGE_CNT().replaceAll(" ", "")+";";
							  sRecode += rs.getPAN_PRICE().replaceAll(" ", "");
										 

							  map.put("filename", sFilename);
							  map.put("recode", sRecode);
							  map.put("requestSn", "tsale");
							  tsaleService.calculateWebserviceTestForm(map);
							  
								String gb = rs.getMEJANG().replaceAll(" ", "");
										
								if(gb.equals("1")){
									System.out.println("구분 : 절화");
								}else if(gb.equals("2")){
									System.out.println("구분 : 관엽");
								}else if(gb.equals("3")){
									System.out.println("구분 : 난");
								}else if(gb.equals("4")){
									System.out.println("구분 : 춘란");
								}else{
									System.out.println("구분 : 5(기타)");
								}
						}
					} catch(Exception e) {
						  e.printStackTrace();
						  mapReturn = new HashMap<String, String>();
						  mapReturn.put("result", "0");
						  mapReturn.put("message", "전송실패");
						  errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
	  					 commonApiLogService.insertFailLog("전송실패", mapLog, jobId, mapLog.get("logSeq"));
					} 

				try {
					for(int i = enint; i<=sint; i++){
						year = Integer.toString(i).substring(0,4);
						month = Integer.toString(i).substring(4,6);
						day = Integer.toString(i).substring(6,8);
						deletedate = year + "-" + month + "-" + day ;

						map.put("requestSn", "magam");
						
						if(Integer.parseInt(day)<32){
			  	  			tsaleService.deleteSaleDate("0000000001", deletedate);	
			  	  			tsaleService.insertSaleDate("0000000001", deletedate);	
			  	  			tsaleService.deleteSaleMonth("0000000001", deletedate);	
			  	  			tsaleService.insertSaleMonth("0000000001", deletedate);
		  					  
		  					System.out.println("마감완료");
						}
					}					
					mapReturn = new HashMap<String, String>();
					mapReturn.put("result", "1");
					mapReturn.put("message", "마감완료");
				} catch(Exception e) {
					e.printStackTrace();
					mapReturn = new HashMap<String, String>();
					mapReturn.put("result", "0");
					mapReturn.put("message", "적재실패");
					logStat = "2";
					errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
					commonApiLogService.insertFailLog("적재실패", mapLog, jobId, mapLog.get("logSeq"));
			 }
			// 	결과 반영
					if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, mapLog.get("logSeq"));
					
					// 최종갱신결과 업데이트
					commonApiLogService.updateJobList(jobId, logStat);
		  	}catch(Exception e){
		  		e.printStackTrace();
		  	}
		}
		
		// 농협 정산자료 마감
		if("5".equals(jobId)){
			try {
			String logStat="1";
			String errorDetail="";
			
			Map<String, String> mapLog = new HashMap<String, String>();
			mapLog.put("jobId", jobId);
			mapLog.put("logGubun", "2");
			mapLog.put("logSeq", "");
			
			pRequestParamMap.put("chDate",startDt);
			
			try {
				
				// 스케쥴러 로그 등록 및 로그 순번 조회
				commonApiLogService.startJobLog(mapLog);
				// 자동마감 insert
				calService.endNonghyup(pRequestParamMap);
				mapReturn = new HashMap<String, String>();
				mapReturn.put("result", "1");
				mapReturn.put("message", "마감완료");
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				logStat="2";
				errorDetail = CommonApiUtil.getSqlErrorMessage(e.toString());
				commonApiLogService.insertFailLog("마감실패", mapLog, jobId, mapLog.get("logSeq"));
				mapReturn = new HashMap<String, String>();
				mapReturn.put("result", "0");
				mapReturn.put("message", "마감실패");
			}
			
//		 	결과 반영
				if(!"1".equals(logStat)) commonApiLogService.updateResultLog(logStat, errorDetail, jobId, mapLog.get("logSeq"));
				
				// 최종갱신결과 업데이트
				commonApiLogService.updateJobList(jobId, logStat);
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return mapReturn;
	}

	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/dataUpdate/linkStatus/updateQnetSchedule.json")
	public Map<String, String> updateQnetSchedule(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){
		System.out.println("================= Ajax list load : /dataUpdate/linkStatus/updateQnetSchedule.do ====================");
		Map<String, String> resultMap = new HashMap<String, String>();
		
		Map<String, String> mapReturn = new HashMap<String, String>();
		
		DataOutputStream out = null;
		BufferedReader reader = null;
		
		// 개발환경
		//String url = "http://localhost:8080/egov/api/json/updateUtilData.do";
		// 운영환경
		String url = "http://210.103.25.107:8082/egov/api/json/updateQnetSchedule.do";
		try {			 
			URL url2 = new URL(url);
			HttpURLConnection httpConnection = (HttpURLConnection) url2.openConnection();
			httpConnection.setConnectTimeout(30*1000);
			httpConnection.setRequestMethod("POST");
			httpConnection.setDoOutput(true);
			httpConnection.setDoInput(true);
			
			out = new DataOutputStream(httpConnection.getOutputStream());
			
			
			//out.writeBytes(param);
			out.flush();
			BufferedReader br = null;
			StringBuffer sb = new StringBuffer();
			if(httpConnection.getResponseCode() == HttpURLConnection.HTTP_OK){
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
				String inputLine = "";
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
				String result = sb.toString();
				mapReturn = new ObjectMapper().readValue(result, HashMap.class);
				//log.info("map stirng : " + map.toString());
			}else{
				mapReturn = new HashMap<String, String>();
				mapReturn.put("result", "0");
				mapReturn.put("message", "잘못된 접근입니다.");
			}

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
				
		return mapReturn;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/dataUpdate/linkStatus/updateSchoolEventSchd.json")
	public Map<String, String> updateSchoolEventSchd(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> pRequestParamMap,	ModelMap model){
		System.out.println("================= Ajax list load : /dataUpdate/linkStatus/updateSchoolEventSchd.do ====================");
		Map<String, String> resultMap = new HashMap<String, String>();
		
		Map<String, String> mapReturn = new HashMap<String, String>();
		
		DataOutputStream out = null;
		BufferedReader reader = null;
		
		// 개발환경
		//String url = "http://localhost:8080/egov/api/json/updateUtilData.do";
		// 운영환경
		String url = "http://210.103.25.107:8082/egov/api/json/updateSchoolEventSchd.do";
		try {			 
			URL url2 = new URL(url);
			HttpURLConnection httpConnection = (HttpURLConnection) url2.openConnection();
			httpConnection.setConnectTimeout(30*1000);
			httpConnection.setRequestMethod("POST");
			httpConnection.setDoOutput(true);
			httpConnection.setDoInput(true);
			
			out = new DataOutputStream(httpConnection.getOutputStream());
			
			
			//out.writeBytes(param);
			out.flush();
			BufferedReader br = null;
			StringBuffer sb = new StringBuffer();
			if(httpConnection.getResponseCode() == HttpURLConnection.HTTP_OK){
				br = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
				String inputLine = "";
				while ((inputLine = br.readLine()) != null) {
					sb.append(inputLine);
				}
				String result = sb.toString();
				mapReturn = new ObjectMapper().readValue(result, HashMap.class);
				//log.info("map stirng : " + map.toString());
			}else{
				mapReturn = new HashMap<String, String>();
				mapReturn.put("result", "0");
				mapReturn.put("message", "잘못된 접근입니다.");
			}

			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
				
		return mapReturn;
	}
	
	@RequestMapping("/dataUpdate/linkStatus/insertLog.json")
	public void insertLog(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> pRequestParamMap){
		
	}
	
	@RequestMapping("/dataUpdate/linkStatus/updateLog.json")
	public void updateLog(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam Map<String, Object> pRequestParamMap){

	}
	
}
