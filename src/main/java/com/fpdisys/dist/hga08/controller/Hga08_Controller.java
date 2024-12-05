package com.fpdisys.dist.hga08.controller;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.hga08.service.Hga08_Service;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


@Controller
public class Hga08_Controller extends BaseController{

	protected Log log = LogFactory.getLog(this.getClass());

	@Autowired
	protected MessageSource messageSource;

	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Autowired
	private Hga08_Service hga08_Service;

	@RequestMapping(value="/hga08/hga08.do")
	public String selectHaa00(HttpServletRequest pRequest, HttpServletResponse pResponse, @RequestParam Map<String, Object> pRequestParamMap ,ModelMap model){
		return "/auction/Hga08";
	}
	
	
	
	/**
 	 * 통합거래동향 호출
 	 * @param pRequest
 	 * @param pResponse
 	 * @param pRequestParamMap
 	 * @param model
 	 * @return
 	 */
 	@RequestMapping(value="/hga08/selectHga08ChartJson1.json")
	public String selectHga08ChartJson1(HttpServletRequest pRequest,HttpServletResponse pResponse
			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		try{
	 		List<EgovMap> list = hga08_Service.selectHga08ChartJson1(pRequestParamMap);
	 		list.add(new EgovMap()); // JS로 전달될때 어째선지 마지막 요소가 하나 사라짐. 빈 값을 추가하여 온전히 전달될 수 있도록 변경
			model.addAttribute("list",list);
 		} catch(Exception e){
 			e.printStackTrace();
 		}
		return "jsonView";
	}
 	@RequestMapping(value="/hga08/selectHga08ChartJson2.json")
 	public String selectHga08ChartJson2(HttpServletRequest pRequest,HttpServletResponse pResponse
 			,@RequestParam Map<String, Object> pRequestParamMap,ModelMap model){
 		try{
	 		List<EgovMap> list = hga08_Service.selectHga08ChartJson2(pRequestParamMap);
	 		
 			for(int i=0; i<list.size(); i++){
 				if(list.get(i).get("location").toString().equals("전국")){
 					EgovMap etc = new EgovMap();
 					for(Object k : list.get(i).keySet()){
 						etc.put(k.toString(), list.get(i).get(k));
 					}
 					list.remove(i);
 					list.add(0, etc);
 					break;
 				}
 			}
			
	 		model.addAttribute("list",list);
	 		
	 		
		} catch(Exception e){
 			e.printStackTrace();
 		}
 		return "jsonView";
 	}
}
