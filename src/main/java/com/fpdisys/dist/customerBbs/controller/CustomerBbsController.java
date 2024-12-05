package com.fpdisys.dist.customerBbs.controller;

import java.io.File;
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
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.base.util.FileUtils;
import com.fpdisys.dist.customerBbs.service.CustomerBbsService;
import com.fpminput.base.util.CommonUtils;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CustomerBbsController extends BaseController{

	//private static final String filePath = "D:\\work\\eGovFrameDev-3.5.1-64bit\\workspace\\fpdisys\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "C:\\Flower\\eGovFrameDev-3.5.1-64bit\\workspace\\fpminput\\src\\main\\webapp\\upload\\";
	//private static final String filePath = "/usr/webapps/upload/";
	private static final String filePath = "D:\\FLOWER\\files\\";
	
	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	CustomerBbsService customerBbsService;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	
	 @RequestMapping(value="/bbs/customerBbsList.do")
	 public String customerBbsList(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		 
			PaginationInfo paginationInfo = new PaginationInfo();  
			
			if(pRequestParamMap.get("currentPageNo") == null || StringUtils.isEmpty(pRequestParamMap.get("currentPageNo")) == true)
				pRequestParamMap.put("currentPageNo", "1");
			
			paginationInfo.setCurrentPageNo(Integer.parseInt(pRequestParamMap.get("currentPageNo").toString()));
		  
			if(pRequestParamMap.get("PAGE_ROW") == null || StringUtils.isEmpty(pRequestParamMap.get("PAGE_ROW")) == true){
				paginationInfo.setRecordCountPerPage(10);
			}else{
				paginationInfo.setRecordCountPerPage(Integer.parseInt(pRequestParamMap.get("PAGE_ROW").toString()));
			}
			
			paginationInfo.setPageSize(5);
			
			int start = paginationInfo.getFirstRecordIndex();
			int end = start + paginationInfo.getRecordCountPerPage();
			pRequestParamMap.put("start",start+1);
			pRequestParamMap.put("end",end);
			
			 try{
			
				 List<EgovMap> list  =  (List<EgovMap>)customerBbsService.customerList(pRequestParamMap);				
				if(!list.isEmpty()){					
				
					if(paginationInfo != null){					
						
						EgovMap data = (EgovMap)list.get(0);
						
						paginationInfo.setTotalRecordCount(Integer.parseInt(String.valueOf(data.get("totalCount"))));							
					}
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
				
				model.addAttribute("paginationInfo", paginationInfo);
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
		 
	 	 return "/auction/customerBbs";
	}
	 
	 @RequestMapping(value="/bbs/insertCustomerBbs.json")
	public String insertCustomerBbs(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session
			, @RequestParam Map<String, Object> pRequestParamMap, MultipartHttpServletRequest request, ModelMap model){		 									 	

		try {
			// 제목체크
			if(pRequestParamMap.get("title")==null || pRequestParamMap.get("title").equals("")){
				 model.addAttribute("result", "1");
				 model.addAttribute("resultMsg", "제목을 입력하세요");
			}else if(pRequestParamMap.get("usrNm")==null || pRequestParamMap.get("usrNm").equals("")){
				 model.addAttribute("result", "1");
				 model.addAttribute("resultMsg", "성명을 입력하세요");
			}else if(pRequestParamMap.get("usrPass")==null || pRequestParamMap.get("usrPass").equals("")){
				 model.addAttribute("result", "1");
				 model.addAttribute("resultMsg", "비밀번호를 입력하세요");
			}else if(pRequestParamMap.get("usrPass2")==null || pRequestParamMap.get("usrPass2").equals("")){
				 model.addAttribute("result", "1");
				 model.addAttribute("resultMsg", "비밀번호확인을 입력하세요");
			}else if(!pRequestParamMap.get("usrPass").equals(pRequestParamMap.get("usrPass2"))){
				 model.addAttribute("result", "1");
				 model.addAttribute("resultMsg", "비밀번호가 일치하지 않습니다");
			}else{
				Iterator<String> iterator =  request.getFileNames();
				 
			  	MultipartFile multipartFile = null;
				String originalFileName = null;
				String originalFileExtension = null;
				String storedFileName = null;
				
				int result =0;
				String resultMsg ="등록되었습니다";
				
				File file = new File(filePath);
				
				if(pRequestParamMap.get("seq")!=null&&!pRequestParamMap.get("seq").equals("")){
					if(iterator.hasNext()) {
						multipartFile = request.getFile(iterator.next());
						System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
							 								
						log.info("------------- file start -------------");
						log.info("name : "+multipartFile.getName());
						log.info("filename : "+multipartFile.getOriginalFilename());
						log.info("size : "+multipartFile.getSize());
						log.info("-------------- file end -------customerBbsTEST-------\n");
						
						if(multipartFile.getSize()>0){
							originalFileName = multipartFile.getOriginalFilename();
							originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
							storedFileName = CommonUtils.getRandomString() + originalFileExtension;
							
							if(originalFileExtension.equals(".doc")||originalFileExtension.equals(".txt")||originalFileExtension.equals(".hwp")
									||originalFileExtension.equals(".pdf")||originalFileExtension.equals(".xls")||originalFileExtension.equals(".xlsx")
									||originalFileExtension.equals(".png")||originalFileExtension.equals(".jpg")||originalFileExtension.equals(".gif")
									||originalFileExtension.equals(".jpeg")){
								file = new File(filePath + storedFileName);
								
								multipartFile.transferTo(file);
									
								String boardIdx = (String)pRequestParamMap.get("seq");
									
								pRequestParamMap.put("CROP_IDX", boardIdx);
								pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
								pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
								pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
									
								customerBbsService.deleteCustomerFile(pRequestParamMap);	
								customerBbsService.insertCustomerFileEncrpt(pRequestParamMap);	
								
								result = 0;
								resultMsg="등록되었습니다";
							}else{
								result =1;
								resultMsg ="첨부한 파일은 업로드가 불가능합니다.";
							}
							
						}
					}
					
					if(result==0){
						customerBbsService.updateCustomer(pRequestParamMap);
						result = 0;
						resultMsg="등록되었습니다";
					}
					
				}else{
					
					int dupChk = customerBbsService.dupChkCustomer(pRequestParamMap);
					
					if(dupChk>0){
						result =1;
						resultMsg ="이미 작성된 글이 있습니다";						
					}else{						
						customerBbsService.insertCustomer(pRequestParamMap);
						
						if(iterator.hasNext()) {
							multipartFile = request.getFile(iterator.next());
							System.out.println(multipartFile.getOriginalFilename() +" uploaded!");
								 								
							log.info("------------- file start -------------");
							log.info("name : "+multipartFile.getName());
							log.info("filename : "+multipartFile.getOriginalFilename());
							log.info("size : "+multipartFile.getSize());
							log.info("-------------- file end ---------customerBbs-----\n");
							
							if(multipartFile.getSize()>0){
								originalFileName = multipartFile.getOriginalFilename();
								
								originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf(".")).toLowerCase();
								storedFileName = CommonUtils.getRandomString() + originalFileExtension;
								
								if(originalFileExtension.equals(".doc")||originalFileExtension.equals(".txt")||originalFileExtension.equals(".hwp")
										||originalFileExtension.equals(".pdf")||originalFileExtension.equals(".xls")||originalFileExtension.equals(".xlsx")
										||originalFileExtension.equals(".png")||originalFileExtension.equals(".jpg")||originalFileExtension.equals(".gif")
										||originalFileExtension.equals(".jpeg")){
									file = new File(filePath + storedFileName);
								
									multipartFile.transferTo(file);
										
									String boardIdx = (String)pRequestParamMap.get("IDX");
										
									pRequestParamMap.put("CROP_IDX", boardIdx);
									pRequestParamMap.put("ORIGIN_FILE_NAME", originalFileName);
									pRequestParamMap.put("STORED_FILE_NAME", storedFileName);
									pRequestParamMap.put("FILE_SIZE", multipartFile.getSize());
									
									customerBbsService.insertCustomerFile(pRequestParamMap);	
									
									result = 0;
									resultMsg="등록되었습니다";
								}else{
									result =0;
									resultMsg ="첨부한 파일은 업로드가 불가능합니다. 내용만 업로드 됩니다.";
								}
							}
						}	
					}
				}
				
				model.addAttribute("result", result);
				model.addAttribute("resultMsg", resultMsg);
			}
		}catch(Exception e){
			model.addAttribute("result", "1");
			model.addAttribute("resultMsg", "예기치 못한 에러가 발생하였습니다");
			e.printStackTrace();
		}
		return "jsonView";
	}
	 
	 @RequestMapping(value="/bbs/updateClickCnt.json")
		public String updateNoticeClickCnt(HttpServletRequest pRequest,HttpServletResponse pResponse,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
		
		 customerBbsService.updateClickCnt(pRequestParamMap);
		 return "jsonView";
	 }
	 
	 @RequestMapping(value="/bbs/selectCustomerBbsBySeq.json", method=RequestMethod.POST)
		public String selectCustomerBbsBySeq(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			 									 	

			try {
				if(pRequestParamMap.get("pass")!=null&&!pRequestParamMap.get("pass").equals("")){
					List<EgovMap> list  =  (List<EgovMap>)customerBbsService.customerList(pRequestParamMap);
					 
					 if(list!=null&&list.size()>0){
						 model.addAttribute("result", "0");
						 model.addAttribute("list", list.get(0));
					 }else{
						 model.addAttribute("result", "비밀번호가 틀렸습니다");
					 }
				}else{
					model.addAttribute("result", "비밀번호를 입력하세요");
				}
				 
			}catch(Exception e){
				model.addAttribute("result", "예외발생, 관리자에게 문의하세요");
				e.printStackTrace();
			}
			return "jsonView";
		}
	 
	 @RequestMapping("/bbs/customerBbsFileDown.json")
		public void customerBbsFileDown(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap) throws Exception{
			
			
			String userFilesPath = filePath;
			
			pRequestParamMap.put("enSeq", pRequestParamMap.get("seq"));
			pRequestParamMap.put("seq", "");
			
			List<EgovMap> list = customerBbsService.customerList(pRequestParamMap);
					
			String downFile = userFilesPath+list.get(0).get("storedFileName");
			String orgFileName = (String) list.get(0).get("originFileName");
			
			FileUtils fileUtil = new FileUtils(); 
			fileUtil.downFile(downFile, orgFileName, pRequest, pResponse);
		}
	 
	 @RequestMapping(value="/bbs/customerBbsDel.json")
		public String customerBbsDel(HttpServletRequest pRequest, HttpServletResponse pResponse, HttpSession  session, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){		 						
			
			try{
					customerBbsService.deleteCustomer(pRequestParamMap);
					model.addAttribute("result", "0");
			} catch (ArithmeticException e) {
				model.addAttribute("result", "1");
				log.error("오류발생 숫자를 0으로 나눌 수 없습니다!!");
			} catch (NumberFormatException e)  {
				model.addAttribute("result", "1");
				log.error("오류발생 숫자로 변환 할 수 없습니다!!");
			} catch (ArrayIndexOutOfBoundsException e) {
				model.addAttribute("result", "1");
				log.error("오류발생 배열인텍스에서 벗어났습니다!!");
				model.addAttribute("result", "1");
			} catch (NegativeArraySizeException e) {
				model.addAttribute("result", "1");
				log.error("오류발생 배열을 음수로 지정 할 수 없습니다!!");
			} catch (NullPointerException e) {
				model.addAttribute("result", "1");
				log.error("오류발생 특정 널 값을 가진 변수를 참조 할수 없습니다!!");
			} catch (NoSuchMethodError e) {
				model.addAttribute("result", "1");
				log.error("오류발생 메서드를 찾을수 없습니다!!");
			} catch (NoClassDefFoundError e) {
				model.addAttribute("result", "1");
				log.error("오류발생 클래스를 찾을 수 없습니다!!");
			} catch (RuntimeException e) {
				model.addAttribute("result", "1");
				log.error("오류발생 런타임!!");
			} catch (Exception e) {
				model.addAttribute("result", "1");
				log.error("오류발생!!");
			}	 							
			return "jsonView";
		}
	 
 }

