package com.fpditrans.trans.cmmn.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpditrans.base.mvc.BaseController;
import com.fpditrans.base.mvc.PageableTO;
import com.fpditrans.trans.cmmn.service.TLocalService;

import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * @Class Name : LocalCodeController.java
 * @Description : LocalCodeController Class
 *	 
 * @산지코드  콘트롤러
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
public class LocalCodeController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired  
	TLocalService tLocalService;
	
	/**
	 * 산지코드  조회페이지 호출 
	 * @param pRequest
	 * @param pResponse
	 * @param pRequestParamMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping(value="/code/LocalCodeListForm.do")
	 public String LocalCodeListForm(
  			HttpServletRequest pRequest, 
 				HttpServletResponse pResponse, 
	  		@RequestParam Map<String, Object> pRequestParamMap,
	  		ModelMap model) throws Exception {		

		  	log.info("===========================================");
		  	log.info("======  LocalCodeListForm ======");
		  	log.info("===========================================");
		  	log.info(">>>>pRequestParamMap.toString() : " + pRequestParamMap.toString());
		  	printRequest(pRequest);
		  	log.info("===========================================");
		  	//----------------------------------------------------------------
		  	// Login check
		  	//----------------------------------------------------------------
		  	
		  	
		  	 return "/tran/code/LocalCodeList";
		  	
	 }
	 
	 
		/**
	 	 *  산지코드 목록 조회 
	 	 * @param pRequest
	 	 * @param pResponse
	 	 * @param pRequestParamMap
	 	 * @param model
	 	 * @return
	 	 */
	 	@RequestMapping(value="/code/LocalCodeList.json")
		public String getLocalCodeList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{
		 
		 log.info("===========================================");
			log.info("======  getLocalCodeList ======");
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
				
				List<?> resultList = (List<?>)tLocalService.selectSanListSearch(pRequestParamMap); 
				
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


}