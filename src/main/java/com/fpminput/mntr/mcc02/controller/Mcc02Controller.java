package com.fpminput.mntr.mcc02.controller;

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
import com.fpminput.base.util.CommonUtils;
import com.fpminput.mntr.mcc02.domain.Mcc02VO;
import com.fpminput.mntr.mcc02.service.Mcc02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mcc02Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	Mcc02Service mcc02Service;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
			
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	@RequestMapping(value="/mcc02/mcc02.do")
	public String SelectSimilarInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/mcc02/similarInput";
	}
	
	@RequestMapping(value="/mntr/mcc02/gridList.json")
	public String similarGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("==========gridListgridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> list  =  (List<EgovMap>)mcc02Service.selectSimilarList(pRequestParamMap);												
			
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
	
	@RequestMapping(value="/mntr/mcc02/gridListSeq.json")
	public String similarGridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("========== gridListSeq ============="+pRequestParamMap.toString());
		
		try{
			List<Mcc02VO> list = (List<Mcc02VO>)mcc02Service.selectSimilarInputSeq(pRequestParamMap);												
			
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
	
	@RequestMapping(value="/mcc02/similarInput_popup.do")
	public String similarInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		
		return "/mcc02/similarInput_popup";
			
	}
	
	@RequestMapping(value="/mntr/mcc02/insertSimilarInput.json")
	public String insertSimilarInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	

		try {
			Iterator<String> iterator =  request.getFileNames();
		 
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			 
			mcc02Service.insertSimilarInput(pRequestParamMap);
			
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
				pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
				
				mcc02Service.insertSimilarFile(pRequestParamMap);
				
			}else{
				//return false;
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
	
	@RequestMapping(value="/mntr/mcc02/updateSugeupInfoInput.json")
	@ResponseBody
	public String updateSimilarInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){
		 
		 
		 //Map<String, String> sumnail = (Map<String, String>)mca01Service.selectSumNail(pRequestParamMap);
			 
		 try {
			 Iterator<String> iterator =  request.getFileNames();
			 
			 MultipartFile multipartFile = null;
			 String originalFileName = null;
			 String originalFileExtension = null;
			 String storedFileName = null;
				
			 File file = new File(filePath);
			 
			 mcc02Service.updateSimilarInfoInput(pRequestParamMap);
			 
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
				 
				 pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				 pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				 pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
				 
				 if(originalFileName != null && !"".equals(originalFileName)){
					 String boardIdx = (String)pRequestParamMap.get("SEQ_NO");
					 pRequestParamMap.put("SEQ_NO", boardIdx);
					 mcc02Service.deleteSimilarFileInfoInput(pRequestParamMap);
					 pRequestParamMap.put("CROP_IDX", boardIdx);
					 mcc02Service.insertSimilarFile(pRequestParamMap);
				 }else{
					 mcc02Service.updateSimilarFile(pRequestParamMap); 
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
	
	@RequestMapping(value="/mntr/mcc02/deleteSimilarInfoInput.json")
	public String deleteSimilarInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
					mcc02Service.deleteSimilarInfoInput(pRequestParamMap);
					mcc02Service.deleteSimilarFileInfoInput(pRequestParamMap);
					
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
	
	 @RequestMapping("/mcc02/mcc02FileDown.json")
		public void mab02FileDown(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, String seq) throws Exception{
			
			String userFilesPath = filePath;
			
			Mcc02VO fileMap = (Mcc02VO) mcc02Service.selectSumNail(seq);
			String downFile = userFilesPath+fileMap.getStoredFileName();
			String orgFileName = fileMap.getOriginalFileName();
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}


}
