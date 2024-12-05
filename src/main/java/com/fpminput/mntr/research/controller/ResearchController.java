package com.fpminput.mntr.research.controller;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.base.mvc.BaseController;
import com.fpminput.mntr.research.service.ResearchService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ResearchController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	ResearchService researchService;
	
	// 절화류 생산조사 사용자
	@RequestMapping(value="/research/prodStat.do")
	public String prodStat(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		return "/research/prodStat";
	}
	
	
	// 절화류 생산조사 메인
	@RequestMapping(value="/research/main.do")
	public String main(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		HttpSession httpSession = pRequest.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}
		 
		return "/research/main";
	}
	
	 
	@RequestMapping(value="/reseach/mainChart.json")
	public String mainChartAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		
		try{
			List<EgovMap> mainChulInfoChart = researchService.mainChulInfoChart(pRequestParamMap);
			List<EgovMap> mainPrdInfoChart = researchService.mainPrdInfoChart(pRequestParamMap);
			model.addAttribute("mainChulInfoChart",mainChulInfoChart);
			model.addAttribute("mainPrdInfoChart",mainPrdInfoChart);
			
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
	
	@RequestMapping(value="/reseach/mainChart2.json")
	public String mainChart2Ajax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		
		try{
			List<EgovMap> mainChulInfoChart2 = researchService.mainChulInfoChart2(pRequestParamMap);
			List<EgovMap> mainPrdInfoChart2 = researchService.mainPrdInfoChart2(pRequestParamMap);
			model.addAttribute("mainChulInfoChart2",mainChulInfoChart2);
			model.addAttribute("mainPrdInfoChart2",mainPrdInfoChart2);
			
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
		
	// 데이터관리 시작
	@RequestMapping(value="/research/dataUpload.do")
	public String dataUpload(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		/*HttpSession httpSession = pRequest.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}*/
		
		
		
		 
		return "/research/dataUpload";
	}
	
	
	
	@RequestMapping(value="/research/excellValidation.json")
	public String excellValidation(
			  @RequestParam Map<String, Object> paramMap
			, HttpServletResponse response
			, MultipartHttpServletRequest request
			, ModelMap model) throws Exception{
		
		/*HttpSession httpSession = request.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}*/
		
		
		
		MultipartFile file = request.getFile("excellFile");
		
		if(file == null || file.getOriginalFilename().equals("") ){
			//파일없음
			model.addAttribute("result","4");
			return "jsonView";
		}
		
		OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
         XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
        try {
         String[] colArr1 = {
        		   			  "농가ID","행정기관코드","시도코드","시도","시군구","성명","성별","일반전화","휴대전화","이메일"
        		   		    , "농가지번","농가도로명","영농시작년","영농시작월","전업여부","농장명","농장지번","농장도로명","농장지번2","농장도로명2"
	        		   		, "농장지번3","농장도로명3","농장지번4","농장도로명4","농장지번5","농장도로명5","농장1면적","농장2면적","농장3면적","농장4면적"
	        		   		, "농장5면적","농장 면적 합계","절화1 면적","절화2 면적","절화3 면적","절화4 면적","절화5 면적","절화 면적 합계","내국인 합계","내국인 상시고용직"
	        		   		, "내국인 무급가족 종사자","내국인 임시직","내국인 성수기 임시직","외극인 합계","외국인 상시고용직","외국인 무급가족 종사자","외국인 임시직","외국인 성수기 임시직","농장전체면적","전체노지면적"
	        		   		, "전체시설합계면적","전체철골유리면적","전체철골경질면적","전체철파이프면적","전체기타면적","자가전체면적","자가노지면적","자가시설합계면적","자가철골유리면적","자가철골경질면적"
	        		   		, "자가철파이프면적","자가기타면적","임차전체면적","임차노지면적","임차시설합계면적","임차철골유리면적","임차철골경질면적","임차철파이프면적","임차기타면적","시설재배유형 합계"
	        		   		, "토경재배","양액재배 고형배지 소계","양액재배 고형배지 펄라이트","양액재배 고형배지 암면","양액재배 고형배지 기타","양액재배 고형배지 기타텍스트","양액재배 순수수경 소계","양액재배 순수수경 담액경","양액재배 순수수경 박막경","양액재배 순수수경 분무경"
	        		   		, "양액재배 순수수경 기타","양액재배 순수수경 기타텍스트","가온여부","가온현황 합계","무가온","가온 소계","가온 전기류","가온 유류","가온 신재생에너지","가온 가스류"
	        		   		, "가온 고체연료","가온 복수가온","가온 기타","가온 기타 텍스트","복수가온 전기류","복수가온 전기류","복수가온 유류","복수가온 신재생에너지","복수가온 가스류","복수가온 기타"
	        		   		, "복수가온 기타 텍스트","보온여부","보온합계","연동 무보온","연동 소계","연동 부직포류","연동 알루미늄스크린","연동 다겹보온","연동 복수보온","연동 기타"
	        		   		, "연동 기타 텍스트","단동 무보온","단동 소계","단동 다중피복","단동 내부터널","단동 외부보온","단동 수막보온","단동 복수보온","단동 기타","단동 기타 텍스트"
	        		   		, "연동 복수보온 부직포류","연동 복수보온 알루미늄스크린","연동 복수보온 다겹보온","연동 복수보온 기타","연동 복수보온 기타텍스트","단동 복수보온 다중피복","단동 복수보온 내부터널","단동 복수보온 외부보온","단동 복수보온 수막보온","단동 복수보온 기타"
	        		   		, "단동 복수보온 기타텍스트","기준년도 정식 출하품목1","기준년도 정식 출하품목2","기준년도 정식 출하품목3","기준년도 정식 출하품목4","기준년도 정식 출하품목5","기준년도 정식 출하품목6","기준년도 정식 출하품목7","기준년도 정식 출하품목8","기준년도 정식 출하품목9"
	        		   		, "다음년도 정식 출하예정품목1","다음년도 정식 출하예정품목2","다음년도 정식 출하예정품목3","다음년도 정식 출하예정품목4","다음년도 정식 출하예정품목5","다음년도 정식 출하예정품목6","다음년도 정식 출하예정품목7","다음년도 정식 출하예정품목8","다음년도 정식 출하예정품목9"
        		            };
         
         String[] colValidition1 = {
        		 "nullNumberChk","nullChk","nullNumberChk","nullChk","nullChk","","numberChk","","",""
		   		, "","","numberChk","numberChk","numberChk","","","","",""
 		   		, "","","","","","","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   	    , "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk",""
 		   		, "numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","","","","","","","","",""
 		   		, "","","","","","","","",""
         };
         
         
         String[] colArr2 = {
        		 "농가ID","정식구분","품목번호","품목명","일반현황 최초(최종)","일반현황 연간(최종)","판매현황 수량","판매현황 단위","판매현황 단가","판매현황 총액"
        		 ,"1월 출하량 분포","2월 출하량 분포","3월 출하량 분포","4월 출하량 분포","5월 출하량 분포","6월 출하량 분포","7월 출하량 분포","8월 출하량 분포","9월 출하량 분포","10월 출하량 분포"
        		 ,"11월 출하량 분포","12월 출하량 분포","법정 양재 출하량 분포","법정 엄궁 출하량 분포","전문 영남 출하량 분포","전문 부경 출하량 분포","전문 광주 출하량 분포","유사 터미널 출하량 분포","유사 코벤트 출하량 분포","유사 남대문 출하량 분포"
        		 ,"유사 기타 출하량 분포","직거래 온라인 출하량 분포","직거래 오프라인 출하량 분포","유사 기타 텍스트","기존면적","기준년도 1월 정식 면적","기준년도 2월 정식 면적","기준년도 3월 정식 면적","기준년도 4월 정식 면적","기준년도 5월 정식 면적"
        		 ,"기준년도 6월 정식 면적","기준년도 7월 정식 면적","기준년도 8월 정식 면적","기준년도 9월 정식 면적","기준년도 10월 정식 면적","기준년도 11월 정식 면적","기준년도 12월 정식 면적","기준년도 1월 정식 구분","기준년도 2월 정식 구분","기준년도 3월 정식 구분"
        		 ,"기준년도 4월 정식 구분","기준년도 5월 정식 구분","기준년도 6월 정식 구분","기준년도 7월 정식 구분","기준년도 8월 정식 구분","기준년도 9월 정식 구분","기준년도 10월 정식 구분","기준년도 11월 정식 구분","기준년도 12월 정식 구분","다음년도 1월 정식 면적"
        		 ,"다음년도 2월 정식 면적","다음년도 3월 정식 면적","다음년도 4월 정식 면적","다음년도 5월 정식 면적","다음년도 6월 정식 면적","다음년도 7월 정식 면적","다음년도 8월 정식 면적","다음년도 9월 정식 면적","다음년도 10월 정식 면적","다음년도 11월 정식 면적"
        		 ,"다음년도 12월 정식 면적","다음년도 1월 정식 구분","다음년도 2월 정식 구분","다음년도 3월 정식 구분","다음년도 4월 정식 구분","다음년도 5월 정식 구분","다음년도 6월 정식 구분","다음년도 7월 정식 구분","다음년도 8월 정식 구분","다음년도 9월 정식 구분"
        		 ,"다음년도 10월 정식 구분","다음년도 11월 정식 구분","다음년도 12월 정식 구분","기준년도 1월 연면적","기준년도 2월 연면적","기준년도 3월 연면적","기준년도 4월 연면적","기준년도 5월 연면적","기준년도 6월 연면적","기준년도 7월 연면적"
        		 ,"기준년도 8월 연면적","기준년도 9월 연면적","기준년도 10월 연면적","기준년도 11월 연면적","기준년도 12월 연면적","다음년도 1월 연면적","다음년도 2월 연면적","다음년도 3월 연면적","다음년도 4월 연면적","다음년도 5월 연면적"
        		 ,"다음년도 6월 연면적","다음년도 7월 연면적","다음년도 8월 연면적","다음년도 9월 연면적","다음년도 10월 연면적","다음년도 11월 연면적","다음년도 12월 연면적"
	            };

		String[] colValidition2 = {
			  "nullNumberChk","nullNumberChk","nullNumberChk","nullChk","numberChk","numberChk","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","","","","",""
       		 ,"","","","","","",""
		};
         

         List<Map<String,Object>> errorList1 = new ArrayList<Map<String,Object>>();
         List<Map<String,Object>> errorList2 = new ArrayList<Map<String,Object>>();
         
         // 첫번째 시트 불러오기
         XSSFSheet sheet = workbook.getSheetAt(0);
         
         for(int i=7; i<sheet.getLastRowNum() + 1; i++) {
        	 
             XSSFRow row = sheet.getRow(i);
             
             // 행이 존재하기 않으면 패스
             if(null == row) {
                 continue;
             }
             
             Map<String, Object> errorVO = new HashMap<String, Object>();
             
             String errorMessage = "";
             
             for(int j=0; j<colArr1.length; j++){
            	 XSSFCell cell = row.getCell(j);
            	 String message = validationChk(cell, colValidition1[j]);
            	 if(!message.equals("")){
            	 errorMessage += colArr1[j] + "[" + message + "]/";
            	 }
             }
             
        	 if(!errorMessage.equals("")){
        		 errorVO.put("errorRow", i+1);
        		 errorVO.put("errorMessage", errorMessage);
        		 errorList1.add(errorVO);
        	 }
             
         }
         
         //두번째 시트 불러오기
         sheet = workbook.getSheetAt(1);
         
         for(int i=5; i<sheet.getLastRowNum() + 1; i++) {
        	 
             XSSFRow row = sheet.getRow(i);
             
             // 행이 존재하기 않으면 패스
             if(null == row) {
                 continue;
             }
             
             Map<String, Object> errorVO = new HashMap<String, Object>();
             
             String errorMessage = "";
             for(int j=0; j<colArr2.length; j++){
            	 XSSFCell cell = row.getCell(j);
            	 String message = validationChk(cell, colValidition2[j]);
            	 if(!message.equals("")){
            		 errorMessage += colArr2[j] + "[" + message + "]/";
            	 }
            	 
             }
             
             if(!errorMessage.equals("")){
        		 errorVO.put("errorRow", i+1);
        		 errorVO.put("errorMessage", errorMessage);
        		 errorList2.add(errorVO);
        	 }
             
         }
         
         model.addAttribute("errorList1",errorList1);
         model.addAttribute("errorList2",errorList2);
         model.addAttribute("result","1");
        
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			if(workbook != null){
				workbook.close();
			}
		}
        
		return "jsonView";
	 
	}
	
	
	@RequestMapping(value="/research/excellSave.json")
	public String excellSave(
			  @RequestParam Map<String, Object> paramMap
			, HttpServletResponse response
			, MultipartHttpServletRequest request
			, ModelMap model) throws Exception{
		
		/*HttpSession httpSession = request.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}*/
		
		
		
		MultipartFile file = request.getFile("excellFile");
		
		if(file == null || file.getOriginalFilename().equals("") ){
			//파일없음
			model.addAttribute("result","4");
			return "jsonView";
		}
		
		OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
         XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
        try {
         String[] colArr1 = {
	   			  "nongId","agCode","sidoCode","sidoName","sigunName","name","gen","tel","phone","email"
	   		    , "nongaddr","nongaddr2","fYear","fMonth","gubn","fName","temp1","temp2","temp3","temp4"
		   		, "temp5","temp6","temp7","temp8","temp9","temp10","f1Py","f2Py","f3Py","f4Py"
		   		, "f5Py","fPy","ff1Py","ff2Py","ff3Py","ff4Py","ff5Py","ffPy","b1r1c1","b1r1c2"
		   		, "b1r1c3","b1r1c4","b1r1c5","b1r2c1","b1r2c2","b1r2c3","b1r2c4","b1r2c5","b2r1c1","b2r1c2"
		   		, "b2r1c3","b2r1c4","b2r1c5","b2r1c6","b2r1c7","b2r2c1","b2r2c2","b2r2c3","b2r2c4","b2r2c5"
		   		, "b2r2c6","b2r2c7","b2r3c1","b2r3c2","b2r3c3","b2r3c4","b2r3c5","b2r3c6","b2r3c7","b3c01"
		   		, "b3c02","b3c03","b3c04","b3c05","b3c06","b3c06e","b3c07","b3c08","b3c09","b3c10"
		   		, "b3c11","b3c11e","b4","b4c01","b4c02","b4c03","b4c04","b4c05","b4c06","b4c07"
		   		, "b4c08","b4c09","b4c10","b4c10e","b4c091","b4c092","b4c093","b4c094","b4c095","b4c096"
		   		, "b4c09e","b5","b5c01","b5c02","b5c03","b5c04","b5c05","b5c06","b5c07","b5c08"
		   		, "b5c08e","b5c09","b5c10","b5c11","b5c12","b5c13","b5c14","b5c15","b5c16","b5c16e"
		   		, "b5c071","b5c072","b5c073","b5c074","b5c07e","b5c151","b5c152","b5c153","b5c154","b5c155"
		   		, "b5c15e","c101","c102","c103","c104","c105","c106","c107","c108","c109"
		   		, "c201","c202","c203","c204","c205","c206","c207","c208","c209"
            };
         
         String[] colValidition1 = {
        		 "nullNumberChk","nullChk","nullNumberChk","nullChk","nullChk","","numberChk","","",""
		   		, "","","numberChk","numberChk","numberChk","","","","",""
 		   		, "","","","","","","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   	    , "numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk",""
 		   		, "numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk"
 		   		, "","","","","","","","","",""
 		   		, "","","","","","","","",""
         };
         
         
         String[] colArr2 = {
        		 "nongId","gu","fid","flower","d1c2","d1c3","d1c4","d1c5","d1c6","d1c7"
        		 ,"e1s01","e1s02","e1s03","e1s04","e1s05","e1s06","e1s07","e1s08","e1s09","e1s10"
        		 ,"e1s11","e1s12","e2s01","e2s02","e2s03","e2s04","e2s05","e2s06","e2s07","e2s08"
        		 ,"e2s09","e2s10","e2s11","e2s11e","f1","fnowa01s1","fnowa02s1","fnowa03s1","fnowa04s1","fnowa05s1"
        		 ,"fnowa06s1","fnowa07s1","fnowa08s1","fnowa09s1","fnowa10s1","fnowa11s1","fnowa12s1","fnowa01s2","fnowa02s2","fnowa03s2"
        		 ,"fnowa04s2","fnowa05s2","fnowa06s2","fnowa07s2","fnowa08s2","fnowa09s2","fnowa10s2","fnowa11s2","fnowa12s2","fnexta01s1"
        		 ,"fnexta02s1","fnexta03s1","fnexta04s1","fnexta05s1","fnexta06s1","fnexta07s1","fnexta08s1","fnexta09s1","fnexta10s1","fnexta11s1"
        		 ,"fnexta12s1","fnexta01s2","fnexta02s2","fnexta03s2","fnexta04s2","fnexta05s2","fnexta06s2","fnexta07s2","fnexta08s2","fnexta09s2"
        		 ,"fnexta10s2","fnexta11s2","fnexta12s2","ffnowa01","ffnowa02","ffnowa03","ffnowa04","ffnowa05","ffnowa06","ffnowa07"
        		 ,"ffnowa08","ffnowa09","ffnowa10","ffnowa11","ffnowa12","ffnexta01","ffnexta02","ffnexta03","ffnexta04","ffnexta05"
        		 ,"ffnexta06","ffnexta07","ffnexta08","ffnexta09","ffnexta10","ffnexta11","ffnexta12"
	            };

		String[] colValidition2 = {
			  "nullNumberChk","nullNumberChk","nullNumberChk","nullChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","nullChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
       		,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
		};
         
/*
         List<Map<String,Object>> insertList1 = new ArrayList<Map<String,Object>>();
         List<Map<String,Object>> insertList2 = new ArrayList<Map<String,Object>>();
  */       
         // 첫번째 시트 불러오기
         XSSFSheet sheet = workbook.getSheetAt(0);
         
         researchService.deleteReserchData(paramMap);
         
         int data1Cnt = 0;
         int data2Cnt = 0;
         
         for(int i=7; i<sheet.getLastRowNum() + 1; i++) {
        	 
             XSSFRow row = sheet.getRow(i);
             
             // 행이 존재하기 않으면 패스
             if(null == row) {
                 continue;
             }
             
             Map<String, Object> insertVO = new HashMap<String, Object>();
             
             insertVO.put("stdYear", paramMap.get("stdYear"));
             for(int j=0; j<colArr1.length; j++){
            	 XSSFCell cell = row.getCell(j);
            	 Map<String, Object> result = valueChk(cell, colValidition1[j]);
            	 insertVO.put(colArr1[j], result.get("data"));
             }
             int result = researchService.insertReserchData1Each(insertVO);
    		 //insertList1.add(insertVO);
             data1Cnt = data1Cnt + result;
         }
         
         
         
         //두번째 시트 불러오기
         sheet = workbook.getSheetAt(1);
         
         for(int i=5; i<sheet.getLastRowNum() + 1; i++) {
        	 
             XSSFRow row = sheet.getRow(i);
             
             // 행이 존재하기 않으면 패스
             if(null == row) {
                 continue;
             }
             
             Map<String, Object> insertVO = new HashMap<String, Object>();
             
             insertVO.put("stdYear", paramMap.get("stdYear"));
             for(int j=0; j<colArr2.length; j++){
            	 XSSFCell cell = row.getCell(j);
            	 Map<String, Object> result = valueChk(cell, colValidition2[j]);
            	 insertVO.put(colArr2[j], result.get("data"));
             }
             
             int result = researchService.insertReserchData2Each(insertVO);
    		 //insertList2.add(insertVO);
             data2Cnt = data2Cnt + result;
         }
         
         	
         	//paramMap.put("insertList1", insertList1);
         	//int result1 = researchService.insertReserchData1(insertList1);
         	
         	 model.addAttribute("data1Cnt",data1Cnt);
         	 model.addAttribute("data2Cnt",data2Cnt);
         	
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			if(workbook != null){
				workbook.close();
			}
		}
        
		return "jsonView";
	 
	}
	
	
	// 전국절화 농가현황
	@RequestMapping(value="/research/chulInfo.do")
	public String chulInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> paramMap, ModelMap model){			  			  				
		
		/*HttpSession httpSession = pRequest.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}
		*/
	    List<EgovMap> sidoList = researchService.sidoList(paramMap);
		model.addAttribute("sidoList",sidoList);
		model.addAttribute("paramMap",paramMap);
		
		 
		return "/research/chulInfo";
	}
	
	
	@RequestMapping(value="/reseach/chulInfoInit.json")
	public String chulInfoInit(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.chulInfoMapSidoList(paramMap);
			
			model.addAttribute("chulInfoMapSidoList",resultList);
			
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
	
	@RequestMapping(value="/reseach/chulInfoInit2.json")
	public String chulInfoInit2(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.chulInfoMapSidoList2(paramMap);
			
			model.addAttribute("chulInfoMapSidoList2",resultList);
			
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
	
	@RequestMapping(value="/reseach/sigunCode.json")
	public String sigunCode(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.sigunList(paramMap);
			
			model.addAttribute("sigunList",resultList);
			
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
	
	
	@RequestMapping(value="/reseach/chulInfo.json")
	public String chulInfoAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
		try{
		
			List<EgovMap> resultList = researchService.chulInfoList(paramMap);
			
			model.addAttribute("chulInfoList",resultList);
			
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

	@RequestMapping(value="/reseach/chulInfo2.json")
	public String chulInfo2Ajax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
		try{
		
			List<EgovMap> resultList = researchService.chulInfoList2(paramMap);
			
			model.addAttribute("chulInfoList2",resultList);
			
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
	
	@RequestMapping(value="/reseach/chulInfoEach.json")
	public String chulInfoEachAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			EgovMap resultVO = researchService.chulInfoEachVO(paramMap);
			
			List<EgovMap> resultList = researchService.chulInfoEachList(paramMap);
			
			model.addAttribute("chulInfoVO",resultVO);
			model.addAttribute("chulInfoList",resultList);
			
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
	
	@RequestMapping(value="/reseach/chulInfoEach2.json")
	public String chulInfoEach2Ajax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			EgovMap resultVO = researchService.chulInfoEachVO2(paramMap);
			
			List<EgovMap> resultList = researchService.chulInfoEachList2(paramMap);
			
			model.addAttribute("chulInfoVO",resultVO);
			model.addAttribute("chulInfoList",resultList);
			
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
	
	@RequestMapping(value="/reseach/chulInfoChart.json")
	public String chulInfoChartAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultVO = researchService.chulInfoChart(paramMap);
			model.addAttribute("chulInfoChartVO",resultVO);
			
			
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
	
	@RequestMapping(value="/reseach/chulInfoChart2.json")
	public String chulInfoChart2Ajax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultVO = researchService.chulInfoChart2(paramMap);
			model.addAttribute("chulInfoChartVO",resultVO);
			
			
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
	
	// 재배현황
	@RequestMapping(value="/research/prodInfo.do")
	public String prodInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> paramMap, ModelMap model){			  			  				
		
		/*HttpSession httpSession = pRequest.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}*/
		
	    List<EgovMap> sidoList = researchService.sidoList(paramMap);
		model.addAttribute("sidoList",sidoList);
		model.addAttribute("paramMap",paramMap);
		
		 
		return "/research/prodInfo";
	}
	
	
	@RequestMapping(value="/reseach/pumMokList.json")
	public String pumMokListAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.pumMokList(paramMap);
			model.addAttribute("resultList",resultList);
			
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
	
	@RequestMapping(value="/reseach/pumMokList.json2")
	public String pumMokListAjax2(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.pumMokList2(paramMap);
			model.addAttribute("resultList",resultList);
			
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
	
	@RequestMapping(value="/reseach/pumMokList2.json")
	public String pumMokList2Ajax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> resultList = researchService.pumMokList2(paramMap);
			model.addAttribute("resultList",resultList);
			
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
	
	@RequestMapping(value="/reseach/prodInfoChart.json")
	public String prodInfoChartAjax(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> prodList = researchService.prodInfoChart(paramMap);
			List<EgovMap> prodAreaList = researchService.prodInfoChartArea(paramMap);
			
			model.addAttribute("prodList",prodList);
			model.addAttribute("prodAreaList",prodAreaList);
			
			
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
	
	@RequestMapping(value="/reseach/prodInfoChart2.json")
	public String prodInfoChartAjax2(HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> prodList = researchService.prodInfoChart2(paramMap);
			List<EgovMap> prodAreaList = researchService.prodInfoChartArea2(paramMap);
			
			model.addAttribute("prodList",prodList);
			model.addAttribute("prodAreaList",prodAreaList);
			
			
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
	
	public String validationChk(XSSFCell cell, String type){
		Map<String, Object> result = new HashMap<String, Object>();
		
		String message = "";
		
		if(type.equals("nullChk")){
			try {
			    String stringVal = cell.getStringCellValue();
			    if(stringVal.equals("")){
			    	message = "필수입력 값입니다.";
			    }
			} catch (Exception e) {
				message = "필수입력 값입니다.";
			}
			
		}else if(type.equals("numberChk")){
			if(cell == null){
				return message;
			}
			try {
				int	numberVal = (int)cell.getNumericCellValue();
			} catch (Exception e) {
				String stringVal = cell.getStringCellValue();
				if(!stringVal.equals("")){
					message = "숫자형식이 아닙니다.";
				}
			}
			
		}else if(type.equals("nullNumberChk")){
			try {
				int	numberVal = (int)cell.getNumericCellValue();
			} catch (Exception e) {
				message = "숫자형식이 아닙니다.";
			}
		}
		
		return message;
	}
	
	
	public Map<String, Object> valueChk(XSSFCell cell, String type){
		Map<String, Object> result = new HashMap<String, Object>();
		
		if(type.equals("nullChk")){
			try {
			    String stringVal = cell.getStringCellValue();
			    result.put("data", stringVal);
			} catch (Exception e) {
				result.put("data", "");
			}
			
		}else if(type.equals("numberChk")){
			
			try {
				int	numberVal = (int)cell.getNumericCellValue();
				result.put("data", numberVal);
			} catch (Exception e) {
				result.put("data", 0);
			}
			
		}else if(type.equals("nullNumberChk")){
			try {
				int	numberVal = (int)cell.getNumericCellValue();
				result.put("data", numberVal);
			} catch (Exception e) {
				result.put("data", 0);
			}
		}else{
			try {
			    String stringVal = cell.getStringCellValue();
			    result.put("data", stringVal);
			} catch (Exception e) {
				result.put("data", "");
			}
		}
		
		return result;
	}
	
	// 종류 콤보 조회
	@RequestMapping(value="/reseach/searchCombo.json")
	public String searchCombo(
			HttpServletRequest pRequest
			, HttpServletResponse pResponse
			, HttpSession  httpSession
			, @RequestParam Map<String, Object> paramMap
			, ModelMap model){		 						
	  	
		/*String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "jsonView";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "jsonView";
		}*/
		
		try{
		
			List<EgovMap> list = researchService.searchCombo(paramMap); 
						
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
	
	// 난 데이터 검증
	@RequestMapping(value="/research/excellValidation2.json")
	public String excellValidation2(
			  @RequestParam Map<String, Object> paramMap
			, HttpServletResponse response
			, MultipartHttpServletRequest request
			, ModelMap model) throws Exception{
		
		/*HttpSession httpSession = request.getSession();
		String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
			return "redirect:/maa01/maa01.do";
		}*/
		
		MultipartFile file = request.getFile("excellFile");
		
		if(file == null || file.getOriginalFilename().equals("") ){
			//파일없음
			model.addAttribute("result","4");
			return "jsonView";
		}
		
		OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
         XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
        try {
         // 한글 항목
         String[] colArr3 = {
        		 "농경체ID","리스트ID","농가주성명","난재배여부","농가주성별","최초재배_년","최초재배_월","시도","자택소재지","재배목적"
        		 ,"기준년_재배여부_혜란류_무늬종_일양금등","기준년_재배여부_철골류_철골소심등","기준년_재배여부_채홍류_황금채홍등","기준년_재배여부_옥화류","기준년_재배여부_보세류_대명란_금릉변등","기준년_재배여부_건란류_건란_소란_소림란등","기준년_재배여부_동양심비류","기준년_재배여부_풍란류_소엽풍란_나도풍란등","기준년_재배여부_기타동양란","기준년_재배여부_기타동양란"
        		 ,"기준년_재배여부_한국춘란","기준년_재배여부_민춘란","기준년_재배여부_새우난","기준년_재배여부_중국춘란","기준년_재배여부_기타자생란","기준년_재배여부_기타자생란","기준년_재배여부_카틀레야","기준년_재배여부_심비디움","기준년_재배여부_파피오페딜럼","기준년_재배여부_깅기아남"
        		 ,"기준년_재배여부_석곡","기준년_재배여부_덴드로비움","기준년_재배여부_온시디움","기준년_재배여부_반다","기준년_재배여부_팔레놉시스_호접란","기준년_재배여부_덴파레","기준년_재배여부_밀토니아","기준년_재배여부_막실라리아","기준년_재배여부_기타서양란","기준년_재배여부_기타서양란"
        		 ,"다음년_재배여부_혜란류_무늬종_일양금등","다음년_재배여부_철골류_철골소심등","다음년_재배여부_채홍류_황금채홍등","다음년_재배여부_옥화류","다음년_재배여부_보세류_대명란_금릉변등","다음년_재배여부_건란류_건란_소란_소림란등","다음년_재배여부_동양심비류","다음년_재배여부_풍란류_소엽풍란_나도풍란등","다음년_재배여부_기타동양란","다음년_재배여부_기타동양란"
        		 ,"다음년_재배여부_한국춘란","다음년_재배여부_민춘란","다음년_재배여부_새우난","다음년_재배여부_중국춘란","다음년_재배여부_기타자생란","다음년_재배여부_기타자생란","다음년_재배여부_카틀레야","다음년_재배여부_심비디움","다음년_재배여부_파피오페딜럼","다음년_재배여부_깅기아남"
        		 ,"다음년_재배여부_석곡","다음년_재배여부_덴드로비움","다음년_재배여부_온시디움","다음년_재배여부_반다","다음년_재배여부_팔레놉시스_호접란","다음년_재배여부_덴파레","다음년_재배여부_밀토니아","다음년_재배여부_막실라리아","다음년_재배여부_기타서양란","다음년_재배여부_기타서양란"
        		 ,"입식방법_1","입식방법_2","입식방법_3","입식방법_4","입식방법_기타","종묘형태_1","종묘형태_2","종묘형태_3","직접수입국가","수입업체국가"
        		 ,"종묘구입처_1","종묘구입처_2","종묘구입처_3","종묘구입처_4","종묘구입처_기타","국내산_%","수입산_%","자체번식방법_1","자체번식방법_2","자체번식방법_3"
        		 ,"자체번식방법_4","출하구분","A_출하품종","A_판매수량","A_판매액_단가","A_판매액_총액","A_출하유형_1","A_출하유형_2","A_출하유형_3","A_출하유형_4"
        		 ,"A_출하실적확인서","B_출하품종","B_판매수량","B_판매액_단가","B_판매액_총액","B_출하유형_1","B_출하유형_2","B_출하유형_3","B_출하유형_4","B_출하실적확인서"
        		 ,"C_출하품종","C_판매수량","C_판매액_단가","C_판매액_총액","C_출하유형_1","C_출하유형_2","C_출하유형_3","C_출하유형_4","C_출하실적확인서","D_출하품종"
        		 ,"D_판매수량","D_판매액_단가","D_판매액_총액","D_출하유형_1","D_출하유형_2","D_출하유형_3","D_출하유형_4","D_출하실적확인서","E_출하품종","E_판매수량"
        		 ,"E_판매액_단가","E_판매액_총액","E_출하유형_1","E_출하유형_2","E_출하유형_3","E_출하유형_4","E_출하실적확인서","F_출하품종","F_판매수량","F_판매액_단가"
        		 ,"F_판매액_총액","F_출하유형_1","F_출하유형_2","F_출하유형_3","F_출하유형_4","F_출하실적확인서","G_출하품종","G_판매수량","G_판매액_단가","G_판매액_총액"
        		 ,"G_출하유형_1","G_출하유형_2","G_출하유형_3","G_출하유형_4","G_출하실적확인서","A_출하월_출하품종","A_출하월_1월","A_출하월_2월","A_출하월_3월","A_출하월_4월"
        		 ,"A_출하월_5월","A_출하월_6월","A_출하월_7월","A_출하월_8월","A_출하월_9월","A_출하월_10월","A_출하월_11월","A_출하월_12월","B_출하월_출하품종","B_출하월_1월"
        		 ,"B_출하월_2월","B_출하월_3월","B_출하월_4월","B_출하월_5월","B_출하월_6월","B_출하월_7월","B_출하월_8월","B_출하월_9월","B_출하월_10월","B_출하월_11월"
        		 ,"B_출하월_12월","C_출하월_출하품종","C_출하월_1월","C_출하월_2월","C_출하월_3월","C_출하월_4월","C_출하월_5월","C_출하월_6월","C_출하월_7월","C_출하월_8월"
        		 ,"C_출하월_9월","C_출하월_10월","C_출하월_11월","C_출하월_12월","D_출하월_출하품종","D_출하월_1월","D_출하월_2월","D_출하월_3월","D_출하월_4월","D_출하월_5월"
        		 ,"D_출하월_6월","D_출하월_7월","D_출하월_8월","D_출하월_9월","D_출하월_10월","D_출하월_11월","D_출하월_12월","E_출하월_출하품종","E_출하월_1월","E_출하월_2월"
        		 ,"E_출하월_3월","E_출하월_4월","E_출하월_5월","E_출하월_6월","E_출하월_7월","E_출하월_8월","E_출하월_9월","E_출하월_10월","E_출하월_11월","E_출하월_12월","F_출하월_출하품종"
        		 ,"F_출하월_1월","F_출하월_2월","F_출하월_3월","F_출하월_4월","F_출하월_5월","F_출하월_6월","F_출하월_7월","F_출하월_8월","F_출하월_9월","F_출하월_10월"
        		 ,"F_출하월_11월","F_출하월_12월","G_출하월_출하품종","G_출하월_1월","G_출하월_2월","G_출하월_3월","G_출하월_4월","G_출하월_5월","G_출하월_6월","G_출하월_7월"
        		 ,"G_출하월_8월","G_출하월_9월","G_출하월_10월","G_출하월_11월","G_출하월_12월","A_출하처_출하품종","A_출하처_양재","A_출하처_엄궁","A_출하처_영남","A_출하처_부경"
        		 ,"A_출하처_광주","A_출하처_음성","A_출하처_고양","A_출하처_유사도매","A_출하처_직거래","A_출하처_전문판매장","A_출하처_전시회판매","A_출하처_수출","B_출하처_출하품종","B_출하처_양재"
        		 ,"B_출하처_엄궁","B_출하처_영남","B_출하처_부경","B_출하처_광주","B_출하처_음성","B_출하처_고양","B_출하처_유사도매","B_출하처_직거래","B_출하처_전문판매장","B_출하처_전시회판매"
        		 ,"B_출하처_수출","C_출하처_출하품종","C_출하처_양재","C_출하처_엄궁","C_출하처_영남","C_출하처_부경","C_출하처_광주","C_출하처_음성","C_출하처_고양","C_출하처_유사도매"
        		 ,"C_출하처_직거래","C_출하처_전문판매장","C_출하처_전시회판매","C_출하처_수출","D_출하처_출하품종","D_출하처_양재","D_출하처_엄궁","D_출하처_영남","D_출하처_부경","D_출하처_광주"
        		 ,"D_출하처_음성","D_출하처_고양","D_출하처_유사도매","D_출하처_직거래","D_출하처_전문판매장","D_출하처_전시회판매","D_출하처_수출","E_출하처_출하품종","E_출하처_양재","E_출하처_엄궁"
        		 ,"E_출하처_영남","E_출하처_부경","E_출하처_광주","E_출하처_음성","E_출하처_고양","E_출하처_유사도매","E_출하처_직거래","E_출하처_전문판매장","E_출하처_전시회판매","E_출하처_수출"
        		 ,"F_출하처_출하품종","F_출하처_양재","F_출하처_엄궁","F_출하처_영남","F_출하처_부경","F_출하처_광주","F_출하처_음성","F_출하처_고양","F_출하처_유사도매","F_출하처_직거래"
        		 ,"F_출하처_전문판매장","F_출하처_전시회판매","F_출하처_수출","G_출하처_출하품종","G_출하처_양재","G_출하처_엄궁","G_출하처_영남","G_출하처_부경","G_출하처_광주","G_출하처_음성"
        		 ,"G_출하처_고양","G_출하처_유사도매","G_출하처_직거래","G_출하처_전문판매장","G_출하처_전시회판매","G_출하처_수출","유사도매시장","최근출하시기_년","최근출하시기_월","출하품목"
        		 ,"최근출하방식","출하주기","출하주기_횟수","주요출하처_1순위","주요출하처_2순위","유사도매시장","시설구분_1","시설구분_2","시설구분_3","시설구분_4","시설구분_기타"
        		 ,"A_농장소재지_농장소재지","A_농장면적_농장면적","A_재배면적_재배면적","B_농장소재지_농장소재지","B_농장면적_농장면적","B_재배면적_재배면적","C_농장소재지_농장소재지","C_농장면적_농장면적","C_재배면적_재배면적","D_농장소재지_농장소재지"
        		 ,"D_농장면적_농장면적","D_재배면적_재배면적","E_농장소재지_농장소재지","E_농장면적_농장면적","E_재배면적_재배면적","F_농장소재지_농장소재지","F_농장면적_농장면적","F_재배면적_재배면적","G_농장소재지_농장소재지","G_농장면적_농장면적"
        		 ,"G_재배면적_재배면적","재배장_농지시설면적_ha","재배장_농지노지면적_ha","재배장_비농지시설면적_ha","재배장_비농지노지면적_ha","재배장_기타면적_ha","실험실_농지시설면적_ha","실험실_비농지시설면적_ha","실험실_기타면적_ha","순화실_농지시설면적_ha"
        		 ,"순화실_비농지시설면적_ha","순화실_기타면적_ha","시설유형_1","시설유형_2","시설유형_3","시설유형_기타","냉방여부","냉방면적_ha","냉방연료_1","냉방연료_2"
        		 ,"냉방연료_3","냉방연료_4","냉방연료_5","냉방연료_6","냉방연료_기타","냉방방법_1","냉방방법_2","냉방방법_3","냉방방법_4","냉방방법_기타"
        		 ,"가온여부","가온면적_ha","가온연료_1","가온연료_2","가온연료_3","가온연료_4","가온연료_5","가온연료_6","가온연료_기타","보온여부"
        		 ,"보온면적_ha","보온방법_1","보온방법_2","보온방법_3","보온방법_4","보온방법_5","보온방법_6","기준년도_재배안함","다음년도_재배안함","A_기준년_재배면적_출하품종"
        		 ,"A_기준년_재배면적_농지시설","A_기준년_재배면적_농지노지","A_기준년_재배면적_비농지시설","A_기준년_재배면적_비농지노지","A_기준년_재배면적_기타","B_기준년_재배면적_출하품종","B_기준년_재배면적_농지시설","B_기준년_재배면적_농지노지","B_기준년_재배면적_비농지시설","B_기준년_재배면적_비농지노지"
        		 ,"B_기준년_재배면적_기타","C_기준년_재배면적_출하품종","C_기준년_재배면적_농지시설","C_기준년_재배면적_농지노지","C_기준년_재배면적_비농지시설","C_기준년_재배면적_비농지노지","C_기준년_재배면적_기타","D_기준년_재배면적_출하품종","D_기준년_재배면적_농지시설","D_기준년_재배면적_농지노지"
        		 ,"D_기준년_재배면적_비농지시설","D_기준년_재배면적_비농지노지","D_기준년_재배면적_기타","E_기준년_재배면적_출하품종","E_기준년_재배면적_농지시설","E_기준년_재배면적_농지노지","E_기준년_재배면적_비농지시설","E_기준년_재배면적_비농지노지","E_기준년_재배면적_기타","F_기준년_재배면적_출하품종"
        		 ,"F_기준년_재배면적_농지시설","F_기준년_재배면적_농지노지","F_기준년_재배면적_비농지시설","F_기준년_재배면적_비농지노지","F_기준년_재배면적_기타","G_기준년_재배면적_출하품종","G_기준년_재배면적_농지시설","G_기준년_재배면적_농지노지","G_기준년_재배면적_비농지시설","G_기준년_재배면적_비농지노지"
        		 ,"G_기준년_재배면적_기타","H_기준년_재배면적_출하품종","H_기준년_재배면적_농지시설","H_기준년_재배면적_농지노지","H_기준년_재배면적_비농지시설","H_기준년_재배면적_비농지노지","H_기준년_재배면적_기타","I_기준년_재배면적_출하품종","I_기준년_재배면적_농지시설","I_기준년_재배면적_농지노지"
        		 ,"I_기준년_재배면적_비농지시설","I_기준년_재배면적_비농지노지","I_기준년_재배면적_기타","J_기준년_재배면적_출하품종","J_기준년_재배면적_농지시설","J_기준년_재배면적_농지노지","J_기준년_재배면적_비농지시설","J_기준년_재배면적_비농지노지","J_기준년_재배면적_기타","K_기준년_재배면적_출하품종"
        		 ,"K_기준년_재배면적_농지시설","K_기준년_재배면적_농지노지","K_기준년_재배면적_비농지시설","K_기준년_재배면적_비농지노지","K_기준년_재배면적_기타","L_기준년_재배면적_출하품종","L_기준년_재배면적_농지시설","L_기준년_재배면적_농지노지","L_기준년_재배면적_비농지시설","L_기준년_재배면적_비농지노지"
        		 ,"L_기준년_재배면적_기타","A_다음년_재배면적_출하품종","A_다음년_재배면적_농지시설","A_다음년_재배면적_농지노지","A_다음년_재배면적_비농지시설","A_다음년_재배면적_비농지노지","A_다음년_재배면적_기타","B_다음년_재배면적_출하품종","B_다음년_재배면적_농지시설","B_다음년_재배면적_농지노지"
        		 ,"B_다음년_재배면적_비농지시설","B_다음년_재배면적_비농지노지","B_다음년_재배면적_기타","C_다음년_재배면적_출하품종","C_다음년_재배면적_농지시설","C_다음년_재배면적_농지노지","C_다음년_재배면적_비농지시설","C_다음년_재배면적_비농지노지","C_다음년_재배면적_기타","D_다음년_재배면적_출하품종"
        		 ,"D_다음년_재배면적_농지시설","D_다음년_재배면적_농지노지","D_다음년_재배면적_비농지시설","D_다음년_재배면적_비농지노지","D_다음년_재배면적_기타","E_다음년_재배면적_출하품종","E_다음년_재배면적_농지시설","E_다음년_재배면적_농지노지","E_다음년_재배면적_비농지시설","E_다음년_재배면적_비농지노지"
        		 ,"E_다음년_재배면적_기타","F_다음년_재배면적_출하품종","F_다음년_재배면적_농지시설","F_다음년_재배면적_농지노지","F_다음년_재배면적_비농지시설","F_다음년_재배면적_비농지노지","F_다음년_재배면적_기타","G_다음년_재배면적_출하품종","G_다음년_재배면적_농지시설","G_다음년_재배면적_농지노지"
        		 ,"G_다음년_재배면적_비농지시설","G_다음년_재배면적_비농지노지","G_다음년_재배면적_기타","H_다음년_재배면적_출하품종","H_다음년_재배면적_농지시설","H_다음년_재배면적_농지노지","H_다음년_재배면적_비농지시설","H_다음년_재배면적_비농지노지","H_다음년_재배면적_기타","I_다음년_재배면적_출하품종"
        		 ,"I_다음년_재배면적_농지시설","I_다음년_재배면적_농지노지","I_다음년_재배면적_비농지시설","I_다음년_재배면적_비농지노지","I_다음년_재배면적_기타","J_다음년_재배면적_출하품종","J_다음년_재배면적_농지시설","J_다음년_재배면적_농지노지","J_다음년_재배면적_비농지시설","J_다음년_재배면적_비농지노지"
        		 ,"J_다음년_재배면적_기타","K_다음년_재배면적_출하품종","K_다음년_재배면적_농지시설","K_다음년_재배면적_농지노지","K_다음년_재배면적_비농지시설","K_다음년_재배면적_비농지노지","K_다음년_재배면적_기타","L_다음년_재배면적_출하품종","L_다음년_재배면적_농지시설","L_다음년_재배면적_농지노지"
        		 ,"L_다음년_재배면적_비농지시설","L_다음년_재배면적_비농지노지","L_다음년_재배면적_기타","영농종류","재배경력","재배품목","지역","재배면적_ha","알메이트지역코드"
        		            };
         // 한글 항목 체크 타입
         String[] colValidition3 = {
        		 "","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
        		 ,"","","","","","","","","","","","","","","","","","","",""
        		 ,"",""
         };
         
         List<Map<String,Object>> errorList3 = new ArrayList<Map<String,Object>>();
         
         // 첫번째 시트 불러오기
         XSSFSheet sheet = workbook.getSheetAt(0);
         
         // 헤더 2row 이후 데이터 검증
         for(int i=2; i<sheet.getLastRowNum() + 1; i++) {
        	 
             XSSFRow row = sheet.getRow(i);

             // 행이 존재하기 않으면 패스
             if(null == row) {
                 continue;
             }
             
             Map<String, Object> errorVO = new HashMap<String, Object>();
             
             String errorMessage = "";
             
             for(int j=0; j<colArr3.length; j++){
            	 XSSFCell cell = row.getCell(j);

            	 String message = validationChk(cell, colValidition3[j]);
            	 if(!message.equals("")){
            	 errorMessage += colArr3[j] + "[" + message + "]/";
            	 }
             }
             
        	 if(!errorMessage.equals("")){
        		 errorVO.put("errorRow", i+1);
        		 errorVO.put("errorMessage", errorMessage);
        		 errorList3.add(errorVO);
        	 }             
         }
         
         model.addAttribute("errorList3",errorList3);
         model.addAttribute("result","1");
        
		}catch(Exception e){
			e.printStackTrace();
			
		}finally{
			if(workbook != null){
				workbook.close();
			}
		}
        
		return "jsonView";	 
	}
	
	// 난 데이터 저장
		@RequestMapping(value="/research/excellSave2.json")
		public String excellSave2(
				  @RequestParam Map<String, Object> paramMap
				, HttpServletResponse response
				, MultipartHttpServletRequest request
				, ModelMap model) throws Exception{
			
			/*HttpSession httpSession = request.getSession();
			String sessionCmpCode = (String)httpSession.getAttribute("SESSION_CMP_CODE");
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "redirect:/mnt/mem01/mem01Form.do";
			}else if(sessionCmpCode == null || !sessionCmpCode.equals("nresearch")){
				return "redirect:/maa01/maa01.do";
			}*/
			
			MultipartFile file = request.getFile("excellFile");
			
			if(file == null || file.getOriginalFilename().equals("") ){
				//파일없음
				model.addAttribute("result","4");
				return "jsonView";
			}
			
			OPCPackage opcPackage = OPCPackage.open(file.getInputStream());
	         XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
	        try {
	         String[] colArr3 = {
	        		 "AID","ID","NAME","SQ1","GENDER","YY","MM","SIDO","HOUSE","TP","B1C1_1","B1C1_2","B1C1_3","B1C1_4","B1C1_5","B1C1_6","B1C1_7","B1C1_8","B1C1_9","B1C1_9T"
	        		 ,"B1C1_11","B1C1_12","B1C1_13","B1C1_14","B1C1_15","B1C1_15T","B1C1_21","B1C1_22","B1C1_23","B1C1_24","B1C1_25","B1C1_26","B1C1_27","B1C1_28","B1C1_29","B1C1_30","B1C1_31","B1C1_32","B1C1_33","B1C1_33T"
	        		 ,"B1C2_1","B1C2_2","B1C2_3","B1C2_4","B1C2_5","B1C2_6","B1C2_7","B1C2_8","B1C2_9","B1C2_9T","B1C2_11","B1C2_12","B1C2_13","B1C2_14","B1C2_15","B1C2_15T","B1C2_21","B1C2_22","B1C2_23","B1C2_24"
	        		 ,"B1C2_25","B1C2_26","B1C2_27","B1C2_28","B1C2_29","B1C2_30","B1C2_31","B1C2_32","B1C2_33","B1C2_33T","B2_1","B2_2","B2_3","B2_4","B2E","B2S1_1","B2S1_2","B2S1_3","B2S2_1T","B2S2_2T"
	        		 ,"B2S2_1","B2S2_2","B2S2_3","B2S2_4","B2S2E","B2S3C1","B2S3C2","B2S4_1","B2S4_2","B2S4_3","B2S4_4","C1","C2S1R1C0","C2S1R1C1","C2S1R1C2","C2S1R1C3","C2S1R1C4_1","C2S1R1C4_2","C2S1R1C4_3","C2S1R1C4_4"
	        		 ,"C2S1R1C5","C2S1R2C0","C2S1R2C1","C2S1R2C2","C2S1R2C3","C2S1R2C4_1","C2S1R2C4_2","C2S1R2C4_3","C2S1R2C4_4","C2S1R2C5","C2S1R3C0","C2S1R3C1","C2S1R3C2","C2S1R3C3","C2S1R3C4_1","C2S1R3C4_2","C2S1R3C4_3","C2S1R3C4_4","C2S1R3C5","C2S1R4C0"
	        		 ,"C2S1R4C1","C2S1R4C2","C2S1R4C3","C2S1R4C4_1","C2S1R4C4_2","C2S1R4C4_3","C2S1R4C4_4","C2S1R4C5","C2S1R5C0","C2S1R5C1","C2S1R5C2","C2S1R5C3","C2S1R5C4_1","C2S1R5C4_2","C2S1R5C4_3","C2S1R5C4_4","C2S1R5C5","C2S1R6C0","C2S1R6C1","C2S1R6C2"
	        		 ,"C2S1R6C3","C2S1R6C4_1","C2S1R6C4_2","C2S1R6C4_3","C2S1R6C4_4","C2S1R6C5","C2S1R7C0","C2S1R7C1","C2S1R7C2","C2S1R7C3","C2S1R7C4_1","C2S1R7C4_2","C2S1R7C4_3","C2S1R7C4_4","C2S1R7C5","C2S2R1C0","C2S2R1C1","C2S2R1C2","C2S2R1C3","C2S2R1C4"
	        		 ,"C2S2R1C5","C2S2R1C6","C2S2R1C7","C2S2R1C8","C2S2R1C9","C2S2R1C10","C2S2R1C11","C2S2R1C12","C2S2R2C0","C2S2R2C1","C2S2R2C2","C2S2R2C3","C2S2R2C4","C2S2R2C5","C2S2R2C6","C2S2R2C7","C2S2R2C8","C2S2R2C9","C2S2R2C10","C2S2R2C11"
	        		 ,"C2S2R2C12","C2S2R3C0","C2S2R3C1","C2S2R3C2","C2S2R3C3","C2S2R3C4","C2S2R3C5","C2S2R3C6","C2S2R3C7","C2S2R3C8","C2S2R3C9","C2S2R3C10","C2S2R3C11","C2S2R3C12","C2S2R4C0","C2S2R4C1","C2S2R4C2","C2S2R4C3","C2S2R4C4","C2S2R4C5"
	        		 ,"C2S2R4C6","C2S2R4C7","C2S2R4C8","C2S2R4C9","C2S2R4C10","C2S2R4C11","C2S2R4C12","C2S2R5C0","C2S2R5C1","C2S2R5C2","C2S2R5C3","C2S2R5C4","C2S2R5C5","C2S2R5C6","C2S2R5C7","C2S2R5C8","C2S2R5C9","C2S2R5C10","C2S2R5C11","C2S2R5C12"
	        		 ,"C2S2R6C0","C2S2R6C1","C2S2R6C2","C2S2R6C3","C2S2R6C4","C2S2R6C5","C2S2R6C6","C2S2R6C7","C2S2R6C8","C2S2R6C9","C2S2R6C10","C2S2R6C11","C2S2R6C12","C2S2R7C0","C2S2R7C1","C2S2R7C2","C2S2R7C3","C2S2R7C4","C2S2R7C5","C2S2R7C6"
	        		 ,"C2S2R7C7","C2S2R7C8","C2S2R7C9","C2S2R7C10","C2S2R7C11","C2S2R7C12","C2S3R1C0","C2S3R1C1","C2S3R1C2","C2S3R1C3","C2S3R1C4","C2S3R1C5","C2S3R1C6","C2S3R1C7","C2S3R1C8","C2S3R1C9","C2S3R1C10","C2S3R1C11","C2S3R1C12","C2S3R2C0"
	        		 ,"C2S3R2C1","C2S3R2C2","C2S3R2C3","C2S3R2C4","C2S3R2C5","C2S3R2C6","C2S3R2C7","C2S3R2C8","C2S3R2C9","C2S3R2C10","C2S3R2C11","C2S3R2C12","C2S3R3C0","C2S3R3C1","C2S3R3C2","C2S3R3C3","C2S3R3C4","C2S3R3C5","C2S3R3C6","C2S3R3C7"
	        		 ,"C2S3R3C8","C2S3R3C9","C2S3R3C10","C2S3R3C11","C2S3R3C12","C2S3R4C0","C2S3R4C1","C2S3R4C2","C2S3R4C3","C2S3R4C4","C2S3R4C5","C2S3R4C6","C2S3R4C7","C2S3R4C8","C2S3R4C9","C2S3R4C10","C2S3R4C11","C2S3R4C12","C2S3R5C0","C2S3R5C1"
	        		 ,"C2S3R5C2","C2S3R5C3","C2S3R5C4","C2S3R5C5","C2S3R5C6","C2S3R5C7","C2S3R5C8","C2S3R5C9","C2S3R5C10","C2S3R5C11","C2S3R5C12","C2S3R6C0","C2S3R6C1","C2S3R6C2","C2S3R6C3","C2S3R6C4","C2S3R6C5","C2S3R6C6","C2S3R6C7","C2S3R6C8"
	        		 ,"C2S3R6C9","C2S3R6C10","C2S3R6C11","C2S3R6C12","C2S3R7C0","C2S3R7C1","C2S3R7C2","C2S3R7C3","C2S3R7C4","C2S3R7C5","C2S3R7C6","C2S3R7C7","C2S3R7C8","C2S3R7C9","C2S3R7C10","C2S3R7C11","C2S3R7C12","C2S3T","C3S1C1","C3S1C2"
	        		 ,"C3S2","C3S3","C3S4","C3S4A","C3S5_R1","C3S5_R2","C3S5T","D1_1","D1_2","D1_3","D1_4","D1_4T","D2R1C1","D2R1C2","D2R1C3","D2R2C1","D2R2C2","D2R2C3","D2R3C1","D2R3C2"
	        		 ,"D2R3C3","D2R4C1","D2R4C2","D2R4C3","D2R5C1","D2R5C2","D2R5C3","D2R6C1","D2R6C2","D2R6C3","D2R7C1","D2R7C2","D2R7C3","D3R1C1","D3R1C2","D3R1C3","D3R1C4","D3R1C5","D3R2C1","D3R2C3"
	        		 ,"D3R2C5","D3R3C1","D3R3C3","D3R3C5","D3A_1","D3A_2","D3A_3","D3AE","D4","D4R1","D4R2_1","D4R2_2","D4R2_3","D4R2_4","D4R2_5","D4R2_6","D4R2_6T","D4R3_1","D4R3_2","D4R3_3"
	        		 ,"D4R3_4","D4R3_4T","D5","D5R1","D5R2_1","D5R2_2","D5R2_3","D5R2_4","D5R2_5","D5R2_6","D5R2_6T","D6","D6R1","D6R2_1","D6R2_2","D6R2_3","D6R2_4","D6R2_5","D6R2_6","D7A"
	        		 ,"D7B","D7AR1C0","D7AR1C1","D7AR1C2","D7AR1C3","D7AR1C4","D7AR1C5","D7AR2C0","D7AR2C1","D7AR2C2","D7AR2C3","D7AR2C4","D7AR2C5","D7AR3C0","D7AR3C1","D7AR3C2","D7AR3C3","D7AR3C4","D7AR3C5","D7AR4C0"
	        		 ,"D7AR4C1","D7AR4C2","D7AR4C3","D7AR4C4","D7AR4C5","D7AR5C0","D7AR5C1","D7AR5C2","D7AR5C3","D7AR5C4","D7AR5C5","D7AR6C0","D7AR6C1","D7AR6C2","D7AR6C3","D7AR6C4","D7AR6C5","D7AR7C0","D7AR7C1","D7AR7C2"
	        		 ,"D7AR7C3","D7AR7C4","D7AR7C5","D7AR8C0","D7AR8C1","D7AR8C2","D7AR8C3","D7AR8C4","D7AR8C5","D7AR9C0","D7AR9C1","D7AR9C2","D7AR9C3","D7AR9C4","D7AR9C5","D7AR10C0","D7AR10C1","D7AR10C2","D7AR10C3","D7AR10C4"
	        		 ,"D7AR10C5","D7AR11C0","D7AR11C1","D7AR11C2","D7AR11C3","D7AR11C4","D7AR11C5","D7AR12C0","D7AR12C1","D7AR12C2","D7AR12C3","D7AR12C4","D7AR12C5","D7BR1C0","D7BR1C1","D7BR1C2","D7BR1C3","D7BR1C4","D7BR1C5","D7BR2C0"
	        		 ,"D7BR2C1","D7BR2C2","D7BR2C3","D7BR2C4","D7BR2C5","D7BR3C0","D7BR3C1","D7BR3C2","D7BR3C3","D7BR3C4","D7BR3C5","D7BR4C0","D7BR4C1","D7BR4C2","D7BR4C3","D7BR4C4","D7BR4C5","D7BR5C0","D7BR5C1","D7BR5C2"
	        		 ,"D7BR5C3","D7BR5C4","D7BR5C5","D7BR6C0","D7BR6C1","D7BR6C2","D7BR6C3","D7BR6C4","D7BR6C5","D7BR7C0","D7BR7C1","D7BR7C2","D7BR7C3","D7BR7C4","D7BR7C5","D7BR8C0","D7BR8C1","D7BR8C2","D7BR8C3","D7BR8C4"
	        		 ,"D7BR8C5","D7BR9C0","D7BR9C1","D7BR9C2","D7BR9C3","D7BR9C4","D7BR9C5","D7BR10C0","D7BR10C1","D7BR10C2","D7BR10C3","D7BR10C4","D7BR10C5","D7BR11C0","D7BR11C1","D7BR11C2","D7BR11C3","D7BR11C4","D7BR11C5","D7BR12C0"
	        		 ,"D7BR12C1","D7BR12C2","D7BR12C3","D7BR12C4","D7BR12C5","DM1","DM2","DM3","DM4","DM5","DM6"
	            };
	         
	         String[] colValidition3 = {
	        		 "numberChk","numberChk" ,"","numberChk","numberChk","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","numberChk","numberChk","","","","","","","numberChk","numberChk","numberChk",""
	        		 ,"","","","","","numberChk","numberChk","numberChk","","","","","","","numberChk","numberChk","numberChk","","","","","",""
	        		 ,"numberChk","numberChk","numberChk","","","","","","","numberChk","numberChk","numberChk","","","","","","","numberChk","numberChk"
	        		 ,"numberChk","","","","","","","numberChk","numberChk","numberChk","","","","","","","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","","","",""
	        		 ,"numberChk","numberChk","","","","","","","","","","numberChk","numberChk","","numberChk","numberChk","","numberChk","numberChk",""
	        		 ,"numberChk","numberChk","","numberChk","numberChk","","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","numberChk","","","","","","numberChk",""
	        		 ,"","","","","","","","","","","","","numberChk","","","","","","","","","numberChk","","","","","","","","","","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk"
	        		 ,"numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk"
	        		 ,"numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk"
	        		 ,"","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk"
	        		 ,"numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","numberChk"
	        		 ,"numberChk","numberChk","numberChk","","numberChk","numberChk","numberChk","numberChk","numberChk","","numberChk","","","numberChk","" 
	        		 /*
	        		 "","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""
	        		 ,"","","","","","","","","","",""*/
	         };
	         
	         // 첫번째 시트 불러오기
	         XSSFSheet sheet = workbook.getSheetAt(0);
	         
	         // 데이터 초기화(DB 테이블 delete)
	         researchService.deleteReserchData2(paramMap);
	         
	         int data3Cnt = 0;
	         
	         for(int i=2; i<sheet.getLastRowNum() + 1; i++) {
	        	 
	             XSSFRow row = sheet.getRow(i);
	             
	             // 행이 존재하기 않으면 패스
	             if(null == row) {
	                 continue;
	             }
	             
	             Map<String, Object> insertVO = new HashMap<String, Object>();
	             
	             insertVO.put("stdYear", paramMap.get("stdYear"));
	             
	             for(int j=0; j<colArr3.length; j++){
	            	 XSSFCell cell = row.getCell(j);
	            	 Map<String, Object> result = valueChk(cell, colValidition3[j]);
	            	 insertVO.put(colArr3[j], result.get("data"));
	             }
	             
	             // 데이터 저장(DB 테이블 insert)
	             int result = researchService.insertReserchData3Each(insertVO);
	    		 //insertList1.add(insertVO);
	             data3Cnt = data3Cnt + result;
	         }
	         System.out.println("!@#$	data3Cnt : "+data3Cnt);
	         	 model.addAttribute("data3Cnt",data3Cnt);
	         	
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				if(workbook != null){
					workbook.close();
				}
			}
	        
			return "jsonView";
		 
		}
 
}
