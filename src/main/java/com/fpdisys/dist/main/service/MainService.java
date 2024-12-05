package com.fpdisys.dist.main.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpdisys.base.mvc.BaseService;
import com.fpdisys.dist.hfa01.domain.Hfa01VO;
import com.fpdisys.dist.hfa01.mapper.Hfa01Mapper;
import com.fpdisys.dist.main.mapper.MainMapper;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class MainService extends BaseService {

	@Autowired
	MainMapper mainMapper;
	
	@Autowired
	Hfa01Mapper hfa01Mapper;
	
	public List<?> selectFlowerMain(Map<String, Object> pRequestParamMap){
		return mainMapper.selectFlowerMain(pRequestParamMap);		
	}
	
	public List<?> selectGridJong(Map<String, Object> pRequestParamMap){
		return mainMapper.selectGridJong(pRequestParamMap);		
	}

	public List<?> selectMainIndex(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectMainIndex(pRequestParamMap);		
	}
	
	public List<?> selectChartListIndex(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectChartListIndex(pRequestParamMap);		
	}

	public List<?> selectAuctionDate(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectAuctionDate(pRequestParamMap);		
	}

	public List<?> selectGridListMok(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectGridListMok(pRequestParamMap);
	}
	
	public List<?> selectGridListAnalysis(	Map<String, Object> pRequestParamMap) {
		return mainMapper.selectGridListAnalysis(pRequestParamMap);
	}

	public List<?> selectChartListChulHa(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectChartListChulHa(pRequestParamMap);
	}

	public List<?> selectChartListChulHaShdul(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectChartListChulHaShdul(pRequestParamMap);
	}

	public List<?> selectSalePriceTrand(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectSalePriceTrand(pRequestParamMap);
	}
	
	public List<?> selectGridListMokSub(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectGridListMokSub(pRequestParamMap);
	}
	
	public List<?> selectGridListMokSubYear(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectGridListMokSubYear(pRequestParamMap);
	}
	
	public List<?> selectGridListMokSubMonth(Map<String, Object> pRequestParamMap){
		return mainMapper.selectGridListMokSubMonth(pRequestParamMap);
	}
	
	public List<?> selectSaleTrend(Map<String, Object> pRequestParamMap){
		return mainMapper.selectSaleTrend(pRequestParamMap);
	}
	

	public List<?> getPumInfo(Map<String, Object> pRequestParamMap) {
		return mainMapper.getPumInfo(pRequestParamMap);
	}

	public List<EgovMap> situationNewChart1(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewChart1(pRequestParamMap);
	}

	public List<EgovMap> situationNewChart2(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewChart2(pRequestParamMap);
	}

	public List<EgovMap> situationNewTable2(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewTable2(pRequestParamMap);
	}

	public List<EgovMap> situationNewChart3(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewChart3(pRequestParamMap);
	}
	
	public List<EgovMap> situationNewChart4(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewChart4(pRequestParamMap);
	}
	
	public List<EgovMap> situationNewChart5(Map<String, Object> pRequestParamMap) {
		return mainMapper.situationNewChart5(pRequestParamMap);
	}
	
	public List<EgovMap> hab01Chart1(Map<String, Object> pRequestParamMap) {
		return mainMapper.hab01Chart1(pRequestParamMap);
	}
	
	public List<EgovMap> hab01Chart2(Map<String, Object> pRequestParamMap) {
		return mainMapper.hab01Chart2(pRequestParamMap);
	}
	
	public List<EgovMap> hab01Button(Map<String, Object> pRequestParamMap) {
		return mainMapper.hab01Button(pRequestParamMap);
	}
	
	public List<EgovMap> selectFlowerMainMonth(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectFlowerMainMonth(pRequestParamMap);
	}
	
	
	/*
	 * 2021.09.07~ 추가
	 */
	public List<Hfa01VO> selectMainGongi(Map<String, Object> pRequestParamMap) {
		return hfa01Mapper.selectHfa01(pRequestParamMap);
	}
	
	public List<EgovMap> selectDealTrendList(int flowerGubn) {
		return mainMapper.selectDealTrendList(flowerGubn);
	}
	
	public List<EgovMap> selectRealSaleDate(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectRealSaleDate(pRequestParamMap);
	}
	
	public List<EgovMap> selectSaleDate(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectSaleDate(pRequestParamMap);
	}
	
	public List<EgovMap> selectPumMokSaledate(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectPumMokSaledate(pRequestParamMap);
	}
	
	public List<EgovMap> selectAreaSaleDate(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectAreaSaleDate(pRequestParamMap);
	}
	
	public List<EgovMap> selectRealData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectRealData(pRequestParamMap);
	}

	public List<EgovMap> selectSaleData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectSaleData(pRequestParamMap);
	}
	
	public List<EgovMap> selectPumMokData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectPumMokData(pRequestParamMap);
	}
	
	public List<EgovMap> selectPumMokTotalInfo(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectPumMokTotalInfo(pRequestParamMap);
	}
	
	public List<EgovMap> selectAreaChartData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectAreaChartData(pRequestParamMap);
	}
	
	public List<EgovMap> selectDetailAreaChartData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectDetailAreaChartData(pRequestParamMap);
	}
	
	public List<EgovMap> selectAreaMapData(Map<String, Object> pRequestParamMap) {
		return mainMapper.selectAreaMapData(pRequestParamMap);
	}
}
