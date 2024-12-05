package com.fpdisys.dist.real.controller;

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

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.real.domain.RealVO;
import com.fpdisys.dist.real.service.RealService;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class RealController extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Autowired
	private RealService realService;
		
	@RequestMapping(value="/real/real2.do")
	public String flowerMain2(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){
		 
		 return "/auction/Real02";
	}
	
	
	@RequestMapping(value="/real/saveReal.json")
	public String saveCustomInfo(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		realService.saveRealData(pRequestParamMap);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/saveSaleData.json")
	public String saveSaleData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		realService.saveSaleData(pRequestParamMap);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/saveNonghyup.json")
	public String saveNonghyup(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		realService.saveNonghyup(pRequestParamMap);
		
		return "jsonView";
	 }
	
	@RequestMapping(value="/real/getRealData.json")
	public String getRealData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		String cmpCd 	= (String) pRequestParamMap.get("cmpCd");
		String flowerCd = (String) pRequestParamMap.get("flowerCd");
		String itemCd 	= (String) pRequestParamMap.get("itemCd");
		
		log.info("1=====================");
		log.info("1======"+cmpCd+"=====");
		log.info("1======"+flowerCd+"==============");
		log.info("1======"+itemCd+"=========");
		log.info("1=====================");
		
		List<RealVO> list = realService.getRealData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	 }
	
	@RequestMapping(value="/real/getRealData1.json")
	public String getRealData1(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = realService.getRealData1(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	 }
	
	@RequestMapping(value="/real/getRealMainData.json")
	public String getRealMainData(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		List<RealVO> list = realService.getRealMainData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	 }
	
	@RequestMapping(value="/real/getSaleDate.json")
	public String getSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		String searchCmpCd 	= (String) pRequestParamMap.get("searchCmpCd");
		String searchProductGubun = (String) pRequestParamMap.get("searchProductGubun");
		
		log.info("2=====================");
		log.info("2======"+searchCmpCd+"=====");
		log.info("2======"+searchProductGubun+"==============");
		log.info("2=====================");
		
		List<RealVO> list  =  (List<RealVO>)realService.getRealSaleData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/getPumNameDate.json")
	public String getPumNameDate(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		List<EgovMap> list  =  (List<EgovMap>)realService.getRealPumNameData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/getRealSilData.json")
	public String getRealSilData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		String cmpCd 	= (String) pRequestParamMap.get("cmpCd");
		String flowerCd = (String) pRequestParamMap.get("flowerCd");
		String itemCd 	= (String) pRequestParamMap.get("itemCd");
		
		log.info("4=====================");
		log.info("4======"+cmpCd+"=====");
		log.info("4======"+flowerCd+"==============");
		log.info("4======"+itemCd+"=========");
		log.info("4=====================");
		
		List<RealVO> list = realService.getRealSilData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/getRealLvData.json")
	public String getRealLvData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		List<RealVO> list = realService.getRealLvData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/real/getRealInforData.json")
	public String getRealInforData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		List<RealVO> list = realService.getRealInforData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		
	}
	
	@RequestMapping(value="/real/getRealchartData.json")
	public String getRealchartData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {	
		
		List<RealVO> list = realService.getRealchartData(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		
	}
	
	@RequestMapping(value="/flowerMain/flowerMain_SubRealSearch.do")
	public String flowerMain_SubSearchMonth(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
  		
		log.info("=========flowerMain_SubRealMonth==============="+pRequestParamMap.toString());			
		log.info("==========lmhlmh==============");
		 
		return "/flowerMain/flowerMain_SubRealSearch";
	}
}
