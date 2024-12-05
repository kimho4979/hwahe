package com.fpminput.mntr.mab02.controller;

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
import com.fpminput.mntr.mab02.domain.Mab02VO;
import com.fpminput.mntr.mab02.service.Mab02Service;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class Mab02Controller extends BaseController{
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Mab02Service mab02Service;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	@RequestMapping(value="/mab02/mab02.do")
	public String selectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		 
		return "/mab02/cropInfoInput";
	}
	 
	@RequestMapping(value="/mab22/mab22.do")
	public String mobileSelectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			 , @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "redirect:/mnt/mem01/mem01Form.do";
			}
			String seq = (String)pRequestParamMap.get("seqNo");
			Mab02VO sumnail = (Mab02VO)mab02Service.selectSumNail(seq);
			
			model.addAttribute("sumnail",sumnail);
		 
	 	 return "/mobile/maa22/cropInfoInput";
	}
	 
	 
	@RequestMapping(value="/mntr/mab02/gridList.json")
	public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){

		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<Mab02VO> resultList = (List<Mab02VO>)mab02Service.selectCropInfoInput(pRequestParamMap);
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
	 
	@RequestMapping(value="/mntr/mab02/gridListAll.json")
	public String gridListAll(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		Map<String, Object> resultMap = new HashMap<String, Object>();
			
		try{
			List<Mab02VO> resultListAll = (List<Mab02VO>)mab02Service.selectCropInfoInputAll(pRequestParamMap);
			model.addAttribute("list", resultListAll);
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
	 
	 
	@RequestMapping(value="/mab02/cropInfoInput_popup.do")
	public String cropInfoInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			
		HttpSession httpSession = pRequest.getSession();
			
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
			
		if(pRequestParamMap.get("seqNo")!=null){
			String seq = (String)pRequestParamMap.get("seqNo");
			Mab02VO resultList = mab02Service.selectCropInfoInput(pRequestParamMap).get(0);
			model.addAttribute("result", resultList);

			Mab02VO sumnail = (Mab02VO)mab02Service.selectSumNail(seq);
			model.addAttribute("sumnail",sumnail);
		}
		return "/mab02/cropInfoInput_popup";
	}
	 
	
	@RequestMapping(value="/mntr/mab02/insertCropInfoInput.json")
	//@ResponseBody
	public String insertCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	
		try {
			Iterator<String> iterator =  request.getFileNames();
		 
			MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			 
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
				
				
				mab02Service.insertCropInfoInput(pRequestParamMap);	
				
				String boardIdx = (String)pRequestParamMap.get("IDX");
				
				pRequestParamMap.put("CROP_IDX", boardIdx);
				pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
				
				mab02Service.insertCropFile(pRequestParamMap);	
								 
				
			} else {
				//return false;
			}	  
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
		return "jsonView";
	}
	 
	@RequestMapping(value="/mntr/mab02/updateCropInfoInput.json")
	@ResponseBody
	public String updateCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){
		 
		Iterator<String> iterator =  request.getFileNames();
		 
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String seq = (String)pRequestParamMap.get("seqNo");
			
		File file = new File(filePath);
		Mab02VO sumnail = (Mab02VO)mab02Service.selectSumNail(seq);

		try {
			mab02Service.updateCropInfoInput(pRequestParamMap);
			if(iterator.hasNext()) {
				multipartFile = request.getFile(iterator.next());
				System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
				System.out.println("FILE IS SIZE1  : " + pRequestParamMap.get("FILE_SIZE"));
	
				log.info("------------- file start -------------");
				log.info("name : "+multipartFile.getName());
				log.info("filename : "+multipartFile.getOriginalFilename());
				log.info("size : "+multipartFile.getSize());
				log.info("-------------- file end --------------\n");
				if(multipartFile.getSize()>0){
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
					mab02Service.updateCropFile(pRequestParamMap);
				}

			}
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
			return "jsonView";
	 }
	 
	 @RequestMapping(value="/mntr/mab02/deleteCropInfoInput.json")
	 public String deleteCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			 , @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  
		 if(pRequestParamMap.get("item_cd")!=null){
			 session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
		 } 	  
	  		
		 String gridResult = pRequestParamMap.toString();
		  
		 String s2 = gridResult.replace("{","");
		 String s3 = s2.replace("}","");
		 String s4 = s3.replace("=","");
		 
		 String[] result = s4.split("!");

		 log.info("result:++++======"+result.length);		 		
	  		
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 log.info("resultMap++++++++++++"+resultMap);
		 String S1 ="";
		 String S2 ="";
		 String S3 ="";
		 String S4 ="";
		 String S5 ="";			
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
					 pRequestParamMap.put("regDate",S1);
					 pRequestParamMap.put("chulNo",S2);	 
					 pRequestParamMap.put("pumName",S3);	
					 pRequestParamMap.put("goodName",S4);
					 pRequestParamMap.put("seqNo",S5);
					 mab02Service.deleteCropInfoInput(pRequestParamMap);
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
	 
	 @RequestMapping("/mab02/mab02FileDown.json")
	 public void mab02FileDown(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, String seq) throws Exception{
			
			String userFilesPath = filePath;
			
			Mab02VO fileMap = (Mab02VO) mab02Service.selectSumNail(seq);
			String downFile = userFilesPath+fileMap.getStoredFileName();
			String orgFileName = fileMap.getOriginalFileName();
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}
}
