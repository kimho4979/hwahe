package com.fpminput.mntr.mab01.controller;

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
import com.fpminput.mntr.mab01.domain.Mab01VO;
import com.fpminput.mntr.mab01.service.Mab01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class Mab01Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Mab01Service mab01Service;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	@RequestMapping(value="/mab01/mab01.do")
	public String selectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
		log.info("==========lmhlmh==============");
		HttpSession httpSession = pRequest.getSession();
		
		if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
			return "redirect:/mnt/mem01/mem01Form.do";
		}
		return "/mab01/cropInfoInput";
	}
	 
	@RequestMapping(value="/mab11/mab11.do")
	public String mobileSelectCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
	  					
			log.info("==========lmhlmh==============");

			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				
				return "redirect:/mnt/mem01/mem01Form.do";
			}
			
			Map<String, String> sumnail = (Map<String, String>)mab01Service.selectSumNail(pRequestParamMap);
			
			log.info("@@@@@@@@@ SUMNAIL @@@@@@@@@");
			log.info(sumnail);
			log.info("@@@@@@@@@ SUMNAIL @@@@@@@@@");
			model.addAttribute("sumnail",sumnail);
		 
	 	 return "/mobile/maa11/cropInfoInput";
	}
	 
	 
	 @RequestMapping(value="/mntr/mab01/gridList.json")
		public String gridList(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		 log.info("==========gridListgridList============="+pRequestParamMap.toString());

		 Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList = (List<EgovMap>)mab01Service.selectCropInfoInput(pRequestParamMap);
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
	 
	 @RequestMapping(value="/mntr/mab01/gridListAll.json")
	 public String gridListAll(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						

		 log.info("==========gridListgridList============="+pRequestParamMap.toString());

		 Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			List<?> resultListAll = (List<?>)mab01Service.selectCropInfoInputAll(pRequestParamMap);
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
	 
	@RequestMapping(value="/mntr/mab01/gridListSeq.json")
	public String gridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession session
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		try{
			String seqNo = (String)pRequestParamMap.get("seqNo");
			
			Mab01VO mab01vo = new Mab01VO();
			mab01vo.setSeqNo(seqNo);
			
			Mab01VO result = mab01Service.selectCropInfoInputSeq(mab01vo);
			model.addAttribute("result", result);
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
	 
	 
	 @RequestMapping(value="/mab01/cropInfoInput_popup.do")
		public String cropInfoInput_popup(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		
			log.info("===========================================");
		  	log.info("======  mab01 ======");
		  	log.info("===========================================");		  	
		 	log.info("mab01+++++++++ : " + pRequestParamMap.toString());
			HttpSession httpSession = pRequest.getSession();
			
			if(httpSession.getAttribute("SESSION_USER_ID") == null || httpSession.getAttribute("SESSION_USER_ID").equals("")){
				return "redirect:/mnt/mem01/mem01Form.do";
			}
			
			Map<String, String> sumnail = (Map<String, String>)mab01Service.selectSumNail(pRequestParamMap);
			
			log.info("@@@@@@@@@ SUMNAIL @@@@@@@@@");
			log.info(sumnail);
			log.info("@@@@@@@@@ SUMNAIL @@@@@@@@@");
			model.addAttribute("sumnail",sumnail);
			
			return "/mab01/cropInfoInput_popup";
			
	 }
	 
	
	 @RequestMapping(value="/mntr/mab01/insertCropInfoInput.json")
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
					
					mab01Service.insertCropInfoInput(pRequestParamMap);	
					
					String boardIdx = (String)pRequestParamMap.get("IDX");
					
					pRequestParamMap.put("CROP_IDX", boardIdx);
					pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
					pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
					pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
					
					mab01Service.insertCropFile(pRequestParamMap);	
								 
				
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
	 
	 @RequestMapping(value="/mntr/mab01/updateCropInfoInput.json")
	 @ResponseBody
		public String updateCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
				, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){
		 
		 Iterator<String> iterator =  request.getFileNames();
		 
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			
			File file = new File(filePath);
			Map<String, String> sumnail = (Map<String, String>)mab01Service.selectSumNail(pRequestParamMap);
			 
			try {
				mab01Service.updateCropInfoInput(pRequestParamMap);
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
					String boardIdx = (String)pRequestParamMap.get("IDX");
					pRequestParamMap.put("CROP_IDX", boardIdx);
					pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
					pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
					pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
					mab01Service.updateCropFile(pRequestParamMap);
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
	 
	 @RequestMapping(value="/mntr/mab01/deleteCropInfoInput.json")
	 public String deleteCropInfoInput(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
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
						pRequestParamMap.put("REG_DATE",S1);
						pRequestParamMap.put("CHUL_NO",S2);	 
						pRequestParamMap.put("PUM_NAME",S3);	
						pRequestParamMap.put("GOOD_NAME",S4);
						pRequestParamMap.put("SEQ_NO",S5);
						mab01Service.deleteCropInfoInput(pRequestParamMap);
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
}
