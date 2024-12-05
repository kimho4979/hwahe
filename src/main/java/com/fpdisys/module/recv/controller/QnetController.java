package com.fpdisys.module.recv.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.module.recv.service.QnetService;
import egovframework.rte.fdl.property.EgovPropertyService;


@Controller
public class QnetController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private QnetService qnetService;


//	@RequestMapping(value="/qnet/getExamPlan.do")
//	public String getExamPlanTemp(HttpServletRequest pRequest, HttpServletResponse pResponse
//			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
//
//		String qnetUrl = "http://openapi.q-net.or.kr/api/service/rest/InquiryTestInformationNTQSVC";
//
//    	// 인증키 (개인이 받아와야함)
//    	String key = "fsPxPzCIoEMLBCgb2LYqBegLXP0dg%2Bi7YBd6iEmnpxOdqmmQyZwThsT7a5hq68rFhmMiAncX%2FVqdaU94LRLS%2Fg%3D%3D";
//
//    	int cnt = 0;
//    	try {
//    		String apiUrl = qnetUrl + "/getCList?serviceKey=" + key;
//    		URL url = new URL(apiUrl);
//
//            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//            conn.connect();
//            BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
//            BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
//            StringBuffer st = new StringBuffer();
//            String line;
//            while ((line = reader.readLine()) != null) {
//                st.append(line);
//            }
//
//            JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
//            String jsonPrettyPrintString = xmlJSONObj.toString(4);
//            logger.debug(jsonPrettyPrintString);
//
//            JSONArray examList = xmlJSONObj
//            						.getJSONObject("response")
//					            	.getJSONObject("body")
//					            	.getJSONObject("items")
//					            	.getJSONArray("item");
//            List<ExamPlanMVO> examPlanMVOList = new ArrayList<>();
//            for ( int idx = 0; idx < examList.length(); idx++ ) {
//            	Map<String, Object> examMap = new HashMap<String, Object>();
//            	JSONObject examObj = examList.getJSONObject(idx);
//            	examMap.put("description", String.valueOf(examObj.get("description")));
//            	examMap.put("desSeq", "1");
//
//            	examMap.put("docRegStartDt",  	examObj.has("docregstartdt") 	&& examObj.get("docregstartdt") 	!= null ? String.valueOf(examObj.get("docregstartdt")) 		: "");
//            	examMap.put("docRegEndDt",  	examObj.has("docregenddt") 		&& examObj.get("docregenddt") 		!= null ? String.valueOf(examObj.get("docregenddt")) 		: "");
//            	examMap.put("docExamDt",  		examObj.has("docexamdt") 		&& examObj.get("docexamdt") 		!= null ? String.valueOf(examObj.get("docexamdt")) 			: "");
//            	examMap.put("docPassDt",  		examObj.has("docpassdt") 		&& examObj.get("docpassdt") 		!= null ? String.valueOf(examObj.get("docpassdt")) 			: "");
//            	examMap.put("docSubmitStartDt", examObj.has("docsubmitstartdt") && examObj.get("docsubmitstartdt") 	!= null ? String.valueOf(examObj.get("docsubmitstartdt")) 	: "");
//            	examMap.put("docSubmitEntDt",  	examObj.has("docsubmitentdt") 	&& examObj.get("docsubmitentdt") 	!= null ? String.valueOf(examObj.get("docsubmitentdt")) 	: "");
//            	examMap.put("pracRegStartDt",  	examObj.has("pracregstartdt") 	&& examObj.get("pracregstartdt") 	!= null ? String.valueOf(examObj.get("pracregstartdt")) 	: "");
//            	examMap.put("pracRegEndDt",  	examObj.has("pracregenddt") 	&& examObj.get("pracregenddt") 		!= null ? String.valueOf(examObj.get("pracregenddt")) 		: "");
//            	examMap.put("pracExamStartDt",  examObj.has("pracexamstartdt") 	&& examObj.get("pracexamstartdt") 	!= null ? String.valueOf(examObj.get("pracexamstartdt")) 	: "");
//            	examMap.put("pracExamEndDt",  	examObj.has("pracexamenddt") 	&& examObj.get("pracexamenddt") 	!= null ? String.valueOf(examObj.get("pracexamenddt")) 		: "");
//            	examMap.put("pracPassDt",  		examObj.has("pracpassdt") 		&& examObj.get("pracpassdt") 		!= null ? String.valueOf(examObj.get("pracpassdt")) 		: "");
//
//            	ExamPlanMVO examPlanMVO = new ExamPlanMVO();
//            	examPlanMVO = ConvertUtils.convertToValueObject(examMap, ExamPlanMVO.class);
//            	examPlanMVOList.add(examPlanMVO);
//            }
//
//            logger.debug("count: {}", examPlanMVOList.size());
//            if (!examPlanMVOList.isEmpty()) {
//            	cnt += qnetService.insertExamPlan(examPlanMVOList);
//            }
//            logger.debug("insert count: {}", cnt);
//            /*
//            "pracexamenddt": 20220507,
//            "pracexamstartdt": 20220410,
//            "pracpassdt": 20220512,
//            "pracregenddt": 20220325,
//            "pracregstartdt": 20220325,
//            "description": "2022년 상시 기능사 103회"
//            */
//
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//
//		 return "/auction/Yuchal";
//	}

//	@RequestMapping(value="/qnet/getExamPlan.json")
//	public String getExamPlan(HttpServletRequest pRequest, HttpServletResponse pResponse
//			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
//
//		
//    	Map<String, Object> rtnMap = new HashMap<String, Object>();
//    	
//    	String startDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//    	
//    	int cnt = 0;
//    	
//		String qnetUrl = "http://openapi.q-net.or.kr/api/service/rest/InquiryTestInformationNTQSVC";
//
//    	// 인증키 (개인이 받아와야함)
//    	String key = "fsPxPzCIoEMLBCgb2LYqBegLXP0dg%2Bi7YBd6iEmnpxOdqmmQyZwThsT7a5hq68rFhmMiAncX%2FVqdaU94LRLS%2Fg%3D%3D";
//
//    	// 기술사			getPEList
//    	// 기능장			getMCList
//    	// 기사, 산업기사	getEList
//    	// 기능사			getCList
//    	// 응시수수료		getFeeList
//    	// 종목별 시행일정		getJMList
//
//    	String[] oprCmdList = {
//    			"getPEList"
//    			, "getMCList"
//    			, "getEList"
//    			, "getCList"   
//    		};
//    	
//    	for ( String oprCmd : oprCmdList ) {
//    		try {
//        		// String apiUrl = qnetUrl + "/getCList?serviceKey=" + key;
//        		String apiUrl = qnetUrl + "/" + oprCmd + "?serviceKey=" + key;
//        		URL url = new URL(apiUrl);
//
//                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//                conn.connect();
//                BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
//                BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
//                StringBuffer st = new StringBuffer();
//                String line;
//                while ((line = reader.readLine()) != null) {
//                    st.append(line);
//                }
//
//                JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
//                String jsonPrettyPrintString = xmlJSONObj.toString(4);
//                logger.debug(jsonPrettyPrintString);
//
////                if (xmlJSONObj.getJSONObject("response").getJSONObject("body").get("items"))) {
////                	continue;		// 대상이 더이상 없으면 종료
////                }
//                
//                JSONArray examList = xmlJSONObj
//                						.getJSONObject("response")
//    					            	.getJSONObject("body")
//    					            	.getJSONObject("items")
//    					            	.getJSONArray("item");
//                if (examList == null) {
//                	continue;
//                }
//                
//                List<ExamPlanMVO> examPlanMVOList = new ArrayList<>();
//                
//                for ( int idx = 0; idx < examList.length(); idx++ ) {
//                	Map<String, Object> examMap = new HashMap<String, Object>();
//                	JSONObject examObj = examList.getJSONObject(idx);
//                	examMap.put("description", String.valueOf(examObj.get("description")));
//                	examMap.put("desSeq", "1");
//
//                	examMap.put("docRegStartDt",  	examObj.has("docregstartdt") 	&& examObj.get("docregstartdt") 	!= null ? String.valueOf(examObj.get("docregstartdt")) 		: "");
//                	examMap.put("docRegEndDt",  	examObj.has("docregenddt") 		&& examObj.get("docregenddt") 		!= null ? String.valueOf(examObj.get("docregenddt")) 		: "");
//                	examMap.put("docExamDt",  		examObj.has("docexamdt") 		&& examObj.get("docexamdt") 		!= null ? String.valueOf(examObj.get("docexamdt")) 			: "");
//                	examMap.put("docPassDt",  		examObj.has("docpassdt") 		&& examObj.get("docpassdt") 		!= null ? String.valueOf(examObj.get("docpassdt")) 			: "");
//                	examMap.put("docSubmitStartDt", examObj.has("docsubmitstartdt") && examObj.get("docsubmitstartdt") 	!= null ? String.valueOf(examObj.get("docsubmitstartdt")) 	: "");
//                	examMap.put("docSubmitEntDt",  	examObj.has("docsubmitentdt") 	&& examObj.get("docsubmitentdt") 	!= null ? String.valueOf(examObj.get("docsubmitentdt")) 	: "");
//                	examMap.put("pracRegStartDt",  	examObj.has("pracregstartdt") 	&& examObj.get("pracregstartdt") 	!= null ? String.valueOf(examObj.get("pracregstartdt")) 	: "");
//                	examMap.put("pracRegEndDt",  	examObj.has("pracregenddt") 	&& examObj.get("pracregenddt") 		!= null ? String.valueOf(examObj.get("pracregenddt")) 		: "");
//                	examMap.put("pracExamStartDt",  examObj.has("pracexamstartdt") 	&& examObj.get("pracexamstartdt") 	!= null ? String.valueOf(examObj.get("pracexamstartdt")) 	: "");
//                	examMap.put("pracExamEndDt",  	examObj.has("pracexamenddt") 	&& examObj.get("pracexamenddt") 	!= null ? String.valueOf(examObj.get("pracexamenddt")) 		: "");
//                	examMap.put("pracPassDt",  		examObj.has("pracpassdt") 		&& examObj.get("pracpassdt") 		!= null ? String.valueOf(examObj.get("pracpassdt")) 		: "");
//
//                	ExamPlanMVO examPlanMVO = new ExamPlanMVO();
//                	examPlanMVO = ConvertUtils.convertToValueObject(examMap, ExamPlanMVO.class);
//                	examPlanMVOList.add(examPlanMVO);
//                }
//
//                logger.debug("count: {}", examPlanMVOList.size());
//                if (!examPlanMVOList.isEmpty()) {
//                	cnt += qnetService.insertExamPlan(examPlanMVOList);
//                }
//                logger.debug("insert count: {}", cnt);
//                /*
//                "pracexamenddt": 20220507,
//                "pracexamstartdt": 20220410,
//                "pracpassdt": 20220512,
//                "pracregenddt": 20220325,
//                "pracregstartdt": 20220325,
//                "description": "2022년 상시 기능사 103회"
//                */
//
//        	}catch(Exception e) {
//        		e.printStackTrace();
//        	}
//    	}
//    	
//    	
//
//    	String endDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//    	
//    	rtnMap.put("count", cnt);
//    	rtnMap.put("startDttm", startDttm);
//    	rtnMap.put("endDttm", endDttm);
//    	
//    	model.addAttribute("rtnMap", rtnMap);
//    	
//    	return "jsonView";
//	}
	

//	@RequestMapping(value="/qnet/qualExamSchd.do")
//	public String getQualExamSchdTemp(HttpServletRequest pRequest, HttpServletResponse pResponse
//			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
//
//		String qnetUrl = "http://apis.data.go.kr/B490007/qualExamSchd";
//    	// 인증키 (개인이 받아와야함)
//    	String key = "fsPxPzCIoEMLBCgb2LYqBegLXP0dg%2Bi7YBd6iEmnpxOdqmmQyZwThsT7a5hq68rFhmMiAncX%2FVqdaU94LRLS%2Fg%3D%3D";
//
//    	// 파싱한 데이터를 저장할 변수
//    	int cnt = 0;
//    	String implYy = "2022";
//    	int numOfRows = 50;
//    	try {
//    		for (int pageNo = 1; pageNo <= 10; pageNo++) {
//    			String apiUrl = qnetUrl
//    					+ "/getQualExamSchdList?dataFormat=xml"
//        				+ "&serviceKey=" + key
//        				+ "&numOfRows=" + Integer.toString(numOfRows)
//        				+ "&pageNo=" + Integer.toString(pageNo)
//        				+ "&implYy=" + implYy;
//    			logger.debug("apiUrl");
//    			logger.debug(apiUrl);
//        		URL url = new URL(apiUrl);
//
//        		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//                conn.connect();
//                BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
//                BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
//                StringBuffer st = new StringBuffer();
//                String line;
//                while ((line = reader.readLine()) != null) {
//                    st.append(line);
//                }
//                JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
//                String jsonPrettyPrintString = xmlJSONObj.toString(4);
//                logger.debug(jsonPrettyPrintString);
//
//                JSONObject rtnObj = xmlJSONObj
//                						.getJSONObject("response")
//                						.getJSONObject("header");
//
//                String resultCode = String.valueOf(rtnObj.get("resultCode"));
//                String resultMsg = String.valueOf(rtnObj.get("resultMsg"));
//                logger.debug("resultCode");
//                logger.debug(resultCode);
//                logger.debug("resultMsg");
//                logger.debug(resultMsg);
//
//                JSONArray examList = xmlJSONObj
//                						.getJSONObject("response")
//    					            	.getJSONObject("body")
//    					            	.getJSONObject("items")
//    					            	.getJSONArray("item");
//
//                List<QualExamSchdMVO> examMVOList = new ArrayList<>();
//                for ( int idx = 0; idx < examList.length(); idx++ ) {
//
//                	Map<String, Object> examMap = new HashMap<String, Object>();
//                	JSONObject examObj = examList.getJSONObject(idx);
//                	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
//                	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
//                	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
//                	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
//                	examMap.put("description", String.valueOf(examObj.get("description")));
//                	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
//                	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
//                	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
//                	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
//                	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
//                	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
//                	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
//                	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
//                	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
//                	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
//
//                	QualExamSchdMVO examMVO = new QualExamSchdMVO();
//                	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
//                	examMVOList.add(examMVO);
//                }
//
//                /*
//    			"implYy": 2022,
//                "pracPassDt": "",
//                "docExamEndDt": 20220514,
//                "pracRegStartDt": "",
//                "pracRegEndDt": "",
//                "description": "전문자격 (2022년도 31회 1차)",
//                "qualgbCd": "S",
//                "docPassDt": 20220615,
//                "qualgbNm": "국가전문자격",
//                "pracExamEndDt": "",
//                "docRegEndDt": 20220325,
//                "pracExamStartDt": "",
//                "docExamStartDt": 20220514,
//                "implSeq": 31,
//                "docRegStartDt": 20220321
//                */
//                logger.debug("count: {}", examMVOList.size());
//                if (examMVOList.isEmpty()) {
//                	break;
//                }
//
//                cnt += qnetService.insertQualExamSchd(examMVOList);
//    		}
//    		logger.debug("insert count: {}", cnt);
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//
//		 return "/auction/Yuchal";
//	}
	
//	@RequestMapping(value="/qnet/qualExamSchd.json")
//	public String getQualExamSchd(HttpServletRequest pRequest, HttpServletResponse pResponse
//			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
//
//    	Map<String, Object> rtnMap = new HashMap<String, Object>();
//    	String implYy = EgovStringUtil.nullConvert(pRequestParamMap.get("implYy"));
//    	
//    	String startDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//    	 
//		String qnetUrl = "http://apis.data.go.kr/B490007/qualExamSchd";
//    	// 인증키 (개인이 받아와야함)
//    	String key = "fsPxPzCIoEMLBCgb2LYqBegLXP0dg%2Bi7YBd6iEmnpxOdqmmQyZwThsT7a5hq68rFhmMiAncX%2FVqdaU94LRLS%2Fg%3D%3D";
//
//    	// 파싱한 데이터를 저장할 변수
//    	int cnt = 0;
//    	//String implYy = "2022";
//    	
//    	int numOfRows = 50;
//    	try {
//    		for (int pageNo = 1; pageNo <= 100; pageNo++) {
//    			String apiUrl = qnetUrl
//    					+ "/getQualExamSchdList?dataFormat=xml"
//        				+ "&serviceKey=" + key
//        				+ "&numOfRows=" + Integer.toString(numOfRows)
//        				+ "&pageNo=" + Integer.toString(pageNo)
//        				+ "&implYy=" + implYy;
//    			logger.debug("apiUrl");
//    			logger.debug(apiUrl);
//        		URL url = new URL(apiUrl);
//
//        		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//                conn.connect();
//                BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
//                BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
//                StringBuffer st = new StringBuffer();
//                String line;
//                while ((line = reader.readLine()) != null) {
//                    st.append(line);
//                }
//                JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
//                String jsonPrettyPrintString = xmlJSONObj.toString(4);
//                logger.debug(jsonPrettyPrintString);
//
//                JSONObject rtnObj = xmlJSONObj
//                						.getJSONObject("response")
//                						.getJSONObject("header");
//
//                String resultCode = String.valueOf(rtnObj.get("resultCode"));
//                String resultMsg = String.valueOf(rtnObj.get("resultMsg"));
//                logger.debug("resultCode");
//                logger.debug(resultCode);
//                logger.debug("resultMsg");
//                logger.debug(resultMsg);
//
//                if (xmlJSONObj.getJSONObject("response").getJSONObject("body").getString("items").isEmpty()) {
//                	break;		// 대상이 더이상 없으면 종료
//                }
//                
//                JSONArray examList = xmlJSONObj
//                						.getJSONObject("response")
//    					            	.getJSONObject("body")
//    					            	.getJSONObject("items")
//    					            	.getJSONArray("item");
//
//                // org.json.JSONException: JSONObject["items"] is not a JSONObject.
//                
//                List<QualExamSchdMVO> examMVOList = new ArrayList<>();
//                for ( int idx = 0; idx < examList.length(); idx++ ) {
//
//                	Map<String, Object> examMap = new HashMap<String, Object>();
//                	JSONObject examObj = examList.getJSONObject(idx);
//                	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
//                	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
//                	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
//                	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
//                	examMap.put("description", String.valueOf(examObj.get("description")));
//                	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
//                	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
//                	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
//                	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
//                	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
//                	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
//                	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
//                	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
//                	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
//                	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
//
//                	QualExamSchdMVO examMVO = new QualExamSchdMVO();
//                	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
//                	examMVOList.add(examMVO);
//                }
//
//                /*
//    			"implYy": 2022,
//                "pracPassDt": "",
//                "docExamEndDt": 20220514,
//                "pracRegStartDt": "",
//                "pracRegEndDt": "",
//                "description": "전문자격 (2022년도 31회 1차)",
//                "qualgbCd": "S",
//                "docPassDt": 20220615,
//                "qualgbNm": "국가전문자격",
//                "pracExamEndDt": "",
//                "docRegEndDt": 20220325,
//                "pracExamStartDt": "",
//                "docExamStartDt": 20220514,
//                "implSeq": 31,
//                "docRegStartDt": 20220321
//                */
//                logger.debug("count: {}", examMVOList.size());
//                if (examMVOList.isEmpty()) {
//                	break;
//                }
//
//                cnt += qnetService.insertQualExamSchd(examMVOList);
//    		}
//    		logger.debug("insert count: {}", cnt);
//    	}catch(Exception e) {
//    		e.printStackTrace();
//    	}
//
//    	String endDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//    	
//    	rtnMap.put("count", cnt);
//    	rtnMap.put("startDttm", startDttm);
//    	rtnMap.put("endDttm", endDttm);
//    	model.addAttribute("rtnMap", rtnMap);
//    	
//    	return "jsonView";
//	}
//
//	@RequestMapping(value="/qnet/qualExamSchdBatch.json")
//	public void getQualExamSchdBatch(@RequestParam Map<String, String> pRequestParamMap){
//		Map<String, Object> rtnMap = new HashMap<>();
//		try {
//			String implYy = EgovStringUtil.nullConvert(pRequestParamMap.get("implYy"));
//			logger.debug("implYy: {}", implYy);
//			
//			// M + 1 의  연도를 가져온다
//			 qnetService.insertExamSchd(pRequestParamMap);
//			
//		} catch (Exception e) {			
//			rtnMap.put("errCd", "999");
//			rtnMap.put("errMsg", e.getMessage());			
//		}
//	}
	
	
	/**
	 * 연계서버에서 시험정보를 넘겨받아 DB에 등록, 주요행사정보 MAIN TABLE UPDATE까지 처리
	 * @param header
	 * @param schdList
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/qnet/insertSchdList.json", method=RequestMethod.POST)
	public String insertSchdList(HttpServletRequest header, @RequestBody List<Map<String, Object>> schdList, ModelMap model){
		Map<String, Object> rtnMap = new HashMap<>();
		try {
			qnetService.insertExamSchd(schdList);
			
		} catch (Exception e) {			
			rtnMap.put("errCd", "999");
			rtnMap.put("errMsg", e.getMessage());			
		}
		
		model.addAttribute("rtnMap", rtnMap);
		
		return "jsonView";
	}
}
