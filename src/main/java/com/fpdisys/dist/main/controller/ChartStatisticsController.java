package com.fpdisys.dist.main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;







import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fpdisys.base.mvc.BaseController;
import com.fpdisys.dist.main.service.ChartStatisticsService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ChartStatisticsController extends BaseController {

	@Autowired
	private ChartStatisticsService chartStatisticsService;
	
	
	@RequestMapping(value="/chart/getPumMokSaledate.json")
	public String getPumMokSaledate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
 			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		List<EgovMap> searchFlowerGubunList  =  (List<EgovMap>)chartStatisticsService.selectSearchFlowerGubun(pRequestParamMap);
		model.addAttribute("searchFlowerGubunList",searchFlowerGubunList);
		
		List<EgovMap> saleDateList  =  (List<EgovMap>)chartStatisticsService.selectSearchPumMokSaleDate(pRequestParamMap);
		model.addAttribute("saleDateList",saleDateList);
		
		//2014-12-17 박대효 수정
		if (!saleDateList.isEmpty()) {
		    String searchDate = (String) saleDateList.get(0).get("saleDate");
		    pRequestParamMap.put("searchSaleDate", searchDate);
		}
		
		List<EgovMap> list = chartStatisticsService.selectPumStats(pRequestParamMap);
		model.addAttribute("list",list);
		
		List<EgovMap> totalInfo = chartStatisticsService.selectPumStatsTot(pRequestParamMap);
		model.addAttribute("totalInfo", totalInfo);
		 
		return "jsonView";
	}
	
	@RequestMapping(value="/chart/getAreaSaleDate.json")
	public String getAreaSaleDate(HttpServletRequest pRequest, HttpServletResponse pResponse, 
			@RequestParam Map<String, Object> pRequestParamMap, ModelMap model){			  			  				
		
		List<EgovMap> saleDateList  =  (List<EgovMap>)chartStatisticsService.selectSearchAreaSaleDate(pRequestParamMap);
		model.addAttribute("saleDateList",saleDateList);
		
		String searchDate = (String) saleDateList.get(0).get("saleDate");
		pRequestParamMap.put("searchSaleDate", searchDate);
		
		List<EgovMap> areaList = chartStatisticsService.selectChartArea(pRequestParamMap);
		model.addAttribute("areaList",areaList);
		
		List<EgovMap> mapList = chartStatisticsService.selectChartAreaMap(pRequestParamMap);
		model.addAttribute("mapList",mapList);
		
		return "jsonView";
	}
	
	
	@RequestMapping(value="/chart/getPumMokData.json")
	public String getPumMokData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = chartStatisticsService.selectPumStats(pRequestParamMap);
		model.addAttribute("list",list);
		
		List<EgovMap> totalInfo = chartStatisticsService.selectPumStatsTot(pRequestParamMap);
		model.addAttribute("totalInfo", totalInfo);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/chart/getAreaChartData.json")
	public String getAreaChartData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		if(pRequestParamMap.get("searchAreaCode") == null) {
			
			List<EgovMap> list = chartStatisticsService.selectChartArea(pRequestParamMap);
			model.addAttribute("list",list);
			
		}else {
			String searchAreaKeyword = null;
			String searchAreaKeyword2 = null;
			
			switch(pRequestParamMap.get("searchAreaCode").toString()) {
				case "100": searchAreaKeyword = "강원"; break;
				case "200": searchAreaKeyword = "경기"; break;
				case "300": searchAreaKeyword = "경상남도"; searchAreaKeyword2 = "경남"; break;
				case "400": searchAreaKeyword = "경상북도"; searchAreaKeyword2 = "경북"; break;
				case "500": searchAreaKeyword = "광주"; break;
				case "600": searchAreaKeyword = "대구"; break;
				case "700": searchAreaKeyword = "대전"; break;
				case "800": searchAreaKeyword = "부산"; break;
				case "90000": searchAreaKeyword = "서울"; break;
				case "1000": searchAreaKeyword = "울산"; break;
				case "1100": searchAreaKeyword = "인천"; break;
				case "1200": searchAreaKeyword = "전라남도"; searchAreaKeyword2 = "전남"; break;
				case "1300": searchAreaKeyword = "전라북도"; searchAreaKeyword2 = "전북"; break;
				case "1400": searchAreaKeyword = "제주"; break;
				case "1500": searchAreaKeyword = "충청남도"; searchAreaKeyword2 = "충남"; break;
				case "1600": searchAreaKeyword = "충청북도"; searchAreaKeyword2 = "충북"; break;
				case "1700": searchAreaKeyword = "세종"; break;
			}
			
			pRequestParamMap.put("searchAreaKeyword", searchAreaKeyword);
			pRequestParamMap.put("searchAreaKeyword2", searchAreaKeyword2);
			
			List<EgovMap> list = chartStatisticsService.selectChartArea(pRequestParamMap);
			model.addAttribute("list",list);
		}
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/chart/getAreaMapData.json")
	public String getAreaMapData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		List<EgovMap> list = chartStatisticsService.selectChartAreaMap(pRequestParamMap);
		model.addAttribute("list",list);
		
		return "jsonView";
		  	
	}
	
	@RequestMapping(value="/chart/insertChartData.json")
	public String insertChartData(HttpServletRequest pRequest, HttpServletResponse pResponse
			, @RequestParam Map<String, Object> pRequestParamMap, ModelMap model) {  
		
		pumMokSearchDate();
		
		chartSearchData();
		
		return "jsonView";
		
	}
	
	public void pumMokSearchDate () {
		
		List<EgovMap> searchData  =  chartStatisticsService.selectPumMokSaledate();
		int i = 0;
		for (EgovMap egovMapDate : searchData) {
			
			if (i < 10) {
				
				Map<String, Object> searchDateMap = new HashMap<String, Object>();
				
				searchDateMap.put("searchSaleDate", egovMapDate.get("saleDate"));
				
				// 품목별거래현황통계 
				chartStatisticsService.deletePumStats(searchDateMap);
				
				List<EgovMap> pumStatsList = chartStatisticsService.selectPumStatsList(searchDateMap);
				
				for (EgovMap egovMap : pumStatsList) {
					chartStatisticsService.insertPumStats(egovMap);
				}
				
				// 품목별거래현황합계통계
				chartStatisticsService.deletePumStatsTot(searchDateMap);
				
				List<EgovMap> pumStatsTotList = chartStatisticsService.selectPumStatsTotList(searchDateMap);
				
				for (EgovMap egovMap : pumStatsTotList) {
					chartStatisticsService.insertPumStatsTot(egovMap);
				}
				
				i++;
			} else {
				break;
			}
		}
	}
	
	public void chartSearchData () {
		List<EgovMap> searchData  = chartStatisticsService.selectAreaSaleDate();
		
		int i = 0;
		for (EgovMap egovMapDate : searchData) {
			
			if (i < 10) {
				
				Map<String, Object> searchDateMap = new HashMap<String, Object>();
				
				searchDateMap.put("searchSaleDate", egovMapDate.get("saleDate"));
				
				chartStatisticsService.deleteChartAreaMap(searchDateMap);
				
				// 지역별거래현황 지도
				List<EgovMap> areaMapList = chartStatisticsService.selectChartAreaMapList(searchDateMap);
				
				for (EgovMap egovMap : areaMapList) {
					chartStatisticsService.insertChartAreaMap(egovMap);
				}
				
				chartStatisticsService.deleteChartArea(searchDateMap);
				
				// 지역별거래현황 차트
				List<EgovMap> areaList = chartStatisticsService.selectChartAreaList(searchDateMap);
				
				for (EgovMap egovMap : areaList) {
					chartStatisticsService.insertChartArea(egovMap);
				}
				i++;
			} else {
				break;
			}
		}
	}
}
