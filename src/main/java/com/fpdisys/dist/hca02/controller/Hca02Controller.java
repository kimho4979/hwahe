package com.fpdisys.dist.hca02.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InterruptedIOException;
import java.util.List;
import java.util.Map;

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

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.hca02.domain.Hca02VO;
import com.fpdisys.dist.hca02.service.Hca02Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Hca02Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());		
	
	@Autowired  
	protected MessageSource messageSource;  
	
	protected EgovPropertyService propertyService;
			
	@Autowired
	Hca02Service hca02Service;
	
	
	@RequestMapping(value="/hca02/hca02.do")
	public String selectView(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
			
			pRequestParamMap.put("initFlag", "T");
			PaginationInfo paginationInfo = new PaginationInfo();
			try{
					
				List<Hca02VO> selectHca02 = (List<Hca02VO>)hca02Service.selectHca02(pRequestParamMap, paginationInfo);
				if(!selectHca02.isEmpty()){					
				
					if(paginationInfo != null){					
						
						Hca02VO data = (Hca02VO)selectHca02.get(0);
						
						paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
					}
				
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
				
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("selectHca02", selectHca02);
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
			
			return "/auction/Hca02";
	}
	
	 @RequestMapping(value="/hca02/hca02Select.do")
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
					
				List<Hca02VO> selectHca02 = (List<Hca02VO>)hca02Service.selectHca02(pRequestParamMap, paginationInfo);
				if(!selectHca02.isEmpty()){					
				
					if(paginationInfo != null){					
						
						Hca02VO data = (Hca02VO)selectHca02.get(0);
						
						paginationInfo.setTotalRecordCount(Integer.parseInt(data.getTOTAL_COUNT()));
					}
				
				}else{
					paginationInfo.setTotalRecordCount(0);
				}
					
				model.addAttribute("paginationInfo", paginationInfo);
				model.addAttribute("selectHca02", selectHca02);
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
			
			return "/auction/Hca02";
	}
	 
/*	 @RequestMapping(value="/hca02/selectGridList.json")
		public String selectGridList(
				HttpServletRequest pRequest, 
				HttpServletResponse pResponse,
				HttpSession  session,
		 		@RequestParam Map<String, Object> pRequestParamMap,
		 		ModelMap model)
		{		 						
	  if(pRequestParamMap.get("item_cd")!=null){
				session.setAttribute("SESSION_ITEM_CD", pRequestParamMap.get("item_cd").toString());
			} 
	  	log.info("gridListgridListgridListgridList++++++++"+pRequestParamMap.toString());
			Map<String, Object> resultMap = new HashMap<String, Object>();
			
			try{
				List<EgovMap> resultList  =  (List<EgovMap>)hca02Service.selectGridList(pRequestParamMap);				
				
				model.addAttribute("list", resultList);
			
			} catch (Exception e) {
				 	e.printStackTrace();
			}														
			 return "jsonView";
		}*/
	
}