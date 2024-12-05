package com.fpdisys.dist.hca03.controller;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.Synchronized;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.hca01.domain.Hca01VO;
import com.fpdisys.dist.hca03.domain.Hca03VO;
import com.fpdisys.dist.hca03.service.Hca03Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Hca03Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
			
	@Autowired
	Hca03Service hca03Service;
	
	
	@RequestMapping(value="/hca03/hca03.do")
	public String selectView(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
			
			//20.03.16 최초 조회 카운트 오류로 주석 처리 및 san_list 추가
			//pRequestParamMap.put("initFlag", "T");			
			List<String> san_list = new ArrayList<String>();
			san_list.add("전체");
			san_list.add("서울");
			san_list.add("경기");
			san_list.add("강원");
			san_list.add("충북");
			san_list.add("충남"); 
			san_list.add("전북");
			san_list.add("전남");
			san_list.add("경북");
			san_list.add("경남");
			
			pRequestParamMap.put("san_list", san_list);
			PaginationInfo paginationInfo = new PaginationInfo();
			try{
					
				List<Hca03VO> selectHca03 = (List<Hca03VO>)hca03Service.selectHca03Test(pRequestParamMap, paginationInfo);
				if(!selectHca03.isEmpty()){					
				
					if(paginationInfo != null){					
						
						Hca03VO data = (Hca03VO)selectHca03.get(0);
						
						paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
					}
				
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
				
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("selectHca03", selectHca03);
				model.addAttribute("initFlag", "T");
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
			
			return "/auction/Hca03";
	}
	
	 @RequestMapping(value="/hca03/hca03Select.do")
	 public String selectCropInfoInput(
  			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,
			@RequestParam(value="san_list", required=false) List<String> san_list,
			@RequestParam(value="san_id_list", required=false) List<String> san_id_list,
			ModelMap model){			  			  				
	  					
		 	pRequestParamMap.remove("san_list");
			pRequestParamMap.put("san_list", san_list);
			PaginationInfo paginationInfo = new PaginationInfo();
			 try{
					
					List<Hca03VO> selectHca03 = (List<Hca03VO>)hca03Service.selectHca03Test(pRequestParamMap, paginationInfo);
					if(!selectHca03.isEmpty()){					
					
						if(paginationInfo != null){					
							
							Hca03VO data = (Hca03VO)selectHca03.get(0);
							
							paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
						}
					
					}else{
						paginationInfo.setTotalRecordCount(0);
					}
					
					model.addAttribute("paginationInfo", paginationInfo);
					model.addAttribute("selectHca03", selectHca03);
					model.addAttribute("san_id_list", san_id_list);
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

		 
	 	 return "/auction/Hca03";
	}
	 
	 /*@Synchronized
	 @RequestMapping(value="/hca03/hca03Image.json")
		public void getPic(HttpServletRequest request, HttpServletResponse response) {

		  // 불러와야할 이미지에 대한 식별값을 파라미터로 받아옴.
		  String fileSeq = request.getParameter("imgId");
		  String pathString = "/usr/webapps/upload/";
		  
		 
		  
		  File file = null;
		  FileInputStream fis = null;
			
		  BufferedInputStream in = null;
		  ByteArrayOutputStream bStream = null;
		  try{
			  
			  Map<String, String> fileDetail = hca03Service.selectCropFileDetail(fileSeq);
			  String name = String.valueOf(fileDetail.get("storedFileName")) ;
			  
			  file = new File((pathString + name ));
			  fis = new FileInputStream(file);
			  in = new BufferedInputStream(fis);
			  bStream = new ByteArrayOutputStream();
			  int imgByte;
			  while ((imgByte = in.read()) != -1) {
				 bStream.write(imgByte);
			  }
			  String type = "";
			  String originalFileExtension = name.substring(name.lastIndexOf("."));
			  if (originalFileExtension != null && !"".equals(originalFileExtension)) {
					if ("jpg".equals(originalFileExtension.toLowerCase())) {
						type = "image/jpeg";
					} else {
						type = "image/" + originalFileExtension.toLowerCase();
					}
					type = "image/" + originalFileExtension.toLowerCase();
				}
			  
			  response.setHeader("Content-Type", type);
			  response.setHeader("Content-Transfer-Encoding", "binary");
			  response.setHeader("Content-Disposition", "filename=image;");
			  response.setContentLength(bStream.size());
			  
			  bStream.writeTo(response.getOutputStream());
			  response.getOutputStream().flush();
			  response.getOutputStream().close();

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
			} finally {
				if (bStream != null) {
					try {
						bStream.close();
					} catch (IOException e) {
						log.debug("입출력 오류!!");
					}
				}
				if (in != null) {
					try {
						in.close();
					} catch (IOException e) {
						log.debug("입출력 오류!!");
					}
				}
				if (fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						log.debug("입출력 오류!!");
					}
				}
			}
		}*/
	 @RequestMapping(value="/hca03/selectCropMainChart.json")
		public String selectCropMainChart(HttpServletRequest pRequest, HttpServletResponse pResponse
				, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
			 		
			try{
				List<Hca03VO> list = (List<Hca03VO>)hca03Service.selectCropMainChart(pRequestParamMap);
				
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
	 
}