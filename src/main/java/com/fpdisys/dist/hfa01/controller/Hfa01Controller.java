package com.fpdisys.dist.hfa01.controller;

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
import com.fpdisys.base.util.CommonUtils;
import com.fpdisys.base.util.FileUtils;
import com.fpdisys.dist.hfa01.domain.Hfa01VO;
import com.fpdisys.dist.hfa01.service.Hfa01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Hfa01Controller extends BaseController{

	//private static final String filePath = "D:\\work\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "D:\\FLOWER\\files\\";
	
	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Hfa01Service hfa01Service;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	
	 @RequestMapping(value="/hfa01/hfa01.do")
	 public String selectCropInfoInput(
  			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========KKKKK==============" + pRequestParamMap.toString());
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PaginationInfo paginationInfo = new PaginationInfo();  
			 try{
			
				List<Hfa01VO> selectHfa01 = (List<Hfa01VO>)hfa01Service.selectHfa01(pRequestParamMap,paginationInfo );
				if(!selectHfa01.isEmpty()){					
				
					if(paginationInfo != null){					
						
						Hfa01VO data = (Hfa01VO)selectHfa01.get(0);
						
						paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));							
					}
				
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
			 
					
				log.info("===============selectHfa01==#####===================");
				log.info("paginationInfo==="+paginationInfo.toString());
				model.addAttribute("pRequestParamMap", pRequestParamMap);
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("selectHfa01", selectHfa01);
				model.addAttribute("mainSeq", pRequestParamMap.get("seq"));
				model.addAttribute("mainTitle", pRequestParamMap.get("title"));
				model.addAttribute("mainContent", pRequestParamMap.get("content"));
				model.addAttribute("mainInsId", pRequestParamMap.get("insId"));
				model.addAttribute("mainInsDt", pRequestParamMap.get("insDt"));
				model.addAttribute("mainGubn", pRequestParamMap.get("gubn"));
				model.addAttribute("mainOrFileNm", pRequestParamMap.get("orFileNm"));
				model.addAttribute("mainSeqNum", pRequestParamMap.get("seqNum"));
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
	 	 return "/auction/Hfa01";
	}
	 
	 @RequestMapping(value="/hfa01/getHfa01Seq.json")
		public String gongiGridListSeq(HttpServletRequest pRequest, HttpServletResponse pResponse
				, HttpSession session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
	  
			log.info("========== gridListSeq ============="+pRequestParamMap.toString());
			
			try{
				Hfa01VO list = (Hfa01VO)hfa01Service.selectMainGongiSeq(pRequestParamMap.get("seq").toString());												
				
				model.addAttribute("list", list);
			} catch (ArithmeticException | NumberFormatException | ArrayIndexOutOfBoundsException | NegativeArraySizeException | NullPointerException | NoSuchMethodError | NoClassDefFoundError Ex) {
				log.error("Exception!! " + Ex.getStackTrace());
			} catch (RuntimeException runEx) {
				log.error("RuntimeException!! " + runEx.getStackTrace());
			}									
			return "jsonView";
		}
	 
	 @RequestMapping(value="/hfa01/hfa01_Popup.do")
	 public String selectCropPopup(
  			HttpServletRequest pRequest, HttpServletResponse pResponse, 
  			@RequestParam Map<String, Object> pRequestParamMap,
  			ModelMap model){			  			  					  									 
		 
		 log.info("selectCropPopup==="+pRequestParamMap.toString());
		 model.addAllAttributes(pRequestParamMap);
		 
	 	 return "/auction/Hfa01_Popup";
	}
	 
	 
	 @RequestMapping(value="/hfa01/insertNotice.json")
	 @ResponseBody
		public String insertNotice(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		MultipartHttpServletRequest request,
		 		ModelMap model)
		{		 									 	
		 
		Iterator<String> iterator =  request.getFileNames();
	  	MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		String userFilesPath = filePath;			
		File file = null;
		 
		if(iterator.hasNext()) {
			multipartFile = request.getFile(iterator.next());
				 								
			log.info("------------- file start -------------");
			log.info("name : "+multipartFile.getName());
			log.info("filename : "+multipartFile.getOriginalFilename());
			log.info("size : "+multipartFile.getSize());
			log.info("-------------- file end --------hfa01controller------\n");
			
			originalFileName = multipartFile.getOriginalFilename();
			originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
			originalFileExtension = originalFileExtension.replaceAll("/", "");
	 		originalFileExtension = originalFileExtension.replaceAll("\\\\", "");
	 		originalFileExtension = originalFileExtension.replaceAll("&", "");
	 		
			storedFileName = CommonUtils.getRandomString() + originalFileExtension;
																	
			try {
				file = new File(userFilesPath + storedFileName);
				multipartFile.transferTo(file);
				
				hfa01Service.insertNotice(pRequestParamMap);	
				
				String boardIdx = (String)pRequestParamMap.get("IDX");
				
				pRequestParamMap.put("CROP_IDX", boardIdx);
				pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize()); 					
				
				hfa01Service.insertNoticeFile(pRequestParamMap);	
							 
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
		} else {
			//return false;
		}	  														
		 return "jsonView";
	 }
	 

		 @RequestMapping(value="/hfa01/updateNotice.json")
		 @ResponseBody
			public String updateCropInfoInput(
					HttpServletRequest pRequest, 
					HttpServletResponse pResponse,
					HttpSession  session,
			 		@RequestParam Map<String, Object> pRequestParamMap,
			 		MultipartHttpServletRequest request,
			 		ModelMap model)
			{		 						

				Map<String, Object> resultMap = new HashMap<String, Object>();
				log.info("updateCropInfoInput++++++++++++"+pRequestParamMap);
				
				 Iterator<String> iterator =  request.getFileNames();
		  	MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			String userFilesPath = filePath;			
			File file = null;
			 
			if(iterator.hasNext()) {
				multipartFile = request.getFile(iterator.next());
					 								
				log.info("------------- file start -------------");
				log.info("name : "+multipartFile.getName());
				log.info("filename : "+multipartFile.getOriginalFilename());
				log.info("size : "+multipartFile.getSize());
				log.info("-------------- file end ------hfa01controller02--------\n");
				
				originalFileName = multipartFile.getOriginalFilename();
		 		originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
		 		
		 		originalFileExtension = originalFileExtension.replaceAll("/", "");
		 		originalFileExtension = originalFileExtension.replaceAll("\\\\", "");
		 		originalFileExtension = originalFileExtension.replaceAll("&", "");
		 		
		 		storedFileName = CommonUtils.getRandomString() + originalFileExtension;
		 		
				try{				
					file = new File(userFilesPath + storedFileName);
					multipartFile.transferTo(file);
					
					String boardIdx = (String)pRequestParamMap.get("IDX");
					
					hfa01Service.updateNotice(pRequestParamMap);			
					pRequestParamMap.put("CROP_IDX", boardIdx);
					pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
					pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
					pRequestParamMap.put("FILE_SIZE", multipartFile.getSize()); 					
					
					hfa01Service.updateNoticeFile(pRequestParamMap);	
								 
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
			} else {
				//return false;
			}	  														
			 return "jsonView";	  
			 }
	 
	 @RequestMapping(value="/hfa01/deleteSugeup.json")
		public String deleteNotice(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam(value="seq_no", required=false) List<String> seqNoList, 
				ModelMap model){
		 
		 log.info("++++++++++++"+seqNoList.toString());
		 
		 for(String seqNo : seqNoList){
			 System.out.println(":::::::::::::::::::" + seqNo);
			 Map<String, Object> requestMap = new HashMap<String, Object>();
			 requestMap.put("seqNo", seqNo);
			 hfa01Service.deleteNotice(requestMap);
			 hfa01Service.deleteNoticeFile(requestMap);
		 }
		 
		// model.addAllAttributes(pRequestParamMap);
		 
	 
		 return "jsonView";
	 
	 }
	 

	@RequestMapping("/hfa01/hfa01FileDown.json")
	public void hba02FileDown(HttpServletRequest pRequest, HttpServletResponse pResponse, String seq) {
			
		try {
			
			String userFilesPath = filePath;
			Hfa01VO fileMap = hfa01Service.selectMainGongiSeq(seq);
			String downFile = userFilesPath+fileMap.getSTORED_FILE_NAME();
			String orgFileName = fileMap.getORIGIN_FILE_NAME();
			
			log.info("------------- file start -------------");
			log.info("name : "+orgFileName);
			log.info("filename : "+downFile);
			log.info("-------------- file end -------Hfa01Controller-------\n");
			
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
			
		} catch (Exception e) {
			
		}
	}
	
	
	 @RequestMapping(value="/hfa01/updateNoticeClickCnt.json")
		public String updateNoticeClickCnt(
	 		HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){
		
		 hfa01Service.updateNoticeClickCnt(pRequestParamMap);
		 

		 return "jsonView";
	 
	 }
}

