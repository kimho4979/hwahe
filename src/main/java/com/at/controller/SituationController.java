package com.at.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.at.domain.SituationVO;
import com.at.service.aTService;
import com.fpdisys.admin.data.service.ConfigService;
import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.main.service.MainService;

import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class SituationController extends BaseController{

protected Log log = LogFactory.getLog(this.getClass());	
	
	@Autowired  
	protected MessageSource messageSource;  
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	@Autowired
	private MainService mainService;
	
	@Autowired
	aTService aTService;
	
	@Autowired
	private ConfigService configService;
	

	@RequestMapping(value="/situation/situation.do")
	public String situation(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {			 
		
		String userIp=pRequest.getRemoteHost();
		String returnUrl="/situation/situation";
		if (userIp.equals("0:0:0:0:0:0:0:1")) {
			userIp = "127.0.0.1";
		}
		
		Map<String,Object> pRequestParam = new HashMap<String,Object>(); 
		pRequestParam.put("IP", "상황판IP");
		List<Map<String,Object>> configIpList =  configService.selectConfig(pRequestParam);
		boolean ipcnt = false;
		for(Map<String,Object> map : configIpList) {
			if(userIp!=null&&(
				//userIp.equals("127.0.0.1") 
				 //userIp.equals("1.227.107.235") // 상황판 접근 아이피 23.12.20  
				//|| userIp.equals("211.218.243.205")  
				//|| userIp.equals("222.106.144.54")  
				//|| userIp.equals("115.89.203.83"))) {
				userIp.equals(map.get("CONFIG_VAL").toString()))) {
				returnUrl="/situation/situation";
				ipcnt = true;
				
				// grid 데이터
				List<SituationVO> resultList = aTService.selectSituation(pRequestParamMap);	
				model.addAttribute("resultList", resultList);		
				
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.");

				model.addAttribute("dateTxt", sdf.format(d) + " 현재");		
				
				// chart 데이터
				JSONArray jArray = new JSONArray();//배열이 필요할때
				
				int totalPlan=0;
				int totalPan=0;
				int totalFive=0;
				int totalBefore=0;
				
				
				for (int i = 0; i < resultList.size(); i++)//배열
				{
					JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
					sObject.put("month", resultList.get(i).getMonth());
					
					sObject.put("plan_sum", resultList.get(i).getPlan_sum());
					totalPlan += Integer.parseInt(resultList.get(i).getPlan_sum());
					sObject.put("pan_sum", resultList.get(i).getPan_sum());
					totalPan += Integer.parseInt(resultList.get(i).getPan_sum());
					sObject.put("five_year_avg", resultList.get(i).getFive_year_avg());
					totalFive += Integer.parseInt(resultList.get(i).getFive_year_avg());
					sObject.put("before_year_avg", resultList.get(i).getBefore_year_avg());
					totalBefore += Integer.parseInt(resultList.get(i).getBefore_year_avg());
					
					jArray.add(sObject);
				}
				
				JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
				sObject.put("month", "누계");
				sObject.put("plan_sum", totalPlan);
				sObject.put("pan_sum", totalPan);
				sObject.put("five_year_avg", totalFive);
				sObject.put("before_year_avg", totalBefore);		
				jArray.add(sObject);		

				model.addAttribute("list", jArray.toJSONString());				
				
			  	return "/situation/situation";
			} else {
				ipcnt = false;
			}
		}
		
		//if(ipcnt) {
			//returnUrl="/situation/situation";
		//} else {
			//return "redirect:/main/flowerMain.do";
		//}

		return "redirect:/main/flowerMain.do";
	 }
	
	@RequestMapping(value="/situation/situation02.do")
	public String situation02(HttpServletRequest pRequest, HttpServletResponse pResponse,
	 		@RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {
		
		String userIp=pRequest.getRemoteHost();
		String returnUrl="/situation/situation";
		if (userIp.equals("0:0:0:0:0:0:0:1")) {
			userIp = "127.0.0.1";
		}
		Map<String,Object> pRequestParam = new HashMap<String,Object>(); 
		pRequestParam.put("IP", "상황판IP");
		List<Map<String,Object>> configIpList =  configService.selectConfig(pRequestParam);
		boolean ipcnt = false;
		for(Map<String,Object> map : configIpList) {
			if(userIp!=null&&(
				//userIp.equals("127.0.0.1") 
				 //userIp.equals("1.227.107.235") // 상황판 접근 아이피 23.12.20  
				//|| userIp.equals("211.218.243.205")  
				//|| userIp.equals("222.106.144.54")  
				//|| userIp.equals("115.89.203.83"))) {
				userIp.equals(map.get("CONFIG_VAL").toString()))) {
				returnUrl="/situation/situation02";
				ipcnt = true;
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.");
		
				model.addAttribute("dateTxt", sdf.format(d) + " 현재");		
				// 오늘일자
				List<SituationVO> resultList1 = aTService.selectSituation1(pRequestParamMap);	
				
				// chart 데이터
				if( resultList1.size()==0){
					model.addAttribute("list1", "[]");
					model.addAttribute("list2", "[]");
					model.addAttribute("list3", "[]");
				}
				for (int i = 0; i < resultList1.size(); i++)//배열
				{
					String rank = resultList1.get(i).getBun_chk_rank();
					if(rank.equals("1")){
						// 절화
						model.addAttribute("resultList1", resultList1.get(i));
						
						JSONArray jArray = new JSONArray();//배열이 필요할때
						JSONObject sObject = new JSONObject();
						sObject.put("pan_day", resultList1.get(i).getBef_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getBef_tot_sok());
						sObject.put("tot_price", resultList1.get(i).getBef_tot_price());
						//jArray.add(sObject);
						jArray.add(sObject);
						
						
						sObject = new JSONObject();//배열 내에 들어갈 json
						sObject.put("pan_day", resultList1.get(i).getPan_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getTot_sok());
						sObject.put("tot_price", resultList1.get(i).getTot_price());
						//jArray.add(sObject);
						jArray.add(sObject);
						
						if(jArray.isEmpty()){
							model.addAttribute("list1","[]");
						}else{
							model.addAttribute("list1", jArray.toJSONString());
						}
						
					}else if(rank.equals("2")){
						// 난, 춘란
						model.addAttribute("resultList2", resultList1.get(i));
						
						JSONArray jArray = new JSONArray();//배열이 필요할때
						
						JSONObject sObject = new JSONObject();
						sObject.put("pan_day", resultList1.get(i).getBef_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getBef_tot_sok());
						sObject.put("tot_price", resultList1.get(i).getBef_tot_price());
						//jArray.add(sObject);
						jArray.add(sObject);
						
						sObject = new JSONObject();
						sObject.put("pan_day", resultList1.get(i).getPan_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getTot_sok());
						sObject.put("tot_price", resultList1.get(i).getTot_price());
						jArray.add(sObject);
						
						if(jArray.isEmpty()){
							model.addAttribute("list2", "[]");
						}else{
							model.addAttribute("list2", jArray.toJSONString());
						}
					}else{
						// 관엽
						model.addAttribute("resultList3", resultList1.get(i));
						
						JSONArray jArray = new JSONArray();//배열이 필요할때
						JSONObject sObject = new JSONObject();
						sObject.put("pan_day", resultList1.get(i).getBef_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getBef_tot_sok());
						sObject.put("tot_price", resultList1.get(i).getBef_tot_price());
						//jArray.add(sObject);
						jArray.add(sObject);
						
						sObject = new JSONObject();
						sObject.put("pan_day", resultList1.get(i).getPan_day());
						sObject.put("bun_chk", resultList1.get(i).getBun_chk());
						sObject.put("bun_chk_rank", resultList1.get(i).getBun_chk_rank());
						sObject.put("tot_sok", resultList1.get(i).getTot_sok());
						sObject.put("tot_price", resultList1.get(i).getTot_price());
						jArray.add(sObject);
						
						if(jArray.isEmpty()){
							model.addAttribute("list3", "[]");
						}else{
							model.addAttribute("list3", jArray.toJSONString());
						}					
					}
				}
				
				if(model.get("list1")==null){
					model.addAttribute("list1", "[]");
				}
				
				if(model.get("list2")==null){
					model.addAttribute("list2", "[]");
				}
				
				if(model.get("list3")==null){
					model.addAttribute("list3", "[]");
				}
			  	return "/situation/situation02";
			} else {
				ipcnt = false;
			}
		}
		
		//if(ipcnt) {
			//returnUrl="/situation/situation02";
		//} else {
			//return "redirect:/main/flowerMain.do";
		//}		
		
		return "redirect:/main/flowerMain.do";
	 }
	
	/*@RequestMapping(value="/situation/situation03.do")
	public String situation03(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {			 
		
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.");

		model.addAttribute("dateTxt", sdf.format(d) + " 현재");
		
		sdf = new SimpleDateFormat("yyyy년 MM월");

		model.addAttribute("dateTxt1", sdf.format(d));		
		
		// grid 데이터
		List<SituationVO> resultList = aTService.selectSituation2(pRequestParamMap);	
		model.addAttribute("resultList", resultList);		
				
		// chart 데이터
		JSONArray jArray = new JSONArray();//배열이 필요할때
		
		int totalPlan=0;
		int totalPan=0;
		int totalFive=0;
		int totalBefore=0;
		
		for (int i = 0; i < resultList.size(); i++)//배열
		{
			JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
			sObject.put("yyyymm", resultList.get(i).getYyyymm());
			
			sObject.put("bun_chk_name", resultList.get(i).getBun_chk_name());
			
			sObject.put("plan", resultList.get(i).getPlan());
			sObject.put("pan_sum", resultList.get(i).getPan_sum());
			sObject.put("sum_plan", resultList.get(i).getSum_plan());
			sObject.put("sum_pan", resultList.get(i).getSum_pan());
			sObject.put("plan_year_sum", resultList.get(i).getPlan_year_sum());

			sObject.put("plan_per", resultList.get(i).getPlan_per());
			sObject.put("sum_per", resultList.get(i).getSum_per());
			
			jArray.add(sObject);
		}
		
		if(jArray.isEmpty()){
			model.addAttribute("list", "[]");
		}else{
			model.addAttribute("list", jArray.toJSONString());	
		}		
					
		
		
	  	return "/situation/situation03";
		  	
	 }*/
	
	@RequestMapping(value="/situation/situation03.do")
	public String situation03(
 			HttpServletRequest pRequest, 
				HttpServletResponse pResponse, 
	 		@RequestParam Map<String, Object> pRequestParamMap,
	 		ModelMap model) {		
		
		String userIp=pRequest.getRemoteHost();
		String returnUrl="/situation/situation";
		if (userIp.equals("0:0:0:0:0:0:0:1")) {
			userIp = "127.0.0.1";
		}
		Map<String,Object> pRequestParam = new HashMap<String,Object>(); 
		pRequestParam.put("IP", "상황판IP");
		List<Map<String,Object>> configIpList =  configService.selectConfig(pRequestParam);
		boolean ipcnt = false;
		for(Map<String,Object> map : configIpList) {
			if(userIp!=null&&(
				//userIp.equals("127.0.0.1") 
				 //userIp.equals("1.227.107.235") // 상황판 접근 아이피 23.12.20  
				//|| userIp.equals("211.218.243.205")  
				//|| userIp.equals("222.106.144.54")  
				//|| userIp.equals("115.89.203.83"))) {
				userIp.equals(map.get("CONFIG_VAL").toString()))) {
				returnUrl="/situation/situation03";
				ipcnt = true;
				Date d = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd.");

				model.addAttribute("dateTxt", sdf.format(d) + " 현재");
				
				sdf = new SimpleDateFormat("yyyy년 MM월");

				model.addAttribute("dateTxt1", sdf.format(d));		
				
				// grid 데이터
				List<SituationVO> resultList = aTService.selectSituation2(pRequestParamMap);	
				model.addAttribute("resultList", resultList);		
						
				// chart 데이터
				JSONArray jArray = new JSONArray();//배열이 필요할때
				
				int totalPlan=0;
				int totalSumPan=0;
				int totalSumPlan=0;
				int totalPanSum=0;
				int totalPlanYearSum=0;
				
				
				for (int i = 0; i < resultList.size(); i++)//배열
				{
					JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
					sObject.put("yyyymm", resultList.get(i).getYyyymm());
					
					sObject.put("bun_chk_name", resultList.get(i).getBun_chk_name());
					
					sObject.put("plan", resultList.get(i).getPlan());
					totalPlan += Integer.parseInt(resultList.get(i).getPlan());
					
					sObject.put("pan_sum", resultList.get(i).getPan_sum());
					totalPanSum += Integer.parseInt(resultList.get(i).getPan_sum());
					
					sObject.put("sum_plan", resultList.get(i).getSum_plan());
					totalSumPlan += Integer.parseInt(resultList.get(i).getSum_plan());
					
					sObject.put("sum_pan", resultList.get(i).getSum_pan());
					totalSumPan += Integer.parseInt(resultList.get(i).getSum_pan());
					
					sObject.put("plan_year_sum", resultList.get(i).getPlan_year_sum());
					totalPlanYearSum += Integer.parseInt(resultList.get(i).getPlan_year_sum());
					
					sObject.put("plan_per", resultList.get(i).getPlan_per());
					sObject.put("sum_per", resultList.get(i).getSum_per());
					
					jArray.add(sObject);
				}
					
					JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
					double totalPlanPer = (double)totalPanSum/(double)totalPlan * 100;
					double totalSumPer = (double)totalSumPan/(double)totalSumPlan * 100;
					
					sObject.put("bun_chk_name", "누계");
					sObject.put("plan", totalPlan);
					sObject.put("pan_sum", totalPanSum);
					sObject.put("sum_plan", totalSumPlan);
					sObject.put("sum_pan", totalSumPan);		
					sObject.put("plan_year_sum", totalPlanYearSum);		
					sObject.put("plan_per", (int)totalPlanPer);		
					sObject.put("sum_per", (int)totalSumPer);		
					jArray.add(sObject);
				
				if(jArray.isEmpty()){
					model.addAttribute("list", "[]");
				}else{
					model.addAttribute("list", jArray.toJSONString());	
				}
				
				
				SimpleDateFormat simpleformat = new SimpleDateFormat("MM");
				String strMonth = simpleformat.format(new Date());
				
				String panSum = "0";
				int panSumTotal = 0;
				List<SituationVO> tempResult = aTService.selectSituation(pRequestParamMap);
				if(tempResult != null && tempResult.size() > 0){
					for(SituationVO temp : tempResult){
						if(temp.getPan_sum() != null && !"".equals(temp.getPan_sum())){
							if(strMonth.equals(temp.getMonth())){
								panSum = temp.getPan_sum();
							}
							panSumTotal += Integer.parseInt(temp.getPan_sum());
						}
					}
				}
				model.addAttribute("panSum", panSum);
				model.addAttribute("panSumTotal", String.valueOf(panSumTotal));
							
				
				
			  	return "/situation/situation03";

			} else {
				ipcnt = false;
			}
		}
		
		//if(ipcnt) {
			//returnUrl="/situation/situation03";
		//} else {
			//return "redirect:/main/flowerMain.do";
		//}
		
		return "redirect:/main/flowerMain.do";	  	
	 }
	
	
}
