package com.fpminput.mntr.mcb01.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
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
import com.fpdisys.dist.customInfo.domain.CustomInfoSnsVO;
import com.fpdisys.dist.customInfo.service.CustomInfoService;
import com.fpminput.base.util.CommonUtils;
import com.fpminput.mntr.mcb01.domain.Mcb01VO;
import com.fpminput.mntr.mcb01.service.Mcb01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mcb01Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	Mcb01Service mcb01Service;
	
	@Autowired
	CustomInfoService custionInfoService;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	@RequestMapping(value="/mcb01/mcb01.do")
	public String SelectMonthInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/mcb01/monthInput";
	}
	
	@RequestMapping(value="/mntr/mcb01/gridList.json")
	public String monthGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("==========gridListgridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> list  =  (List<EgovMap>)mcb01Service.selectMonthList(pRequestParamMap);												
			
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		} 									
		return "jsonView";
	}
	
	@RequestMapping(value="/mntr/mcb01/gridListSeq.json")
	public String monthGridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("========== gridListSeq ============="+pRequestParamMap.toString());
		
		try{
			List<Mcb01VO> list = (List<Mcb01VO>)mcb01Service.selectMonthInputSeq(pRequestParamMap);												
			
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
		} catch (RuntimeException e) {
			log.error("오류발생 런타임!!");
		} catch (Exception e) {
			log.error("오류발생!!");
		} 									
		return "jsonView";
	}
	
	@RequestMapping(value="/mcb01/monthInput_popup.do")
	public String monthInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		
		return "/mcb01/monthInput_popup";
			
	}
	
	@RequestMapping(value="/mntr/mcb01/insertMonthInput.json")
	public String insertMonthInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	

		try {
			Iterator<String> iterator =  request.getFileNames();
		 
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			 
			mcb01Service.insertMonthInput(pRequestParamMap);
			
			if(iterator.hasNext()) {
				multipartFile = request.getFile(iterator.next());
				System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
					 								
				log.info("------------- file start -------------");
				log.info("name : "+multipartFile.getName());
				log.info("filename : "+multipartFile.getOriginalFilename());
				log.info("size : "+multipartFile.getSize());
				log.info("-------------- file end --------------\n");
				
				if(multipartFile.getSize() >0){
					originalFileName = multipartFile.getOriginalFilename();
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					
					file = new File(filePath + storedFileName);
					
					multipartFile.transferTo(file);
						
					String boardIdx = (String)pRequestParamMap.get("IDX");
						
					pRequestParamMap.put("CROP_IDX", boardIdx);
					pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
					pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
					pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
						
					mcb01Service.insertMonthFile(pRequestParamMap);	
				}
				
			}else{
				//return false;
			}	
			// 카카오톡 이메일 발송
			HashMap<String , Object> map = new HashMap<String, Object>();
	 		// 1. 맞춤정보 요청 - 사용자 정보 가져오기
	 		List<CustomInfoSnsVO> customInfo = custionInfoService.getSnsList(map);
	 		
	 		// 2. 맞춤정보 요청 사용자가 있을경우 realTime 시간별
	 		if(customInfo.size() > 0){
	 			for(int i=0; i<customInfo.size(); i++){
	 				
	 				CustomInfoSnsVO customInfoSns = customInfo.get(i);
	 				
	 				// 실시간 가격정보 
	 				if(customInfoSns.getReport2Yn().equals("Y")){
	 					sendService("맞춤알림 보고서 정보", customInfoSns.getUserGubun(), customInfoSns.getUserId(), customInfoSns);
					}
	 			}
	 		} 
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
		return "jsonView";
	}
	
public void sendService(String title, String gubun, String userId, CustomInfoSnsVO customInfoSnsVO){
		
		StringBuilder result = new StringBuilder();
		String lineEnter="\r\n";
		if(gubun.equals("email")){
			lineEnter = "<br>";
		}
		result.append("화훼유통정보시스템 맞춤알림 보고서 등록 안내");
		result.append(lineEnter);
		
		result.append("월간거래동향보고서");
		result.append(lineEnter);
		
		result.append("https://flower.at.or.kr/hba02/hba02.do");
		result.append(lineEnter);
		
		result.append("화훼유통정보시스템에서 신청하신 맞춤알림 정보입니다. ");
		result.append(lineEnter);
		
		result.append("더 이상 수신을 원하지 않으시는 경우 웹사이트에서 맞춤알림 설정을 변경하십시오. ");
		result.append(lineEnter);
		
		result.append("https://flower.at.or.kr/customInfo/customInfoForm.do -> 오른쪽 위 (맞춤알림정보) 클릭 -> 수신하시는 휴대폰번호와 비밀번호 입력 -> 맞춤알림 변경");
		result.append(lineEnter);
		
		
		if(gubun.equals("email")){
			// email 발송
			// 카카오톡 이메일 발송
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("title", title);
			map.put("userId", userId);
			map.put("content", result.toString());
			
			int sendResult = custionInfoService.sendMail(map);
		 		
			 
		}else{
			// 문자발송
			HashMap<String , Object> map = new HashMap<String, Object>();
			map.put("msgType", "5");
			map.put("userId", userId);
			map.put("subject", result.toString());
			
			int sendResult = custionInfoService.sendKakao(map);
		}
	}
	
	@RequestMapping(value="/mntr/mcb01/updateMonthInfoInput.json")
	@ResponseBody
	public String updateMonthInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){
		 
		 Iterator<String> iterator =  request.getFileNames();
		 
		 MultipartFile multipartFile = null;
		 String originalFileName = null;
		 String originalFileExtension = null;
		 String storedFileName = null;
			
		 File file = new File(filePath);
		 //Map<String, String> sumnail = (Map<String, String>)mca01Service.selectSumNail(pRequestParamMap);
			 
		 try {
			 mcb01Service.updateMonthInfoInput(pRequestParamMap);
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
				 pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				 pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				 pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
				 
				 if(originalFileName != null && !"".equals(originalFileName)){
					 String boardIdx = (String)pRequestParamMap.get("SEQ_NO");
					 pRequestParamMap.put("SEQ_NO", boardIdx);
					 mcb01Service.deleteMonthFileInfoInput(pRequestParamMap);
					 pRequestParamMap.put("CROP_IDX", boardIdx);
					 mcb01Service.insertMonthFile(pRequestParamMap);
				 }else{
					 mcb01Service.updateMonthFile(pRequestParamMap);
				 }
			 }
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
		return "jsonView";
	}
	
	@RequestMapping(value="/mntr/mcb01/deleteMonthInfoInput.json")
	public String deleteMonthInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
					pRequestParamMap.put("SEQ_NO",S1);
					pRequestParamMap.put("TITLE",S2);	 
					pRequestParamMap.put("WRITE_NAME",S3);	
					pRequestParamMap.put("CONTENT",S4);
					mcb01Service.deleteMonthInfoInput(pRequestParamMap);
					mcb01Service.deleteMonthFileInfoInput(pRequestParamMap);
					
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
	
	 @RequestMapping("/mcb01/mcb01FileDown.json")
		public void mab02FileDown(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, String seq) throws Exception{
			
			String userFilesPath = filePath;
			
			Mcb01VO fileMap = (Mcb01VO) mcb01Service.selectSumNail(seq);
			String downFile = userFilesPath+fileMap.getStoredFileName();
			String orgFileName = fileMap.getOriginalFileName();
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}

}
