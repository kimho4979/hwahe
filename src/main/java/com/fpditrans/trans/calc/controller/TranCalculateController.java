package com.fpditrans.trans.calc.controller;


import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fpditrans.base.mvc.BaseController;
import com.fpditrans.base.mvc.PageableTO;
import com.fpditrans.trans.calc.service.TransTsaleService;

import egovframework.rte.fdl.property.EgovPropertyService;
/**
 * @Class Name : CalculateController.java
 * @Description : CalculateController Class
 *	 
 * @정산자료 콘트롤러
 * @  수정일	  수정자			  수정내용
 * @ ---------	---------	-------------------------------
 * @ 2016.07.28			최초생성
 *
 * @author 우림인포텍
 * @version 1.0
 * @see
 *
 *  Copyright (C) by woorim All right reserved.
 */
@Controller
public class TranCalculateController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	

	@Autowired
	TransTsaleService calService;
	
	/**
	 * 정산조회 페이지 호출 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping(value="/calculate/calculateForm.do")
	 public String calculateForm(
  			HttpServletRequest pRequest, 
 				HttpServletResponse pResponse, 
	  		@RequestParam Map<String, Object> pRequestParamMap,
	  		ModelMap model) throws Exception {		

		  	log.info("===========================================");
		  	log.info("======  calculateForm ======");
		  	log.info("===========================================");
		  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		  	printRequest(pRequest);
		  	log.info("===========================================");
		  	//----------------------------------------------------------------
		  	// Login check
		  	//----------------------------------------------------------------
		  	
		  	String sssddd =calService.selectKoreaLvCdChage("00");
			log.info("===========================================");
		  	log.debug("sddd ["+sssddd+"]");
		  	 return "/tran/calculate/CalculateForm";
		  	
	 }
	 
	 
	 	/**
	 	 *  목록 조회 
	 	 * @param pRequest
	 	 * @param pResponse
	 	 * @param pRequestParamMap
	 	 * @param model
	 	 * @return
	 	 */
	 	@RequestMapping(value="/trans/calcList.json")
		public String saleList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  saleList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PageableTO pageTo = new PageableTO();
			int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
			int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
			pageTo.setCurrentPage(currentPage);
			pageTo.setPageSize(pageSize);
			
			
			try{
				
				/* List<?> resultList = (List<?>)tSaleService.selectSearchTsaleListPageAble(pRequestParamMap); 
				
				int total = resultList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(resultList.size()+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
	 		  	int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			
	 		 	pageTo.setTotalPages(totalPage);
				
				model.addAttribute("list", resultList);*/
			} catch (Exception e) {
				 	resultMap.clear();
				if (!getErrReturn(e, (Map<String, Object>) resultMap)) {
					logger.error(e);
				}
			}
			
			model.addAttribute("page",pageTo );
		 return "jsonView";
		}	 	
	 	

	 	/**
	 	 * 파일업로드 처리 
	 	 * @param pRequest
	 	 * @param pResponse
	 	 * @param multi
	 	 * @param pRequestParamMap
	 	 * @param model
	 	 * @return
	 	 */
	 	@RequestMapping(value="/calculate/saveFileProc.json")
		public String saveCalculateFileProc(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
				MultipartHttpServletRequest multi,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model
	 	
				)
		{

			printRequest(pRequest);

			long startTime = System.currentTimeMillis();
			pRequestParamMap = calService.saveFileProc(pRequest, multi);
			long endTime = System.currentTimeMillis();
			String resultTime =  ( endTime - startTime )/1000.0f+"초";
			
			printRequest(pRequest);
			
			model.addAttribute("resultTime" ,resultTime);
			model.addAttribute("orginFileName" ,pRequestParamMap.get("orginFileName"));
			model.addAttribute("dataCnt" ,pRequestParamMap.get("dataCnt").toString());
			model.addAttribute("totCnt" ,pRequestParamMap.get("totCnt").toString());
			model.addAttribute("fileSize" ,pRequestParamMap.get("fileSize").toString());
			
			model.addAttribute("saleDate" ,pRequestParamMap.get("sale_date").toString());
			model.addAttribute("cmpCd" ,pRequestParamMap.get("cmpCd").toString());
			model.addAttribute("yCNT" ,pRequestParamMap.get("yCNT").toString());
			model.addAttribute("nCNT" ,pRequestParamMap.get("nCNT").toString());
			model.addAttribute("yQTY" ,pRequestParamMap.get("yQTY").toString());
			model.addAttribute("nQTY" ,pRequestParamMap.get("nQTY").toString());
			model.addAttribute("yAMT" ,pRequestParamMap.get("yAMT").toString());
			model.addAttribute("nAMT" ,pRequestParamMap.get("nAMT").toString());
			
			
			 return "jsonView";
		}
	 
	 	
	 	
	 	/**
	 	 * 정산자료 세부내역리스트폼 호출 
	 	 * @param pRequest
	 	 * @param pResponse
	 	 * @param pRequestParamMap
	 	 * @param model
	 	 * @return
	 	 * @throws Exception
	 	 */
	 	 @RequestMapping(value="/calculate/calculateDetailListForm.do")
		 public String calculateDetailListForm(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

			  	log.info("===========================================");
			  	log.info("======  calculateDetailListForm ======");
			  	log.info("===========================================");
			  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			  	printRequest(pRequest);
			  	log.info("===========================================");
			  	//----------------------------------------------------------------
			  	// Login check
			  	//----------------------------------------------------------------
			  	
			  	if( pRequestParamMap.get("searchSaleDate")!=null && !StringUtils.isEmpty(pRequestParamMap.get("searchSaleDate").toString())){
			  		model.addAttribute("searchSaleDate", pRequestParamMap.get("searchSaleDate").toString());
			  		
			  	}
			  	
			  	  
			  	
			  	 return "/tran/calculate/CalculateDetailList";
			  	
		 }
	 	 
	 	 /**
	 	  * 정산자료 세부내역 리스트 조회 
	 	  * @param pRequest
	 	  * @param pResponse
	 	  * @param pRequestParamMap
	 	  * @param model
	 	  * @return
	 	  */
	 	@RequestMapping(value="/trans/calcLogDetailList.json")
		public String calcLogDetailList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  calcLogDetailList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PageableTO pageTo = new PageableTO();
			int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
			int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
			pageTo.setCurrentPage(currentPage);
			pageTo.setPageSize(pageSize);
			
			HttpSession httpSession = pRequest.getSession();
			
			String cmp_code =  (String) httpSession.getAttribute("SESSION_CMP_CODE");
			
			if(!cmp_code.equals("0000000001")){
				pRequestParamMap.put("searchCmpCode", cmp_code);
			}
			
			
			
			try{
				
				List<?> resultList = (List<?>)calService.selectEpisTsaleSvcLogSearch(pRequestParamMap); 
				
				int total = resultList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(resultList.size()+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
	 		  	int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			
	 		 	pageTo.setTotalPages(totalPage);
				
				model.addAttribute("list", resultList);
				
			} catch (Exception e) {
				 	resultMap.clear();
				if (!getErrReturn(e, (Map<String, Object>) resultMap)) {
					logger.error(e);
				}
			}
			
			model.addAttribute("page",pageTo );
		 return "jsonView";
		}	 	
	 	
	 		
		 /**
		  * 전송현황
		  * @param pRequest
		  * @param pResponse
		  * @param pRequestParamMap
		  * @param model
		  * @return
		  * @throws Exception
		  */
 	 	@RequestMapping(value="/calculate/calculateListForm.do")
		 public String calculateListForm(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

			  	log.info("===========================================");
			  	log.info("======  calculateListForm ======");
			  	log.info("===========================================");
			  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			  	printRequest(pRequest);
			  	log.info("===========================================");
			  	//----------------------------------------------------------------
			  	// Login check
			  	//----------------------------------------------------------------
			  	
			  	
			  	  
			  	
			  	 return "/tran/calculate/CalculateList";
			  	
		 }
 	 	
 	 	/**
 	 	 * 전송현황 조회
 	 	 * @param pRequest
 	 	 * @param pResponse
 	 	 * @param pRequestParamMap
 	 	 * @param model
 	 	 * @return
 	 	 */
 	 	@RequestMapping(value="/trans/calcLogResultList.json")
		public String calcResultList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  calcResultList ======");
			log.info("===========================================");
			log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			printRequest(pRequest);
			log.info("===========================================");
			 
			 
			//----------------------------------------------------------------
			// Login check
			//----------------------------------------------------------------
			Map<String, Object> resultMap = new HashMap<String, Object>();
			PageableTO pageTo = new PageableTO();
			int currentPage =	Integer.parseInt(pRequestParamMap.get("pageNumber").toString());
			int pageSize = Integer.parseInt(pRequestParamMap.get("pageSize").toString());
			pageTo.setCurrentPage(currentPage);
			pageTo.setPageSize(pageSize);
			
			HttpSession httpSession = pRequest.getSession();
			
			String cmp_code =  (String) httpSession.getAttribute("SESSION_CMP_CODE");
			
			if(!cmp_code.equals("0000000001")){
				pRequestParamMap.put("searchCmpCode", cmp_code);
			}
			
			try{
				
				List<?> resultList = (List<?>)calService.selectEpisTsaleSvcLogResultListSearch(pRequestParamMap); 
				
				int total = resultList.size();
	 		 	
	 		  	Long totalLong = Long.parseLong(resultList.size()+"");
	 		  	pageTo.setTotalElements(totalLong);
	 		  
	 		  	int totalPage= total/pageSize + (total%pageSize == 0?0:1);
			
	 		 	pageTo.setTotalPages(totalPage);
				
				model.addAttribute("list", resultList);
				
			} catch (Exception e) {
				 	resultMap.clear();
				if (!getErrReturn(e, (Map<String, Object>) resultMap)) {
					logger.error(e);
				}
			}
			
			model.addAttribute("page",pageTo );
		 return "jsonView";
		}
 	 	
 	 	/**
 	 	 * 화훼공판장 자료전송 처리 테스트 
 	 	 * @param pRequest
 	 	 * @param pResponse
 	 	 * @param pRequestParamMap
 	 	 * @param model
 	 	 * @return
 	 	 * @throws Exception
 	 	 */
 	 	@RequestMapping(value="/calculateWebService.do")
		 public String calculateWebserviceForm(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

			  	log.info("===========================================");
			  	log.info("======  calculateWebserviceForm ======");
			  	log.info("===========================================");
			  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			  	printRequest(pRequest);
			  	log.info("===========================================");
			  	//----------------------------------------------------------------
			  	// Login check
			  	//----------------------------------------------------------------
			  	String filename = pRequestParamMap.get("filename").toString();
				String recode = pRequestParamMap.get("recode").toString();
				log.info("===========================================");
			  	log.info(">>>>  1 filename : " +pRequestParamMap.get("filename").toString());
			  	log.info(">>>>  1 recode : " +pRequestParamMap.get("recode").toString());
			  	/**String a2 = new String(pRequestParamMap.get("recode").toString().getBytes("MS949"),"UTF-8"); 
			  	String a3 = new String(pRequestParamMap.get("recode").toString().getBytes("UTF-8"),"MS949"); 
			  	String a4 = new String(pRequestParamMap.get("recode").toString().getBytes("EUC-KR"),"UTF-8"); 
				String a5 = new String(pRequestParamMap.get("recode").toString().getBytes("ISO-8859-1"),"UTF-8"); 
			  	log.info(">>>>  1 a2 : " +a2);
			  	log.info(">>>>  1 a3 : " +a3);
				log.info(">>>>  1 a4 : " +a4);
				log.info(">>>>  1 a5 : " +a5);**/ 
					log.info("===========================================");
			  	
						 
					Map<String, Object> reqMap = new HashMap<String, Object>();
						reqMap.put("filename", filename);
						reqMap.put("recode", recode);
					log.info("===========================================");
			  	log.info(">>>>  2 reqMap : " +reqMap.toString());
					log.info("===========================================");
				log.info("===========================================");
			  	log.info(">>>>  2 reqMap filename : " +reqMap.get("filename").toString());
			  	log.info(">>>>  2 reqMap recode: " +reqMap.get("recode").toString());
					log.info("===========================================");	
					reqMap =	calService.serviceProc(filename,recode);
					
					
						
					log.info("===========================================");
					log.info(">>>>  after reqMap : " +reqMap.toString());
					log.info("===========================================");
					
				model.addAttribute("filename",filename );
				model.addAttribute("recode",recode );
			  	
			  	
			  	
			  	
			  	  
			  	
			  	 return "/tran/mem01/test";
			  	
		 }
		  
 	 	@RequestMapping(value="/calculateWebServiceTest.do")
		 public String calculateWebserviceTestForm(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

				Map<String, Object> reqMap = new HashMap<String, Object>();	 


					if(pRequestParamMap.get("requestSn").toString().equals("magam")){
						reqMap =	calService.serviceMagam(pRequestParamMap);
					}else{
						
				  	String filename = pRequestParamMap.get("filename").toString();
					String recode = pRequestParamMap.get("recode").toString();

					/*String originalStr = recode; 
					recode = new String(originalStr.getBytes("iso-8859-1"), "utf-8");
					*/
					pRequestParamMap.put("filename", filename);
					pRequestParamMap.put("recode", recode);
						
						reqMap.put("filename", filename);
						reqMap.put("recode", recode);
					reqMap =	calService.serviceProc(filename,recode);
					
					 model.addAttribute("filename",filename );
					 model.addAttribute("recode",recode );
					}

				
			  	
			  	
			  	
			  	
			  	  
			  	
			  	 return "/tran/mem01/test";
			  	
		 }
 	 	
 	 	@RequestMapping(value="/calculateWebServiceTestDelete.do")
		 public String calculateWebserviceTestDelete(
	  			HttpServletRequest pRequest, 
	 				HttpServletResponse pResponse, 
		  		@RequestParam Map<String, Object> pRequestParamMap,
		  		ModelMap model) throws Exception {		

			  	log.info("===========================================");
			  	log.info("======  calculateWebserviceTestForm ======");
			  	log.info("===========================================");
			  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
			  	printRequest(pRequest);
			  	log.info("===========================================");
			  	//----------------------------------------------------------------
			  	// Login check
			  	//----------------------------------------------------------------
				String saleDate = pRequestParamMap.get("saleDate").toString();
				String compCode ="0000000001";
				
				pRequestParamMap.put("originFileName", ""+compCode+saleDate+".txt");
				pRequestParamMap.put("v_sale_date", saleDate);
				pRequestParamMap.put("v_cmp_code", compCode);
				pRequestParamMap.put("retMessage", "");
				pRequestParamMap.put("intprocesscnt", "");
				
				calService.deleteTsaleAllByDate(pRequestParamMap);
				
				
 	 			
			  	return "/tran/mem01/test";	
 	 	}
 	 	

}
