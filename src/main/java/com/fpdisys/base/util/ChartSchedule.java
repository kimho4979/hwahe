package com.fpdisys.base.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fpdisys.dist.main.service.ChartStatisticsService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class ChartSchedule {
	
	@Autowired
	private ChartStatisticsService chartStatisticsService;
			
	// 매일 실행
	@Scheduled(cron="0 10 7,19 * * *")
	public void scheduleRun(){	
		
		pumMokSearchDate();
		
		chartSearchData();
		
  	}
	
	public void pumMokSearchDate () {
		
		List<EgovMap> searchData  =  chartStatisticsService.selectPumMokSaledate();
		int i = 0;
		for (EgovMap egovMapDate : searchData) {
			
			if (i < 3) {
				
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
			
			if (i < 3) {
				
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
			} else {
				break;
			}
		}
		
	}
	
}