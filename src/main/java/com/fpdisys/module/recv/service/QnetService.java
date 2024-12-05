package com.fpdisys.module.recv.service;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jdom2.Document;
import org.jdom2.input.SAXBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.base.util.ConvertUtils;
import com.fpdisys.module.recv.domain.ExamPlanMVO;
import com.fpdisys.module.recv.domain.QualExamSchdMVO;
import com.fpdisys.module.recv.mapper.QnetMapper;
import com.fpditrans.base.util.EgovStringUtil;

@Service
public class QnetService extends BaseService {

	@Autowired
	QnetMapper qnetMapper;

	protected Log log = LogFactory.getLog(this.getClass());


	public int insertExamPlan(List<ExamPlanMVO> list) throws Exception {

		int cnt = 0;
		for ( ExamPlanMVO exam : list ) {
			try{
				cnt += qnetMapper.insertExamPlan(exam);
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
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error("오류발생!!");
			}
		}
		return cnt;
	}

	public int insertQualExamSchd(List<QualExamSchdMVO> list) throws Exception {

		int cnt = 0;
		for ( QualExamSchdMVO exam : list ) {
			try{
				cnt += qnetMapper.insertQualExamSchd(exam);
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
				log.error(e.getMessage());
			} catch (Exception e) {
				log.error("오류발생!!");
			}
		}
		return cnt;
	}
	
	
	
	
	/**
	 * 종목별 시험정보 등록
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
//	public Map<String, Object> insertExamSchd(Map<String, Object> paramMap) throws Exception {
//		
//    	Map<String, Object> rtnMap = new HashMap<String, Object>();
//    	
//    	String implYy = EgovStringUtil.nullConvert(paramMap.get("implYy"));
//    	
//    	String startDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//
//    	List<QualExamSchdMVO> examList = new ArrayList<>();
//    	
//    	// preset
//    	
//    	// 
//    	// 7901	시설원예기능사
//    	examList.add(new QualExamSchdMVO("7901", "시설원예기능사"));
//    	examList.add(new QualExamSchdMVO("1780", "시설원예기사"));
//    	examList.add(new QualExamSchdMVO("841", "시설원예기술사"));
//    	
//    	examList.add(new QualExamSchdMVO("7900", "조경기능사"));
//    	examList.add(new QualExamSchdMVO("2320", "조경산업기사"));
//    	examList.add(new QualExamSchdMVO("1370", "조경기사"));
//    	examList.add(new QualExamSchdMVO("670", "조경기술사"));
//    	
//    	examList.add(new QualExamSchdMVO("7620", "종자기능사"));
//    	examList.add(new QualExamSchdMVO("2470", "종자산업기사"));
//    	examList.add(new QualExamSchdMVO("1560", "종자기사"));
//    	examList.add(new QualExamSchdMVO("840", "종자기술사"));
//
//    	examList.add(new QualExamSchdMVO("7625", "화훼장식기능사"));
//    	examList.add(new QualExamSchdMVO("2625", "화훼장식산업기사"));
//    	examList.add(new QualExamSchdMVO("1576", "화훼장식기사"));
//    	
//		String qnetUrl = "http://apis.data.go.kr/B490007/qualExamSchd";
//		
//    	// 인증키 (개인이 받아와야함)
//    	String key = "fsPxPzCIoEMLBCgb2LYqBegLXP0dg%2Bi7YBd6iEmnpxOdqmmQyZwThsT7a5hq68rFhmMiAncX%2FVqdaU94LRLS%2Fg%3D%3D";
//
//    	// 파싱한 데이터를 저장할 변수
//    	int cnt = 0;
//    	int numOfRows = 50;
//    	
//    	for ( QualExamSchdMVO exam : examList ) {
//    		
//    		String jmCd = EgovStringUtil.nullConvert(exam.getJmCd());
//    		String jmNm = EgovStringUtil.nullConvert(exam.getJmNm());
//    		
//    		try {
//        		for (int pageNo = 1; pageNo <= 100; pageNo++) {
//        			
//                    List<QualExamSchdMVO> examMVOList = new ArrayList<>();
//        			
//        			String apiUrl = qnetUrl
//        					+ "/getQualExamSchdList?dataFormat=xml"
//            				+ "&serviceKey=" + key
//            				+ "&numOfRows=" + Integer.toString(numOfRows)
//            				+ "&pageNo=" + Integer.toString(pageNo)
//            				+ "&implYy=" + implYy
//            				+ "&qualgbCd=T"
//            				+ "&jmCd=" + jmCd;
//        			
//        			logger.debug("apiUrl: {}", apiUrl);
//            		URL url = new URL(apiUrl);
//
//            		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//                    conn.connect();
//                    BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
//                    BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
//                    StringBuffer st = new StringBuffer();
//                    String line;
//                    while ((line = reader.readLine()) != null) {
//                        st.append(line);
//                    }
//                    JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
//                    String jsonPrettyPrintString = xmlJSONObj.toString(4);
//                    logger.debug(jsonPrettyPrintString);
//
//                    JSONObject rtnObj = xmlJSONObj
//                    						.getJSONObject("response")
//                    						.getJSONObject("header");
//
//                    String resultCode = String.valueOf(rtnObj.get("resultCode"));
//                    String resultMsg = String.valueOf(rtnObj.get("resultMsg"));
//                    logger.debug("resultCode: {}", resultCode);
//                    logger.debug("resultMsg: {}", resultMsg);
//
//                    if (xmlJSONObj.getJSONObject("response").getJSONObject("body").isNull("items")) {
//                    	break;		// 대상이 더이상 없으면 종료
//                    }
//                    
//
//                    
//                    try {
//                    	JSONArray examSchdList = xmlJSONObj
//        						.getJSONObject("response")
//				            	.getJSONObject("body")
//				            	.getJSONObject("items")
//				            	.getJSONArray("item");
//				        
//				        for ( int idx = 0; idx < examSchdList.length(); idx++ ) {
//				
//				        	Map<String, Object> examMap = new HashMap<String, Object>();
//				        	JSONObject examObj = examSchdList.getJSONObject(idx);
//				        	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
//				        	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
//				        	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
//				        	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
//				        	examMap.put("description", String.valueOf(examObj.get("description")));
//				        	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
//				        	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
//				        	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
//				        	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
//				        	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
//				        	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
//				        	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
//				        	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
//				        	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
//				        	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
//				        	
//				        	examMap.put("jmCd", jmCd);
//				        	examMap.put("jmNm", jmNm);
//				        	
//				        	QualExamSchdMVO examMVO = new QualExamSchdMVO();
//				        	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
//				        	examMVOList.add(examMVO);
//				        }
//                    } catch (Exception e) {
//                    	JSONObject examObj = xmlJSONObj
//        						.getJSONObject("response")
//				            	.getJSONObject("body")
//				            	.getJSONObject("items")
//				            	.getJSONObject("item");
//				        
//			        	Map<String, Object> examMap = new HashMap<String, Object>();
//
//			        	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
//			        	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
//			        	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
//			        	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
//			        	examMap.put("description", String.valueOf(examObj.get("description")));
//			        	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
//			        	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
//			        	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
//			        	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
//			        	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
//			        	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
//			        	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
//			        	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
//			        	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
//			        	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
//			        	
//			        	examMap.put("jmCd", jmCd);
//			        	examMap.put("jmNm", jmNm);
//			        	
//			        	QualExamSchdMVO examMVO = new QualExamSchdMVO();
//			        	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
//			        	examMVOList.add(examMVO);
//                    }
//                    
//                    /*
//        			"implYy": 2022,
//                    "pracPassDt": "",
//                    "docExamEndDt": 20220514,
//                    "pracRegStartDt": "",
//                    "pracRegEndDt": "",
//                    "description": "전문자격 (2022년도 31회 1차)",
//                    "qualgbCd": "S",
//                    "docPassDt": 20220615,
//                    "qualgbNm": "국가전문자격",
//                    "pracExamEndDt": "",
//                    "docRegEndDt": 20220325,
//                    "pracExamStartDt": "",
//                    "docExamStartDt": 20220514,
//                    "implSeq": 31,
//                    "docRegStartDt": 20220321
//                    */
//                    logger.debug("count: {}", examMVOList.size());
//                    
//                    if (examMVOList.isEmpty()) {
//                    	break;
//                    }
//
//                    cnt += insertQualExamSchd(examMVOList);
//        		}
//        		
//        		logger.debug("insert count: {}", cnt);
//        		
//        	}catch(Exception e) {
//        		e.printStackTrace();
//        	}
//    	}
    	
    	//public Map<String, Object> insertExamSchd(Map<String, Object> paramMap) throws Exception {
	public void insertExamSchd(Map<String, String> paramMap) {
		//try{
		//String data = String.valueOf(paramMap.get("data"));
		//Document doc = new SAXBuilder().build(new StringReader(data));
		//} catch(Exception e){
			//e.printStackTrace();
		//}
		
		String jmCd = paramMap.get("jmCd").toString();
		String jmNm = paramMap.get("jmNm").toString();
		int pageNo =  Integer.parseInt(paramMap.get("pageNo").toString());
		String implYy = paramMap.get("implYy").toString();
		
    	Map<String, Object> rtnMap = new HashMap<String, Object>();
    	try{
    		System.out.println(URLDecoder.decode(paramMap.get("data").toString(), "UTF-8"));
			JSONObject xmlJSONObj = XML.toJSONObject(paramMap.get("data").toString());
			String jsonPrettyPrintString = xmlJSONObj.toString(4);
            logger.debug(jsonPrettyPrintString);


            JSONObject rtnObj = xmlJSONObj.getJSONObject("response").getJSONObject("header");

            String resultCode = String.valueOf(rtnObj.get("resultCode"));
            String resultMsg = String.valueOf(rtnObj.get("resultMsg"));
            logger.debug("resultCode: {}", resultCode);
            logger.debug("resultMsg: {}", resultMsg);

            List<QualExamSchdMVO> examMVOList = new ArrayList<>();
            try {
            	JSONArray examSchdList = xmlJSONObj
						.getJSONObject("response")
		            	.getJSONObject("body")
		            	.getJSONObject("items")
		            	.getJSONArray("item");
		        
		        for ( int idx = 0; idx < examSchdList.length(); idx++ ) {
		
		        	Map<String, Object> examMap = new HashMap<String, Object>();
		        	JSONObject examObj = examSchdList.getJSONObject(idx);
		        	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
		        	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
		        	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
		        	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
		        	examMap.put("description", String.valueOf(examObj.get("description")));
		        	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
		        	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
		        	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
		        	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
		        	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
		        	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
		        	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
		        	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
		        	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
		        	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
		        	
		        	examMap.put("jmCd", jmCd);
		        	examMap.put("jmNm", jmNm);
		        	
		        	QualExamSchdMVO examMVO = new QualExamSchdMVO();
		        	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
		        	examMVOList.add(examMVO);
		        }
            } catch (Exception e) {
            	JSONObject examObj = xmlJSONObj
						.getJSONObject("response")
		            	.getJSONObject("body")
		            	.getJSONObject("items")
		            	.getJSONObject("item");
		        
	        	Map<String, Object> examMap = new HashMap<String, Object>();

	        	examMap.put("implYy", String.valueOf(examObj.get("implYy")));
	        	examMap.put("implSeq", String.valueOf(examObj.get("implSeq")));
	        	examMap.put("qualgbCd", String.valueOf(examObj.get("qualgbCd")));
	        	examMap.put("qualgbNm", String.valueOf(examObj.get("qualgbNm")));
	        	examMap.put("description", String.valueOf(examObj.get("description")));
	        	examMap.put("docRegStartDt", String.valueOf(examObj.get("docRegStartDt")));
	        	examMap.put("docRegEndDt", String.valueOf(examObj.get("docRegEndDt")));
	        	examMap.put("docExamStartDt", String.valueOf(examObj.get("docExamStartDt")));
	        	examMap.put("docExamEndDt", String.valueOf(examObj.get("docExamEndDt")));
	        	examMap.put("docPassDt", String.valueOf(examObj.get("docPassDt")));
	        	examMap.put("pracRegStartDt", String.valueOf(examObj.get("pracRegStartDt")));
	        	examMap.put("pracRegEndDt", String.valueOf(examObj.get("pracRegEndDt")));
	        	examMap.put("pracExamStartDt", String.valueOf(examObj.get("pracExamStartDt")));
	        	examMap.put("pracExamEndDt", String.valueOf(examObj.get("pracExamEndDt")));
	        	examMap.put("pracPassDt", String.valueOf(examObj.get("pracPassDt")));
	        	
	        	examMap.put("jmCd", jmCd);
	        	examMap.put("jmNm", jmNm);
	        	
	        	QualExamSchdMVO examMVO = new QualExamSchdMVO();
	        	examMVO = ConvertUtils.convertToValueObject(examMap, QualExamSchdMVO.class);
	        	examMVOList.add(examMVO);
            }
            int temp = insertQualExamSchd(examMVOList);
    	} catch(Exception e){
    		e.printStackTrace();
    	}
	}
	
	public Map<String, String> insertExamSchd(List<Map<String, Object>> schdList) {
		List<QualExamSchdMVO> examMVOList = new ArrayList<>();
		
		try {
			
			String implYy = "";
			
			for ( Map<String, Object> schd : schdList) {
				QualExamSchdMVO examMVO = new QualExamSchdMVO();
	        	examMVO = ConvertUtils.convertToValueObject(schd, QualExamSchdMVO.class);
	        	examMVOList.add(examMVO);
	        	
	        	if (EgovStringUtil.isEmpty(implYy)) {
	        		implYy = examMVO.getImplYy();
	        	}
			}
			
			insertQualExamSchd(examMVOList);
			
	    	Map<String, Object> schInfoRegMap = new HashMap<String, Object>();
			schInfoRegMap.put("eventGp", "50");
			schInfoRegMap.put("eventYmd", implYy);
			qnetMapper.insertSchInfo(schInfoRegMap);
	    	
	    	//String endDttm = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

		} catch (Exception e) {
			
		}
		
		return null;
	}
	
	
}

