package com.fpminput.mntr.dailyRptMgt.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.FileUtils;
import com.fpminput.base.util.CommonUtils;
import com.fpminput.mntr.dailyRptMgt.domain.DailyRptMgtVO;
import com.fpminput.mntr.dailyRptMgt.service.DailyRptMgtService;
import com.fpminput.mntr.dailyRptSend.domain.DailyRptSendVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class DailyRptMgtController extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	DailyRptMgtService dailyRptMgtService;
	
	@Autowired
	dailyRptSendexcel dailyRptSendExcel;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	//private static final String filePath = "D:\\work\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	// 화면 open
	@RequestMapping(value="/dailyRptMgt/dailyRptMgt.do")
	public String SelectEventSch(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/dailyRptMgt/dailyRptMgt";
	}
	
	@RequestMapping(value="/dailyRptMgt/sendEmail.do")
	public String sendEmail(HttpServletRequest pRequest, HttpServletResponse pResponse
			,@RequestParam(value="startDate") String param
			, ModelMap model){
		String startDate = param.substring(0, param.indexOf("?"));
		String idx = param.substring(param.indexOf("?idx=")+"?idx=".length());
		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("searchDate", startDate);
		
		// 전송 버튼을 누른 row에 해당하는 email 조회
		List<DailyRptMgtVO> resultList = dailyRptMgtService.searchGridList(pRequestParamMap);
		String receiveEmail = resultList.get(Integer.parseInt(idx)).getUserNm();
		int logSeq = resultList.get(Integer.parseInt(idx)).getLogSeq(); // startDate, idx로 logSeq 값 조회
		
		// 메일 재전송
		try{
		String date = startDate.replaceAll("-", "");
		Workbook dayAuc_excel = dailyRptSendExcel.get_dayAuc_excel(date);
		Workbook dayPumAuc_excel = dailyRptSendExcel.get_dayPumAuc_excel(date);
		Workbook mainFlowerAuc_excel = dailyRptSendExcel.get_mainFlowerAuc_excel(date);
		dailyRptSendExcel.mailSend(receiveEmail, dayPumAuc_excel, mainFlowerAuc_excel, dayAuc_excel);
		
		//메일 전송 성공하였을 경우, DB에서 실패 > 성공으로 변경
		
		pRequestParamMap = new HashMap<String, Object>();
		pRequestParamMap.put("logSeq", logSeq);
		pRequestParamMap.put("rsltGp", 'S');
		pRequestParamMap.put("procMsg", receiveEmail + "메일 발송 성공");
		
		dailyRptMgtService.updateGridList(pRequestParamMap);
		}
		catch(Exception e){
			System.out.println("Daily Report 재전송 실패");
		}

		return "/dailyRptMgt/dailyRptMgt";
	}
	@RequestMapping(value="/dailyRptMgt/sendTest.do")
	public void sendTest(@RequestParam Map<String, Object> pRequestParamMap){
		// 메일 재전송

		String date = pRequestParamMap.get("date").toString();
		Workbook dayAuc_excel = dailyRptSendExcel.get_dayAuc_excel(date);
		Workbook dayPumAuc_excel = dailyRptSendExcel.get_dayPumAuc_excel(date);
		Workbook mainFlowerAuc_excel = dailyRptSendExcel.get_mainFlowerAuc_excel(date);

		
		dailyRptSendExcel.mailSend(pRequestParamMap.get("receiveEmail").toString(), dayAuc_excel, dayPumAuc_excel, mainFlowerAuc_excel);
	}
	
	@RequestMapping(value="/mntr/dailyRptMgt/gridList.json")
	public String selectGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session
			,@RequestParam(value="searchNm") String searchNm
			,@RequestParam(value="searchDate") String searchDate
			, ModelMap model){		 						
  		
		Map<String, Object> pRequestParamMap = new HashMap<String, Object>();
		List<EgovMap> resultList;

		pRequestParamMap.put("searchNm", searchNm);
		pRequestParamMap.put("searchDate", searchDate);
		
		try{
			resultList = dailyRptMgtService.selectGridList(pRequestParamMap);
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
	
	@RequestMapping(value="/mntr/dailyRptMgt/gridListSeq.json")
	public String gongiGridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("========== gridListSeq ============="+pRequestParamMap.toString());
		
		try{
			List<DailyRptMgtVO> list = (List<DailyRptMgtVO>)dailyRptMgtService.selectSimilarInputSeq(pRequestParamMap);												
			
			model.addAttribute("list", list);
		} catch (ArithmeticException | NumberFormatException | ArrayIndexOutOfBoundsException | NegativeArraySizeException | NullPointerException | NoSuchMethodError | NoClassDefFoundError Ex) {
			log.error("Exception!! " + Ex.getStackTrace());
		} catch (RuntimeException runEx) {
			log.error("RuntimeException!! " + runEx.getStackTrace());
		}									
		return "jsonView";
	}
	
	@RequestMapping(value="/dailyRptMgt/gongiInput_popup.do")
	public String gongiInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		DailyRptMgtVO list = (DailyRptMgtVO)dailyRptMgtService.selectSimilarInputSeq(pRequestParamMap);												
		
		model.addAttribute("selectDailyRptMgt", list);
			
		
		return "/dailyRptMgt/gongiInput_popup";
			
	}
	
	@RequestMapping(value="/mntr/dailyRptMgt/insertGongiInput.json")
	public String insertGongiInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	

		try {
			Iterator<String> iterator =  request.getFileNames();
		 
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			 
			dailyRptMgtService.insertGongiInput(pRequestParamMap);
			
			if(iterator.hasNext()) {
				multipartFile = request.getFile(iterator.next());
				System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
					 								
				log.info("------------- file start -------------");
				log.info("name : "+multipartFile.getName());
				log.info("filename : "+multipartFile.getOriginalFilename());
				log.info("size : "+multipartFile.getSize());
				log.info("-------------- file end --------------\n");
				
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = CommonUtils.getRandomString() + originalFileExtension;
				
				file = new File(filePath + storedFileName);
				
				multipartFile.transferTo(file);
					
				String boardIdx = (String)pRequestParamMap.get("IDX");
					
				pRequestParamMap.put("CROP_IDX", boardIdx);
				pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
					
				dailyRptMgtService.insertGongiFile(pRequestParamMap);	

			}else{
				//return false;
			}	  
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
		return "jsonView";
	}
	
	@RequestMapping(value="/mntr/dailyRptMgt/updateGongiInfoInput.json")
	@ResponseBody
	public String updateGongiInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){
		 
		 //Map<String, String> sumnail = (Map<String, String>)mca01Service.selectSumNail(pRequestParamMap);
			 
		 try {
			 Iterator<String> iterator =  request.getFileNames();
			 
			 MultipartFile multipartFile = null;
			 String originalFileName = null;
			 String originalFileExtension = null;
			 String storedFileName = null;
				
			 File file = new File(filePath);
			 
			 dailyRptMgtService.updateGongiInfoInput(pRequestParamMap);
			 
			 if(iterator.hasNext()) {
				 multipartFile = request.getFile(iterator.next());
				 System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
				 System.out.println("FILE IS SIZE1  : " + pRequestParamMap.get("FILE_SIZE"));
				 
				 log.info("------------- file start -------------");
				 log.info("name : "+multipartFile.getName());
				 log.info("filename : "+multipartFile.getOriginalFilename());
				 log.info("size : "+multipartFile.getSize());
				 log.info("-------------- file end --------------\n");
					
				 originalFileName = multipartFile.getOriginalFilename();
				 originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				 storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					
				 file = new File(filePath + storedFileName);
				 multipartFile.transferTo(file);
				 //String boardIdx = (String)pRequestParamMap.get("IDX");
				 //pRequestParamMap.put("CROP_IDX", boardIdx);
				 pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
				 pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				 pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
				 
				 if(originalFileName != null && !"".equals(originalFileName)){
					 String boardIdx = (String)pRequestParamMap.get("SEQ");
					 pRequestParamMap.put("CROP_IDX", boardIdx);
					 dailyRptMgtService.insertGongiFile(pRequestParamMap);
				 }else{
					 dailyRptMgtService.updateGongiFile(pRequestParamMap); 
				 }
			 }
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
		return "jsonView";
	}
	
	@RequestMapping(value="/mntr/dailyRptMgt/deleteGongiInfoInput.json")
	public String deleteGongiInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		if(pRequestParamMap.get("item_cd")!=null){
			session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
		} 

		String gridResult = pRequestParamMap.toString();

		log.info("gridResult:++++======"+gridResult);
		log.info("gridResult:++++======"+gridResult.length());
	  
		String s2 = gridResult.replace("{","");
		String s3 = s2.replace("}","");
		String s4 = s3.replace("=","");
	  
		log.info("gridResult:++++======"+s2);
		log.info("gridResult:++++======"+s3);
		log.info("gridResult:++++======"+s4);
	 
		String[] result = s4.split("!");
	 
		log.info("result:++++======"+result.length);		 		
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		log.info("resultMap++++++++++++"+resultMap);
		String S1 ="";
		String S2 ="";
		String S3 ="";
		String S4 ="";
		String S5 ="";
		
		File file = new File(filePath);
		
		try{
			for( int x = 0; x < result.length; x++ ){
				String R1= result[x];
				String[] R2= R1.split(",");
				log.info("R2++++++++++++"+R2.length);
				
				for(int i = 0; i < R2.length;i++){
					if(i == 0){
						S1=R2[0];
					}
					if(i == 1){
						S2=R2[1];
					}
					if(i == 2){
						S3=R2[2];
					}
					if(i == 3){
						S4=R2[3];
					}
					if(i == 4){
						S5=R2[4];
					}
					pRequestParamMap.put("SEQ",S1);
					pRequestParamMap.put("TITLE",S2);	 
					pRequestParamMap.put("INS_ID",S3);	
					pRequestParamMap.put("CONTENT",S4);
					dailyRptMgtService.deleteGongiInfoInput(pRequestParamMap);
					dailyRptMgtService.deleteGongiFileInfoInput(pRequestParamMap);
					
					file = new File(filePath+S5);
					file.delete();
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
	
	 @RequestMapping("/dailyRptMgt/dailyRptMgtFileDown.json")
		public void dailyRptMgtFileDown(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, String seq) throws Exception{
			
			String userFilesPath = filePath;
			
			DailyRptMgtVO fileMap = (DailyRptMgtVO) dailyRptMgtService.selectSumNail(seq);
			String downFile = userFilesPath+fileMap.getStoredFileName();
			String orgFileName = fileMap.getOriginFileName();
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}

}
