package com.fpdisys.dist.hba01.controller;

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
import com.fpdisys.dist.hba01.domain.Hba01VO;
import com.fpdisys.dist.hba01.service.Hba01Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



@Controller
public class Hba01Controller extends BaseController{
	//private static final String filePath = "C:\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	private static final String filePath = "/usr/webapps/upload/";
	
	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Autowired
	Hba01Service hba01Service;
	
	
	@RequestMapping(value="/hba01/hba01.do")
	public String selectCropInfoInput(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========kkkkk=============="+pRequestParamMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PaginationInfo paginationInfo = new PaginationInfo();  
				try{
				
					List<Hba01VO> selectHba01 = hba01Service.selectHba01(pRequestParamMap,paginationInfo);
					if(selectHba01!=null){					
						
						if(paginationInfo != null){					
							
							Hba01VO data = (Hba01VO)selectHba01.get(0);
							
							paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
						}
					
					}else{
						paginationInfo.setTotalRecordCount(0);
					}
			 
					
					log.info("===============selectHfa01==#####===================");
					log.info("paginationInfo==="+paginationInfo.toString());
					model.addAttribute("pRequestParamMap", pRequestParamMap);
					model.addAttribute("paginationInfo", paginationInfo);
					model.addAttribute("selectHba01", selectHba01);
					model.addAttribute("mainSeq", pRequestParamMap.get("seqNo"));
					model.addAttribute("mainTitle", pRequestParamMap.get("title"));
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
		 
		 return "/auction/Hba01";
	}
	
	@RequestMapping(value="/hba01/hba04.do")
	public String sunSelectCropInfoInput(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  				
	  					
			log.info("==========kkkkk=============="+pRequestParamMap);
			
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PaginationInfo paginationInfo = new PaginationInfo();  
				try{
				
					List<Hba01VO> selectHba01 = hba01Service.selectHba02(pRequestParamMap,paginationInfo);
					if(selectHba01!=null){					
						
						if(paginationInfo != null){					
							
							Hba01VO data = (Hba01VO)selectHba01.get(0);
							
							paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
						}
					
					}else{
						paginationInfo.setTotalRecordCount(0);
					}
			 
					
					log.info("===============selectHfa01==#####===================");
					log.info("paginationInfo==="+paginationInfo.toString());
					model.addAttribute("pRequestParamMap", pRequestParamMap);
					model.addAttribute("paginationInfo", paginationInfo);
					model.addAttribute("selectHba01", selectHba01);
					model.addAttribute("mainSeq", pRequestParamMap.get("seqNo"));
					model.addAttribute("mainTitle", pRequestParamMap.get("title"));
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
		 
		 return "/auction/Hba04";
	}
	
	 @RequestMapping(value="/hba01/hba01_Popup.do")
	 public String selectCropPopup(
  			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			ModelMap model){			  			  					  									 
		 
		 log.info("selectCropPopup==="+pRequestParamMap.toString());
		 model.addAllAttributes(pRequestParamMap);
		 
	 	 return "/auction/Hba01_Popup";
	}
	 
	 @RequestMapping(value="/hba01/insertForecast.json")
	 @ResponseBody
		public String insertCropInfoInput(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		MultipartHttpServletRequest request,
		 		ModelMap model)
		{		 									 	
		 
		 
		 List<MultipartFile> multipartFileList = request.getFiles("file");
		 //Iterator<String> iterator =  request.getFileNames();
		  	//MultipartFile multipartFile = null;
			String originalFileName = null;
			String originalFileExtension = null;
			String storedFileName = null;
			String userFilesPath = filePath;			
			File file = new File(userFilesPath);
			 
			 
			 hba01Service.insertForecast(pRequestParamMap);	
			 
			
				for(MultipartFile multipartFile : multipartFileList){
						 								
					log.info("------------- file start -------------");
					log.info("name : "+multipartFile.getName());
					log.info("filename : "+multipartFile.getOriginalFilename());
					log.info("size : "+multipartFile.getSize());
					log.info("-------------- file end --------------\n");
					
					originalFileName = multipartFile.getOriginalFilename();
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					
					file = new File(userFilesPath + storedFileName);
																			
					try {
						multipartFile.transferTo(file);
						
						 
						
						String boardIdx = (String)pRequestParamMap.get("IDX");
	
						pRequestParamMap.put("CROP_IDX", boardIdx);
						pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
						pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
						pRequestParamMap.put("FILE_SIZE", multipartFile.getSize()); 					
						
						hba01Service.insertForecastFile(pRequestParamMap);	
					
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
				}
														
			 return "jsonView";
		}
	 

	@RequestMapping("/hba01/hba01FileDown.json")
	public void hba01FileDown(HttpServletRequest pRequest, 
			HttpServletResponse pResponse, String seq) throws Exception{
		
		//System.out.println("seqtest"+seq);
		String userFilesPath = filePath;
		
		Map<String, String> fileMap = hba01Service.selectFileDown(seq);
		String downFile = userFilesPath+fileMap.get("STORED_FILE_NAME");
		String orgFileName = fileMap.get("ORIGINAL_FILE_NAME");
		
		FileUtils fileUtil = new FileUtils(); 
		fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		
	}
	
	 @RequestMapping(value="/hba01/updateForecast.json")
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
			log.info("-------------- file end --------------\n");
			
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
				
				hba01Service.updateForecast(pRequestParamMap);			
				pRequestParamMap.put("CROP_IDX", boardIdx);
				pRequestParamMap.put("ORIGINAL_FILE_NAME", originalFileName);
				pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
				pRequestParamMap.put("FILE_SIZE", multipartFile.getSize()); 					
				
				hba01Service.updateForecastFile(pRequestParamMap);	
							 
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
	 
	 @RequestMapping(value="/hba01/deleteSugeup.json")
		public String deleteSugeup(
	 			HttpServletRequest pRequest, 
					HttpServletResponse pResponse, 
				@RequestParam(value="seq_no", required=false) List<String> seqNoList,
				@RequestParam(value="storedFileName", required=false) List<String> storedFileName,
				ModelMap model){
		 
		 log.info("++++++++++++"+seqNoList.toString());
		 for(String fileName : storedFileName){
			 String userFilesPath = filePath;
					 File file = new File(userFilesPath+fileName);
					 System.out.println(userFilesPath+fileName);
					 
					 	if( file.exists() ){
							if(file.delete()){
								System.out.println("파일삭제 성공");
							}else{
								System.out.println("파일삭제 실패");
							}
						}else{
							System.out.println("파일이 존재하지 않습니다.");

						}
		 }
		 
		 
		 
		 
		 for(String seqNo : seqNoList){
			 System.out.println(":::::::::::::::::::" + seqNo);
			 Map<String, Object> requestMap = new HashMap<String, Object>();
			 requestMap.put("seqNo", seqNo);
			 hba01Service.deleteSugeup(requestMap);
			 hba01Service.deleteSugeupFile(requestMap);
		 }
		 
		// model.addAllAttributes(pRequestParamMap);
		 
	 
		 return "jsonView";
	 
	 }
	 
	 @RequestMapping(value="/hba01/updateForecastClickCnt.json")
		public String updateForecastClickCnt(
	 		HttpServletRequest pRequest, 
			HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
				ModelMap model){
		
		 hba01Service.updateForecastClickCnt(pRequestParamMap);
		 

		 return "jsonView";
	 
	 }
}