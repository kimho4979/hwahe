package com.fpminput.mntr.mcd01.controller;

import java.io.File;
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
import com.fpminput.mntr.mcd01.domain.Mcd01VO;
import com.fpminput.mntr.mcd01.service.Mcd01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mcd01Controller extends BaseController{
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Autowired
	Mcd01Service mcd01Service;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	//private static final String filePath = "D:\\work\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	@RequestMapping(value="/mcd01/mcd01.do")
	public String SelectGongiInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
	
		String sessionId = (String) httpSession.getAttribute("SESSION_USER_ID");
		httpSession.setAttribute("SESSION_USER_ID", sessionId);
		
		return "/mcd01/gongiInput";
	}
	
	@RequestMapping(value="/mntr/mcd01/gridList.json")
	public String gongiGridList(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("==========gridListgridList============="+pRequestParamMap.toString());
  		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<EgovMap> list  =  (List<EgovMap>)mcd01Service.selectGongiList(pRequestParamMap);												
			
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
	
	@RequestMapping(value="/mntr/mcd01/gridListSeq.json")
	public String gongiGridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse
			, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
  
		log.info("========== gridListSeq ============="+pRequestParamMap.toString());
		
		try{
			List<Mcd01VO> list = (List<Mcd01VO>)mcd01Service.selectSimilarInputSeq(pRequestParamMap);												
			
			model.addAttribute("list", list);
		} catch (ArithmeticException | NumberFormatException | ArrayIndexOutOfBoundsException | NegativeArraySizeException | NullPointerException | NoSuchMethodError | NoClassDefFoundError Ex) {
			log.error("Exception!! " + Ex.getStackTrace());
		} catch (RuntimeException runEx) {
			log.error("RuntimeException!! " + runEx.getStackTrace());
		}									
		return "jsonView";
	}
	
	@RequestMapping(value="/mcd01/gongiInput_popup.do")
	public String gongiInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}

		Mcd01VO list = (Mcd01VO)mcd01Service.selectSimilarInputSeq(pRequestParamMap);												
		
		model.addAttribute("selectMcd01", list);
			
		
		return "/mcd01/gongiInput_popup";
			
	}
	
	@RequestMapping(value="/mntr/mcd01/insertGongiInput.json")
	public String insertGongiInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	

		try {
			Iterator<String> iterator =  request.getFileNames();
		 
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			 
			mcd01Service.insertGongiInput(pRequestParamMap);
			
			if(iterator.hasNext()) {
				multipartFile = request.getFile(iterator.next());
				System.out.println(multipartFile.getOriginalFilename() + " uploaded!");

				log.info("------------- file start -------------");
				log.info("name : " + multipartFile.getName());
				log.info("filename : " + multipartFile.getOriginalFilename());
				log.info("size : " + multipartFile.getSize());
				log.info("-------------- file end --------------\n");

					originalFileName = multipartFile.getOriginalFilename();
					if (multipartFile.getSize() > 0)
						originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;

					file = new File(filePath + storedFileName);
					if (multipartFile.getSize() > 0)
						multipartFile.transferTo(file);

					String boardIdx = (String) pRequestParamMap.get("IDX");

					pRequestParamMap.put("CROP_IDX", boardIdx);
					pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
					pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
					pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());

					mcd01Service.insertGongiFile(pRequestParamMap);

			}
		} catch (IOException e) {
			log.debug("입출력 오류!!");
			e.printStackTrace();
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
	
	@RequestMapping(value="/mntr/mcd01/updateGongiInfoInput.json")
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
			 
			 mcd01Service.updateGongiInfoInput(pRequestParamMap);
			 
			 if(iterator.hasNext()) {
				 multipartFile = request.getFile(iterator.next());
				 System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
				 System.out.println("FILE IS SIZE1  : " + pRequestParamMap.get("FILE_SIZE"));
				 
				 log.info("------------- file start -------------");
				 log.info("name : "+multipartFile.getName());
				 log.info("filename : "+multipartFile.getOriginalFilename());
				 log.info("size : "+multipartFile.getSize());
				 log.info("-------------- file end --------------\n");
				 if(multipartFile.getSize() > 0) {
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

					 if (originalFileName != null && !"".equals(originalFileName)) {
						 String boardIdx = (String) pRequestParamMap.get("SEQ");
						 pRequestParamMap.put("CROP_IDX", boardIdx);
						 mcd01Service.updateGongiFile(pRequestParamMap);
						 //mcd01Service.insertGongiFile(pRequestParamMap);
					 } else {
						 mcd01Service.updateGongiFile(pRequestParamMap);
					 }
				 }
			 }
		} catch (IOException e) {
			e.printStackTrace();
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
			e.printStackTrace();
		} catch (Exception e) {
			log.error("오류발생!!");
		} 
		return "jsonView";
	}
	
	@RequestMapping(value="/mntr/mcd01/deleteGongiInfoInput.json")
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
					mcd01Service.deleteGongiInfoInput(pRequestParamMap);
					mcd01Service.deleteGongiFileInfoInput(pRequestParamMap);
					
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
	
	 @RequestMapping("/mcd01/mcd01FileDown.json")
		public void mcd01FileDown(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, String seq) throws Exception{
			
			String userFilesPath = filePath;
			
			Mcd01VO fileMap = (Mcd01VO) mcd01Service.selectSumNail(seq);
			String downFile = userFilesPath+fileMap.getStoredFileName();
			String orgFileName = fileMap.getOriginFileName();
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}

}
